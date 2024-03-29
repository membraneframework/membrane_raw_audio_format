defmodule Membrane.RawAudioTest do
  use ExUnit.Case, async: true
  alias Membrane.RawAudio

  @all_sample_formats [
    :s8,
    :u8,
    :s16le,
    :u16le,
    :s16be,
    :u16be,
    :s24le,
    :u24le,
    :s24be,
    :u24be,
    :s32le,
    :u32le,
    :s32be,
    :u32be,
    :f32le,
    :f32be,
    :f64le,
    :f64be
  ]

  defp to_raw_audio_format(sample_format) when sample_format in @all_sample_formats do
    %RawAudio{sample_format: sample_format, channels: 2, sample_rate: 44_100}
  end

  test "sample_size/1" do
    sizes = [1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 8, 8]

    assert length(@all_sample_formats) == length(sizes)

    @all_sample_formats
    |> Enum.map(&to_raw_audio_format/1)
    |> Enum.zip(sizes)
    |> Enum.each(fn {sample_format, size} ->
      assert RawAudio.sample_size(sample_format) == size
    end)
  end

  test "frame_size/1" do
    sizes = [2, 2, 4, 4, 4, 4, 6, 6, 6, 6, 8, 8, 8, 8, 8, 8, 16, 16]

    assert length(@all_sample_formats) == length(sizes)

    @all_sample_formats
    |> Enum.map(&to_raw_audio_format/1)
    |> Enum.zip(sizes)
    |> Enum.each(fn {sample_format, size} ->
      assert RawAudio.frame_size(sample_format) == size
    end)
  end

  @float_sample_formats [:f32be, :f32le, :f64le, :f64be]

  @non_float_formats [
    :s8,
    :u8,
    :s16le,
    :u16le,
    :s16be,
    :u16be,
    :s24le,
    :u24le,
    :s24be,
    :u24be,
    :s32le,
    :u32le,
    :s32be,
    :u32be
  ]

  test "sample_type_float?" do
    @float_sample_formats
    |> Enum.map(&to_raw_audio_format/1)
    |> Enum.each(fn sample_format -> assert RawAudio.sample_type_float?(sample_format) == true end)

    @non_float_formats
    |> Enum.map(&to_raw_audio_format/1)
    |> Enum.each(fn sample_format ->
      assert RawAudio.sample_type_float?(sample_format) == false
    end)
  end

  test "sample_type_fixed?" do
    @float_sample_formats
    |> Enum.map(&to_raw_audio_format/1)
    |> Enum.each(fn sample_format ->
      assert RawAudio.sample_type_fixed?(sample_format) == false
    end)

    @non_float_formats
    |> Enum.map(&to_raw_audio_format/1)
    |> Enum.each(fn sample_format -> assert RawAudio.sample_type_fixed?(sample_format) == true end)
  end

  @little_endian_sample_formats [
    :s16le,
    :u16le,
    :s24le,
    :u24le,
    :s32le,
    :u32le,
    :f32le,
    :f64le
  ]

  @big_endian_sample_formats [
    :s16be,
    :u16be,
    :s24be,
    :u24be,
    :s32be,
    :u32be,
    :f32be,
    :f64be
  ]

  @one_byte_sample_formats [:s8, :u8]

  test "little_endian?" do
    @little_endian_sample_formats
    |> Enum.map(&to_raw_audio_format/1)
    |> Enum.each(fn sample_format -> RawAudio.little_endian?(sample_format) == true end)

    @big_endian_sample_formats
    |> Enum.map(&to_raw_audio_format/1)
    |> Enum.each(fn sample_format -> RawAudio.little_endian?(sample_format) == false end)

    @one_byte_sample_formats
    |> Enum.map(&to_raw_audio_format/1)
    |> Enum.each(fn sample_format -> RawAudio.little_endian?(sample_format) == true end)
  end

  test "big_endian?" do
    @little_endian_sample_formats
    |> Enum.map(&to_raw_audio_format/1)
    |> Enum.each(fn sample_format -> RawAudio.big_endian?(sample_format) == false end)

    @big_endian_sample_formats
    |> Enum.map(&to_raw_audio_format/1)
    |> Enum.each(fn sample_format -> RawAudio.big_endian?(sample_format) == true end)

    @one_byte_sample_formats
    |> Enum.map(&to_raw_audio_format/1)
    |> Enum.each(fn sample_format -> RawAudio.big_endian?(sample_format) == true end)
  end

  @signed_sample_formats [
    :s8,
    :s16le,
    :s16be,
    :s24le,
    :s24be,
    :s32le,
    :s32be
  ]

  @unsigned_sample_formats [
    :u8,
    :u16le,
    :u16be,
    :u24le,
    :u24be,
    :u32le,
    :u32be
  ]

  test "signed?" do
    @signed_sample_formats
    |> Enum.map(&to_raw_audio_format/1)
    |> Enum.each(fn sample_format -> RawAudio.signed?(sample_format) == true end)

    @unsigned_sample_formats
    |> Enum.map(&to_raw_audio_format/1)
    |> Enum.each(fn sample_format -> RawAudio.signed?(sample_format) == false end)

    @float_sample_formats
    |> Enum.map(&to_raw_audio_format/1)
    |> Enum.each(fn sample_format -> RawAudio.signed?(sample_format) == true end)
  end

  test "unsigned?/1" do
    @signed_sample_formats
    |> Enum.map(&to_raw_audio_format/1)
    |> Enum.each(fn sample_format -> RawAudio.unsigned?(sample_format) == false end)

    @unsigned_sample_formats
    |> Enum.map(&to_raw_audio_format/1)
    |> Enum.each(fn sample_format -> RawAudio.unsigned?(sample_format) == true end)

    @float_sample_formats
    |> Enum.map(&to_raw_audio_format/1)
    |> Enum.each(fn sample_format -> RawAudio.unsigned?(sample_format) == false end)
  end

  @example_value 42
  defp assert_value_to_sample(sample_format, result) do
    assert RawAudio.value_to_sample(@example_value, to_raw_audio_format(sample_format)) ==
             result
  end

  test "value_to_sample/2" do
    assert_value_to_sample(:s8, <<@example_value>>)
    assert_value_to_sample(:u8, <<@example_value>>)

    assert_value_to_sample(:s16le, <<@example_value, 0>>)
    assert_value_to_sample(:s16le, <<@example_value, 0>>)
    assert_value_to_sample(:u16be, <<0, @example_value>>)
    assert_value_to_sample(:u16be, <<0, @example_value>>)

    assert_value_to_sample(:s24le, <<@example_value, 0, 0>>)
    assert_value_to_sample(:s24be, <<0, 0, @example_value>>)
    assert_value_to_sample(:u24le, <<@example_value, 0, 0>>)
    assert_value_to_sample(:u24be, <<0, 0, @example_value>>)

    assert_value_to_sample(:s32le, <<@example_value, 0, 0, 0>>)
    assert_value_to_sample(:s32be, <<0, 0, 0, @example_value>>)
    assert_value_to_sample(:u32le, <<@example_value, 0, 0, 0>>)
    assert_value_to_sample(:u32be, <<0, 0, 0, @example_value>>)
  end

  defp assert_value_to_sample_check_overflow_ok(sample_format, result) do
    assert RawAudio.value_to_sample_check_overflow(
             @example_value,
             to_raw_audio_format(sample_format)
           ) ==
             {:ok, result}
  end

  test "value_to_sample_check_overflow/2 with value in range" do
    assert_value_to_sample_check_overflow_ok(:s8, <<@example_value>>)
    assert_value_to_sample_check_overflow_ok(:u8, <<@example_value>>)

    assert_value_to_sample_check_overflow_ok(:s16le, <<@example_value, 0>>)
    assert_value_to_sample_check_overflow_ok(:s16le, <<@example_value, 0>>)
    assert_value_to_sample_check_overflow_ok(:u16be, <<0, @example_value>>)
    assert_value_to_sample_check_overflow_ok(:u16be, <<0, @example_value>>)

    assert_value_to_sample_check_overflow_ok(:s24le, <<@example_value, 0, 0>>)
    assert_value_to_sample_check_overflow_ok(:s24be, <<0, 0, @example_value>>)
    assert_value_to_sample_check_overflow_ok(:u24le, <<@example_value, 0, 0>>)
    assert_value_to_sample_check_overflow_ok(:u24be, <<0, 0, @example_value>>)

    assert_value_to_sample_check_overflow_ok(:s32le, <<@example_value, 0, 0, 0>>)
    assert_value_to_sample_check_overflow_ok(:s32be, <<0, 0, 0, @example_value>>)
    assert_value_to_sample_check_overflow_ok(:u32le, <<@example_value, 0, 0, 0>>)
    assert_value_to_sample_check_overflow_ok(:u32be, <<0, 0, 0, @example_value>>)
  end

  defp assert_value_to_sample_check_overflow_error(value, sample_format) do
    assert RawAudio.value_to_sample_check_overflow(
             value,
             to_raw_audio_format(sample_format)
           ) ==
             {:error, :overflow}
  end

  test "value_to_sample_check_overflow/2 when value is not in valid range" do
    assert_value_to_sample_check_overflow_error(257, :u8)
    assert_value_to_sample_check_overflow_error(-1, :u8)
    assert_value_to_sample_check_overflow_error(129, :s8)
    assert_value_to_sample_check_overflow_error(-129, :s8)

    assert_value_to_sample_check_overflow_error(65_536, :u16le)
    assert_value_to_sample_check_overflow_error(-1, :u16le)
    assert_value_to_sample_check_overflow_error(32_768, :s16le)
    assert_value_to_sample_check_overflow_error(-32_769, :s16le)

    assert_value_to_sample_check_overflow_error(:math.pow(2, 23), :s24le)
    assert_value_to_sample_check_overflow_error(-(:math.pow(2, 23) + 1), :s24be)
    assert_value_to_sample_check_overflow_error(:math.pow(2, 24), :u24le)
    assert_value_to_sample_check_overflow_error(-1, :u24be)

    assert_value_to_sample_check_overflow_error(:math.pow(2, 31), :s32le)
    assert_value_to_sample_check_overflow_error(-(:math.pow(2, 31) + 1), :s32be)
    assert_value_to_sample_check_overflow_error(:math.pow(2, 32), :u32le)
    assert_value_to_sample_check_overflow_error(-1, :u32be)
  end

  defp assert_sample_to_value_ok(sample, sample_format, value) do
    RawAudio.sample_to_value(sample, sample_format |> to_raw_audio_format()) == {:ok, value}
  end

  test "sample_to_value/2" do
    value = -123
    assert_sample_to_value_ok(<<value::integer-unit(8)-size(1)-signed>>, :s8, value)
    value = 123
    assert_sample_to_value_ok(<<value::integer-unit(8)-size(1)-unsigned>>, :u8, value)
    value = -1234
    assert_sample_to_value_ok(<<value::integer-unit(8)-size(2)-little-signed>>, :s16le, value)
    value = -1234
    assert_sample_to_value_ok(<<value::integer-unit(8)-size(4)-little-signed>>, :s32le, value)
    value = 1234
    assert_sample_to_value_ok(<<value::integer-unit(8)-size(2)-little-unsigned>>, :u16le, value)
    value = 1234
    assert_sample_to_value_ok(<<value::integer-unit(8)-size(4)-little-unsigned>>, :u32le, value)
    value = 1234.0
    assert_sample_to_value_ok(<<value::float-unit(8)-size(4)-little>>, :f32le, value)
    value = -1234
    assert_sample_to_value_ok(<<value::integer-unit(8)-size(2)-big-signed>>, :s16be, value)
    value = -1234
    assert_sample_to_value_ok(<<value::integer-unit(8)-size(4)-big-signed>>, :s32be, value)
    value = 1234
    assert_sample_to_value_ok(<<value::integer-unit(8)-size(2)-big-unsigned>>, :u16be, value)
    value = 1234
    assert_sample_to_value_ok(<<value::integer-unit(8)-size(4)-big-unsigned>>, :u32be, value)
    value = 1234.0
    assert_sample_to_value_ok(<<value::float-unit(8)-size(4)-big>>, :f32be, value)
  end

  test "sample_min/1" do
    [
      {:s8, -128},
      {:u8, 0},
      {:s16le, -32_768},
      {:s32le, -2_147_483_648},
      {:u16le, 0},
      {:u32le, 0},
      {:s16be, -32_768},
      {:s32be, -2_147_483_648},
      {:u16be, 0},
      {:u32be, 0},
      {:f32le, -1.0},
      {:f32be, -1.0},
      {:f64le, -1.0},
      {:f64be, -1.0}
    ]
    |> Enum.each(fn {sample_format, min_sample} ->
      assert RawAudio.sample_min(sample_format |> to_raw_audio_format()) == min_sample
    end)
  end

  test "sample_max/1" do
    [
      {:s8, 127},
      {:u8, 255},
      {:s16le, 32_767},
      {:s32le, 2_147_483_647},
      {:u16le, 65_535},
      {:u32le, 4_294_967_295},
      {:s16be, 32_767},
      {:s32be, 2_147_483_647},
      {:u16be, 65_535},
      {:u32be, 4_294_967_295},
      {:f32le, 1.0},
      {:f32be, 1.0},
      {:f64le, 1.0},
      {:f64be, 1.0}
    ]
    |> Enum.each(fn {sample_format, max_sample} ->
      assert RawAudio.sample_max(sample_format |> to_raw_audio_format()) == max_sample
    end)
  end
end
