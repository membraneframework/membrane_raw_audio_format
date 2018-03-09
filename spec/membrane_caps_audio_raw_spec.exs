defmodule Membrane.Caps.Audio.RawSpec do
  use ESpec, async: true
  alias Membrane.Caps.Audio.Raw, as: Caps


  defp format_to_caps(format) do
    %Caps{format: format, channels: 2, sample_rate: 44100}
  end

  describe "sample_size/1" do
    it "should return proper sample sizes" do
      [u8: 1, s16le: 2, s24be: 3, u32le: 4, f32le: 4]
        |> Enum.each(fn {format, size} ->
            caps = format |> format_to_caps
            expect(described_module().sample_size(caps)).to eq size
          end)
    end
  end


  describe ".sample_to_value/2" do
    context "if format is :s8" do
      let :caps, do: :s8 |> format_to_caps
      let :value, do: -123
      let :sample, do: << value() :: integer-unit(8)-size(1)-signed >>
      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())).to eq value()
      end
    end

    context "if format is :u8" do
      let :caps, do: :u8 |> format_to_caps
      let :value, do: 123
      let :sample, do: << value() :: integer-unit(8)-size(1)-unsigned >>
      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())).to eq value()
      end
    end

    context "if format is :s16le" do
      let :caps, do: :s16le |> format_to_caps
      let :value, do: -1234
      let :sample, do: << value() :: integer-unit(8)-size(2)-little-signed >>
      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())).to eq value()
      end
    end

    context "if format is :s32le" do
      let :caps, do: :s32le |> format_to_caps
      let :value, do: -1234
      let :sample, do: << value() :: integer-unit(8)-size(4)-little-signed >>
      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())).to eq value()
      end
    end

    context "if format is :u16le" do
      let :caps, do: :u16le |> format_to_caps
      let :value, do: 1234
      let :sample, do: << value() :: integer-unit(8)-size(2)-little-unsigned >>
      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())).to eq value()
      end
    end

    context "if format is :u32le" do
      let :caps, do: :u32le |> format_to_caps
      let :value, do: 1234
      let :sample, do: << value() :: integer-unit(8)-size(4)-little-unsigned >>
      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())).to eq value()
      end
    end

    context "if format is :f32le" do
      let :caps, do: :f32le |> format_to_caps
      let :value, do: 1234.0
      let :sample, do: << value() :: float-unit(8)-size(4)-little >>
      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())).to eq value()
      end
    end

    context "if format is :s16be" do
      let :caps, do: :s16be |> format_to_caps
      let :value, do: -1234
      let :sample, do: << value() :: integer-unit(8)-size(2)-big-signed >>
      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())).to eq value()
      end
    end

    context "if format is :s32be" do
      let :caps, do: :s32be |> format_to_caps
      let :value, do: -1234
      let :sample, do: << value() :: integer-unit(8)-size(4)-big-signed >>
      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())).to eq value()
      end
    end

    context "if format is :u16be" do
      let :caps, do: :u16be |> format_to_caps
      let :value, do: 1234
      let :sample, do: << value() :: integer-unit(8)-size(2)-big-unsigned >>
      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())).to eq value()
      end
    end

    context "if format is :u32be" do
      let :caps, do: :u32be |> format_to_caps
      let :value, do: 1234
      let :sample, do: << value() :: integer-unit(8)-size(4)-big-unsigned >>
      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())).to eq value()
      end
    end

    context "if format is :f32be" do
      let :caps, do: :f32be |> format_to_caps
      let :value, do: 1234.0
      let :sample, do: << value() :: float-unit(8)-size(4)-big >>
      it "should return {:ok, decoded value}" do
        expect(described_module().sample_to_value(sample(), caps())).to eq value()
      end
    end
  end


  describe ".sample_min/1" do
    context "if format is :s8" do
      let :caps, do: :s8 |> format_to_caps
      let :value, do: -128
      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())).to eq value()
      end
    end

    context "if format is :u8" do
      let :caps, do: :u8 |> format_to_caps
      let :value, do: 0
      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())).to eq value()
      end
    end

    context "if format is :s16le" do
      let :caps, do: :s16le |> format_to_caps
      let :value, do: -32768
      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())).to eq value()
      end
    end

    context "if format is :s32le" do
      let :caps, do: :s32le |> format_to_caps
      let :value, do: -2147483648
      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())).to eq value()
      end
    end

    context "if format is :u16le" do
      let :caps, do: :u16le |> format_to_caps
      let :value, do: 0
      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())).to eq value()
      end
    end

    context "if format is :u32le" do
      let :caps, do: :u32le |> format_to_caps
      let :value, do: 0
      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())).to eq value()
      end
    end

    context "if format is :s16be" do
      let :caps, do: :s16be |> format_to_caps
      let :value, do: -32768
      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())).to eq value()
      end
    end

    context "if format is :s32be" do
      let :caps, do: :s32be |> format_to_caps
      let :value, do: -2147483648
      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())).to eq value()
      end
    end

    context "if format is :u16be" do
      let :caps, do: :u16be |> format_to_caps
      let :value, do: 0
      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())).to eq value()
      end
    end

    context "if format is :u32be" do
      let :caps, do: :u32be |> format_to_caps
      let :value, do: 0
      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())).to eq value()
      end
    end

    context "if format is :f32le" do
      let :caps, do: :f32le |> format_to_caps
      let :value, do: -1.0
      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())).to eq value()
      end
    end

    context "if format is :f32be" do
      let :caps, do: :f32be |> format_to_caps
      let :value, do: -1.0
      it "should return minimum integer for underlying data type" do
        expect(described_module().sample_min(caps())).to eq value()
      end
    end
  end


  describe ".sample_max/1" do
    context "if format is :s8" do
      let :caps, do: :s8 |> format_to_caps
      let :value, do: 127
      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())).to eq value()
      end
    end

    context "if format is :u8" do
      let :caps, do: :u8 |> format_to_caps
      let :value, do: 255
      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())).to eq value()
      end
    end

    context "if format is :s16le" do
      let :caps, do: :s16le |> format_to_caps
      let :value, do: 32767
      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())).to eq value()
      end
    end

    context "if format is :s32le" do
      let :caps, do: :s32le |> format_to_caps
      let :value, do: 2147483647
      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())).to eq value()
      end
    end

    context "if format is :u16le" do
      let :caps, do: :u16le |> format_to_caps
      let :value, do: 65535
      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())).to eq value()
      end
    end

    context "if format is :u32le" do
      let :caps, do: :u32le |> format_to_caps
      let :value, do: 4294967295
      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())).to eq value()
      end
    end

    context "if format is :s16be" do
      let :caps, do: :s16be |> format_to_caps
      let :value, do: 32767
      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())).to eq value()
      end
    end

    context "if format is :s32be" do
      let :caps, do: :s32be |> format_to_caps
      let :value, do: 2147483647
      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())).to eq value()
      end
    end

    context "if format is :u16be" do
      let :caps, do: :u16be |> format_to_caps
      let :value, do: 65535
      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())).to eq value()
      end
    end

    context "if format is :u32be" do
      let :caps, do: :u32be |> format_to_caps
      let :value, do: 4294967295
      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())).to eq value()
      end
    end

    context "if format is :f32le" do
      let :caps, do: :f32le |> format_to_caps
      let :value, do: 1.0
      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())).to eq value()
      end
    end

    context "if format is :f32be" do
      let :caps, do: :f32be |> format_to_caps
      let :value, do: 1.0
      it "should return maximum integer for underlying data type" do
        expect(described_module().sample_max(caps())).to eq value()
      end
    end
  end
end
