const MAX_COMPONENTS = 10

const JSAMPLE = @static BITS_IN_JSAMPLE == 8 ? Cuchar : Cshort
const MAXJSAMPLE = @static BITS_IN_JSAMPLE == 8 ? 255 : 4095
const CENTERJSAMPLE = @static BITS_IN_JSAMPLE == 8 ? 128 : 2048

const JCOEF = Cshort
const JOCTET = Cuchar
const UINT8 = Cuchar

const UINT16 = @static HAVE_UNSIGNED_SHORT ? Cushort : Cuint
const INT16 = Cshort
const INT32 = Clong

const JDIMENSION = Cuint
const JPEG_MAX_DIMENSION = Clong(65500)

# CHECKME(johnnychen94): this is included in Steven's version
const boolean = @static Sys.iswindows() ? Cuchar : Cint
