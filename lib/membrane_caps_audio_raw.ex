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
    :s24le |
    :s32le |
    :u16le |
    :u24le |
    :u32le |
    :s16be |
    :s24be |
    :s32be |
    :u16be |
    :u24be |
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
  def format_to_sample_size(:s24le), do: {:ok, 3}
  def format_to_sample_size(:s32le), do: {:ok, 4}
  def format_to_sample_size(:u16le), do: {:ok, 2}
  def format_to_sample_size(:u24le), do: {:ok, 3}
  def format_to_sample_size(:u32le), do: {:ok, 4}
  def format_to_sample_size(:s16be), do: {:ok, 2}
  def format_to_sample_size(:s24be), do: {:ok, 3}
  def format_to_sample_size(:s32be), do: {:ok, 4}
  def format_to_sample_size(:u16be), do: {:ok, 2}
  def format_to_sample_size(:u24be), do: {:ok, 3}
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

  def sample_to_value(sample, :s24le) do
    << value :: integer-unit(8)-size(3)-little-signed >> = sample
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

  def sample_to_value(sample, :u24le) do
    << value :: integer-unit(8)-size(3)-little-unsigned >> = sample
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

  def sample_to_value(sample, :s24be) do
    << value :: integer-unit(8)-size(3)-big-signed >> = sample
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

  def sample_to_value(sample, :u24be) do
    << value :: integer-unit(8)-size(3)-big-unsigned >> = sample
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
  Similar to `sample_to_value/2` but returns just plain value.

  Inlined by the compiler.
  """
  @spec sample_to_value!(bitstring, format_t) :: integer | float
  def sample_to_value!(sample, format) do
    {:ok, value} = sample_to_value(sample, format)
    value
  end
end
