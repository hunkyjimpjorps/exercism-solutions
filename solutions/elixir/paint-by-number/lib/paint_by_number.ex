defmodule PaintByNumber do
  def palette_bit_size(color_count, size \\ 1) do
    if 2 ** size >= color_count do
      size
    else
      palette_bit_size(color_count, size + 1)
    end
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    s = palette_bit_size(color_count)
    <<pixel_color_index::size(s), picture::bitstring>>
  end

  def get_first_pixel(picture, color_count) do
    s = palette_bit_size(color_count)
    case picture do
      <<first::size(s), _::bitstring>> -> first
      _ -> nil
    end
  end

  def drop_first_pixel(picture, color_count) do
    s = palette_bit_size(color_count)
    case picture do
      <<_::size(s), rest::bitstring>> -> rest
      _ -> <<>>
    end
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
