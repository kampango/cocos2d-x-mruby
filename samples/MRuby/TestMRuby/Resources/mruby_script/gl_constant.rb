module GLConstant

  GL_DEPTH_BUFFER_BIT             = 0x00000100
  GL_STENCIL_BUFFER_BIT           = 0x00000400
  GL_COLOR_BUFFER_BIT             = 0x00004000

  GL_ZERO                         = 0
  GL_ONE                          = 1
  GL_SRC_COLOR                    = 0x0300
  GL_ONE_MINUS_SRC_COLOR          = 0x0301
  GL_SRC_ALPHA                    = 0x0302
  GL_ONE_MINUS_SRC_ALPHA          = 0x0303
  GL_DST_ALPHA                    = 0x0304
  GL_ONE_MINUS_DST_ALPHA          = 0x0305

  GL_DST_COLOR                    = 0x0306
  GL_ONE_MINUS_DST_COLOR          = 0x0307
  GL_SRC_ALPHA_SATURATE           = 0x0308

  GL_NEAREST_MIPMAP_NEAREST       = 0x2700
  GL_LINEAR_MIPMAP_NEAREST        = 0x2701
  GL_NEAREST_MIPMAP_LINEAR        = 0x2702
  GL_LINEAR_MIPMAP_LINEAR         = 0x2703

  GL_REPEAT                       = 0x2901
  GL_CLAMP_TO_EDGE                = 0x812F
  GL_MIRRORED_REPEAT              = 0x8370

  # Buffer Objects
  GL_ARRAY_BUFFER                 = 0x8892
  GL_ELEMENT_ARRAY_BUFFER         = 0x8893
  GL_ARRAY_BUFFER_BINDING         = 0x8894
  GL_ELEMENT_ARRAY_BUFFER_BINDING = 0x8895

  GL_STREAM_DRAW                  = 0x88E0
  GL_STATIC_DRAW                  = 0x88E4
  GL_DYNAMIC_DRAW                 = 0x88E8

  GL_BUFFER_SIZE                  = 0x8764
  GL_BUFFER_USAGE                 = 0x8765

  GL_CURRENT_VERTEX_ATTRIB        = 0x8626

  # DataType
  GL_BYTE                         = 0x1400
  GL_UNSIGNED_BYTE                = 0x1401
  GL_SHORT                        = 0x1402
  GL_UNSIGNED_SHORT               = 0x1403
  GL_INT                          = 0x1404
  GL_UNSIGNED_INT                 = 0x1405
  GL_FLOAT                        = 0x1406
  GL_FIXED                        = 0x140C

  # PixelFormat
  GL_DEPTH_COMPONENT              = 0x1902
  GL_ALPHA                        = 0x1906
  GL_RGB                          = 0x1907
  GL_RGBA                         = 0x1908
  GL_LUMINANCE                    = 0x1909
  GL_LUMINANCE_ALPHA              = 0x190A

  # Boolean
  GL_FALSE                        = 0
  GL_TRUE                         = 1

  # BeginMode
  GL_POINTS                       = 0x0000
  GL_LINES                        = 0x0001
  GL_LINE_LOOP                    = 0x0002
  GL_LINE_STRIP                   = 0x0003
  GL_TRIANGLES                    = 0x0004
  GL_TRIANGLE_STRIP               = 0x0005
  GL_TRIANGLE_FAN                 = 0x0006

  # EnableCap
  GL_TEXTURE_2D                   = 0x0DE1
  GL_CULL_FACE                    = 0x0B44
  GL_BLEND                        = 0x0BE2
  GL_DITHER                       = 0x0BD0
  GL_STENCIL_TEST                 = 0x0B90
  GL_DEPTH_TEST                   = 0x0B71
  GL_SCISSOR_TEST                 = 0x0C11
  GL_POLYGON_OFFSET_FILL          = 0x8037
  GL_SAMPLE_ALPHA_TO_COVERAGE     = 0x809E
  GL_SAMPLE_COVERAGE              = 0x80A0

  # TextureParameterName
  GL_TEXTURE_MAG_FILTER           = 0x2800
  GL_TEXTURE_MIN_FILTER           = 0x2801
  GL_TEXTURE_WRAP_S               = 0x2802
  GL_TEXTURE_WRAP_T               = 0x2803

  # StencilFunction
  GL_NEVER                        = 0x0200
  GL_LESS                         = 0x0201
  GL_EQUAL                        = 0x0202
  GL_LEQUAL                       = 0x0203
  GL_GREATER                      = 0x0204
  GL_NOTEQUAL                     = 0x0205
  GL_GEQUAL                       = 0x0206
  GL_ALWAYS                       = 0x0207

  # StencilOp
  # GL_ZERO
  GL_KEEP                         = 0x1E00
  GL_REPLACE                      = 0x1E01
  GL_INCR                         = 0x1E02
  GL_DECR                         = 0x1E03
  GL_INVERT                       = 0x150A
  GL_INCR_WRAP                    = 0x8507
  GL_DECR_WRAP                    = 0x8508

  # StringName
  GL_VENDOR                       = 0x1F00
  GL_RENDERER                     = 0x1F01
  GL_VERSION                      = 0x1F02
  GL_EXTENSIONS                   = 0x1F03

  # TextureMagFilter
  GL_NEAREST                      = 0x2600
  GL_LINEAR                       = 0x2601

  # GetPName
  GL_LINE_WIDTH                   = 0x0B21
  GL_ALIASED_POINT_SIZE_RANGE     = 0x846D
  GL_ALIASED_LINE_WIDTH_RANGE     = 0x846E
  GL_CULL_FACE_MODE               = 0x0B45
  GL_FRONT_FACE                   = 0x0B46
  GL_DEPTH_RANGE                  = 0x0B70
  GL_DEPTH_WRITEMASK              = 0x0B72
  GL_DEPTH_CLEAR_VALUE            = 0x0B73
  GL_DEPTH_FUNC                   = 0x0B74
  GL_STENCIL_CLEAR_VALUE          = 0x0B91
  GL_STENCIL_FUNC                 = 0x0B92
  GL_STENCIL_FAIL                 = 0x0B94
  GL_STENCIL_PASS_DEPTH_FAIL      = 0x0B95
  GL_STENCIL_PASS_DEPTH_PASS      = 0x0B96
  GL_STENCIL_REF                  = 0x0B97
  GL_STENCIL_VALUE_MASK           = 0x0B93
  GL_STENCIL_WRITEMASK            = 0x0B98
  GL_STENCIL_BACK_FUNC            = 0x8800
  GL_STENCIL_BACK_FAIL            = 0x8801
  GL_STENCIL_BACK_PASS_DEPTH_FAIL = 0x8802
  GL_STENCIL_BACK_PASS_DEPTH_PASS = 0x8803
  GL_STENCIL_BACK_REF             = 0x8CA3
  GL_STENCIL_BACK_VALUE_MASK      = 0x8CA4
  GL_STENCIL_BACK_WRITEMASK       = 0x8CA5
  GL_VIEWPORT                     = 0x0BA2
  GL_SCISSOR_BOX                  = 0x0C10
# GL_SCISSOR_TEST
  GL_COLOR_CLEAR_VALUE            = 0x0C22
  GL_COLOR_WRITEMASK              = 0x0C23
  GL_UNPACK_ALIGNMENT             = 0x0CF5
  GL_PACK_ALIGNMENT               = 0x0D05
  GL_MAX_TEXTURE_SIZE             = 0x0D33
  GL_MAX_VIEWPORT_DIMS            = 0x0D3A
  GL_SUBPIXEL_BITS                = 0x0D50
  GL_RED_BITS                     = 0x0D52
  GL_GREEN_BITS                   = 0x0D53
  GL_BLUE_BITS                    = 0x0D54
  GL_ALPHA_BITS                   = 0x0D55
  GL_DEPTH_BITS                   = 0x0D56
  GL_STENCIL_BITS                 = 0x0D57
  GL_POLYGON_OFFSET_UNITS         = 0x2A00
# GL_POLYGON_OFFSET_FILL
  GL_POLYGON_OFFSET_FACTOR        = 0x8038
  GL_TEXTURE_BINDING_2D           = 0x8069
  GL_SAMPLE_BUFFERS               = 0x80A8
  GL_SAMPLES                      = 0x80A9
  GL_SAMPLE_COVERAGE_VALUE        = 0x80AA
  GL_SAMPLE_COVERAGE_INVERT       = 0x80AB
end
