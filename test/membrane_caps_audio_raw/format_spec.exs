defmodule Membrane.Caps.Audio.Raw.FormatTest do
  use ExUnit.Case, async: true

  alias Membrane.RawAudio.Format, as: RawAudio

  @all_formats [
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

  @all_tuples [
    {:s, 8, :any},
    {:u, 8, :any},
    {:s, 16, :le},
    {:u, 16, :le},
    {:s, 16, :be},
    {:u, 16, :be},
    {:s, 24, :le},
    {:u, 24, :le},
    {:s, 24, :be},
    {:u, 24, :be},
    {:s, 32, :le},
    {:u, 32, :le},
    {:s, 32, :be},
    {:u, 32, :be},
    {:f, 32, :le},
    {:f, 32, :be},
    {:f, 64, :le},
    {:f, 64, :be}
  ]

  test "to_tuple/1" do
    Enum.zip(@all_formats, @all_tuples)
    |> Enum.each(fn {fmt, tuple} ->
      assert RawAudio.to_tuple(fmt) == tuple
    end)
  end

  test "from_tuple/1" do
    Enum.zip(@all_tuples, @all_formats)
    |> Enum.each(fn {tuple, fmt} ->
      assert RawAudio.from_tuple(tuple) == fmt
    end)
  end

  test "Using serialize/1 and then deserialize/1" do
    @all_formats
    |> Enum.each(fn fmt ->
      assert fmt |> RawAudio.serialize() |> RawAudio.deserialize() == fmt
    end)
  end
end
