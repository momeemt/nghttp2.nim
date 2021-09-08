import types

when defined(windows):
  {.push importc, dynlib: "nghttp2(|-14).dll", cdecl.}
elif defined(macosx):
  {.push importc, dynlib: "libnghttp2(|.14).dylib", cdecl.}
else:
  {.push importc, dynlib: "libnghttp2.so(|.14)", cdecl.}

const
  NGHTTP2_PROTO_VERSION_ID* = "h2"
  NGHTTP2_PROTO_VERSION_ID_LEN* = 2
  NGHTTP2_PROTO_ALPN* = "\002h2"
  # NGHTTP2_PROTO_ALPN_LEN* = (sizeof(NGHTTP2_PROTO_ALPN) - 1)
  NGHTTP2_CLEARTEXT_PROTO_VERSION_ID* = "h2c"
  NGHTTP2_CLEARTEXT_PROTO_VERSION_ID_LEN* = 3
  NGHTTP2_VERSION_AGE* = 1
  NGHTTP2_DEFAULT_WEIGHT* = 16
  NGHTTP2_MAX_WEIGHT* = 256
  NGHTTP2_MIN_WEIGHT* = 1
  NGHTTP2_MAX_WINDOW_SIZE* = int32((1.uint shl 31) - 1)
  NGHTTP2_INITIAL_WINDOW_SIZE* = (1 shl 16) - 1
  NGHTTP2_INITIAL_CONNECTION_WINDOW_SIZE* = (1 shl 16) - 1
  NGHTTP2_DEFAULT_HEADER_TABLE_SIZE* = 1 shl 12
  NGHTTP2_CLIENT_MAGIC* = "PRI * HTTP/2.0\r\n\r\nSM\r\n\r\n"
  NGHTTP2_CLIENT_MAGIC_LEN* = 24
  NGHTTP2_DEFAULT_MAX_SETTINGS* = 32
  NGHTTP2_INITIAL_MAX_CONCURRENT_STREAMS* = (1.uint shl 31) - 1

proc nghttp2_rcbuf_incref* (rcbuf: ptr nghttp2_rcbuf)
proc nghttp2_rcbuf_decref* (rcbuf: ptr nghttp2_rcbuf)
proc nghttp2_rcbuf_get_buf* (rcbuf: ptr nghttp2_rcbuf): nghttp2_vec
proc nghttp2_rcbuf_is_static* (rcbuf: ptr nghttp2_rcbuf): cint
