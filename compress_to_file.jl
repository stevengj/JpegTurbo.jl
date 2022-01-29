# Modified from the "JPEG COMPRESSION SAMPLE INTERFACE" part in example.txt
# https://raw.githubusercontent.com/libjpeg-turbo/libjpeg-turbo/main/example.txt
using TestImages
using ImageCore
using ImageShow
using JpegTurbo
import JpegTurbo: LibJpeg

img = RGB.(testimage("cameraman"))
filename = "test.jpg"

cinfo = LibJpeg.jpeg_compress_struct()
jerr = Ref{LibJpeg.jpeg_error_mgr}()
cinfo.err = LibJpeg.jpeg_std_error(jerr)
LibJpeg.jpeg_create_compress(cinfo)

outfile = ccall(:fopen, Libc.FILE, (Cstring, Cstring), filename, "wb")
@assert outfile != C_NULL
LibJpeg.jpeg_stdio_dest(cinfo, outfile)

cinfo.image_width = size(img, 2)
cinfo.image_height = size(img, 1)
cinfo.input_components = length(eltype(img))
cinfo.in_color_space = LibJpeg.JCS_RGB

LibJpeg.jpeg_set_defaults(cinfo)
LibJpeg.jpeg_set_quality(cinfo, 1, true)

LibJpeg.jpeg_start_compress(cinfo, true)

row_stride = size(img, 2) * length(eltype(img))

while (cinfo.next_scanline < cinfo.image_height)
    jarray = Ptr{UInt8}[pointer(img) + cinfo.next_scanline * row_stride]
    @show jarray cinfo.next_scanline
    GC.@preserve LibJpeg.jpeg_write_scanlines(cinfo, jarray, 1)
end

LibJpeg.jpeg_finish_compress(cinfo)

ccall(:fclose, Cint, (Ptr{Libc.FILE},), outfile)

LibJpeg.jpeg_destroy_compress(cinfo)
