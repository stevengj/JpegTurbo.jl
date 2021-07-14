# JpegTurbo

This is a **work-in-progress** Julia package to provide
Julia-callable wrappers to the [libjpeg-turbo](https://libjpeg-turbo.org/) C library.

It currently only offers a very low-level mirror of the C API,
but this should be a good starting point for higher-level Julia code.

Example usage to open a JPEG file and extract the image width from
the header, based on the [libjpeg documentation](https://github.com/libjpeg-turbo/libjpeg-turbo/blob/main/libjpeg.txt):
```jl
# download a test image:
using TestImages
filename = testimage("earth_apollo17", download_only=true)

# read the header and display the width:
import JpegTurbo: LibJpeg
cinfo = LibJpeg.jpeg_decompress_struct()
jerr = Ref{LibJpeg.jpeg_error_mgr}()
cinfo.err = LibJpeg.jpeg_std_error(jerr)
LibJpeg.jpeg_create_decompress(cinfo)
infile = ccall(:fopen, Libc.FILE, (Cstring, Cstring), filename, "rb")
LibJpeg.jpeg_stdio_src(cinfo, infile)
LibJpeg.jpeg_read_header(cinfo, true)
LibJpeg.jpeg_start_decompress(cinfo)
@show Int(cinfo.output_width) # show the image width
LibJpeg.jpeg_destroy_decompress(cinfo)
ccall(:fclose, Cint, (Ptr{Libc.FILE},), infile)
```
