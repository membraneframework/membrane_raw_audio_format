defmodule Membrane.Caps.Audio.Raw do
  alias __MODULE__.Format
  alias Membrane.Time

  @moduledoc """
  This module implements struct for caps representing raw audio stream with
  interleaved channels.
  """

  @compile {:inline,
            [
              sample_size: 1,
              frame_size: 1,
              sample_type_float?: 1,
              sample_type_int?: 1,
              big_endian?: 1,
              little_endian?: 1,
              signed?: 1,
              unsigned?: 1,
              sample_to_value: 2,
              value_to_sample: 2,
              value_to_sample_check_overflow: 2,
              sample_min: 1,
              sample_max: 1,
              sound_of_silence: 1,
              frames_to_bytes: 2,
              bytes_to_frames: 3,
              frames_to_time: 3,
              time_to_frames: 3,
              bytes_to_time: 3,
              time_to_bytes: 3,
              format_to_sample_size: 1,
              format_to_sample_size!: 1,
              sample_to_value!: 2,
              value_to_sample!: 2
            ]}

  # Amount of channels inside a frame.
  @type channels_t :: pos_integer

  # Sample rate of the audio.
  @type sample_rate_t :: pos_integer

  @type t :: %Membrane.Caps.Audio.Raw{
          channels: channels_t,
          sample_rate: sample_rate_t,
          format: Format.t()
        }

  defstruct channels: nil,
            sample_rate: nil,
            format: nil

  @doc """
  Returns how many bytes are needed to store a single sample.

  Inlined by the compiler
  """
  @spec sample_size(t) :: integer
  def sample_size(%__MODULE__{format: format}) do
    {_, size, _} = Format.to_tuple(format)
    size |> div(8)
  end

  @doc """
  Returns how many bytes are needed to store a single frame.

  Inlined by the compiler
  """
  @spec frame_size(t) :: integer
  def frame_size(%__MODULE__{channels: channels} = caps) do
    sample_size(caps) * channels
  end

  @doc """
  Determines if format is floating point.

  Inlined by the compiler.
  """
  @spec sample_type_float?(t) :: boolean
  def sample_type_float?(%__MODULE__{format: format}) do
    case Format.to_tuple(format) do
      {:f, _, _} -> true
      _ -> false
    end
  end

  @doc """
  Determines if format is integer.

  Inlined by the compiler.
  """
  @spec sample_type_int?(t) :: boolean
  def sample_type_int?(%__MODULE__{format: format}) do
    case Format.to_tuple(format) do
      {:s, _, _} -> true
      {:u, _, _} -> true
      _ -> false
    end
  end

  @doc """
  Determines if format is little endian.

  Inlined by the compiler.
  """
  @spec little_endian?(t) :: boolean
  def little_endian?(%__MODULE__{format: format}) do
    case Format.to_tuple(format) do
      {_, _, :le} -> true
      {_, _, :any} -> true
      _ -> false
    end
  end

  @doc """
  Determines if format is big endian.

  Inlined by the compiler.
  """
  @spec big_endian?(t) :: boolean
  def big_endian?(%__MODULE__{format: format}) do
    case Format.to_tuple(format) do
      {_, _, :be} -> true
      {_, _, :any} -> true
      _ -> false
    end
  end

  @doc """
  Determines if format is signed.

  Inlined by the compiler.
  """
  @spec signed?(t) :: boolean
  def signed?(%__MODULE__{format: format}) do
    case Format.to_tuple(format) do
      {:s, _, _} -> true
      {:f, _, _} -> true
      _ -> false
    end
  end

  @doc """
  Determines if format is unsigned.

  Inlined by the compiler.
  """
  @spec unsigned?(t) :: boolean
  def unsigned?(%__MODULE__{format: format}) do
    case Format.to_tuple(format) do
      {:u, _, _} -> true
      _ -> false
    end
  end

  @doc """
  Converts one raw sample into its numeric value, interpreting it for given format.

  Inlined by the compiler.
  """
  @spec sample_to_value(bitstring, t | Format.t()) :: number
  def sample_to_value(sample, %__MODULE__{format: format}) do
    sample_to_value(sample, format)
  end

  def sample_to_value(sample, format) when is_atom(format) do
    case Format.to_tuple(format) do
      {:s, size, endianness} when endianness in [:le, :any] ->
        <<value::integer-size(size)-little-signed>> = sample
        value

      {:u, size, endianness} when endianness in [:le, :any] ->
        <<value::integer-size(size)-little-unsigned>> = sample
        value

      {:s, size, :be} ->
        <<value::integer-size(size)-big-signed>> = sample
        value

      {:u, size, :be} ->
        <<value::integer-size(size)-big-unsigned>> = sample
        value

      {:f, size, :le} ->
        <<value::float-size(size)-little>> = sample
        value

      {:f, size, :be} ->
        <<value::float-size(size)-big>> = sample
        value
    end
  end

  @doc """
  Converts value into one raw sample, encoding it in given format.

  Inlined by the compiler.
  """
  @spec value_to_sample(number, t | Format.t()) :: binary
  def value_to_sample(value, %__MODULE__{format: format}) do
    value_to_sample(value, format)
  end

  def value_to_sample(value, format) when is_atom(format) do
    case Format.to_tuple(format) do
      {:s, size, endianness} when endianness in [:le, :any] ->
        <<value::integer-size(size)-little-signed>>

      {:u, size, endianness} when endianness in [:le, :any] ->
        <<value::integer-size(size)-little-unsigned>>

      {:s, size, :be} ->
        <<value::integer-size(size)-big-signed>>

      {:u, size, :be} ->
        <<value::integer-size(size)-big-unsigned>>

      {:f, size, :le} ->
        <<value::float-size(size)-little>>

      {:f, size, :be} ->
        <<value::float-size(size)-big>>
    end
  end

  @doc """
  Same as value_to_sample/2, but also checks for overflow.
  Returns {:error, :overflow} if overflow happens.

  Inlined by the compiler.
  """
  @spec value_to_sample_check_overflow(number, t) :: {:ok, binary} | {:error, :overflow}
  def value_to_sample_check_overflow(value, caps) do
    if sample_min(caps) <= value and sample_max(caps) >= value do
      {:ok, value_to_sample(value, caps)}
    else
      {:error, :overflow}
    end
  end

  @doc """
  Returns minimum sample value for given format.

  Inlined by the compiler.
  """
  @spec sample_min(t) :: number
  def sample_min(%__MODULE__{format: format}) do
    use Bitwise

    case Format.to_tuple(format) do
      {:u, _, _} -> 0
      {:s, size, _} -> -(1 <<< (size - 1))
      {:f, _, _} -> -1.0
    end
  end

  @doc """
  Returns maximum sample value for given format.

  Inlined by the compiler.
  """
  @spec sample_max(t) :: number
  def sample_max(%__MODULE__{format: format}) do
    use Bitwise

    case Format.to_tuple(format) do
      {:s, size, _} -> (1 <<< (size - 1)) - 1
      {:u, size, _} -> (1 <<< size) - 1
      {:f, _, _} -> 1.0
    end
  end

  @doc """
  Returns one 'silent' sample, that is value of zero in given caps' format.

  Inlined by the compiler.
  """
  @spec sound_of_silence(t) :: binary
  def sound_of_silence(%__MODULE__{format: format}) do
    case Format.to_tuple(format) do
      {:s, size, _} ->
        <<0::integer-size(size)>>

      {:f, size, _} ->
        <<0::integer-size(size)>>

      {:u, size, :le} ->
        size = size - 8
        <<0::integer-size(size), 128>>

      {:u, size, :be} ->
        size = size - 8
        <<128, 0::integer-size(size)>>
    end
  end

  @doc """
  Converts frames to bytes in given caps.

  Inlined by the compiler.
  """
  @spec frames_to_bytes(non_neg_integer, t) :: non_neg_integer
  def frames_to_bytes(frames, %__MODULE__{} = caps) when frames >= 0 do
    frames * frame_size(caps)
  end

  @doc """
  Converts bytes to frames in given caps.

  Inlined by the compiler.
  """
  @spec bytes_to_frames(non_neg_integer, t) :: non_neg_integer
  def bytes_to_frames(bytes, %__MODULE__{} = caps, round_f \\ &trunc/1) when bytes >= 0 do
    (bytes / frame_size(caps)) |> round_f.()
  end

  @doc """
  Converts time in Membrane.Time units to frames in given caps.

  Inlined by the compiler.
  """
  @spec time_to_frames(Time.non_neg_t(), t, (float -> integer)) :: non_neg_integer
  def time_to_frames(time, %__MODULE__{} = caps, round_f \\ &(&1 |> :math.ceil() |> trunc))
      when time >= 0 do
    (time * caps.sample_rate / (1 |> Time.second())) |> round_f.()
  end

  @doc """
  Converts frames to time in Membrane.Time units in given caps.

  Inlined by the compiler.
  """
  @spec frames_to_time(non_neg_integer, t, (float -> integer)) :: Time.non_neg_t()
  def frames_to_time(frames, %__MODULE__{} = caps, round_f \\ &trunc/1)
      when frames >= 0 do
    (frames * (1 |> Time.second()) / caps.sample_rate) |> round_f.()
  end

  @doc """
  Converts time in Membrane.Time units to bytes in given caps.

  Inlined by the compiler.
  """
  @spec time_to_bytes(Time.non_neg_t(), t, (float -> integer)) :: non_neg_integer
  def time_to_bytes(time, %__MODULE__{} = caps, round_f \\ &(&1 |> :math.ceil() |> trunc))
      when time >= 0 do
    time_to_frames(time, caps, round_f) |> frames_to_bytes(caps)
  end

  @doc """
  Converts bytes to time in Membrane.Time units in given caps.

  Inlined by the compiler.
  """
  @spec bytes_to_time(non_neg_integer, t, (float -> integer)) :: Time.non_neg_t()
  def bytes_to_time(bytes, %__MODULE__{} = caps, round_f \\ &trunc/1)
      when bytes >= 0 do
    frames_to_time(bytes |> bytes_to_frames(caps), caps, round_f)
  end

  @doc """
  Returns how many bytes are needed to store single frame of given format.

  Inlined by the compiler.
  """
  @spec format_to_sample_size(Format.t()) :: {:ok, pos_integer}
  @deprecated "Use sample_size/2 instead, mind the new typespec"
  def format_to_sample_size(:s8), do: {:ok, 1}
  def format_to_sample_size(:u8), do: {:ok, 1}
  def format_to_sample_size(:s16le), do: {:ok, 2}
  def format_to_sample_size(:s24le), do: {:ok, 3}
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
  @spec format_to_sample_size!(Format.t()) :: pos_integer
  @deprecated "Use sample_size/2 instead, mind the new typespec"
  def format_to_sample_size!(format) do
    {:ok, value} = format_to_sample_size(format)
    value
  end

  @doc """
  Same as value_to_sample/2, but returns just a plain binary

  Inlined by the compiler.
  """
  @spec value_to_sample!(number, Format.t()) :: binary
  @deprecated "Use value_to_sample/2 instead, mind the new typespec"
  def value_to_sample!(value, format) do
    value_to_sample(value, format)
  end

  @doc """
  Similar to `sample_to_value/2` but returns just plain value.

  Inlined by the compiler.
  """
  @spec sample_to_value!(bitstring, Format.t()) :: number
  @deprecated "Use sample_to_value/2 instead, mind the new typespec"
  def sample_to_value!(sample, format) do
    sample_to_value(sample, format)
  end
end
