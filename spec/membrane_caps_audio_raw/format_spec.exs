defmodule Membrane.Caps.Audio.Raw.FormatSpec do
  use ESpec, async: true

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
      :f32be
    ]

  let :all_tuples,
    do: [
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
      {:f, 32, :be}
    ]

  describe "to_tuple/1" do
    it "should split format atom to proper 3-element tuple" do
      Enum.zip(all_formats(), all_tuples())
      |> Enum.each(fn {fmt, tuple} ->
        expect(described_module().to_tuple(fmt)) |> to(eq tuple)
      end)
    end
  end

  describe "from_tuple/1" do
    it "should join 3-element tuple to proper format atom" do
      Enum.zip(all_tuples(), all_formats())
      |> Enum.each(fn {tuple, fmt} ->
        expect(described_module().from_tuple(tuple)) |> to(eq fmt)
      end)
    end
  end

  describe "Using serialize/1 and then deserialize/1" do
    it "should not change the format" do
      all_formats()
      |> Enum.each(fn fmt ->
        result = fmt |> described_module().serialize() |> described_module().deserialize()
        expect(result) |> to(eq fmt)
      end)
    end
  end
end
