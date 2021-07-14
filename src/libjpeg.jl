# mirror of jpeglib.h
module LibJpeg

import JpegTurbo_jll: libjpeg
using CEnum

######################################################################################################

# Generated from jpeglib.h using Clang.jl with:
#=
    using Clang, JpegTurbo_jll

    jconfig_h = joinpath(JpegTurbo_jll.artifact_dir, "include", "jconfig.h")
    jmorecfg_h = joinpath(JpegTurbo_jll.artifact_dir, "include", "jmorecfg.h")
    jpeglib_h = joinpath(JpegTurbo_jll.artifact_dir, "include", "jpeglib.h")
    wc = init(; headers = [jconfig_h, jmorecfg_h, jpeglib_h],
            output_file = joinpath(@__DIR__, "libjpeg_out.jl"),
            common_file = joinpath(@__DIR__, "libjpeg_common.jl"),
            header_wrapped = (root, current)->root == current,
            header_library = x->"libjpeg"
            )
    run(wc)
=#

######################################################################################################

const JSAMPLE = UInt8

# incomplete internal types, defined in jpegint.h, which
# we only need pointers to and hence can define as Cvoid
const jpeg_comp_master = Cvoid
const jpeg_c_main_controller = Cvoid
const jpeg_c_prep_controller = Cvoid
const jpeg_c_coef_controller = Cvoid
const jpeg_marker_writer = Cvoid
const jpeg_color_converter = Cvoid
const jpeg_downsampler = Cvoid
const jpeg_forward_dct = Cvoid
const jpeg_entropy_encoder = Cvoid
const jpeg_decomp_master = Cvoid
const jpeg_d_main_controller = Cvoid
const jpeg_d_coef_controller = Cvoid
const jpeg_d_post_controller = Cvoid
const jpeg_input_controller = Cvoid
const jpeg_marker_reader = Cvoid
const jpeg_entropy_decoder = Cvoid
const jpeg_inverse_dct = Cvoid
const jpeg_upsampler = Cvoid
const jpeg_color_deconverter = Cvoid
const jpeg_color_quantizer = Cvoid

######################################################################################################
# Automatically generated using Clang.jl


const JPEG_LIB_VERSION = 62
const LIBJPEG_TURBO_VERSION = ".1."
const LIBJPEG_TURBO_VERSION_NUMBER = 2001000
const C_ARITH_CODING_SUPPORTED = 1
const D_ARITH_CODING_SUPPORTED = 1
const MEM_SRCDST_SUPPORTED = 1
const WITH_SIMD = 1
const BITS_IN_JSAMPLE = 8
const HAVE_LOCALE_H = 1
const HAVE_STDDEF_H = 1
const HAVE_STDLIB_H = 1
const NEED_SYS_TYPES_H = 1
const HAVE_UNSIGNED_CHAR = 1
const HAVE_UNSIGNED_SHORT = 1
const MAX_COMPONENTS = 10

# Skipping MacroDefinition: GETJOCTET ( value ) ( value )

const JPEG_MAX_DIMENSION = Int32(65500)

# Skipping MacroDefinition: METHODDEF ( type ) static type
# Skipping MacroDefinition: LOCAL ( type ) static type
# Skipping MacroDefinition: GLOBAL ( type ) type
# Skipping MacroDefinition: EXTERN ( type ) extern type
# Skipping MacroDefinition: JMETHOD ( type , methodname , arglist ) type ( * methodname ) arglist

const FALSE = 0
const TRUE = 1
const JCOEF = Int16
const JOCTET = Cuchar
const UINT8 = Cuchar
const UINT16 = UInt32
const INT16 = Int16
const INT32 = Clong
const JDIMENSION = UInt32
const boolean = Cint
const DCTSIZE = 8
const DCTSIZE2 = 64
const NUM_QUANT_TBLS = 4
const NUM_HUFF_TBLS = 4
const NUM_ARITH_TBLS = 16
const MAX_COMPS_IN_SCAN = 4
const MAX_SAMP_FACTOR = 4
const C_MAX_BLOCKS_IN_MCU = 10
const D_MAX_BLOCKS_IN_MCU = 10
const JCS_EXTENSIONS = 1
const JCS_ALPHA_EXTENSIONS = 1

@cenum J_DCT_METHOD::UInt32 begin
    JDCT_ISLOW = 0
    JDCT_IFAST = 1
    JDCT_FLOAT = 2
end


const JDCT_DEFAULT = JDCT_ISLOW
const JDCT_FASTEST = JDCT_IFAST

# Skipping MacroDefinition: jpeg_common_fields struct jpeg_error_mgr * err ; /* Error handler module */ struct jpeg_memory_mgr * mem ; /* Memory manager module */ struct jpeg_progress_mgr * progress ; /* Progress monitor, or NULL if none */ void * client_data ; /* Available for use by application */ boolean is_decompressor ; /* So common code can tell which is which */ int global_state

const JMSG_LENGTH_MAX = 200
const JMSG_STR_PARM_MAX = 80
const JPOOL_PERMANENT = 0
const JPOOL_IMAGE = 1
const JPOOL_NUMPOOLS = 2

# Skipping MacroDefinition: JPP ( arglist ) arglist
# Skipping MacroDefinition: jpeg_create_compress ( cinfo ) jpeg_CreateCompress ( ( cinfo ) , JPEG_LIB_VERSION , ( size_t ) sizeof ( struct jpeg_compress_struct ) )
# Skipping MacroDefinition: jpeg_create_decompress ( cinfo ) jpeg_CreateDecompress ( ( cinfo ) , JPEG_LIB_VERSION , ( size_t ) sizeof ( struct jpeg_decompress_struct ) )

const JPEG_SUSPENDED = 0
const JPEG_HEADER_OK = 1
const JPEG_HEADER_TABLES_ONLY = 2
const JPEG_REACHED_SOS = 1
const JPEG_REACHED_EOI = 2
const JPEG_ROW_COMPLETED = 3
const JPEG_SCAN_COMPLETED = 4
const JPEG_RST0 = 0xd0
const JPEG_EOI = 0xd9
const JPEG_APP0 = 0xe0
const JPEG_COM = 0xfe
const JSAMPROW = Ptr{JSAMPLE}
const JSAMPARRAY = Ptr{JSAMPROW}
const JSAMPIMAGE = Ptr{JSAMPARRAY}
const JBLOCK = NTuple{64, JCOEF}
const JBLOCKROW = Ptr{JBLOCK}
const JBLOCKARRAY = Ptr{JBLOCKROW}
const JBLOCKIMAGE = Ptr{JBLOCKARRAY}
const JCOEFPTR = Ptr{JCOEF}

struct JQUANT_TBL
    quantval::NTuple{64, UINT16}
    sent_table::boolean
end

struct JHUFF_TBL
    bits::NTuple{17, UINT8}
    huffval::NTuple{256, UINT8}
    sent_table::boolean
end

struct jpeg_component_info
    component_id::Cint
    component_index::Cint
    h_samp_factor::Cint
    v_samp_factor::Cint
    quant_tbl_no::Cint
    dc_tbl_no::Cint
    ac_tbl_no::Cint
    width_in_blocks::JDIMENSION
    height_in_blocks::JDIMENSION
    DCT_scaled_size::Cint
    downsampled_width::JDIMENSION
    downsampled_height::JDIMENSION
    component_needed::boolean
    MCU_width::Cint
    MCU_height::Cint
    MCU_blocks::Cint
    MCU_sample_width::Cint
    last_col_width::Cint
    last_row_height::Cint
    quant_table::Ptr{JQUANT_TBL}
    dct_table::Ptr{Cvoid}
end

struct jpeg_scan_info
    comps_in_scan::Cint
    component_index::NTuple{4, Cint}
    Ss::Cint
    Se::Cint
    Ah::Cint
    Al::Cint
end

struct jpeg_marker_struct
    next::Ptr{jpeg_marker_struct}
    marker::UINT8
    original_length::UInt32
    data_length::UInt32
    data::Ptr{JOCTET}
end

const jpeg_saved_marker_ptr = Ptr{jpeg_marker_struct}

@cenum J_COLOR_SPACE::UInt32 begin
    JCS_UNKNOWN = 0
    JCS_GRAYSCALE = 1
    JCS_RGB = 2
    JCS_YCbCr = 3
    JCS_CMYK = 4
    JCS_YCCK = 5
    JCS_EXT_RGB = 6
    JCS_EXT_RGBX = 7
    JCS_EXT_BGR = 8
    JCS_EXT_BGRX = 9
    JCS_EXT_XBGR = 10
    JCS_EXT_XRGB = 11
    JCS_EXT_RGBA = 12
    JCS_EXT_BGRA = 13
    JCS_EXT_ABGR = 14
    JCS_EXT_ARGB = 15
    JCS_RGB565 = 16
end

@cenum J_DITHER_MODE::UInt32 begin
    JDITHER_NONE = 0
    JDITHER_ORDERED = 1
    JDITHER_FS = 2
end


struct ANONYMOUS1_msg_parm
    s::NTuple{80, UInt8}
end

struct jpeg_error_mgr
    error_exit::Ptr{Cvoid}
    emit_message::Ptr{Cvoid}
    output_message::Ptr{Cvoid}
    format_message::Ptr{Cvoid}
    reset_error_mgr::Ptr{Cvoid}
    msg_code::Cint
    msg_parm::ANONYMOUS1_msg_parm
    trace_level::Cint
    num_warnings::Clong
    jpeg_message_table::Ptr{Cstring}
    last_jpeg_message::Cint
    addon_message_table::Ptr{Cstring}
    first_addon_message::Cint
    last_addon_message::Cint
end

struct jpeg_memory_mgr
    alloc_small::Ptr{Cvoid}
    alloc_large::Ptr{Cvoid}
    alloc_sarray::Ptr{Cvoid}
    alloc_barray::Ptr{Cvoid}
    request_virt_sarray::Ptr{Cvoid}
    request_virt_barray::Ptr{Cvoid}
    realize_virt_arrays::Ptr{Cvoid}
    access_virt_sarray::Ptr{Cvoid}
    access_virt_barray::Ptr{Cvoid}
    free_pool::Ptr{Cvoid}
    self_destruct::Ptr{Cvoid}
    max_memory_to_use::Clong
    max_alloc_chunk::Clong
end

struct jpeg_progress_mgr
    progress_monitor::Ptr{Cvoid}
    pass_counter::Clong
    pass_limit::Clong
    completed_passes::Cint
    total_passes::Cint
end

struct jpeg_common_struct
    err::Ptr{jpeg_error_mgr}
    mem::Ptr{jpeg_memory_mgr}
    progress::Ptr{jpeg_progress_mgr}
    client_data::Ptr{Cvoid}
    is_decompressor::boolean
    global_state::Cint
end

const j_common_ptr = Ptr{jpeg_common_struct}

struct jpeg_destination_mgr
    next_output_byte::Ptr{JOCTET}
    free_in_buffer::Cint
    init_destination::Ptr{Cvoid}
    empty_output_buffer::Ptr{Cvoid}
    term_destination::Ptr{Cvoid}
end

struct jpeg_compress_struct
    err::Ptr{jpeg_error_mgr}
    mem::Ptr{jpeg_memory_mgr}
    progress::Ptr{jpeg_progress_mgr}
    client_data::Ptr{Cvoid}
    is_decompressor::boolean
    global_state::Cint
    dest::Ptr{jpeg_destination_mgr}
    image_width::JDIMENSION
    image_height::JDIMENSION
    input_components::Cint
    in_color_space::J_COLOR_SPACE
    input_gamma::Cdouble
    data_precision::Cint
    num_components::Cint
    jpeg_color_space::J_COLOR_SPACE
    comp_info::Ptr{jpeg_component_info}
    quant_tbl_ptrs::NTuple{4, Ptr{JQUANT_TBL}}
    dc_huff_tbl_ptrs::NTuple{4, Ptr{JHUFF_TBL}}
    ac_huff_tbl_ptrs::NTuple{4, Ptr{JHUFF_TBL}}
    arith_dc_L::NTuple{16, UINT8}
    arith_dc_U::NTuple{16, UINT8}
    arith_ac_K::NTuple{16, UINT8}
    num_scans::Cint
    scan_info::Ptr{jpeg_scan_info}
    raw_data_in::boolean
    arith_code::boolean
    optimize_coding::boolean
    CCIR601_sampling::boolean
    smoothing_factor::Cint
    dct_method::J_DCT_METHOD
    restart_interval::UInt32
    restart_in_rows::Cint
    write_JFIF_header::boolean
    JFIF_major_version::UINT8
    JFIF_minor_version::UINT8
    density_unit::UINT8
    X_density::UINT16
    Y_density::UINT16
    write_Adobe_marker::boolean
    next_scanline::JDIMENSION
    progressive_mode::boolean
    max_h_samp_factor::Cint
    max_v_samp_factor::Cint
    total_iMCU_rows::JDIMENSION
    comps_in_scan::Cint
    cur_comp_info::NTuple{4, Ptr{jpeg_component_info}}
    MCUs_per_row::JDIMENSION
    MCU_rows_in_scan::JDIMENSION
    blocks_in_MCU::Cint
    MCU_membership::NTuple{10, Cint}
    Ss::Cint
    Se::Cint
    Ah::Cint
    Al::Cint
    master::Ptr{jpeg_comp_master}
    main::Ptr{jpeg_c_main_controller}
    prep::Ptr{jpeg_c_prep_controller}
    coef::Ptr{jpeg_c_coef_controller}
    marker::Ptr{jpeg_marker_writer}
    cconvert::Ptr{jpeg_color_converter}
    downsample::Ptr{jpeg_downsampler}
    fdct::Ptr{jpeg_forward_dct}
    entropy::Ptr{jpeg_entropy_encoder}
    script_space::Ptr{jpeg_scan_info}
    script_space_size::Cint
end

const j_compress_ptr = Ptr{jpeg_compress_struct}

struct jpeg_source_mgr
    next_input_byte::Ptr{JOCTET}
    bytes_in_buffer::Cint
    init_source::Ptr{Cvoid}
    fill_input_buffer::Ptr{Cvoid}
    skip_input_data::Ptr{Cvoid}
    resync_to_restart::Ptr{Cvoid}
    term_source::Ptr{Cvoid}
end

struct jpeg_decompress_struct
    err::Ptr{jpeg_error_mgr}
    mem::Ptr{jpeg_memory_mgr}
    progress::Ptr{jpeg_progress_mgr}
    client_data::Ptr{Cvoid}
    is_decompressor::boolean
    global_state::Cint
    src::Ptr{jpeg_source_mgr}
    image_width::JDIMENSION
    image_height::JDIMENSION
    num_components::Cint
    jpeg_color_space::J_COLOR_SPACE
    out_color_space::J_COLOR_SPACE
    scale_num::UInt32
    scale_denom::UInt32
    output_gamma::Cdouble
    buffered_image::boolean
    raw_data_out::boolean
    dct_method::J_DCT_METHOD
    do_fancy_upsampling::boolean
    do_block_smoothing::boolean
    quantize_colors::boolean
    dither_mode::J_DITHER_MODE
    two_pass_quantize::boolean
    desired_number_of_colors::Cint
    enable_1pass_quant::boolean
    enable_external_quant::boolean
    enable_2pass_quant::boolean
    output_width::JDIMENSION
    output_height::JDIMENSION
    out_color_components::Cint
    output_components::Cint
    rec_outbuf_height::Cint
    actual_number_of_colors::Cint
    colormap::JSAMPARRAY
    output_scanline::JDIMENSION
    input_scan_number::Cint
    input_iMCU_row::JDIMENSION
    output_scan_number::Cint
    output_iMCU_row::JDIMENSION
    coef_bits::Ptr{NTuple{64, Cint}}
    quant_tbl_ptrs::NTuple{4, Ptr{JQUANT_TBL}}
    dc_huff_tbl_ptrs::NTuple{4, Ptr{JHUFF_TBL}}
    ac_huff_tbl_ptrs::NTuple{4, Ptr{JHUFF_TBL}}
    data_precision::Cint
    comp_info::Ptr{jpeg_component_info}
    progressive_mode::boolean
    arith_code::boolean
    arith_dc_L::NTuple{16, UINT8}
    arith_dc_U::NTuple{16, UINT8}
    arith_ac_K::NTuple{16, UINT8}
    restart_interval::UInt32
    saw_JFIF_marker::boolean
    JFIF_major_version::UINT8
    JFIF_minor_version::UINT8
    density_unit::UINT8
    X_density::UINT16
    Y_density::UINT16
    saw_Adobe_marker::boolean
    Adobe_transform::UINT8
    CCIR601_sampling::boolean
    marker_list::jpeg_saved_marker_ptr
    max_h_samp_factor::Cint
    max_v_samp_factor::Cint
    min_DCT_scaled_size::Cint
    total_iMCU_rows::JDIMENSION
    sample_range_limit::Ptr{JSAMPLE}
    comps_in_scan::Cint
    cur_comp_info::NTuple{4, Ptr{jpeg_component_info}}
    MCUs_per_row::JDIMENSION
    MCU_rows_in_scan::JDIMENSION
    blocks_in_MCU::Cint
    MCU_membership::NTuple{10, Cint}
    Ss::Cint
    Se::Cint
    Ah::Cint
    Al::Cint
    unread_marker::Cint
    master::Ptr{jpeg_decomp_master}
    main::Ptr{jpeg_d_main_controller}
    coef::Ptr{jpeg_d_coef_controller}
    post::Ptr{jpeg_d_post_controller}
    inputctl::Ptr{jpeg_input_controller}
    marker::Ptr{jpeg_marker_reader}
    entropy::Ptr{jpeg_entropy_decoder}
    idct::Ptr{jpeg_inverse_dct}
    upsample::Ptr{jpeg_upsampler}
    cconvert::Ptr{jpeg_color_deconverter}
    cquantize::Ptr{jpeg_color_quantizer}
end

const j_decompress_ptr = Ptr{jpeg_decompress_struct}
const jvirt_sarray_control = Cvoid
const jvirt_sarray_ptr = Ptr{jvirt_sarray_control}
const jvirt_barray_control = Cvoid
const jvirt_barray_ptr = Ptr{jvirt_barray_control}
const jpeg_marker_parser_method = Ptr{Cvoid}
# Julia wrapper for header: jconfig.h
# Automatically generated using Clang.jl

# Julia wrapper for header: jmorecfg.h
# Automatically generated using Clang.jl

# Julia wrapper for header: jpeglib.h
# Automatically generated using Clang.jl

######################################################################################################

function jpeg_std_error(err)
    ccall((:jpeg_std_error, libjpeg), Ptr{jpeg_error_mgr}, (Ptr{jpeg_error_mgr},), err)
end

function jpeg_CreateCompress(cinfo, version, structsize)
    ccall((:jpeg_CreateCompress, libjpeg), Cvoid, (j_compress_ptr, Cint, Cint), cinfo, version, structsize)
end

function jpeg_CreateDecompress(cinfo, version, structsize)
    ccall((:jpeg_CreateDecompress, libjpeg), Cvoid, (j_decompress_ptr, Cint, Cint), cinfo, version, structsize)
end

function jpeg_destroy_compress(cinfo)
    ccall((:jpeg_destroy_compress, libjpeg), Cvoid, (j_compress_ptr,), cinfo)
end

function jpeg_destroy_decompress(cinfo)
    ccall((:jpeg_destroy_decompress, libjpeg), Cvoid, (j_decompress_ptr,), cinfo)
end

function jpeg_stdio_dest(cinfo, outfile)
    ccall((:jpeg_stdio_dest, libjpeg), Cvoid, (j_compress_ptr, Ptr{Cint}), cinfo, outfile)
end

function jpeg_stdio_src(cinfo, infile)
    ccall((:jpeg_stdio_src, libjpeg), Cvoid, (j_decompress_ptr, Ptr{Cint}), cinfo, infile)
end

function jpeg_mem_dest(cinfo, outbuffer, outsize)
    ccall((:jpeg_mem_dest, libjpeg), Cvoid, (j_compress_ptr, Ptr{Ptr{Cuchar}}, Ptr{Culong}), cinfo, outbuffer, outsize)
end

function jpeg_mem_src(cinfo, inbuffer, insize)
    ccall((:jpeg_mem_src, libjpeg), Cvoid, (j_decompress_ptr, Ptr{Cuchar}, Culong), cinfo, inbuffer, insize)
end

function jpeg_set_defaults(cinfo)
    ccall((:jpeg_set_defaults, libjpeg), Cvoid, (j_compress_ptr,), cinfo)
end

function jpeg_set_colorspace(cinfo, colorspace)
    ccall((:jpeg_set_colorspace, libjpeg), Cvoid, (j_compress_ptr, J_COLOR_SPACE), cinfo, colorspace)
end

function jpeg_default_colorspace(cinfo)
    ccall((:jpeg_default_colorspace, libjpeg), Cvoid, (j_compress_ptr,), cinfo)
end

function jpeg_set_quality(cinfo, quality, force_baseline)
    ccall((:jpeg_set_quality, libjpeg), Cvoid, (j_compress_ptr, Cint, boolean), cinfo, quality, force_baseline)
end

function jpeg_set_linear_quality(cinfo, scale_factor, force_baseline)
    ccall((:jpeg_set_linear_quality, libjpeg), Cvoid, (j_compress_ptr, Cint, boolean), cinfo, scale_factor, force_baseline)
end

function jpeg_add_quant_table(cinfo, which_tbl, basic_table, scale_factor, force_baseline)
    ccall((:jpeg_add_quant_table, libjpeg), Cvoid, (j_compress_ptr, Cint, Ptr{UInt32}, Cint, boolean), cinfo, which_tbl, basic_table, scale_factor, force_baseline)
end

function jpeg_quality_scaling(quality)
    ccall((:jpeg_quality_scaling, libjpeg), Cint, (Cint,), quality)
end

function jpeg_simple_progression(cinfo)
    ccall((:jpeg_simple_progression, libjpeg), Cvoid, (j_compress_ptr,), cinfo)
end

function jpeg_suppress_tables(cinfo, suppress)
    ccall((:jpeg_suppress_tables, libjpeg), Cvoid, (j_compress_ptr, boolean), cinfo, suppress)
end

function jpeg_alloc_quant_table(cinfo)
    ccall((:jpeg_alloc_quant_table, libjpeg), Ptr{JQUANT_TBL}, (j_common_ptr,), cinfo)
end

function jpeg_alloc_huff_table(cinfo)
    ccall((:jpeg_alloc_huff_table, libjpeg), Ptr{JHUFF_TBL}, (j_common_ptr,), cinfo)
end

function jpeg_start_compress(cinfo, write_all_tables)
    ccall((:jpeg_start_compress, libjpeg), Cvoid, (j_compress_ptr, boolean), cinfo, write_all_tables)
end

function jpeg_write_scanlines(cinfo, scanlines, num_lines)
    ccall((:jpeg_write_scanlines, libjpeg), JDIMENSION, (j_compress_ptr, JSAMPARRAY, JDIMENSION), cinfo, scanlines, num_lines)
end

function jpeg_finish_compress(cinfo)
    ccall((:jpeg_finish_compress, libjpeg), Cvoid, (j_compress_ptr,), cinfo)
end

function jpeg_write_raw_data(cinfo, data, num_lines)
    ccall((:jpeg_write_raw_data, libjpeg), JDIMENSION, (j_compress_ptr, JSAMPIMAGE, JDIMENSION), cinfo, data, num_lines)
end

function jpeg_write_marker(cinfo, marker, dataptr, datalen)
    ccall((:jpeg_write_marker, libjpeg), Cvoid, (j_compress_ptr, Cint, Ptr{JOCTET}, UInt32), cinfo, marker, dataptr, datalen)
end

function jpeg_write_m_header(cinfo, marker, datalen)
    ccall((:jpeg_write_m_header, libjpeg), Cvoid, (j_compress_ptr, Cint, UInt32), cinfo, marker, datalen)
end

function jpeg_write_m_byte(cinfo, val)
    ccall((:jpeg_write_m_byte, libjpeg), Cvoid, (j_compress_ptr, Cint), cinfo, val)
end

function jpeg_write_tables(cinfo)
    ccall((:jpeg_write_tables, libjpeg), Cvoid, (j_compress_ptr,), cinfo)
end

function jpeg_write_icc_profile(cinfo, icc_data_ptr, icc_data_len)
    ccall((:jpeg_write_icc_profile, libjpeg), Cvoid, (j_compress_ptr, Ptr{JOCTET}, UInt32), cinfo, icc_data_ptr, icc_data_len)
end

function jpeg_read_header(cinfo, require_image)
    ccall((:jpeg_read_header, libjpeg), Cint, (j_decompress_ptr, boolean), cinfo, require_image)
end

function jpeg_start_decompress(cinfo)
    ccall((:jpeg_start_decompress, libjpeg), boolean, (j_decompress_ptr,), cinfo)
end

function jpeg_read_scanlines(cinfo, scanlines, max_lines)
    ccall((:jpeg_read_scanlines, libjpeg), JDIMENSION, (j_decompress_ptr, JSAMPARRAY, JDIMENSION), cinfo, scanlines, max_lines)
end

function jpeg_skip_scanlines(cinfo, num_lines)
    ccall((:jpeg_skip_scanlines, libjpeg), JDIMENSION, (j_decompress_ptr, JDIMENSION), cinfo, num_lines)
end

function jpeg_crop_scanline(cinfo, xoffset, width)
    ccall((:jpeg_crop_scanline, libjpeg), Cvoid, (j_decompress_ptr, Ptr{JDIMENSION}, Ptr{JDIMENSION}), cinfo, xoffset, width)
end

function jpeg_finish_decompress(cinfo)
    ccall((:jpeg_finish_decompress, libjpeg), boolean, (j_decompress_ptr,), cinfo)
end

function jpeg_read_raw_data(cinfo, data, max_lines)
    ccall((:jpeg_read_raw_data, libjpeg), JDIMENSION, (j_decompress_ptr, JSAMPIMAGE, JDIMENSION), cinfo, data, max_lines)
end

function jpeg_has_multiple_scans(cinfo)
    ccall((:jpeg_has_multiple_scans, libjpeg), boolean, (j_decompress_ptr,), cinfo)
end

function jpeg_start_output(cinfo, scan_number)
    ccall((:jpeg_start_output, libjpeg), boolean, (j_decompress_ptr, Cint), cinfo, scan_number)
end

function jpeg_finish_output(cinfo)
    ccall((:jpeg_finish_output, libjpeg), boolean, (j_decompress_ptr,), cinfo)
end

function jpeg_input_complete(cinfo)
    ccall((:jpeg_input_complete, libjpeg), boolean, (j_decompress_ptr,), cinfo)
end

function jpeg_new_colormap(cinfo)
    ccall((:jpeg_new_colormap, libjpeg), Cvoid, (j_decompress_ptr,), cinfo)
end

function jpeg_consume_input(cinfo)
    ccall((:jpeg_consume_input, libjpeg), Cint, (j_decompress_ptr,), cinfo)
end

function jpeg_calc_output_dimensions(cinfo)
    ccall((:jpeg_calc_output_dimensions, libjpeg), Cvoid, (j_decompress_ptr,), cinfo)
end

function jpeg_save_markers(cinfo, marker_code, length_limit)
    ccall((:jpeg_save_markers, libjpeg), Cvoid, (j_decompress_ptr, Cint, UInt32), cinfo, marker_code, length_limit)
end

function jpeg_set_marker_processor(cinfo, marker_code, routine)
    ccall((:jpeg_set_marker_processor, libjpeg), Cvoid, (j_decompress_ptr, Cint, jpeg_marker_parser_method), cinfo, marker_code, routine)
end

function jpeg_read_coefficients(cinfo)
    ccall((:jpeg_read_coefficients, libjpeg), Ptr{jvirt_barray_ptr}, (j_decompress_ptr,), cinfo)
end

function jpeg_write_coefficients(cinfo, coef_arrays)
    ccall((:jpeg_write_coefficients, libjpeg), Cvoid, (j_compress_ptr, Ptr{jvirt_barray_ptr}), cinfo, coef_arrays)
end

function jpeg_copy_critical_parameters(srcinfo, dstinfo)
    ccall((:jpeg_copy_critical_parameters, libjpeg), Cvoid, (j_decompress_ptr, j_compress_ptr), srcinfo, dstinfo)
end

function jpeg_abort_compress(cinfo)
    ccall((:jpeg_abort_compress, libjpeg), Cvoid, (j_compress_ptr,), cinfo)
end

function jpeg_abort_decompress(cinfo)
    ccall((:jpeg_abort_decompress, libjpeg), Cvoid, (j_decompress_ptr,), cinfo)
end

function jpeg_abort(cinfo)
    ccall((:jpeg_abort, libjpeg), Cvoid, (j_common_ptr,), cinfo)
end

function jpeg_destroy(cinfo)
    ccall((:jpeg_destroy, libjpeg), Cvoid, (j_common_ptr,), cinfo)
end

function jpeg_resync_to_restart(cinfo, desired)
    ccall((:jpeg_resync_to_restart, libjpeg), boolean, (j_decompress_ptr, Cint), cinfo, desired)
end

function jpeg_read_icc_profile(cinfo, icc_data_ptr, icc_data_len)
    ccall((:jpeg_read_icc_profile, libjpeg), boolean, (j_decompress_ptr, Ptr{Ptr{JOCTET}}, Ptr{UInt32}), cinfo, icc_data_ptr, icc_data_len)
end

######################################################################################################

end # module
