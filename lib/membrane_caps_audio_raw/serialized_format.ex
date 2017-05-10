defmodule Membrane.Caps.Audio.Raw.SerializedFormat do
  use Bitwise
  alias Membrane.Caps.Audio.Raw, as: Caps

  @le_sample_endianity 0b0 <<< 29
  @be_sample_endianity 0b1 <<< 29
  @unsigned_sample_type 0b0 <<< 30
  @signed_sample_type 0b1 <<< 30
  @int_sample_type 0b0 <<< 31
  @float_sample_type 0b1 <<< 31

  @sample_size (0b1 <<< 8) - 1

  @doc """
  converts audio format to 32-bit integer consisting of (from oldest bit):
    first 2 bits for type
    then 1 bit for endianity
    then sequence of zeroes
    last 8 bits for size (in bits)
  expects atom format
  returns format encoded as integer
  """
  def from_atom(format) do
    0
      ||| if Caps.is_int_format format do @int_sample_type else @float_sample_type end
      ||| if Caps.is_signed format do @signed_sample_type else @unsigned_sample_type end
      ||| if Caps.is_little_endian format do @le_sample_endianity else @be_sample_endianity end
      ||| 8 * Caps.format_to_sample_size! format
  end

  @doc """
  expects serialized format
  returns sample size in bytes as integer
  """
  def sample_size(serialized_format) do
    (serialized_format &&& @sample_size) |> div(8)
  end

end
