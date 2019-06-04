module StumpyJPEG
  class Segment::COM < Segment
    getter text : String

    def initialize(@text)
      super Markers::COM
    end

    def length
      3 + text.bytesize
    end

    def to_io(io : IO, format : IO::ByteFormat = IO::ByteFormat::SystemEndian)
      super(io, format)
      format.encode(length.to_u16, io)
      io.write(text.to_slice)
      io.write_byte(0_u8)
    end

    def self.from_io(io)
      length = io.read_bytes(UInt16, IO::ByteFormat::BigEndian)
      text = io.gets(length - 2).not_nil!.chomp('\0')
      self.new(text)
    end
  end
end
