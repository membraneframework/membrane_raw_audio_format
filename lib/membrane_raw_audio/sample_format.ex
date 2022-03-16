defmodule Membrane.RawAudio.SampleFormat do
  @moduledoc """
  This module defines sample formats used in `Membrane.RawAudio`
  and some helpers to deal with them.
  """

  use Bunch.Typespec
  import Bitwise

  @compile {:inline,
            [
              to_tuple: 1,
              from_tuple: 1
            ]}

  @list_type t :: [
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

  @spec values() :: [t()]
  def values(), do: @t

  @type sample_type_t :: :s | :u | :f
  @type sample_size_t :: 8 | 16 | 24 | 32 | 64
  @type endianness_t :: :le | :be | :any

  @doc """
  Converts format atom to an equivalent 3-tuple form
  """
  @spec to_tuple(t) :: {sample_type_t, sample_size_t, endianness_t}
  def to_tuple(:s8), do: {:s, 8, :any}
  def to_tuple(:u8), do: {:u, 8, :any}
  def to_tuple(:s16le), do: {:s, 16, :le}
  def to_tuple(:u16le), do: {:u, 16, :le}
  def to_tuple(:s16be), do: {:s, 16, :be}
  def to_tuple(:u16be), do: {:u, 16, :be}
  def to_tuple(:s24le), do: {:s, 24, :le}
  def to_tuple(:u24le), do: {:u, 24, :le}
  def to_tuple(:s24be), do: {:s, 24, :be}
  def to_tuple(:u24be), do: {:u, 24, :be}
  def to_tuple(:s32le), do: {:s, 32, :le}
  def to_tuple(:u32le), do: {:u, 32, :le}
  def to_tuple(:s32be), do: {:s, 32, :be}
  def to_tuple(:u32be), do: {:u, 32, :be}
  def to_tuple(:f32le), do: {:f, 32, :le}
  def to_tuple(:f32be), do: {:f, 32, :be}
  def to_tuple(:f64le), do: {:f, 64, :le}
  def to_tuple(:f64be), do: {:f, 64, :be}

  @doc """
  Converts 3-tuple format to an equivalent atom form
  """
  @spec from_tuple({sample_type_t, sample_size_t, endianness_t}) :: t
  def from_tuple({:s, 8, :any}), do: :s8
  def from_tuple({:u, 8, :any}), do: :u8
  def from_tuple({:s, 16, :le}), do: :s16le
  def from_tuple({:u, 16, :le}), do: :u16le
  def from_tuple({:s, 16, :be}), do: :s16be
  def from_tuple({:u, 16, :be}), do: :u16be
  def from_tuple({:s, 24, :le}), do: :s24le
  def from_tuple({:u, 24, :le}), do: :u24le
  def from_tuple({:s, 24, :be}), do: :s24be
  def from_tuple({:u, 24, :be}), do: :u24be
  def from_tuple({:s, 32, :le}), do: :s32le
  def from_tuple({:u, 32, :le}), do: :u32le
  def from_tuple({:s, 32, :be}), do: :s32be
  def from_tuple({:u, 32, :be}), do: :u32be
  def from_tuple({:f, 32, :le}), do: :f32le
  def from_tuple({:f, 32, :be}), do: :f32be
  def from_tuple({:f, 64, :le}), do: :f64le
  def from_tuple({:f, 64, :be}), do: :f64be

  # Serialization constants

  @sample_types BiMap.new(s: 0b01 <<< 30, u: 0b00 <<< 30, f: 0b11 <<< 30)
  @endianness_mapping BiMap.new(le: 0b0 <<< 29, be: 0b1 <<< 29)

  @sample_type 0b11 <<< 30
  @endianness_bitmask 0b1 <<< 29
  @sample_size (0b1 <<< 8) - 1

  @doc """
  converts audio format to 32-bit unsigned integer consisting of (from oldest bit):
  * first bit for type (int/float)
  * then bit for encoding (unsigned/signed)
  * then bit for endianity (little/big)
  * then sequence of zeroes
  * last 8 bits for size (in bits)

  expects atom format

  returns format encoded as integer
  """
  @spec serialize(t) :: pos_integer
  def serialize(format) do
    {type, size, endianness} = format |> to_tuple

    0 ||| @sample_types[type] ||| (@endianness_mapping[endianness] || @endianness_mapping[:le]) |||
      size
  end

  # Workaround for dialyzer not handling opaque term creation at compile time
  # See: https://github.com/elixir-lang/elixir/issues/8463
  @dialyzer [{:no_opaque, deserialize: 1}]

  @doc """
  Converts positive integer containing serialized format to atom.

  expects serialized format

  returns format atom (See `t:t/0`)
  """
  @spec deserialize(pos_integer) :: t
  def deserialize(serialized_format) do
    type = @sample_types |> BiMap.get_key(serialized_format &&& @sample_type)
    size = serialized_format &&& @sample_size

    endianness =
      case size do
        8 ->
          :any

        _otherwise ->
          @endianness_mapping |> BiMap.get_key(serialized_format &&& @endianness_bitmask)
      end

    {type, size, endianness} |> from_tuple
  end
end
