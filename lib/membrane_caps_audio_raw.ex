defmodule Membrane.Caps.Audio.Raw do
  @moduledoc """
  This module implements struct for caps representing raw audio stream with
  interleaved channels.
  """

  @compile {:inline, format_to_frame_size: 1}


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
    :f16le |
    :f32le |
    :f16be |
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
  @spec format_to_frame_size(format_t) :: pos_integer
  def format_to_frame_size(:s8), do: 1
  def format_to_frame_size(:u8), do: 1
  def format_to_frame_size(:s16le), do: 2
  def format_to_frame_size(:s24le), do: 3
  def format_to_frame_size(:s32le), do: 4
  def format_to_frame_size(:u16le), do: 2
  def format_to_frame_size(:u24le), do: 3
  def format_to_frame_size(:u32le), do: 4
  def format_to_frame_size(:s16be), do: 2
  def format_to_frame_size(:s24be), do: 3
  def format_to_frame_size(:s32be), do: 4
  def format_to_frame_size(:u16be), do: 2
  def format_to_frame_size(:u24be), do: 3
  def format_to_frame_size(:u32be), do: 4
  def format_to_frame_size(:f16le), do: 2
  def format_to_frame_size(:f32le), do: 4
  def format_to_frame_size(:f16be), do: 2
  def format_to_frame_size(:f32be), do: 4
end
