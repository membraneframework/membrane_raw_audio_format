defmodule Membrane.Caps.Audio.Raw.SerializedFormat do
  @moduledoc """
  Module provides functionality for serializing caps format, so that it can be
  conveniently passed to the native code.
  """

  use Bitwise
  alias Membrane.Caps.Audio.Raw, as: Caps

  @compile {:inline, [
    from_atom: 1,
    sample_size: 1,
  ]}

  @int_sample_type 0b0 <<< 31
  @float_sample_type 0b1 <<< 31
  @unsigned_sample_type 0b0 <<< 30
  @signed_sample_type 0b1 <<< 30
  @le_sample_endianity 0b0 <<< 29
  @be_sample_endianity 0b1 <<< 29

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

  inlined by compiler
  """
  @spec from_atom(Caps.format_t) :: pos_integer
  def from_atom format do
    0
      ||| if Caps.is_int_format format do @int_sample_type else @float_sample_type end
      ||| if Caps.is_signed format do @signed_sample_type else @unsigned_sample_type end
      ||| if Caps.is_little_endian format do @le_sample_endianity else @be_sample_endianity end
      ||| 8 * Caps.format_to_sample_size! format
  end

  @doc """
  expects serialized format

  returns sample size in bytes as integer

  inlined by compiler
  """
  @spec sample_size(pos_integer) :: pos_integer
  def sample_size serialized_format do
    (serialized_format &&& @sample_size) |> div(8)
  end

end