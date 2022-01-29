module LibJpeg

import JpegTurbo_jll: libjpeg
using CEnum

include("jconfig.jl")
include("jmorecfg.jl")
include("jpegint.jl")

const DCTSIZE = 8
const DCTSIZE2 = 64
const NUM_QUANT_TBLS = 4
const NUM_HUFF_TBLS = 4
const NUM_ARITH_TBLS = 16
const MAX_COMPS_IN_SCAN = 4
const MAX_SAMP_FACTOR = 4

const C_MAX_BLOCKS_IN_MCU = 10
const D_MAX_BLOCKS_IN_MCU = 10

const JSAMPROW = Ptr{JSAMPLE}
const JSAMPARRAY = Ptr{JSAMPROW}
const JSAMPIMAGE = Ptr{JSAMPARRAY}

const JBLOCK = NTuple{DCTSIZE2, JCOEF}
const JBLOCKROW = Ptr{JBLOCK}
const JBLOCKARRAY = Ptr{JBLOCKROW}
const JBLOCKIMAGE = Ptr{JBLOCKARRAY}

const JCOEFPTR = Ptr{JCOEF}

struct JQUANT_TBL
    quantval::NTuple{DCTSIZE2, UINT16}
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
    DCT_scaled_size::Cint # Compat: JPEG_LIB_VERSION < 70
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
    component_index::NTuple{MAX_COMPS_IN_SCAN, Cint}
    Ss::Cint
    Se::Cint
    Ah::Cint
    Al::Cint
end

struct jpeg_marker_struct
    next::Ptr{jpeg_marker_struct}
    marker::UINT8
    original_length::Cuint
    data_length::Cuint
    data::Ptr{JOCTET}
end

const jpeg_saved_marker_ptr = Ptr{jpeg_marker_struct}

const JCS_EXTENSIONS = 1
const JCS_ALPHA_EXTENSIONS = 1

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

@cenum J_DCT_METHOD::UInt32 begin
    JDCT_ISLOW = 0
    JDCT_IFAST = 1
    JDCT_FLOAT = 2
end

const JDCT_DEFAULT = JDCT_ISLOW
const JDCT_FASTEST = JDCT_IFAST

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

struct jpeg_destination_mgr
    next_output_byte::Ptr{JOCTET}
    free_in_buffer::Csize_t
    init_destination::Ptr{Cvoid}
    empty_output_buffer::Ptr{Cvoid}
    term_destination::Ptr{Cvoid}
end

Base.@kwdef mutable struct jpeg_compress_struct
    err::Ptr{jpeg_error_mgr} = C_NULL
    mem::Ptr{jpeg_memory_mgr} = C_NULL
    progress::Ptr{jpeg_progress_mgr} = C_NULL
    client_data::Ptr{Cvoid} = C_NULL
    is_decompressor::boolean = false
    global_state::Cint = 0
    dest::Ptr{jpeg_destination_mgr} = C_NULL
    image_width::JDIMENSION = 0
    image_height::JDIMENSION = 0
    input_components::Cint = 0
    in_color_space::J_COLOR_SPACE = JCS_UNKNOWN
    input_gamma::Cdouble = 0
    data_precision::Cint = 0
    num_components::Cint = 0
    jpeg_color_space::J_COLOR_SPACE = JCS_UNKNOWN
    comp_info::Ptr{jpeg_component_info} = C_NULL
    quant_tbl_ptrs::NTuple{NUM_QUANT_TBLS, Ptr{JQUANT_TBL}} = ntuple(i -> C_NULL, NUM_QUANT_TBLS)
    dc_huff_tbl_ptrs::NTuple{NUM_HUFF_TBLS, Ptr{JHUFF_TBL}} = ntuple(i -> C_NULL, NUM_HUFF_TBLS)
    ac_huff_tbl_ptrs::NTuple{NUM_HUFF_TBLS, Ptr{JHUFF_TBL}} = ntuple(i -> C_NULL, NUM_HUFF_TBLS)
    arith_dc_L::NTuple{NUM_ARITH_TBLS, UINT8} = ntuple(i -> zero(UINT8), NUM_ARITH_TBLS)
    arith_dc_U::NTuple{NUM_ARITH_TBLS, UINT8} = ntuple(i -> zero(UINT8), NUM_ARITH_TBLS)
    arith_dc_K::NTuple{NUM_ARITH_TBLS, UINT8} = ntuple(i -> zero(UINT8), NUM_ARITH_TBLS)
    num_scans::Cint = 0
    scan_info::Ptr{jpeg_scan_info} = C_NULL
    raw_data_in::boolean = false
    arith_code::boolean = false
    optimize_coding::boolean = false
    CCIR601_sampling::boolean = false
    smoothing_factor::Cint = 0
    dct_method::J_DCT_METHOD = JDCT_DEFAULT
    restart_interval::Cuint = 0
    restart_in_rows::Cint = 0
    write_JFIF_header::boolean = false
    JFIF_major_version::UINT8 = 0
    JFIF_minor_version::UINT8 = 0
    density_unit::UINT8 = 0
    X_density::UINT16 = 0
    Y_density::UINT16 = 0
    write_Adobe_marker::boolean = false
    next_scanline::JDIMENSION = 0
    progressive_mode::boolean = false
    max_h_samp_factor::Cint = 0
    max_v_samp_factor::Cint = 0
    total_iMCU_rows::JDIMENSION = 0
    comps_in_scan::Cint = 0
    cur_comp_info::NTuple{MAX_COMPS_IN_SCAN, Ptr{jpeg_component_info}} = ntuple(i -> C_NULL, MAX_COMPS_IN_SCAN)
    MCUs_per_row::JDIMENSION = 0
    MCU_rows_in_scan::JDIMENSION = 0
    blocks_in_MCU::Cint = 0
    MCU_membership::NTuple{C_MAX_BLOCKS_IN_MCU, Cint} = ntuple(i -> Cint(0), C_MAX_BLOCKS_IN_MCU)
    Ss::Cint = 0
    Se::Cint = 0
    Ah::Cint = 0
    Al::Cint = 0
    master::Ptr{jpeg_comp_master} = C_NULL
    main::Ptr{jpeg_c_main_controller} = C_NULL
    prep::Ptr{jpeg_c_prep_controller} = C_NULL
    coef::Ptr{jpeg_c_coef_controller} = C_NULL
    marker::Ptr{jpeg_marker_writer} = C_NULL
    cconvert::Ptr{jpeg_color_converter} = C_NULL
    downsample::Ptr{jpeg_downsampler} = C_NULL
    fdct::Ptr{jpeg_forward_dct} = C_NULL
    entropy::Ptr{jpeg_entropy_encoder} = C_NULL
    script_space::Ptr{jpeg_scan_info} = C_NULL
    script_space_size::Cint = 0
end

const j_compress_ptr = Ptr{jpeg_compress_struct}


######################################################################################################

function jpeg_std_error(err)
    ccall((:jpeg_std_error, libjpeg), Ptr{jpeg_error_mgr}, (Ptr{jpeg_error_mgr},), err)
end

function jpeg_CreateCompress(cinfo::jpeg_compress_struct, version::Integer, structsize::Integer)
    ccall((:jpeg_CreateCompress, libjpeg), Cvoid, (j_compress_ptr, Cint, Csize_t), Ref(cinfo), version, structsize)
end

# function jpeg_CreateDecompress(cinfo, version, structsize)
#     ccall((:jpeg_CreateDecompress, libjpeg), Cvoid, (j_decompress_ptr, Cint, Cint), cinfo, version, structsize)
# end

function jpeg_destroy_compress(cinfo::jpeg_compress_struct)
    ccall((:jpeg_destroy_compress, libjpeg), Cvoid, (j_compress_ptr,), Ref(cinfo))
end

# function jpeg_destroy_decompress(cinfo)
#     ccall((:jpeg_destroy_decompress, libjpeg), Cvoid, (j_decompress_ptr,), cinfo)
# end

function jpeg_stdio_dest(cinfo::jpeg_compress_struct, outfile)
    ccall((:jpeg_stdio_dest, libjpeg), Cvoid, (j_compress_ptr, Ptr{Libc.FILE}), Ref(cinfo), Ref(outfile))
end

# function jpeg_stdio_src(cinfo, infile)
#     ccall((:jpeg_stdio_src, libjpeg), Cvoid, (j_decompress_ptr, Ptr{Libc.FILE}), cinfo, infile)
# end

function jpeg_mem_dest(cinfo::jpeg_compress_struct, outbuffer, outsize)
    ccall((:jpeg_mem_dest, libjpeg), Cvoid, (j_compress_ptr, Ptr{Ptr{Cuchar}}, Ptr{Culong}), Ref(cinfo), outbuffer, outsize)
end

# function jpeg_mem_src(cinfo, inbuffer, insize)
#     ccall((:jpeg_mem_src, libjpeg), Cvoid, (j_decompress_ptr, Ptr{Cuchar}, Culong), cinfo, inbuffer, insize)
# end

function jpeg_set_defaults(cinfo::jpeg_compress_struct)
    ccall((:jpeg_set_defaults, libjpeg), Cvoid, (j_compress_ptr,), Ref(cinfo))
end

function jpeg_set_colorspace(cinfo::jpeg_compress_struct, colorspace::Integer)
    ccall((:jpeg_set_colorspace, libjpeg), Cvoid, (j_compress_ptr, J_COLOR_SPACE), cinfo, colorspace)
end

function jpeg_default_colorspace(cinfo::jpeg_compress_struct)
    ccall((:jpeg_default_colorspace, libjpeg), Cvoid, (j_compress_ptr,), cinfo)
end

function jpeg_set_quality(cinfo::jpeg_compress_struct, quality::Integer, force_baseline::Bool)
    ccall((:jpeg_set_quality, libjpeg), Cvoid, (j_compress_ptr, Cint, boolean), Ref(cinfo), quality, force_baseline)
end

# function jpeg_set_linear_quality(cinfo, scale_factor, force_baseline)
#     ccall((:jpeg_set_linear_quality, libjpeg), Cvoid, (j_compress_ptr, Cint, boolean), cinfo, scale_factor, force_baseline)
# end

# function jpeg_add_quant_table(cinfo, which_tbl, basic_table, scale_factor, force_baseline)
#     ccall((:jpeg_add_quant_table, libjpeg), Cvoid, (j_compress_ptr, Cint, Ptr{UInt32}, Cint, boolean), cinfo, which_tbl, basic_table, scale_factor, force_baseline)
# end

# function jpeg_quality_scaling(quality)
#     ccall((:jpeg_quality_scaling, libjpeg), Cint, (Cint,), quality)
# end

# function jpeg_simple_progression(cinfo)
#     ccall((:jpeg_simple_progression, libjpeg), Cvoid, (j_compress_ptr,), cinfo)
# end

# function jpeg_suppress_tables(cinfo, suppress)
#     ccall((:jpeg_suppress_tables, libjpeg), Cvoid, (j_compress_ptr, boolean), cinfo, suppress)
# end

# function jpeg_alloc_quant_table(cinfo)
#     ccall((:jpeg_alloc_quant_table, libjpeg), Ptr{JQUANT_TBL}, (j_common_ptr,), cinfo)
# end

# function jpeg_alloc_huff_table(cinfo)
#     ccall((:jpeg_alloc_huff_table, libjpeg), Ptr{JHUFF_TBL}, (j_common_ptr,), cinfo)
# end

function jpeg_start_compress(cinfo::jpeg_compress_struct, write_all_tables::Bool)
    ccall((:jpeg_start_compress, libjpeg), Cvoid, (j_compress_ptr, boolean), Ref(cinfo), write_all_tables)
end

function jpeg_write_scanlines(cinfo::jpeg_compress_struct, scanlines::Vector{Ptr{JSAMPLE}}, num_lines::Integer)
    ccall((:jpeg_write_scanlines, libjpeg), JDIMENSION, (j_compress_ptr, JSAMPARRAY, JDIMENSION), Ref(cinfo), scanlines, num_lines)
end

function jpeg_finish_compress(cinfo::jpeg_compress_struct)
    ccall((:jpeg_finish_compress, libjpeg), Cvoid, (j_compress_ptr,), Ref(cinfo))
end

# function jpeg_write_raw_data(cinfo, data, num_lines)
#     ccall((:jpeg_write_raw_data, libjpeg), JDIMENSION, (j_compress_ptr, JSAMPIMAGE, JDIMENSION), cinfo, data, num_lines)
# end

# function jpeg_write_marker(cinfo, marker, dataptr, datalen)
#     ccall((:jpeg_write_marker, libjpeg), Cvoid, (j_compress_ptr, Cint, Ptr{JOCTET}, UInt32), cinfo, marker, dataptr, datalen)
# end

# function jpeg_write_m_header(cinfo, marker, datalen)
#     ccall((:jpeg_write_m_header, libjpeg), Cvoid, (j_compress_ptr, Cint, UInt32), cinfo, marker, datalen)
# end

# function jpeg_write_m_byte(cinfo, val)
#     ccall((:jpeg_write_m_byte, libjpeg), Cvoid, (j_compress_ptr, Cint), cinfo, val)
# end

# function jpeg_write_tables(cinfo)
#     ccall((:jpeg_write_tables, libjpeg), Cvoid, (j_compress_ptr,), cinfo)
# end

# function jpeg_write_icc_profile(cinfo, icc_data_ptr, icc_data_len)
#     ccall((:jpeg_write_icc_profile, libjpeg), Cvoid, (j_compress_ptr, Ptr{JOCTET}, UInt32), cinfo, icc_data_ptr, icc_data_len)
# end

# function jpeg_read_header(cinfo, require_image)
#     ccall((:jpeg_read_header, libjpeg), Cint, (j_decompress_ptr, boolean), cinfo, require_image)
# end

# function jpeg_start_decompress(cinfo)
#     ccall((:jpeg_start_decompress, libjpeg), boolean, (j_decompress_ptr,), cinfo)
# end

# function jpeg_read_scanlines(cinfo, scanlines, max_lines)
#     ccall((:jpeg_read_scanlines, libjpeg), JDIMENSION, (j_decompress_ptr, JSAMPARRAY, JDIMENSION), cinfo, scanlines, max_lines)
# end

# function jpeg_skip_scanlines(cinfo, num_lines)
#     ccall((:jpeg_skip_scanlines, libjpeg), JDIMENSION, (j_decompress_ptr, JDIMENSION), cinfo, num_lines)
# end

# function jpeg_crop_scanline(cinfo, xoffset, width)
#     ccall((:jpeg_crop_scanline, libjpeg), Cvoid, (j_decompress_ptr, Ptr{JDIMENSION}, Ptr{JDIMENSION}), cinfo, xoffset, width)
# end

# function jpeg_finish_decompress(cinfo)
#     ccall((:jpeg_finish_decompress, libjpeg), boolean, (j_decompress_ptr,), cinfo)
# end

# function jpeg_read_raw_data(cinfo, data, max_lines)
#     ccall((:jpeg_read_raw_data, libjpeg), JDIMENSION, (j_decompress_ptr, JSAMPIMAGE, JDIMENSION), cinfo, data, max_lines)
# end

# function jpeg_has_multiple_scans(cinfo)
#     ccall((:jpeg_has_multiple_scans, libjpeg), boolean, (j_decompress_ptr,), cinfo)
# end

# function jpeg_start_output(cinfo, scan_number)
#     ccall((:jpeg_start_output, libjpeg), boolean, (j_decompress_ptr, Cint), cinfo, scan_number)
# end

# function jpeg_finish_output(cinfo)
#     ccall((:jpeg_finish_output, libjpeg), boolean, (j_decompress_ptr,), cinfo)
# end

# function jpeg_input_complete(cinfo)
#     ccall((:jpeg_input_complete, libjpeg), boolean, (j_decompress_ptr,), cinfo)
# end

# function jpeg_new_colormap(cinfo)
#     ccall((:jpeg_new_colormap, libjpeg), Cvoid, (j_decompress_ptr,), cinfo)
# end

# function jpeg_consume_input(cinfo)
#     ccall((:jpeg_consume_input, libjpeg), Cint, (j_decompress_ptr,), cinfo)
# end

# function jpeg_calc_output_dimensions(cinfo)
#     ccall((:jpeg_calc_output_dimensions, libjpeg), Cvoid, (j_decompress_ptr,), cinfo)
# end

# function jpeg_save_markers(cinfo, marker_code, length_limit)
#     ccall((:jpeg_save_markers, libjpeg), Cvoid, (j_decompress_ptr, Cint, UInt32), cinfo, marker_code, length_limit)
# end

# function jpeg_set_marker_processor(cinfo, marker_code, routine)
#     ccall((:jpeg_set_marker_processor, libjpeg), Cvoid, (j_decompress_ptr, Cint, jpeg_marker_parser_method), cinfo, marker_code, routine)
# end

# function jpeg_read_coefficients(cinfo)
#     ccall((:jpeg_read_coefficients, libjpeg), Ptr{jvirt_barray_ptr}, (j_decompress_ptr,), cinfo)
# end

# function jpeg_write_coefficients(cinfo, coef_arrays)
#     ccall((:jpeg_write_coefficients, libjpeg), Cvoid, (j_compress_ptr, Ptr{jvirt_barray_ptr}), cinfo, coef_arrays)
# end

# function jpeg_copy_critical_parameters(srcinfo, dstinfo)
#     ccall((:jpeg_copy_critical_parameters, libjpeg), Cvoid, (j_decompress_ptr, j_compress_ptr), srcinfo, dstinfo)
# end

# function jpeg_abort_compress(cinfo)
#     ccall((:jpeg_abort_compress, libjpeg), Cvoid, (j_compress_ptr,), cinfo)
# end

# function jpeg_abort_decompress(cinfo)
#     ccall((:jpeg_abort_decompress, libjpeg), Cvoid, (j_decompress_ptr,), cinfo)
# end

# function jpeg_abort(cinfo)
#     ccall((:jpeg_abort, libjpeg), Cvoid, (j_common_ptr,), cinfo)
# end

# function jpeg_destroy(cinfo)
#     ccall((:jpeg_destroy, libjpeg), Cvoid, (j_common_ptr,), cinfo)
# end

# function jpeg_resync_to_restart(cinfo, desired)
#     ccall((:jpeg_resync_to_restart, libjpeg), boolean, (j_decompress_ptr, Cint), cinfo, desired)
# end

# function jpeg_read_icc_profile(cinfo, icc_data_ptr, icc_data_len)
#     ccall((:jpeg_read_icc_profile, libjpeg), boolean, (j_decompress_ptr, Ptr{Ptr{JOCTET}}, Ptr{UInt32}), cinfo, icc_data_ptr, icc_data_len)
# end

######################################################################################################
# macros from jpeglib.h

jpeg_create_compress(cinfo) =
    jpeg_CreateCompress(cinfo, JPEG_LIB_VERSION, sizeof(jpeg_compress_struct))
jpeg_create_decompress(cinfo) =
    jpeg_CreateDecompress(cinfo, JPEG_LIB_VERSION, sizeof(jpeg_decompress_struct))

######################################################################################################

end # module
