defmodule Membrane.Caps.Audio.RawSpec do
  use ESpec, async: true
  alias Membrane.Caps.Audio.Raw, as: Caps

  defp format_to_caps(format) do
    %Caps{format: format, channels: 2, sample_rate: 44100}
  end

  let :all_formats,
    do: [
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

  describe ".sample_size/1" do
    let :sample_sizes, do: [1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4]

    it "should return proper size in bytes for each sample format" do
      all_formats()
      |> Enum.zip(sample_sizes())
      |> Enum.each(fn {fmt, size} ->
        caps = fmt |> format_to_caps()
        expect(described_module().sample_size(caps)) |> to(eq size)
      end)
    end
  end

  describe "frame_size/1" do
    let :frame_sizes, do: [2, 2, 4, 4, 4, 4, 6, 6, 6, 6, 8, 8, 8, 8, 8, 8]

    it "should return proper frame in bytes for each caps" do
      all_formats()
      |> Enum.zip(frame_sizes())
      |> Enum.each(fn {fmt, size} ->
        caps = fmt |> format_to_caps()
        expect(described_module().frame_size(caps)) |> to(eq size)
      end)
    end
  end

  let :float_caps, do: [:f32be, :f32le, :f64le, :f64be] |> Enum.map(&format_to_caps/1)

  let :non_float_caps,
    do:
      [
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
      |> Enum.map(&format_to_caps/1)

  describe ".sample_type_float?/1" do
    it "should return true for float formats" do
      float_caps()
      |> Enum.each(fn caps ->
        expect(described_module().sample_type_float?(caps)) |> to(be_true())
      end)
    end

    it "should return false for non-float formats" do
      non_float_caps()
      |> Enum.each(fn caps ->
        expect(described_module().sample_type_float?(caps)) |> to(be_false())
      end)
    end
  end

  describe ".sample_type_int?/1" do
    it "should return true for integer formats" do
      non_float_caps()
      |> Enum.each(fn caps ->
        expect(described_module().sample_type_int?(caps)) |> to(be_true())
      end)
    end

    it "should return false for float formats" do
      float_caps()
      |> Enum.each(fn caps ->
        expect(described_module().sample_type_int?(caps)) |> to(be_false())
      end)
    end
  end

  let :le_caps,
    do:
      [
        :s16le,
        :u16le,
        :s24le,
        :u24le,
        :s32le,
        :u32le,
        :f32le,
        :f64le
      ]
      |> Enum.map(&format_to_caps/1)

  let :be_caps,
    do:
      [
        :s16be,
        :u16be,
        :s24be,
        :u24be,
        :s32be,
        :u32be,
        :f32be,
        :f64be
      ]
      |> Enum.map(&format_to_caps/1)

  let :one_byte_caps, do: [:s8, :u8] |> Enum.map(&format_to_caps/1)

  describe "little_endian?/1" do
    it "should return true for little endian formats" do
      le_caps()
      |> Enum.each(fn caps ->
        expect(described_module().little_endian?(caps)) |> to(be_true())
      end)
    end

    it "should return false for big endian formats" do
      be_caps()
      |> Enum.each(fn caps ->
        expect(described_module().little_endian?(caps)) |> to(be_false())
      end)
    end

    it "should return true for one byte formats" do
      one_byte_caps()
      |> Enum.each(fn caps ->
        expect(described_module().little_endian?(caps)) |> to(be_true())
      end)
    end
  end

  describe "big_endian?/1" do
    it "should return true for big endian formats" do
      be_caps()
      |> Enum.each(fn caps ->
        expect(described_module().big_endian?(caps)) |> to(be_true())
      end)
    end

    it "should return false for little endian formats" do
      le_caps()
      |> Enum.each(fn caps ->
        expect(described_module().big_endian?(caps)) |> to(be_false())
      end)
    end

    it "should return true for one byte formats" do
      one_byte_caps()
      |> Enum.each(fn caps ->
        expect(described_module().big_endian?(caps)) |> to(be_true())
      end)
    end
  end

  let :signed_caps,
    do:
      [
        :s8,
        :s16le,
        :s16be,
        :s24le,
        :s24be,
        :s32le,
        :s32be
      ]
      |> Enum.map(&format_to_caps/1)

  let :unsigned_caps,
    do:
      [
        :u8,
        :u16le,
        :u16be,
        :u24le,
        :u24be,
        :u32le,
        :u32be
      ]
      |> Enum.map(&format_to_caps/1)

  describe "signed?/1" do
    it "should return true for signed integer formats" do
      signed_caps()
      |> Enum.each(fn caps ->
        expect(described_module().signed?(caps)) |> to(be_true())
      end)
    end

    it "should return false for unsigned integer formats" do
      unsigned_caps()
      |> Enum.each(fn caps ->
        expect(described_module().signed?(caps)) |> to(be_false())
      end)
    end

    it "should return true for float formats" do
      float_caps()
      |> Enum.each(fn caps ->
        expect(described_module().signed?(caps)) |> to(be_true())
      end)
    end
  end

  describe "unsigned?/1" do
    it "should return true for unsigned integer formats" do
      unsigned_caps()
      |> Enum.each(fn caps ->
        expect(described_module().unsigned?(caps)) |> to(be_true())
      end)
    end

    it "should return false for signed integer formats" do
      signed_caps()
      |> Enum.each(fn caps ->
        expect(described_module().unsigned?(caps)) |> to(be_false())
      end)
    end

    it "should return false for float formats" do
      float_caps()
      |> Enum.each(fn caps ->
        expect(described_module().unsigned?(caps)) |> to(be_false())
      end)
    end
  end

  describe ".value_to_sample/2" do
    let :value, do: 42

    let :expect_result,
      do: fn format, result ->
        expect(described_module().value_to_sample(value(), format_to_caps(format)))
        |> to(eq result)
      end

    it "should properly encode 42 as sample in different formats" do
      expect_result().(:s8, <<value()>>)
      expect_result().(:u8, <<value()>>)

      expect_result().(:s16le, <<value(), 0>>)
      expect_result().(:s16le, <<value(), 0>>)
      expect_result().(:u16be, <<0, value()>>)
      expect_result().(:u16be, <<0, value()>>)

      expect_result().(:s24le, <<value(), 0, 0>>)
      expect_result().(:s24be, <<0, 0, value()>>)
      expect_result().(:u24le, <<value(), 0, 0>>)
      expect_result().(:u24be, <<0, 0, value()>>)

      expect_result().(:s32le, <<value(), 0, 0, 0>>)
      expect_result().(:s32be, <<0, 0, 0, value()>>)
      expect_result().(:u32le, <<value(), 0, 0, 0>>)
      expect_result().(:u32be, <<0, 0, 0, value()>>)
    end
  end

  describe ".value_to_sample_check_overflow/2" do
    let :value, do: 42

    let :expect_result,
      do: fn format, result ->
        expect(described_module().value_to_sample_check_overflow(value(), format_to_caps(format)))
        |> to(eq result)
      end

    let :expect_error,
      do: fn value, format ->
        expect(described_module().value_to_sample_check_overflow(value, format_to_caps(format)))
        |> to(eq {:error, :overflow})
      end

    it "should properly encode 42 as sample in different formats" do
      expect_result().(:s8, {:ok, <<value()>>})
      expect_result().(:u8, {:ok, <<value()>>})

      expect_result().(:s16le, {:ok, <<value(), 0>>})
      expect_result().(:s16le, {:ok, <<value(), 0>>})
      expect_result().(:u16be, {:ok, <<0, value()>>})
      expect_result().(:u16be, {:ok, <<0, value()>>})

      expect_result().(:s24le, {:ok, <<value(), 0, 0>>})
      expect_result().(:s24be, {:ok, <<0, 0, value()>>})
      expect_result().(:u24le, {:ok, <<value(), 0, 0>>})
      expect_result().(:u24be, {:ok, <<0, 0, value()>>})

      expect_result().(:s32le, {:ok, <<value(), 0, 0, 0>>})
      expect_result().(:s32be, {:ok, <<0, 0, 0, value()>>})
      expect_result().(:u32le, {:ok, <<value(), 0, 0, 0>>})
      expect_result().(:u32be, {:ok, <<0, 0, 0, value()>>})
    end

    it "should return error when value is not in valid range" do
      expect_error().(257, :u8)
      expect_error().(-1, :u8)
      expect_error().(129, :s8)
      expect_error().(-129, :s8)

      expect_error().(65536, :u16le)
      expect_error().(-1, :u16le)
      expect_error().(32768, :s16le)
      expect_error().(-32769, :s16le)

      expect_error().(:math.pow(2, 23), :s24le)
      expect_error().(-(:math.pow(2, 23) + 1), :s24be)
      expect_error().(:math.pow(2, 24), :u24le)
      expect_error().(-1, :u24be)

      expect_error().(:math.pow(2, 31), :s32le)
      expect_error().(-(:math.pow(2, 31) + 1), :s32be)
      expect_error().(:math.pow(2, 32), :u32le)
      expect_error().(-1, :u32be)
    end
  end

  describe ".sample_to_value/2" do
    context "if format is :s8" do
      let :caps, do: :s8 |> format_to_caps
      let :value, do: -123
      let :sample, do: <<value()::integer-unit(8)-size(1)-signed>>

      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())) |> to(eq value())
      end
    end

    context "if format is :u8" do
      let :caps, do: :u8 |> format_to_caps
      let :value, do: 123
      let :sample, do: <<value()::integer-unit(8)-size(1)-unsigned>>

      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())) |> to(eq value())
      end
    end

    context "if format is :s16le" do
      let :caps, do: :s16le |> format_to_caps
      let :value, do: -1234
      let :sample, do: <<value()::integer-unit(8)-size(2)-little-signed>>

      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())) |> to(eq value())
      end
    end

    context "if format is :s32le" do
      let :caps, do: :s32le |> format_to_caps
      let :value, do: -1234
      let :sample, do: <<value()::integer-unit(8)-size(4)-little-signed>>

      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())) |> to(eq value())
      end
    end

    context "if format is :u16le" do
      let :caps, do: :u16le |> format_to_caps
      let :value, do: 1234
      let :sample, do: <<value()::integer-unit(8)-size(2)-little-unsigned>>

      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())) |> to(eq value())
      end
    end

    context "if format is :u32le" do
      let :caps, do: :u32le |> format_to_caps
      let :value, do: 1234
      let :sample, do: <<value()::integer-unit(8)-size(4)-little-unsigned>>

      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())) |> to(eq value())
      end
    end

    context "if format is :f32le" do
      let :caps, do: :f32le |> format_to_caps
      let :value, do: 1234.0
      let :sample, do: <<value()::float-unit(8)-size(4)-little>>

      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())) |> to(eq value())
      end
    end

    context "if format is :s16be" do
      let :caps, do: :s16be |> format_to_caps
      let :value, do: -1234
      let :sample, do: <<value()::integer-unit(8)-size(2)-big-signed>>

      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())) |> to(eq value())
      end
    end

    context "if format is :s32be" do
      let :caps, do: :s32be |> format_to_caps
      let :value, do: -1234
      let :sample, do: <<value()::integer-unit(8)-size(4)-big-signed>>

      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())) |> to(eq value())
      end
    end

    context "if format is :u16be" do
      let :caps, do: :u16be |> format_to_caps
      let :value, do: 1234
      let :sample, do: <<value()::integer-unit(8)-size(2)-big-unsigned>>

      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())) |> to(eq value())
      end
    end

    context "if format is :u32be" do
      let :caps, do: :u32be |> format_to_caps
      let :value, do: 1234
      let :sample, do: <<value()::integer-unit(8)-size(4)-big-unsigned>>

      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())) |> to(eq value())
      end
    end

    context "if format is :f32be" do
      let :caps, do: :f32be |> format_to_caps
      let :value, do: 1234.0
      let :sample, do: <<value()::float-unit(8)-size(4)-big>>

      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())) |> to(eq value())
      end
    end
  end

  describe ".sample_min/1" do
    context "if format is :s8" do
      let :caps, do: :s8 |> format_to_caps
      let :value, do: -128

      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())) |> to(eq value())
      end
    end

    context "if format is :u8" do
      let :caps, do: :u8 |> format_to_caps
      let :value, do: 0

      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())) |> to(eq value())
      end
    end

    context "if format is :s16le" do
      let :caps, do: :s16le |> format_to_caps
      let :value, do: -32768

      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())) |> to(eq value())
      end
    end

    context "if format is :s32le" do
      let :caps, do: :s32le |> format_to_caps
      let :value, do: -2_147_483_648

      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())) |> to(eq value())
      end
    end

    context "if format is :u16le" do
      let :caps, do: :u16le |> format_to_caps
      let :value, do: 0

      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())) |> to(eq value())
      end
    end

    context "if format is :u32le" do
      let :caps, do: :u32le |> format_to_caps
      let :value, do: 0

      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())) |> to(eq value())
      end
    end

    context "if format is :s16be" do
      let :caps, do: :s16be |> format_to_caps
      let :value, do: -32768

      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())) |> to(eq value())
      end
    end

    context "if format is :s32be" do
      let :caps, do: :s32be |> format_to_caps
      let :value, do: -2_147_483_648

      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())) |> to(eq value())
      end
    end

    context "if format is :u16be" do
      let :caps, do: :u16be |> format_to_caps
      let :value, do: 0

      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())) |> to(eq value())
      end
    end

    context "if format is :u32be" do
      let :caps, do: :u32be |> format_to_caps
      let :value, do: 0

      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())) |> to(eq value())
      end
    end

    context "if format is :f32le" do
      let :caps, do: :f32le |> format_to_caps
      let :value, do: -1.0

      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())) |> to(eq value())
      end
    end

    context "if format is :f32be" do
      let :caps, do: :f32be |> format_to_caps
      let :value, do: -1.0

      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())) |> to(eq value())
      end
    end

    context "if format is :f64le" do
      let :caps, do: :f64le |> format_to_caps
      let :value, do: -1.0

      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())) |> to(eq value())
      end
    end

    context "if format is :f64be" do
      let :caps, do: :f64be |> format_to_caps
      let :value, do: -1.0

      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())) |> to(eq value())
      end
    end
  end

  describe ".sample_max/1" do
    context "if format is :s8" do
      let :caps, do: :s8 |> format_to_caps
      let :value, do: 127

      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())) |> to(eq value())
      end
    end

    context "if format is :u8" do
      let :caps, do: :u8 |> format_to_caps
      let :value, do: 255

      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())) |> to(eq value())
      end
    end

    context "if format is :s16le" do
      let :caps, do: :s16le |> format_to_caps
      let :value, do: 32767

      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())) |> to(eq value())
      end
    end

    context "if format is :s32le" do
      let :caps, do: :s32le |> format_to_caps
      let :value, do: 2_147_483_647

      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())) |> to(eq value())
      end
    end

    context "if format is :u16le" do
      let :caps, do: :u16le |> format_to_caps
      let :value, do: 65535

      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())) |> to(eq value())
      end
    end

    context "if format is :u32le" do
      let :caps, do: :u32le |> format_to_caps
      let :value, do: 4_294_967_295

      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())) |> to(eq value())
      end
    end

    context "if format is :s16be" do
      let :caps, do: :s16be |> format_to_caps
      let :value, do: 32767

      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())) |> to(eq value())
      end
    end

    context "if format is :s32be" do
      let :caps, do: :s32be |> format_to_caps
      let :value, do: 2_147_483_647

      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())) |> to(eq value())
      end
    end

    context "if format is :u16be" do
      let :caps, do: :u16be |> format_to_caps
      let :value, do: 65535

      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())) |> to(eq value())
      end
    end

    context "if format is :u32be" do
      let :caps, do: :u32be |> format_to_caps
      let :value, do: 4_294_967_295

      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())) |> to(eq value())
      end
    end

    context "if format is :f32le" do
      let :caps, do: :f32le |> format_to_caps
      let :value, do: 1.0

      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())) |> to(eq value())
      end
    end

    context "if format is :f32be" do
      let :caps, do: :f32be |> format_to_caps
      let :value, do: 1.0

      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())) |> to(eq value())
      end
    end

    context "if format is :f64le" do
      let :caps, do: :f64le |> format_to_caps
      let :value, do: 1.0

      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())) |> to(eq value())
      end
    end

    context "if format is :f64be" do
      let :caps, do: :f64be |> format_to_caps
      let :value, do: 1.0

      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())) |> to(eq value())
      end
    end
  end
end
