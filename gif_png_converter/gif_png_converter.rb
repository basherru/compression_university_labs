require_relative '../4/gif'
require_relative '../5/png'
require_relative 'converter_exception'

if ARGV[0] == 'rnd'
  width = ARGV[1].to_i
  height = ARGV[2].to_i
  file_name = 10.times.map{ 97 + rand(25) }.map(&:chr).join
  file_name = file_name + ".png"
  png = Png.new(nil)
  png.header = {
    :width       => width,
    :height      => height,
    :bit_depth   => 8,
    :palette     => 0,
    :color       => 1,
    :alpha       => 0,
    :compression => 0,
    :filtering   => 0,
    :interlacing => 0
  }
  pixels = (3 * width * height).times.map{ rand(255) }.each_slice(3).to_a
  png.import_pixels(pixels)
  byte_stream = png.pack_image
  packed_stream = byte_stream.pack('C*')
  File.write(file_name, packed_stream)
end  

path_to_file = ARGV[0]
parts = path_to_file.split('.')
file_name = parts[0..-2].join('.')
file_extension = parts[-1]

if file_extension == 'gif'
  gif = Gif.new(path_to_file)
  png = Png.new(nil)
  png.header = {
    :width       => gif.header[:width],
    :height      => gif.header[:height],
    :bit_depth   => 8,
    :palette     => 0,
    :color       => 1,
    :alpha       => 0,
    :compression => 0,
    :filtering   => 0,
    :interlacing => 0
  }
  png.import_pixels(gif.pixels)
  byte_stream = png.pack_image
  packed_stream = byte_stream.pack('C*')
  File.write("#{file_name}.gif.png", packed_stream)
elsif file_extension == 'png'
  png = Png.new(path_to_file)
  gif = Gif.new(nil)
  png_pixels = png.export_pixels
  addendix_size = 0
  addendix_size = (2 ** (Math.log(png_pixels.uniq.size) / Math.log(2)).ceil) - png_pixels.uniq.size if png_pixels.uniq.size < 256
  gif.global_color_map = png_pixels.uniq + [[ 0, 0, 0 ]] * addendix_size
  std_map = [[0, 0, 0], [128, 0, 0], [0, 128, 0], [128, 128, 0], [0, 0, 128], [128, 0, 128], [0, 128, 128], [192, 192, 192], [128, 128, 128], [255, 0, 0], [0, 255, 0], [255, 255, 0], [0, 0, 255], [255, 0, 255], [0, 255, 255], [255, 255, 255], [0, 0, 95], [0, 0, 135], [0, 0, 175], [0, 0, 215], [0, 95, 0], [0, 95, 95], [0, 95, 135], [0, 95, 175], [0, 95, 215], [0, 95, 255], [0, 135, 0], [0, 135, 95], [0, 135, 135], [0, 135, 175], [0, 135, 215], [0, 135, 255], [0, 175, 0], [0, 175, 95], [0, 175, 135], [0, 175, 175], [0, 175, 215], [0, 175, 255], [0, 215, 0], [0, 215, 95], [0, 215, 135], [0, 215, 175], [0, 215, 215], [0, 215, 255], [0, 255, 95], [0, 255, 135], [0, 255, 175], [0, 255, 215], [95, 0, 0], [95, 0, 95], [95, 0, 135], [95, 0, 175], [95, 0, 215], [95, 0, 255], [95, 95, 0], [95, 95, 95], [95, 95, 135], [95, 95, 175], [95, 95, 215], [95, 95, 255], [95, 135, 0], [95, 135, 95], [95, 135, 135], [95, 135, 175], [95, 135, 215], [95, 135, 255], [95, 175, 0], [95, 175, 95], [95, 175, 135], [95, 175, 175], [95, 175, 215], [95, 175, 255], [95, 215, 0], [95, 215, 95], [95, 215, 135], [95, 215, 175], [95, 215, 215], [95, 215, 255], [95, 255, 0], [95, 255, 95], [95, 255, 135], [95, 255, 175], [95, 255, 215], [95, 255, 255], [135, 0, 0], [135, 0, 95], [135, 0, 135], [135, 0, 175], [135, 0, 215], [135, 0, 255], [135, 95, 0], [135, 95, 95], [135, 95, 135], [135, 95, 175], [135, 95, 215], [135, 95, 255], [135, 135, 0], [135, 135, 95], [135, 135, 135], [135, 135, 175], [135, 135, 215], [135, 135, 255], [135, 175, 0], [135, 175, 95], [135, 175, 135], [135, 175, 175], [135, 175, 215], [135, 175, 255], [135, 215, 0], [135, 215, 95], [135, 215, 135], [135, 215, 175], [135, 215, 215], [135, 215, 255], [135, 255, 0], [135, 255, 95], [135, 255, 135], [135, 255, 175], [135, 255, 215], [135, 255, 255], [175, 0, 0], [175, 0, 95], [175, 0, 135], [175, 0, 175], [175, 0, 215], [175, 0, 255], [175, 95, 0], [175, 95, 95], [175, 95, 135], [175, 95, 175], [175, 95, 215], [175, 95, 255], [175, 135, 0], [175, 135, 95], [175, 135, 135], [175, 135, 175], [175, 135, 215], [175, 135, 255], [175, 175, 0], [175, 175, 95], [175, 175, 135], [175, 175, 175], [175, 175, 215], [175, 175, 255], [175, 215, 0], [175, 215, 95], [175, 215, 135], [175, 215, 175], [175, 215, 215], [175, 215, 255], [175, 255, 0], [175, 255, 95], [175, 255, 135], [175, 255, 175], [175, 255, 215], [175, 255, 255], [215, 0, 0], [215, 0, 95], [215, 0, 135], [215, 0, 175], [215, 0, 215], [215, 0, 255], [215, 95, 0], [215, 95, 95], [215, 95, 135], [215, 95, 175], [215, 95, 215], [215, 95, 255], [215, 135, 0], [215, 135, 95], [215, 135, 135], [215, 135, 175], [215, 135, 215], [215, 135, 255], [215, 175, 0], [215, 175, 95], [215, 175, 135], [215, 175, 175], [215, 175, 215], [215, 175, 255], [215, 215, 0], [215, 215, 95], [215, 215, 135], [215, 215, 175], [215, 215, 215], [215, 215, 255], [215, 255, 0], [215, 255, 95], [215, 255, 135], [215, 255, 175], [215, 255, 215], [215, 255, 255], [255, 0, 95], [255, 0, 135], [255, 0, 175], [255, 0, 215], [255, 95, 0], [255, 95, 95], [255, 95, 135], [255, 95, 175], [255, 95, 215], [255, 95, 255], [255, 135, 0], [255, 135, 95], [255, 135, 135], [255, 135, 175], [255, 135, 215], [255, 135, 255], [255, 175, 0], [255, 175, 95], [255, 175, 135], [255, 175, 175], [255, 175, 215], [255, 175, 255], [255, 215, 0], [255, 215, 95], [255, 215, 135], [255, 215, 175], [255, 215, 215], [255, 215, 255], [255, 255, 95], [255, 255, 135], [255, 255, 175], [255, 255, 215], [8, 8, 8], [18, 18, 18], [28, 28, 28], [38, 38, 38], [48, 48, 48], [58, 58, 58], [68, 68, 68], [78, 78, 78], [88, 88, 88], [98, 98, 98], [108, 108, 108], [118, 118, 118], [138, 138, 138], [148, 148, 148], [158, 158, 158], [168, 168, 168], [178, 178, 178], [188, 188, 188], [198, 198, 198], [208, 208, 208], [218, 218, 218], [228, 228, 228], [238, 238, 238]].uniq
  websafe_map = [[0, 0, 0], [0, 0, 51], [0, 0, 102], [0, 0, 153], [0, 0, 204], [0, 0, 255], [0, 51, 0], [0, 51, 51], [0, 51, 102], [0, 51, 153], [0, 51, 204], [0, 51, 255], [0, 102, 0], [0, 102, 51], [0, 102, 102], [0, 102, 153], [0, 102, 204], [0, 102, 255], [0, 153, 0], [0, 153, 51], [0, 153, 102], [0, 153, 153], [0, 153, 204], [0, 153, 255], [0, 204, 0], [0, 204, 51], [0, 204, 102], [0, 204, 153], [0, 204, 204], [0, 204, 255], [0, 255, 0], [0, 255, 51], [0, 255, 102], [0, 255, 153], [0, 255, 204], [0, 255, 255], [51, 0, 0], [51, 0, 51], [51, 0, 102], [51, 0, 153], [51, 0, 204], [51, 0, 255], [51, 51, 0], [51, 51, 51], [51, 51, 102], [51, 51, 153], [51, 51, 204], [51, 51, 255], [51, 102, 0], [51, 102, 51], [51, 102, 102], [51, 102, 153], [51, 102, 204], [51, 102, 255], [51, 153, 0], [51, 153, 51], [51, 153, 102], [51, 153, 153], [51, 153, 204], [51, 153, 255], [51, 204, 0], [51, 204, 51], [51, 204, 102], [51, 204, 153], [51, 204, 204], [51, 204, 255], [51, 255, 0], [51, 255, 51], [51, 255, 102], [51, 255, 153], [51, 255, 204], [51, 255, 255], [102, 0, 0], [102, 0, 51], [102, 0, 102], [102, 0, 153], [102, 0, 204], [102, 0, 255], [102, 51, 0], [102, 51, 51], [102, 51, 102], [102, 51, 153], [102, 51, 204], [102, 51, 255], [102, 102, 0], [102, 102, 51], [102, 102, 102], [102, 102, 153], [102, 102, 204], [102, 102, 255], [102, 153, 0], [102, 153, 51], [102, 153, 102], [102, 153, 153], [102, 153, 204], [102, 153, 255], [102, 204, 0], [102, 204, 51], [102, 204, 102], [102, 204, 153], [102, 204, 204], [102, 204, 255], [102, 255, 0], [102, 255, 51], [102, 255, 102], [102, 255, 153], [102, 255, 204], [102, 255, 255], [153, 0, 0], [153, 0, 51], [153, 0, 102], [153, 0, 153], [153, 0, 204], [153, 0, 255], [153, 51, 0], [153, 51, 51], [153, 51, 102], [153, 51, 153], [153, 51, 204], [153, 51, 255], [153, 102, 0], [153, 102, 51], [153, 102, 102], [153, 102, 153], [153, 102, 204], [153, 102, 255], [153, 153, 0], [153, 153, 51], [153, 153, 102], [153, 153, 153], [153, 153, 204], [153, 153, 255], [153, 204, 0], [153, 204, 51], [153, 204, 102], [153, 204, 153], [153, 204, 204], [153, 204, 255], [153, 255, 0], [153, 255, 51], [153, 255, 102], [153, 255, 153], [153, 255, 204], [153, 255, 255], [204, 0, 0], [204, 0, 51], [204, 0, 102], [204, 0, 153], [204, 0, 204], [204, 0, 255], [204, 51, 0], [204, 51, 51], [204, 51, 102], [204, 51, 153], [204, 51, 204], [204, 51, 255], [204, 102, 0], [204, 102, 51], [204, 102, 102], [204, 102, 153], [204, 102, 204], [204, 102, 255], [204, 153, 0], [204, 153, 51], [204, 153, 102], [204, 153, 153], [204, 153, 204], [204, 153, 255], [204, 204, 0], [204, 204, 51], [204, 204, 102], [204, 204, 153], [204, 204, 204], [204, 204, 255], [204, 255, 0], [204, 255, 51], [204, 255, 102], [204, 255, 153], [204, 255, 204], [204, 255, 255], [255, 0, 0], [255, 0, 51], [255, 0, 102], [255, 0, 153], [255, 0, 204], [255, 0, 255], [255, 51, 0], [255, 51, 51], [255, 51, 102], [255, 51, 153], [255, 51, 204], [255, 51, 255], [255, 102, 0], [255, 102, 51], [255, 102, 102], [255, 102, 153], [255, 102, 204], [255, 102, 255], [255, 153, 0], [255, 153, 51], [255, 153, 102], [255, 153, 153], [255, 153, 204], [255, 153, 255], [255, 204, 0], [255, 204, 51], [255, 204, 102], [255, 204, 153], [255, 204, 204], [255, 204, 255], [255, 255, 0], [255, 255, 51], [255, 255, 102], [255, 255, 153], [255, 255, 204], [255, 255, 255]]
  greyscale_map = [[220, 220, 220], [211, 211, 211], [192, 192, 192], [169, 169, 169], [128, 128, 128], [105, 105, 105], [119, 136, 153], [112, 128, 144], [47, 79, 79], [0, 0, 0]].uniq
  gif.global_color_map = std_map if png_pixels.uniq.size > 256
  gif.global_color_map = greyscale_map if ARGV[1] == '--greyscale'
  gif.global_color_map = websafe_map if ARGV[1] == '--websafe'
  gif.pixels = png_pixels
  deg = (Math.log(gif.global_color_map.size) / Math.log(2)).ceil
  gif.header = {
    width: png.header[:width],
    height: png.header[:height],
    global_color_map: true,
    color_resolution: 2 ** 8,
    color_table_size: 2 ** [ deg, 8 ].min,
    background: 0
  }
  byte_stream = gif.pack_image
  packed_stream = byte_stream.pack('C*')
  File.write("#{file_name}.png.gif", packed_stream)
else
  raise ConverterException.new('unknown format')
end  