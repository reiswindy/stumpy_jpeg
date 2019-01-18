require "./spec_helper"

describe Transformation::DCT do

  context "DCT" do
    matrix = Matrix.rows([
      [-98,  -93,  -98,  -96,  -97,  -111, -111, -104],
      [-108, -103, -109, -111, -106, -114, -118, -116],
      [-116, -113, -118, -112, -108, -107, -114, -121],
      [-106, -105, -111, -113, -111, -103, -99,  -100],
      [-44,  -37,  -42,  -83,  -88,  -101, -95,  -73],
      [ 26,   32,   23,  -4,   -13,  -62,  -87,  -70],
      [ 62,   67,   70,   59,   47,  -17,  -53,  -52],
      [ 66,   70,   75,   77,   70,   17,  -12,  -21]
    ])

    expected = Matrix.rows([
      [-455,  148, -35, -16,  14, -24, -2,  10],
      [-440, -129,  45,  12, -15,  10, -3, -9],
      [ 179,  32,  -49,  6,   16,  0,  -6,  1],
      [ 27,   56,   17, -22,  5,  -12,  4,  6],
      [-14,  -38,   21, -4,  -6,   6,   0,  0],
      [ 4,   -1,   -16,  7,   4,   4,  -2, -3],
      [ 5,    2,   -4,   4,   2,  -1,  -1, -2],
      [ 4,    6,    3,  -6,  -2,   0,   2,  2]
    ])

    it "applies a DCT transform to matrix" do
      dct_t = Transformation::DCT.new(8)
      dct_t.transform(matrix).map { |v, i, r, c| v.round.to_i }.should eq(expected)
    end

    it "applies a fast DCT transform to matrix" do
      dct_t = Transformation::DCT.new(8)
      dct_t.fast_transform(matrix).map { |v, i, r, c| v.round.to_i }.should eq(expected)
    end
  end

  context "IDCT" do
    matrix = Matrix.rows([
      [-455,  148, -35, -16,  14, -24, -2, 0],
      [-440, -129,  45,  12, -15,  10,  0, 0],
      [ 179,  32,  -49,  6,   16,  0,   0, 0],
      [ 27,   56,   17, -22,  0,   0,   0, 0],
      [-14,  -38,   21,  0,   0,   0,   0, 0],
      [ 4,   -1,    0,   0,   0,   0,   0, 0],
      [ 5,    0,    0,   0,   0,   0,   0, 0],
      [ 0,    0,    0,   0,   0,   0,   0, 0]
    ])

    expected = Matrix.rows([
      [32,  34,  31,  30,  27,  18,  18,  26],
      [19,  23,  21,  23,  25,  17,  8,   6],
      [10,  14,  10,  11,  21,  21,  13,  10],
      [24,  30,  19,  10,  17,  22,  26,  34],
      [82,  89,  75,  54,  43,  32,  33,  48],
      [153, 163, 153, 131, 105, 66,  46,  56],
      [190, 198, 195, 188, 166, 113, 75,  78],
      [194, 199, 199, 208, 201, 150, 108, 109]
    ])

    it "applies an IDCT transform to matrix" do
      dct_t = Transformation::DCT.new(8)
      dct_t.inverse_transform(matrix).map { |v, i, r, c| v.round.to_i + 128 }.should eq(expected)
    end

    it "applies a fast IDCT transform to matrix" do
      dct_t = Transformation::DCT.new(8)
      dct_t.fast_inverse_transform(matrix).map { |v, i, r, c| v.round.to_i + 128 }.should eq(expected)
    end
  end
  
end
