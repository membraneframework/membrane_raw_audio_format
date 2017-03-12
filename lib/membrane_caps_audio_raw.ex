defmodule Membrane.Caps.Audio.Raw do
  @moduledoc """
  This module implements struct for caps representing raw audio stream with
  interleaved channels.
  """

  @compile {:inline, [
    format_to_sample_size: 1,
    format_to_sample_size!: 1,
    sample_to_value: 2,
    sample_to_value!: 2,
    value_to_sample: 2,
    value_to_sample!: 2,
    value_to_sample_check_overflow: 2,
    sample_min: 1,
    sample_max: 1,
    is_signed: 1,
    is_unsigned: 1,
    is_int_format: 1,
    is_float_format: 1,
    sound_of_silence: 1,
  ]}


  # Amount of channels inside a frame.
  @type channels_t :: pos_integer


  # Sample rate of the audio.
  @type sample_rate_t :: pos_integer


  # Frame format.
  @type format_t ::
    :s8 |
    :u8 |
    :s16le |
    :s32le |
    :u16le |
    :u32le |
    :s16be |
    :s32be |
    :u16be |
    :u32be |
    :f32le |
    :f32be


  @type t :: %Membrane.Caps.Audio.Raw{
    channels: channels_t,
    sample_rate: sample_rate_t,
    format: format_t
  }

  defstruct \
    channels: nil,
    sample_rate: nil,
    format: nil


  @doc """
  Returns how many bytes are needed to store single frame of given format.

  Inlined by the compiler.
  """
  @spec format_to_sample_size(format_t) :: {:ok, pos_integer}
  def format_to_sample_size(:s8), do: {:ok, 1}
  def format_to_sample_size(:u8), do: {:ok, 1}
  def format_to_sample_size(:s16le), do: {:ok, 2}
  def format_to_sample_size(:s32le), do: {:ok, 4}
  def format_to_sample_size(:u16le), do: {:ok, 2}
  def format_to_sample_size(:u32le), do: {:ok, 4}
  def format_to_sample_size(:s16be), do: {:ok, 2}
  def format_to_sample_size(:s32be), do: {:ok, 4}
  def format_to_sample_size(:u16be), do: {:ok, 2}
  def format_to_sample_size(:u32be), do: {:ok, 4}
  def format_to_sample_size(:f32le), do: {:ok, 4}
  def format_to_sample_size(:f32be), do: {:ok, 4}


  @doc """
  Similar to `format_to_sample_size/1` but returns just plain value.

  Inlined by the compiler.
  """
  @spec format_to_sample_size!(format_t) :: pos_integer
  def format_to_sample_size!(format) do
    {:ok, value} = format_to_sample_size(format)
    value
  end

  @doc """
  Returns one 'silent' sample in given format, that is value of zero in this
  format.

  Inlined by the compiler.
  """
  @spec sound_of_silence(format_t) :: binary
  def sound_of_silence(:s8), do: <<0>>
  def sound_of_silence(:u8), do: <<128>>
  def sound_of_silence(:s16le), do: <<0, 0>>
  def sound_of_silence(:s16be), do: <<0, 0>>
  def sound_of_silence(:u16le), do: <<0, 128>>
  def sound_of_silence(:u16be), do: <<128, 0>>
  def sound_of_silence(:s32le), do: <<0, 0, 0, 0>>
  def sound_of_silence(:s32be), do: <<0, 0, 0, 0>>
  def sound_of_silence(:u32le), do: <<0, 0, 0, 128>>
  def sound_of_silence(:u32be), do: <<128, 0, 0, 0>>
  def sound_of_silence(:f32le), do: <<0, 0, 0, 0>>
  def sound_of_silence(:f32be), do: <<0, 0, 0, 0>>

  @doc """
  Determines if format is floating point.

  Inlined by the compiler.
  """
  @spec is_float_format(format_t) :: boolean
  def is_float_format(:f32le), do: true
  def is_float_format(:f32be), do: true
  def is_float_format(_), do: false

  @doc """
  Determines if format is integer.

  Inlined by the compiler.
  """
  @spec is_int_format(format_t) :: boolean
  def is_int_format(format), do: !is_float(format)

  @doc """
  Determines if format is signed.

  Inlined by the compiler.
  """
  @spec is_signed(format_t) :: boolean
  def is_signed(:s8), do: true
  def is_signed(:s16le), do: true
  def is_signed(:s16be), do: true
  def is_signed(:s32le), do: true
  def is_signed(:s32be), do: true
  def is_signed(:f32le), do: true
  def is_signed(:f32be), do: true
  def is_signed(_), do: false


  @doc """
  Determines if format is unsigned.

  Inlined by the compiler.
  """
  @spec is_unsigned(format_t) :: boolean
  def is_unsigned(format), do: !is_signed(format)


  @doc """
  Converts one raw sample into its numeric value, interpreting it for given format.

  Inlined by the compiler.
  """
  @spec sample_to_value(bitstring, format_t) :: {:ok, integer | float}
  def sample_to_value(sample, :s8) do
    << value :: integer-unit(8)-size(1)-signed >> = sample
    {:ok, value}
  end

  def sample_to_value(sample, :u8) do
    << value :: integer-unit(8)-size(1)-unsigned >> = sample
    {:ok, value}
  end

  def sample_to_value(sample, :s16le) do
    << value :: integer-unit(8)-size(2)-little-signed >> = sample
    {:ok, value}
  end

  def sample_to_value(sample, :s32le) do
    << value :: integer-unit(8)-size(4)-little-signed >> = sample
    {:ok, value}
  end

  def sample_to_value(sample, :u16le) do
    << value :: integer-unit(8)-size(2)-little-unsigned >> = sample
    {:ok, value}
  end

  def sample_to_value(sample, :u32le) do
    << value :: integer-unit(8)-size(4)-little-unsigned >> = sample
    {:ok, value}
  end

  def sample_to_value(sample, :f32le) do
    << value :: float-unit(8)-size(4)-little >> = sample
    {:ok, value}
  end

  def sample_to_value(sample, :s16be) do
    << value :: integer-unit(8)-size(2)-big-signed >> = sample
    {:ok, value}
  end

  def sample_to_value(sample, :s32be) do
    << value :: integer-unit(8)-size(4)-big-signed >> = sample
    {:ok, value}
  end

  def sample_to_value(sample, :u16be) do
    << value :: integer-unit(8)-size(2)-big-unsigned >> = sample
    {:ok, value}
  end

  def sample_to_value(sample, :u32be) do
    << value :: integer-unit(8)-size(4)-big-unsigned >> = sample
    {:ok, value}
  end

  def sample_to_value(sample, :f32be) do
    << value :: float-unit(8)-size(4)-big >> = sample
    {:ok, value}
  end


  @doc """
  Converts value into one raw sample, encoding it in given format.

  Inlined by the compiler.
  """
  @spec value_to_sample(bitstring, format_t) :: {:ok, binary}
  def value_to_sample(value, :s8) do
    {:ok, << value :: integer-unit(8)-size(1)-signed >> }
  end

  def value_to_sample(value, :u8) do
    {:ok, << value :: integer-unit(8)-size(1)-unsigned >> }
  end

  def value_to_sample(value, :s16le) do
    {:ok, << value :: integer-unit(8)-size(2)-little-signed >> }
  end

  def value_to_sample(value, :s32le) do
    {:ok, << value :: integer-unit(8)-size(4)-little-signed >> }
  end

  def value_to_sample(value, :u16le) do
    {:ok, << value :: integer-unit(8)-size(2)-little-unsigned >> }
  end

  def value_to_sample(value, :u32le) do
    {:ok, << value :: integer-unit(8)-size(4)-little-unsigned >> }
  end

  def value_to_sample(value, :f32le) do
    {:ok, << value :: float-unit(8)-size(4)-little >> }
  end

  def value_to_sample(value, :s16be) do
    {:ok, << value :: integer-unit(8)-size(2)-big-signed >> }
  end

  def value_to_sample(value, :s32be) do
    {:ok, << value :: integer-unit(8)-size(4)-big-signed >> }
  end

  def value_to_sample(value, :u16be) do
    {:ok, << value :: integer-unit(8)-size(2)-big-unsigned >> }
  end

  def value_to_sample(value, :u32be) do
    {:ok, << value :: integer-unit(8)-size(4)-big-unsigned >> }
  end

  def value_to_sample(value, :f32be) do
    {:ok, << value :: float-unit(8)-size(4)-big >> }
  end

  @doc """
  Same as value_to_sample/2, but returns just a plain binary

  Inlined by the compiler.
  """
  @spec value_to_sample!(bitstring, format_t) :: binary
  def value_to_sample!(value, format) do
    {:ok, sample} = value_to_sample(value, format)
    sample
  end

  @doc """
  Same as value_to_sample/2, but also checks for overflow.
  Returns {:error, :overflow} if overflow happens.

  Inlined by the compiler.
  """
  @spec value_to_sample_check_overflow(bitstring, format_t)
    :: {:ok, binary} | {:error, :overflow}
  def value_to_sample_check_overflow(value, format) do
    if sample_min(format) <= value and sample_max(format) >= value do
      value_to_sample(value, format)
    else
      {:error, :overflow}
    end
  end

  @doc """
  Returns minimum sample value for given format.

  Inlined by the compiler.
  """
  @spec sample_min(format_t) :: integer | float
  def sample_min(:s8), do: -128
  def sample_min(:u8), do: 0
  def sample_min(:s16le), do: -32768
  def sample_min(:s32le), do: -2147483648
  def sample_min(:u16le), do: 0
  def sample_min(:u32le), do: 0
  def sample_min(:s16be), do: -32768
  def sample_min(:s32be), do: -2147483648
  def sample_min(:u16be), do: 0
  def sample_min(:u32be), do: 0
  def sample_min(:f32le), do: -1.0
  def sample_min(:f32be), do: -1.0


  @doc """
  Returns maximum sample value for given format.
  Inlined by the compiler.

  """
  @spec sample_max(format_t) :: integer | float
  def sample_max(:s8), do: 127
  def sample_max(:u8), do: 255
  def sample_max(:s16le), do: 32767
  def sample_max(:s32le), do: 2147483647
  def sample_max(:u16le), do: 65535
  def sample_max(:u32le), do: 4294967295
  def sample_max(:s16be), do: 32767
  def sample_max(:s32be), do: 2147483647
  def sample_max(:u16be), do: 65535
  def sample_max(:u32be), do: 4294967295
  def sample_max(:f32le), do: 1.0
  def sample_max(:f32be), do: 1.0


  @doc """
  Similar to `sample_to_value/2` but returns just plain value.

  Inlined by the compiler.
  """
  @spec sample_to_value!(bitstring, format_t) :: integer | float
  def sample_to_value!(sample, format) do
    {:ok, value} = sample_to_value(sample, format)
    value
  end
end
