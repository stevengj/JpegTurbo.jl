using JpegTurbo
using Test, TestImages

import JpegTurbo: LibJpeg

@testset "decompress" begin
    filename = testimage("earth_apollo17", download_only=true)

    cinfo = LibJpeg.jpeg_decompress_struct()
    jerr = Ref{LibJpeg.jpeg_error_mgr}()
    cinfo.err = LibJpeg.jpeg_std_error(jerr)
    LibJpeg.jpeg_create_decompress(cinfo)
    infile = ccall(:fopen, Libc.FILE, (Cstring, Cstring), filename, "rb")
    LibJpeg.jpeg_stdio_src(cinfo, infile)
    LibJpeg.jpeg_read_header(cinfo, true)
    LibJpeg.jpeg_start_decompress(cinfo)

    @test cinfo.output_width == 3000
    @test cinfo.output_height== 3002

    LibJpeg.jpeg_destroy_decompress(cinfo)
    ccall(:fclose, Cint, (Ptr{Libc.FILE},), infile)
end
