type
  nghttp2_session* = object

  nghttp2_info* = object
    age*: cint
    version_num*: cint
    version_str*: cstring
    proto_str*: cstring

  nghttp2_error* = enum
    NGHTTP2_ERR_FLOODED = -904
    NGHTTP2_ERR_BAD_CLIENT_MAGIC = -903
    NGHTTP2_ERR_CALLBACK_FAILURE = -902
    NGHTTP2_ERR_NOMEM = -901
    NGHTTP2_ERR_FATAL = -900
    NGHTTP2_ERR_TOO_MANY_SETTINGS = -537
    NGHTTP2_ERR_SETTINGS_EXPECTED = -536
    NGHTTP2_ERR_CANCEL = -535
    NGHTTP2_ERR_INTERNAL = -534
    NGHTTP2_ERR_REFUSED_STREAM = -533
    NGHTTP2_ERR_HTTP_MESSAGING = -532
    NGHTTP2_ERR_HTTP_HEADER = -531
    NGHTTP2_ERR_SESSION_CLOSING = -530
    NGHTTP2_ERR_DATA_EXIST = -529
    NGHTTP2_ERR_PUSH_DISABLED = -528
    NGHTTP2_ERR_TOO_MANY_INFLIGHT_SETTINGS = -527
    NGHTTP2_ERR_PAUSE = -526
    NGHTTP2_ERR_INSUFF_BUFSIZE = -525
    NGHTTP2_ERR_FLOW_CONTROL = -524
    NGHTTP2_ERR_HEADER_COMP = -523
    NGHTTP2_ERR_FRAME_SIZE_ERROR = -522
    NGHTTP2_ERR_TEMPORAL_CALLBACK_FAILURE = -521
    NGHTTP2_ERR_INVALID_STATE = -519
    NGHTTP2_ERR_INVALID_HEADER_BLOCK = -518
    NGHTTP2_ERR_GOAWAY_ALREADY_SENT = -517
    NGHTTP2_ERR_START_STREAM_NOT_ALLOWED = -516
    NGHTTP2_ERR_DEFERRED_DATA_EXIST = -515
    NGHTTP2_ERR_INVALID_STREAM_STATE = -514
    NGHTTP2_ERR_INVALID_STREAM_ID = -513
    NGHTTP2_ERR_STREAM_SHUT_WR = -512
    NGHTTP2_ERR_STREAM_CLOSING = -511
    NGHTTP2_ERR_STREAM_CLOSED = -510
    NGHTTP2_ERR_STREAM_ID_NOT_AVAILABLE = -509
    NGHTTP2_ERR_DEFERRED = -508
    NGHTTP2_ERR_EOF = -507
    NGHTTP2_ERR_INVALID_FRAME = -506
    NGHTTP2_ERR_PROTO = -505
    NGHTTP2_ERR_WOULDBLOCK = -504
    NGHTTP2_ERR_UNSUPPORTED_VERSION = -503
    NGHTTP2_ERR_BUFFER_ERROR = -502
    NGHTTP2_ERR_INVALID_ARGUMENT = -501
  
  nghttp2_vec* = object
    base*: ptr uint8
    len*: csize_t
  
  nghttp2_rcbuf* = object

  nghttp2_nv_flag* = enum
    NGHTTP2_NV_FLAG_NONE = 0
    NGHTTP2_NV_FLAG_NO_INDEX = 0x01
    NGHTTP2_NV_FLAG_NO_COPY_NAME = 0x02
    NGHTTP2_NV_FLAG_NO_COPY_VALUE = 0x04
  
  nghttp2_nv* = object
    name: ptr uint8
    value: ptr uint8
    namelen: csize_t
    valuelen: csize_t
    flags: uint8
  
  nghttp2_frame_type* = enum
    NGHTTP2_DATA = 0
    NGHTTP2_HEADERS = 0x01
    NGHTTP2_PRIORITY = 0x02
    NGHTTP2_RST_STREAM = 0x03
    NGHTTP2_SETTINGS = 0x04
    NGHTTP2_PUSH_PROMISE = 0x05
    NGHTTP2_PING = 0x06
    NGHTTP2_GOAWAY = 0x07
    NGHTTP2_WINDOW_UPDATE = 0x08
    NGHTTP2_CONTINUATION = 0x09
    NGHTTP2_ALTSVC = 0x0a
    NGHTTP2_ORIGIN = 0x0c
  
  nghttp2_flag* = enum
    NGHTTP2_FLAG_NONE = 0
    NGHTTP2_FLAG_END_STREAM = 0x01
    NGHTTP2_FLAG_END_HEADERS = 0x04
    NGHTTP2_FLAG_ACK # = 0x01 # なんで重複させるねん
    NGHTTP2_FLAG_PADDED = 0x08
    NGHTTP2_FLAG_PRIORITY = 0x20
  
  nghttp2_settings_id* = enum
    NGHTTP2_SETTINGS_HEADER_TABLE_SIZE = 0x01
    NGHTTP2_SETTINGS_ENABLE_PUSH = 0x02
    NGHTTP2_SETTINGS_MAX_CONCURRENT_STREAMS = 0x03
    NGHTTP2_SETTINGS_INITIAL_WINDOW_SIZE = 0x04
    NGHTTP2_SETTINGS_MAX_FRAME_SIZE = 0x05
    NGHTTP2_SETTINGS_MAX_HEADER_LIST_SIZE = 0x06
    NGHTTP2_SETTINGS_ENABLE_CONNECT_PROTOCOL = 0x08
  
  nghttp2_error_code* = enum
    NGHTTP2_NO_ERROR = 0x00
    NGHTTP2_PROTOCOL_ERROR = 0x01
    NGHTTP2_INTERNAL_ERROR = 0x02
    NGHTTP2_FLOW_CONTROL_ERROR = 0x03
    NGHTTP2_SETTINGS_TIMEOUT = 0x04
    NGHTTP2_STREAM_CLOSED = 0x05
    NGHTTP2_FRAME_SIZE_ERROR = 0x06
    NGHTTP2_REFUSED_STREAM = 0x07
    NGHTTP2_CANCEL = 0x08
    NGHTTP2_COMPRESSION_ERROR = 0x09
    NGHTTP2_CONNECT_ERROR = 0x0a
    NGHTTP2_ENHANCE_YOUR_CALM = 0x0b
    NGHTTP2_INADEQUATE_SECURITY = 0x0c
    NGHTTP2_HTTP_1_1_REQUIRED = 0x0d
  
  nghttp2_frame_hd* = object
    length*: csize_t
    stream_id*: int32
    `type`*: uint8
    flags: uint8
    reserved: uint8
  
  nghttp2_data_source* {.union.} = object
    fd*: cint
    `ptr`*: pointer
  
  nghttp2_data_flag* = enum
    NGHTTP2_DATA_FLAG_NONE = 0
    NGHTTP2_DATA_FLAG_EOF = 0x01
    NGHTTP2_DATA_FLAG_NO_END_STREAM = 0x02
    NGHTTP2_DATA_FLAG_NO_COPY = 0x04
  
  ssize_t* = proc (
    session: ptr nghttp2_session,
    stream_id: int32,
    buf: ptr uint8,
    length: csize_t,
    data_flags: ptr uint32,
    source: ptr nghttp2_data_source,
    user_data: pointer
  )# : ptr nghttp2_data_source_read_callback
  # FIXME: nghttp2_data_source_read_callback型が存在しない

  nghttp2_data_provider* = object
    source*: nghttp2_data_source
    # read_callback*: nghttp2_data_source_read_callback
    # FIXME: nghttp2_data_source_read_callback型が存在しない
  
  nghttp2_data* = object
    hd: nghttp2_frame_hd
    padlen: csize_t
  
  nghttp2_headers_category* = enum
    NGHTTP2_HCAT_REQUEST = 0
    NGHTTP2_HCAT_RESPONSE = 1
    NGHTTP2_HCAT_PUSH_RESPONSE = 2
    NGHTTP2_HCAT_HEADERS = 3
  
  nghttp2_priority_spec* = object
    stream_id*: int32
    weight*: int32
    exclusive*: uint8
  
  nghttp2_headers* = object
    hd*: nghttp2_frame_hd
    padlen*: csize_t
    pri_spec*: nghttp2_priority_spec
    nva*: ptr nghttp2_nv
    nvlen*: csize_t
    cat*: nghttp2_headers_category
  
  nghttp2_priority* = object
    hd*: nghttp2_frame_hd
    pri_spec*: nghttp2_priority_spec
  
  nghttp2_rst_stream* = object
    hd*: nghttp2_frame_hd
    error_code*: uint32
  
  nghttp2_settings_entry* = object
    settings_id: int32
    value: uint32
  
  nghttp2_settings* = object
    hd*: nghttp2_frame_hd
    niv*: csize_t
    iv*: ptr nghttp2_settings_entry
  
  nghttp2_push_promise* = object
    hd*: nghttp2_frame_hd
    padlen*: csize_t
    nva*: ptr nghttp2_nv
    nvlen*: csize_t
    promised_stream_id*: int32
    reserved*: uint8
  
  nghttp2_ping* = object
    hd*: nghttp2_frame_hd
    opaque_data*: array[8, uint8]
  
  nghttp2_goaway* = object
    hd*: nghttp2_frame_hd
    last_stream_id*: int32
    error_code*: uint32
    opaque_data*: ptr uint8
    opaque_data_len*: csize_t
    reserved*: uint8
  
  nghttp2_window_update* = object
    hd*: nghttp2_frame_hd
    window_size_increment*: int32
    reserved*: uint8
  
  nghttp2_extension* = object
    hd*: nghttp2_frame_hd
    payload*: pointer
  
  nghttp2_frame* {.union.} = object
    hd*: nghttp2_frame_hd
    data*: nghttp2_data
    headers*: nghttp2_headers
    priority*: nghttp2_priority
    rst_stream*: nghttp2_rst_stream
    settings*: nghttp2_settings
    push_promise*: nghttp2_push_promise
    ping*: nghttp2_ping
    goaway*: nghttp2_goaway
    window_update*: nghttp2_window_update
    ext*: nghttp2_extension