defmodule Membrane.Caps.Audio.RawSpec do
  use ESpec, async: true


  describe ".format_to_sample_size/1" do
    context "if format is :s8" do
      let :format, do: :s8
      it "should return {:ok, 1}" do
        expect(described_module.format_to_sample_size(format)).to eq {:ok, 1}
      end
    end

    context "if format is :u8" do
      let :format, do: :u8
      it "should return {:ok, 1}" do
        expect(described_module.format_to_sample_size(format)).to eq {:ok, 1}
      end
    end

    context "if format is :s16le" do
      let :format, do: :s16le
      it "should return {:ok, 2}" do
        expect(described_module.format_to_sample_size(format)).to eq {:ok, 2}
      end
    end

    context "if format is :s24le" do
      let :format, do: :s24le
      it "should return {:ok, 3}" do
        expect(described_module.format_to_sample_size(format)).to eq {:ok, 3}
      end
    end

    context "if format is :s32le" do
      let :format, do: :s32le
      it "should return {:ok, 4}" do
        expect(described_module.format_to_sample_size(format)).to eq {:ok, 4}
      end
    end

    context "if format is :u16le" do
      let :format, do: :u16le
      it "should return {:ok, 2}" do
        expect(described_module.format_to_sample_size(format)).to eq {:ok, 2}
      end
    end

    context "if format is :u24le" do
      let :format, do: :u24le
      it "should return {:ok, 3}" do
        expect(described_module.format_to_sample_size(format)).to eq {:ok, 3}
      end
    end

    context "if format is :u32le" do
      let :format, do: :u32le
      it "should return {:ok, 4}" do
        expect(described_module.format_to_sample_size(format)).to eq {:ok, 4}
      end
    end

    context "if format is :s16be" do
      let :format, do: :s16be
      it "should return {:ok, 2}" do
        expect(described_module.format_to_sample_size(format)).to eq {:ok, 2}
      end
    end

    context "if format is :s24be" do
      let :format, do: :s24be
      it "should return {:ok, 3}" do
        expect(described_module.format_to_sample_size(format)).to eq {:ok, 3}
      end
    end

    context "if format is :s32be" do
      let :format, do: :s32be
      it "should return {:ok, 4}" do
        expect(described_module.format_to_sample_size(format)).to eq {:ok, 4}
      end
    end

    context "if format is :u16be" do
      let :format, do: :u16be
      it "should return {:ok, 2}" do
        expect(described_module.format_to_sample_size(format)).to eq {:ok, 2}
      end
    end

    context "if format is :u24be" do
      let :format, do: :u24be
      it "should return {:ok, 3}" do
        expect(described_module.format_to_sample_size(format)).to eq {:ok, 3}
      end
    end

    context "if format is :u32be" do
      let :format, do: :u32be
      it "should return {:ok, 4}" do
        expect(described_module.format_to_sample_size(format)).to eq {:ok, 4}
      end
    end

    context "if format is :f32le" do
      let :format, do: :f32le
      it "should return {:ok, 4}" do
        expect(described_module.format_to_sample_size(format)).to eq {:ok, 4}
      end
    end

    context "if format is :f32be" do
      let :format, do: :f32be
      it "should return {:ok, 4}" do
        expect(described_module.format_to_sample_size(format)).to eq {:ok, 4}
      end
    end
  end


  describe ".sample_to_value/2" do
    context "if format is :s8" do
      let :format, do: :s8
      let :value, do: -123
      let :sample, do: << value :: integer-unit(8)-size(1)-signed >>
      it "should return {:ok, decoded value}" do
        expect(described_module.sample_to_value(sample, format)).to eq {:ok, value}
      end
    end

    context "if format is :u8" do
      let :format, do: :u8
      let :value, do: 123
      let :sample, do: << value :: integer-unit(8)-size(1)-unsigned >>
      it "should return {:ok, decoded value}" do
        expect(described_module.sample_to_value(sample, format)).to eq {:ok, value}
      end
    end

    context "if format is :s16le" do
      let :format, do: :s16le
      let :value, do: -1234
      let :sample, do: << value :: integer-unit(8)-size(2)-little-signed >>
      it "should return {:ok, decoded value}" do
        expect(described_module.sample_to_value(sample, format)).to eq {:ok, value}
      end
    end

    context "if format is :s24le" do
      let :format, do: :s24le
      let :value, do: -1234
      let :sample, do: << value :: integer-unit(8)-size(3)-little-signed >>
      it "should return {:ok, decoded value}" do
        expect(described_module.sample_to_value(sample, format)).to eq {:ok, value}
      end
    end

    context "if format is :s32le" do
      let :format, do: :s32le
      let :value, do: -1234
      let :sample, do: << value :: integer-unit(8)-size(4)-little-signed >>
      it "should return {:ok, decoded value}" do
        expect(described_module.sample_to_value(sample, format)).to eq {:ok, value}
      end
    end

    context "if format is :u16le" do
      let :format, do: :u16le
      let :value, do: 1234
      let :sample, do: << value :: integer-unit(8)-size(2)-little-unsigned >>
      it "should return {:ok, decoded value}" do
        expect(described_module.sample_to_value(sample, format)).to eq {:ok, value}
      end
    end

    context "if format is :u24le" do
      let :format, do: :u24le
      let :value, do: 1234
      let :sample, do: << value :: integer-unit(8)-size(3)-little-unsigned >>
      it "should return {:ok, decoded value}" do
        expect(described_module.sample_to_value(sample, format)).to eq {:ok, value}
      end
    end

    context "if format is :u32le" do
      let :format, do: :u32le
      let :value, do: 1234
      let :sample, do: << value :: integer-unit(8)-size(4)-little-unsigned >>
      it "should return {:ok, decoded value}" do
        expect(described_module.sample_to_value(sample, format)).to eq {:ok, value}
      end
    end

    context "if format is :f32le" do
      let :format, do: :f32le
      let :value, do: 1234.0
      let :sample, do: << value :: float-unit(8)-size(4)-little >>
      it "should return {:ok, decoded value}" do
        expect(described_module.sample_to_value(sample, format)).to eq {:ok, value}
      end
    end

    context "if format is :s16be" do
      let :format, do: :s16be
      let :value, do: -1234
      let :sample, do: << value :: integer-unit(8)-size(2)-big-signed >>
      it "should return {:ok, decoded value}" do
        expect(described_module.sample_to_value(sample, format)).to eq {:ok, value}
      end
    end

    context "if format is :s24be" do
      let :format, do: :s24be
      let :value, do: -1234
      let :sample, do: << value :: integer-unit(8)-size(3)-big-signed >>
      it "should return {:ok, decoded value}" do
        expect(described_module.sample_to_value(sample, format)).to eq {:ok, value}
      end
    end

    context "if format is :s32be" do
      let :format, do: :s32be
      let :value, do: -1234
      let :sample, do: << value :: integer-unit(8)-size(4)-big-signed >>
      it "should return {:ok, decoded value}" do
        expect(described_module.sample_to_value(sample, format)).to eq {:ok, value}
      end
    end

    context "if format is :u16be" do
      let :format, do: :u16be
      let :value, do: 1234
      let :sample, do: << value :: integer-unit(8)-size(2)-big-unsigned >>
      it "should return {:ok, decoded value}" do
        expect(described_module.sample_to_value(sample, format)).to eq {:ok, value}
      end
    end

    context "if format is :u24be" do
      let :format, do: :u24be
      let :value, do: 1234
      let :sample, do: << value :: integer-unit(8)-size(3)-big-unsigned >>
      it "should return {:ok, decoded value}" do
        expect(described_module.sample_to_value(sample, format)).to eq {:ok, value}
      end
    end

    context "if format is :u32be" do
      let :format, do: :u32be
      let :value, do: 1234
      let :sample, do: << value :: integer-unit(8)-size(4)-big-unsigned >>
      it "should return {:ok, decoded value}" do
        expect(described_module.sample_to_value(sample, format)).to eq {:ok, value}
      end
    end

    context "if format is :f32be" do
      let :format, do: :f32be
      let :value, do: 1234.0
      let :sample, do: << value :: float-unit(8)-size(4)-big >>
      it "should return {:ok, decoded value}" do
        expect(described_module.sample_to_value(sample, format)).to eq {:ok, value}
      end
    end
  end


  describe ".format_to_sample_size!/1" do
    context "if format is :s8" do
      let :format, do: :s8
      it "should return 1" do
        expect(described_module.format_to_sample_size!(format)).to eq 1
      end
    end

    context "if format is :u8" do
      let :format, do: :u8
      it "should return 1" do
        expect(described_module.format_to_sample_size!(format)).to eq 1
      end
    end

    context "if format is :s16le" do
      let :format, do: :s16le
      it "should return 2" do
        expect(described_module.format_to_sample_size!(format)).to eq 2
      end
    end

    context "if format is :s24le" do
      let :format, do: :s24le
      it "should return 3" do
        expect(described_module.format_to_sample_size!(format)).to eq 3
      end
    end

    context "if format is :s32le" do
      let :format, do: :s32le
      it "should return 4" do
        expect(described_module.format_to_sample_size!(format)).to eq 4
      end
    end

    context "if format is :u16le" do
      let :format, do: :u16le
      it "should return 2" do
        expect(described_module.format_to_sample_size!(format)).to eq 2
      end
    end

    context "if format is :u24le" do
      let :format, do: :u24le
      it "should return 3" do
        expect(described_module.format_to_sample_size!(format)).to eq 3
      end
    end

    context "if format is :u32le" do
      let :format, do: :u32le
      it "should return 4" do
        expect(described_module.format_to_sample_size!(format)).to eq 4
      end
    end

    context "if format is :s16be" do
      let :format, do: :s16be
      it "should return 2" do
        expect(described_module.format_to_sample_size!(format)).to eq 2
      end
    end

    context "if format is :s24be" do
      let :format, do: :s24be
      it "should return 3" do
        expect(described_module.format_to_sample_size!(format)).to eq 3
      end
    end

    context "if format is :s32be" do
      let :format, do: :s32be
      it "should return 4" do
        expect(described_module.format_to_sample_size!(format)).to eq 4
      end
    end

    context "if format is :u16be" do
      let :format, do: :u16be
      it "should return 2" do
        expect(described_module.format_to_sample_size!(format)).to eq 2
      end
    end

    context "if format is :u24be" do
      let :format, do: :u24be
      it "should return 3" do
        expect(described_module.format_to_sample_size!(format)).to eq 3
      end
    end

    context "if format is :u32be" do
      let :format, do: :u32be
      it "should return 4" do
        expect(described_module.format_to_sample_size!(format)).to eq 4
      end
    end

    context "if format is :f32le" do
      let :format, do: :f32le
      it "should return 4" do
        expect(described_module.format_to_sample_size!(format)).to eq 4
      end
    end

    context "if format is :f32be" do
      let :format, do: :f32be
      it "should return 4" do
        expect(described_module.format_to_sample_size!(format)).to eq 4
      end
    end
  end


  describe ".sample_to_value!/2" do
    context "if format is :s8" do
      let :format, do: :s8
      let :value, do: -123
      let :sample, do: << value :: integer-unit(8)-size(1)-signed >>
      it "should return decoded value" do
        expect(described_module.sample_to_value!(sample, format)).to eq value
      end
    end

    context "if format is :u8" do
      let :format, do: :u8
      let :value, do: 123
      let :sample, do: << value :: integer-unit(8)-size(1)-unsigned >>
      it "should return decoded value" do
        expect(described_module.sample_to_value!(sample, format)).to eq value
      end
    end

    context "if format is :s16le" do
      let :format, do: :s16le
      let :value, do: -1234
      let :sample, do: << value :: integer-unit(8)-size(2)-little-signed >>
      it "should return decoded value" do
        expect(described_module.sample_to_value!(sample, format)).to eq value
      end
    end

    context "if format is :s24le" do
      let :format, do: :s24le
      let :value, do: -1234
      let :sample, do: << value :: integer-unit(8)-size(3)-little-signed >>
      it "should return decoded value" do
        expect(described_module.sample_to_value!(sample, format)).to eq value
      end
    end

    context "if format is :s32le" do
      let :format, do: :s32le
      let :value, do: -1234
      let :sample, do: << value :: integer-unit(8)-size(4)-little-signed >>
      it "should return decoded value" do
        expect(described_module.sample_to_value!(sample, format)).to eq value
      end
    end

    context "if format is :u16le" do
      let :format, do: :u16le
      let :value, do: 1234
      let :sample, do: << value :: integer-unit(8)-size(2)-little-unsigned >>
      it "should return decoded value" do
        expect(described_module.sample_to_value!(sample, format)).to eq value
      end
    end

    context "if format is :u24le" do
      let :format, do: :u24le
      let :value, do: 1234
      let :sample, do: << value :: integer-unit(8)-size(3)-little-unsigned >>
      it "should return decoded value" do
        expect(described_module.sample_to_value!(sample, format)).to eq value
      end
    end

    context "if format is :u32le" do
      let :format, do: :u32le
      let :value, do: 1234
      let :sample, do: << value :: integer-unit(8)-size(4)-little-unsigned >>
      it "should return decoded value" do
        expect(described_module.sample_to_value!(sample, format)).to eq value
      end
    end

    context "if format is :f32le" do
      let :format, do: :f32le
      let :value, do: 1234.0
      let :sample, do: << value :: float-unit(8)-size(4)-little >>
      it "should return decoded value" do
        expect(described_module.sample_to_value!(sample, format)).to eq value
      end
    end

    context "if format is :s16be" do
      let :format, do: :s16be
      let :value, do: -1234
      let :sample, do: << value :: integer-unit(8)-size(2)-big-signed >>
      it "should return decoded value" do
        expect(described_module.sample_to_value!(sample, format)).to eq value
      end
    end

    context "if format is :s24be" do
      let :format, do: :s24be
      let :value, do: -1234
      let :sample, do: << value :: integer-unit(8)-size(3)-big-signed >>
      it "should return decoded value" do
        expect(described_module.sample_to_value!(sample, format)).to eq value
      end
    end

    context "if format is :s32be" do
      let :format, do: :s32be
      let :value, do: -1234
      let :sample, do: << value :: integer-unit(8)-size(4)-big-signed >>
      it "should return decoded value" do
        expect(described_module.sample_to_value!(sample, format)).to eq value
      end
    end

    context "if format is :u16be" do
      let :format, do: :u16be
      let :value, do: 1234
      let :sample, do: << value :: integer-unit(8)-size(2)-big-unsigned >>
      it "should return decoded value" do
        expect(described_module.sample_to_value!(sample, format)).to eq value
      end
    end

    context "if format is :u24be" do
      let :format, do: :u24be
      let :value, do: 1234
      let :sample, do: << value :: integer-unit(8)-size(3)-big-unsigned >>
      it "should return decoded value" do
        expect(described_module.sample_to_value!(sample, format)).to eq value
      end
    end

    context "if format is :u32be" do
      let :format, do: :u32be
      let :value, do: 1234
      let :sample, do: << value :: integer-unit(8)-size(4)-big-unsigned >>
      it "should return decoded value" do
        expect(described_module.sample_to_value!(sample, format)).to eq value
      end
    end

    context "if format is :f32be" do
      let :format, do: :f32be
      let :value, do: 1234.0
      let :sample, do: << value :: float-unit(8)-size(4)-big >>
      it "should return decoded value" do
        expect(described_module.sample_to_value!(sample, format)).to eq value
      end
    end
  end

end
