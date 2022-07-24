#ifndef FLAGS_H
#define FLAGS_H

#ifndef MINIMAL_CORE
/* #undef MINIMAL_CORE */
#endif

// BUILD flags

#ifndef BUILD_GL
/* #undef BUILD_GL */
#endif

#ifndef BUILD_GLES2
/* #undef BUILD_GLES2 */
#endif

#ifndef BUILD_GLES3
/* #undef BUILD_GLES3 */
#endif

// Miscellaneous flags

#ifndef COLOR_16_BIT
/* #undef COLOR_16_BIT */
#endif

#ifndef COLOR_5_6_5
/* #undef COLOR_5_6_5 */
#endif

#ifndef DISABLE_THREADING
/* #undef DISABLE_THREADING */
#endif

#ifndef FIXED_ROM_BUFFER
/* #undef FIXED_ROM_BUFFER */
#endif

// M_CORE flags

#ifndef M_CORE_GBA
#define M_CORE_GBA
#endif

#ifndef M_CORE_GB
/* #undef M_CORE_GB */
#endif

// ENABLE flags

#ifndef ENABLE_SCRIPTING
#define ENABLE_SCRIPTING
#endif

// USE flags

#ifndef USE_DEBUGGERS
/* #undef USE_DEBUGGERS */
#endif

#ifndef USE_EDITLINE
/* #undef USE_EDITLINE */
#endif

#ifndef USE_ELF
/* #undef USE_ELF */
#endif

#ifndef USE_EPOXY
/* #undef USE_EPOXY */
#endif

#ifndef USE_FFMPEG
/* #undef USE_FFMPEG */
#endif

#ifndef USE_GDB_STUB
/* #undef USE_GDB_STUB */
#endif

#ifndef USE_LIBAV
/* #undef USE_LIBAV */
#endif

#ifndef USE_LIBAVRESAMPLE
/* #undef USE_LIBAVRESAMPLE */
#endif

#ifndef USE_LIBSWRESAMPLE
/* #undef USE_LIBSWRESAMPLE */
#endif

#ifndef USE_LIBZIP
/* #undef USE_LIBZIP */
#endif

#ifndef USE_LZMA
/* #undef USE_LZMA */
#endif

#ifndef USE_MINIZIP
/* #undef USE_MINIZIP */
#endif

#ifndef USE_PNG
#define USE_PNG
#endif

#ifndef USE_PTHREADS
#define USE_PTHREADS
#endif

#ifndef USE_SQLITE3
/* #undef USE_SQLITE3 */
#endif

#ifndef USE_ZLIB
#define USE_ZLIB
#endif

#endif
