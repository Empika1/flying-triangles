extends Node

enum ObjType {
    STATIC_RECT_BORDER, STATIC_RECT_INSIDE,
    STATIC_CIRC_BORDER, STATIC_CIRC_INSIDE,
    DYNAMIC_RECT_BORDER, DYNAMIC_RECT_INSIDE,
    DYNAMIC_CIRC_BORDER, DYNAMIC_CIRC_INSIDE,
    GP_RECT_BORDER, GP_RECT_INSIDE,
    GP_CIRC_BORDER, GP_CIRC_INSIDE,
    WOOD_BORDER, WOOD_INSIDE,
    WATER_BORDER, WATER_INSIDE,
    CW_BORDER, CW_INSIDE, CW_DECAL,
    CCW_BORDER, CCW_INSIDE, CCW_DECAL,
    UPW_BORDER, UPW_INSIDE, UPW_DECAL,
    BUILD_BORDER, BUILD_INSIDE,
    GOAL_BORDER, GOAL_INSIDE,
    JOINT_NORMAL, JOINT_WHEEL_CENTER,
}

# enum ColorNames {
#     STATIC_RECT_BORDER, STATIC_RECT_INSIDE,
#     STATIC_CIRC_BORDER, STATIC_CIRC_INSIDE,
#     DYNAMIC_RECT_BORDER, DYNAMIC_RECT_INSIDE,
#     DYNAMIC_CIRC_BORDER, DYNAMIC_CIRC_INSIDE,
#     GP_RECT_BORDER, GP_RECT_INSIDE,
#     GP_CIRC_BORDER, GP_CIRC_INSIDE,
#     WOOD_BORDER, WOOD_INSIDE,
#     WATER_BORDER, WATER_INSIDE,
#     CW_BORDER, CW_INSIDE, CW_DECAL,
#     CCW_BORDER, CCW_INSIDE, CCW_DECAL,
#     UPW_BORDER, UPW_INSIDE, UPW_DECAL,
#     BUILD_BORDER, BUILD_INSIDE,
#     GOAL_BORDER, GOAL_INSIDE,
#     JOINT_NORMAL_BORDER, JOINT_WHEEL_CENTER_BORDER,
# }

var sm: ShaderMaterial = load("res://render.tres")

var colors: Array[Color]
func setColors() -> void:
    colors.resize(ObjType.size())
    colors[ObjType.STATIC_RECT_BORDER] = Color("#008009"); colors[ObjType.STATIC_RECT_INSIDE] = Color("#00be01")
    colors[ObjType.STATIC_CIRC_BORDER] = Color("#008009"); colors[ObjType.STATIC_CIRC_INSIDE] = Color("#00be01")
    colors[ObjType.DYNAMIC_RECT_BORDER] = Color("#c6560c"); colors[ObjType.DYNAMIC_RECT_INSIDE] = Color("#f9da2f")
    colors[ObjType.DYNAMIC_CIRC_BORDER] = Color("#c6560c"); colors[ObjType.DYNAMIC_CIRC_INSIDE] = Color("#f9da2f")
    colors[ObjType.GP_RECT_BORDER] = Color("#bb6666"); colors[ObjType.GP_RECT_INSIDE] = Color("#ff6666")
    colors[ObjType.GP_CIRC_BORDER] = Color("#bb6666"); colors[ObjType.GP_CIRC_INSIDE] = Color("#ff6666")
    colors[ObjType.WOOD_BORDER] = Color("#b55900"); colors[ObjType.WOOD_INSIDE] = Color("#6b3400")
    colors[ObjType.WATER_BORDER] = Color("#ffffff"); colors[ObjType.WATER_INSIDE] = Color("#0000ff")
    colors[ObjType.CW_BORDER] = Color("#fc8003"); colors[ObjType.CW_INSIDE] = Color("#ffec00"); colors[ObjType.CW_DECAL] = Color("#fc8003")
    colors[ObjType.CCW_BORDER] = Color("#d147a5"); colors[ObjType.CCW_INSIDE] = Color("#ffcccc"); colors[ObjType.CCW_DECAL] = Color("#d147a5")
    colors[ObjType.UPW_BORDER] = Color("#0a69fd"); colors[ObjType.UPW_INSIDE] = Color("#89fae3"); colors[ObjType.UPW_DECAL] = Color("#4a69fd")
    colors[ObjType.BUILD_BORDER] = Color("#7777ee"); colors[ObjType.BUILD_INSIDE] = Color("#bcdbf9")
    colors[ObjType.GOAL_BORDER] = Color("#bb6666"); colors[ObjType.GOAL_INSIDE] = Color("#f19191")
    colors[ObjType.JOINT_NORMAL] = Color("#838383"); colors[ObjType.JOINT_WHEEL_CENTER] = Color("#ffffff");

func setShaderColors() -> void:
    var shaderColors: PackedVector4Array
    shaderColors.resize(ObjType.size())
    for i in range(ObjType.size()):
        shaderColors[i] = Vector4(colors[i][0], colors[i][1], colors[i][2], colors[i][3])
    sm.set_shader_parameter("colorsGlobal", shaderColors)

# enum CornerRadiusNames {
#     STATIC_RECT, DYNAMIC_RECT, GP_RECT, WOOD, WATER, BUILD, GOAL, ZERO
# }

var cornerRadii: Array[float]
func setCornerRadii() -> void:
    cornerRadii.resize(ObjType.size())
    cornerRadii[ObjType.STATIC_RECT_BORDER] = 2.4
    cornerRadii[ObjType.DYNAMIC_RECT_BORDER] = 2.4
    cornerRadii[ObjType.GP_RECT_BORDER] = 2.4
    cornerRadii[ObjType.WOOD_BORDER] = 1.6
    cornerRadii[ObjType.WATER_BORDER] = 1.6
    cornerRadii[ObjType.BUILD_BORDER] = 1.6
    cornerRadii[ObjType.GOAL_BORDER] = 1.6

func setShaderCornerRadii() -> void: #TODO: make these accurate
    var shaderCornerRadii: PackedFloat32Array
    shaderCornerRadii.resize(ObjType.size())
    for i in range(ObjType.size()):
        shaderCornerRadii[i] = cornerRadii[i]
    sm.set_shader_parameter("cornerRadiiGlobal", shaderCornerRadii)

# enum BorderThicknessNames {
#     STATIC_RECT, STATIC_CIRC,
#     DYNAMIC_RECT, DYNAMIC_CIRC,
#     GP_RECT, GP_CIRC,
#     WOOD, WATER,
#     CW, CCW, UPW,
#     BUILD, GOAL,
#     JOINT_NORMAL, JOINT_WHEEL_CENTER,
#     ZERO
# }

var borderThicknesses: Array[float]
func setBorderThicknesses() -> void: #TODO: make these accurate
    borderThicknesses.resize(ObjType.size())
    borderThicknesses[ObjType.STATIC_RECT_BORDER] = 4; borderThicknesses[ObjType.STATIC_CIRC_BORDER] = 4
    borderThicknesses[ObjType.DYNAMIC_RECT_BORDER] = 4; borderThicknesses[ObjType.DYNAMIC_CIRC_BORDER] = 4
    borderThicknesses[ObjType.GP_RECT_BORDER] = 4; borderThicknesses[ObjType.GP_CIRC_BORDER] = 4
    borderThicknesses[ObjType.STATIC_RECT_BORDER] = 4; borderThicknesses[ObjType.STATIC_CIRC_BORDER] = 4
    borderThicknesses[ObjType.WOOD_BORDER] = 2.5; borderThicknesses[ObjType.WATER_BORDER] = 2.5
    borderThicknesses[ObjType.BUILD_BORDER] = 4; borderThicknesses[ObjType.GOAL_BORDER] = 4
    borderThicknesses[ObjType.CW_BORDER] = 4; borderThicknesses[ObjType.CCW_BORDER] = 4; borderThicknesses[ObjType.UPW_BORDER] = 4;
    borderThicknesses[ObjType.JOINT_NORMAL] = 2; borderThicknesses[ObjType.JOINT_WHEEL_CENTER] = 2

func setShaderBorderThicknesses() -> void:
    var shaderBorderThicknesses: PackedFloat32Array
    shaderBorderThicknesses.resize(ObjType.size())
    for i in range(ObjType.size()):
        shaderBorderThicknesses[i] = borderThicknesses[i]
    sm.set_shader_parameter("borderThicknessesGlobal", shaderBorderThicknesses)

func setupVisuals() -> void:
    setColors()
    setShaderColors()
    setCornerRadii()
    setShaderCornerRadii()
    setBorderThicknesses()
    setShaderBorderThicknesses()

var uintBitsToFloat_Bytes: PackedByteArray = (func():
    var bytes: PackedByteArray
    bytes.resize(4)
    return bytes
).call()
func uintBitsToFloat(data: int) -> float: #32 bit uint to 32 bit float
    uintBitsToFloat_Bytes.encode_u32(0, data)
    return uintBitsToFloat_Bytes.decode_float(0)

# data layout:
# size: 48 bytes as fixed point | center: 48 bytes as fixed point | type: 32 bytes as enum (lol)
func packDataToColor(size: Vector2, center: Vector2, type: ObjType) -> Color:
    var sizeU: Vector2i = Vector2i(int(size.x * 16), int(size.y * 16)) #stored to the precision of 1/16 of a pixel. stores in the range [0, (2 ** 20 - 1) / 16]
    var centerU: Vector2i = Vector2i(int(center.x * 16), int(center.y * 16)) #ditto
    var int1: int = sizeU.x << 8 | sizeU.y >> 16
    var int2: int = sizeU.y << 16 | centerU.x >> 8
    var int3: int = centerU.x << 24 | centerU.y
    var int4: int = int(type)
    return Color(uintBitsToFloat(int1), uintBitsToFloat(int2), uintBitsToFloat(int3), uintBitsToFloat(int4));

#render data
class RenderLayer extends RefCounted:
    var outer

    var mmi: MultiMeshInstance2D
    var sizes: Array[Vector2]
    var rotations: Array[float]
    var poses: Array[Vector2]
    var centers: Array[Vector2]
    var objTypes: Array[ObjType]
    var layerID: int

    func _init(mmi_: MultiMeshInstance2D, layerID_: int, outer_) -> void:
        mmi = mmi_
        layerID = layerID_
        outer = outer_
        var count = mmi.multimesh.instance_count
        sizes.resize(count)
        rotations.resize(count)
        poses.resize(count)
        centers.resize(count)
        objTypes.resize(count)
        mmi.set_instance_shader_parameter("layerID", layerID)

    var renderSpot: int = 0
    func addRenderObject(size: Vector2, rotation: float, pos: Vector2, center: Vector2, type: ObjType) -> void:
        assert(renderSpot < mmi.multimesh.instance_count, "can't render this many objects")

        sizes[renderSpot] = size
        rotations[renderSpot] = rotation
        poses[renderSpot] = pos
        centers[renderSpot] = center
        objTypes[renderSpot] = type
        renderSpot += 1

    func addRenderObjectTransformed(size: Vector2, rotation: float, pos: Vector2, center: Vector2, type: ObjType) -> void:
        addRenderObject(size * outer.scale, rotation, pos * outer.scale + outer.shift, center * outer.scale, type)

    func resetRenderObjects() -> void:
        renderSpot = 0

    var renderDataImg: Image = Image.create_empty(128, 128, false, Image.FORMAT_RGBAF) #128*128 instances allowed (should be plenty)
    var renderDataTex: ImageTexture = ImageTexture.create_from_image(renderDataImg)
    func renderPartial() -> void: #doesn't directly send data to the shaders. render does that.
        mmi.set_instance_shader_parameter("scale", outer.scale)
        mmi.multimesh.visible_instance_count = renderSpot
        for i in range(renderSpot):
            var transform_ := Transform2D()
            transform_ = transform_.rotated_local(rotations[i])
            transform_ = transform_.scaled_local(sizes[i])
            transform_.origin = poses[i]
            mmi.multimesh.set_instance_transform_2d(i, transform_)

            var data: Color = outer.packDataToColor(sizes[i], centers[i], objTypes[i])
            @warning_ignore("integer_division")
            renderDataImg.set_pixel(i % 128, i / 128, data)
        renderDataTex.update(renderDataImg)

@onready var areasLayer: RenderLayer = RenderLayer.new($AreasLayer, 0, self)
@onready var bordersLayer: RenderLayer = RenderLayer.new($BordersLayer, 1, self)
@onready var insidesLayer: RenderLayer = RenderLayer.new($InsidesLayer, 2, self)

var renderDataTexAll: Array[ImageTexture]
func setupRenderDataTexAll() -> void:
    renderDataTexAll.resize(3)
    renderDataTexAll[0] = areasLayer.renderDataTex
    renderDataTexAll[1] = bordersLayer.renderDataTex
    renderDataTexAll[2] = insidesLayer.renderDataTex

func resetRenderObjects() -> void:
    areasLayer.resetRenderObjects()
    bordersLayer.resetRenderObjects()
    insidesLayer.resetRenderObjects()

func render() -> void:
    areasLayer.renderPartial()
    bordersLayer.renderPartial()
    insidesLayer.renderPartial()
    sm.set_shader_parameter("data", renderDataTexAll)

#TODO: make this good
var scale: float = 1
var shift: Vector2 = Vector2(0, 0)
func zoom(deltaScale: float, screen_pos: Vector2):
    var old_scale = scale
    scale *= deltaScale
    shift -= (screen_pos - shift) * (scale / old_scale - 1)

enum PieceType {
    STATIC_RECT, STATIC_CIRC, DYNAMIC_RECT, DYNAMIC_CIRC, GP_RECT, GP_CIRC, WOOD, WATER, CW, CCW, UPW, BUILD, GOAL
}

var pieceBorders: Array[ObjType]
func setPieceBorders() -> void:
    pieceBorders.resize(PieceType.size())
    pieceBorders[PieceType.STATIC_RECT] = ObjType.STATIC_RECT_BORDER
    pieceBorders[PieceType.STATIC_CIRC] = ObjType.STATIC_CIRC_BORDER
    pieceBorders[PieceType.DYNAMIC_RECT] = ObjType.DYNAMIC_RECT_BORDER
    pieceBorders[PieceType.DYNAMIC_CIRC] = ObjType.DYNAMIC_CIRC_BORDER
    pieceBorders[PieceType.GP_RECT] = ObjType.GP_RECT_BORDER
    pieceBorders[PieceType.GP_CIRC] = ObjType.GP_CIRC_BORDER
    pieceBorders[PieceType.WOOD] = ObjType.WOOD_BORDER
    pieceBorders[PieceType.WATER] = ObjType.WATER_BORDER
    pieceBorders[PieceType.CW] = ObjType.CW_BORDER
    pieceBorders[PieceType.CCW] = ObjType.CCW_BORDER
    pieceBorders[PieceType.UPW] = ObjType.UPW_BORDER
    pieceBorders[PieceType.BUILD] = ObjType.BUILD_BORDER
    pieceBorders[PieceType.GOAL] = ObjType.GOAL_BORDER

var pieceInsides: Array[ObjType]
func setPieceInsides() -> void:
    pieceInsides.resize(PieceType.size())
    pieceInsides[PieceType.STATIC_RECT] = ObjType.STATIC_RECT_INSIDE
    pieceInsides[PieceType.STATIC_CIRC] = ObjType.STATIC_CIRC_INSIDE
    pieceInsides[PieceType.DYNAMIC_RECT] = ObjType.DYNAMIC_RECT_INSIDE
    pieceInsides[PieceType.DYNAMIC_CIRC] = ObjType.DYNAMIC_CIRC_INSIDE
    pieceInsides[PieceType.GP_RECT] = ObjType.GP_RECT_INSIDE
    pieceInsides[PieceType.GP_CIRC] = ObjType.GP_CIRC_INSIDE
    pieceInsides[PieceType.WOOD] = ObjType.WOOD_INSIDE
    pieceInsides[PieceType.WATER] = ObjType.WATER_INSIDE
    pieceInsides[PieceType.CW] = ObjType.CW_INSIDE
    pieceInsides[PieceType.CCW] = ObjType.CCW_INSIDE
    pieceInsides[PieceType.UPW] = ObjType.UPW_INSIDE
    pieceInsides[PieceType.BUILD] = ObjType.BUILD_INSIDE
    pieceInsides[PieceType.GOAL] = ObjType.GOAL_INSIDE

var pieceDecals: Array[ObjType]
func setPieceDecals() -> void:
    pieceDecals.resize(PieceType.size())
    pieceDecals[PieceType.CW] = ObjType.CW_DECAL
    pieceDecals[PieceType.CCW] = ObjType.CCW_DECAL
    pieceDecals[PieceType.UPW] = ObjType.UPW_DECAL

func setupPieceArrays() -> void:
    setPieceBorders()
    setPieceInsides()
    setPieceDecals()

func addRoundedRect(size: Vector2, rotation: float, pos: Vector2, type: PieceType, borderLayer: RenderLayer, insideLayer: RenderLayer) -> void:
    var borderType: ObjType = pieceBorders[type]
    var insideType: ObjType = pieceInsides[type]
    borderLayer.addRenderObjectTransformed(size, rotation, pos, size * 0.5, borderType)
    var borderOffset = Vector2(borderThicknesses[borderType], borderThicknesses[borderType])
    var insideSize: Vector2 = size - 2 * borderOffset
    insideLayer.addRenderObjectTransformed(insideSize, rotation, pos, insideSize * 0.5, insideType)

func addRoundedRectPiece(size: Vector2, rotation: float, pos: Vector2, type: PieceType) -> void:
    addRoundedRect(size, rotation, pos, type, bordersLayer, insidesLayer)

func addArea(size: Vector2, rotation: float, pos: Vector2, type: PieceType) -> void:
    addRoundedRect(size, rotation, pos, type, areasLayer, areasLayer)

func addCirclePiece(radius: float, rotation: float, pos: Vector2, type: PieceType) -> void:
    addRoundedRectPiece(Vector2(radius, radius) * 2, rotation, pos, type)

const jointRadius: float = 4
func addJoint(pos: Vector2, rotation: float, type: ObjType) -> void:
    var size: Vector2 = Vector2(jointRadius, jointRadius) * 2
    insidesLayer.addRenderObjectTransformed(Vector2(jointRadius, jointRadius) * 2, rotation, pos, size * 0.5, type)

func addJointedRod(size: Vector2, rotation: float, pos: Vector2, type: PieceType) -> void:
    addRoundedRectPiece(size, rotation, pos, type)
    addJoint(Vector2(size.x * 0.5, 0).rotated(rotation) + pos, 0, ObjType.JOINT_NORMAL)
    addJoint(Vector2(-size.x * 0.5, 0).rotated(rotation) + pos, 0, ObjType.JOINT_NORMAL)

const innerJointThresholdRadius: float = 20
func addCircleJoints(radius: float, rotation: float, pos: Vector2) -> void:
    addJoint(pos, 0, ObjType.JOINT_WHEEL_CENTER)
    addJoint(Vector2(radius, 0).rotated(rotation) + pos, 0, ObjType.JOINT_NORMAL)
    addJoint(Vector2(-radius, 0).rotated(rotation) + pos, 0, ObjType.JOINT_NORMAL)
    addJoint(Vector2(0, radius).rotated(rotation) + pos, 0, ObjType.JOINT_NORMAL)
    addJoint(Vector2(0, -radius).rotated(rotation) + pos, 0, ObjType.JOINT_NORMAL)
    if radius > innerJointThresholdRadius:
        addJoint(Vector2(innerJointThresholdRadius, 0).rotated(rotation) + pos, 0, ObjType.JOINT_NORMAL)
        addJoint(Vector2(-innerJointThresholdRadius, 0).rotated(rotation) + pos, 0, ObjType.JOINT_NORMAL)
        addJoint(Vector2(0, innerJointThresholdRadius).rotated(rotation) + pos, 0, ObjType.JOINT_NORMAL)
        addJoint(Vector2(0, -innerJointThresholdRadius).rotated(rotation) + pos, 0, ObjType.JOINT_NORMAL)

func addJointedCircle(radius: float, rotation: float, pos: Vector2, type: PieceType) -> void:
    addCirclePiece(radius, rotation, pos, type)
    addCircleJoints(radius, rotation, pos)

func addDecalCircle(radius: float, rotation: float, pos: Vector2, type: PieceType) -> void:
    addCirclePiece(radius, rotation, pos, type)
    var size: Vector2 = Vector2(radius, radius) * 2
    var borderType: ObjType = pieceBorders[type]
    var borderOffset = Vector2(borderThicknesses[borderType], borderThicknesses[borderType])
    var insideSize: Vector2 = size - 2 * borderOffset
    insidesLayer.addRenderObjectTransformed(insideSize, rotation, pos, insideSize * 0.5, pieceDecals[type]) #maybe make this a seperate function if i ever wanna add just a decal
    addCircleJoints(radius, rotation, pos)

func addStaticRect(pos: Vector2, size: Vector2, rotation: float) -> void:
    addRoundedRectPiece(size, rotation, pos, PieceType.STATIC_RECT)

func addStaticCirc(pos: Vector2, radius: float, rotation: float) -> void:
    addCirclePiece(radius, rotation, pos, PieceType.STATIC_CIRC)

func addDynamicRect(pos: Vector2, size: Vector2, rotation: float) -> void:
    addRoundedRectPiece(size, rotation, pos, PieceType.DYNAMIC_RECT)

func addDynamicCirc(pos: Vector2, radius: float, rotation: float) -> void:
    addCirclePiece(radius, rotation, pos, PieceType.DYNAMIC_CIRC)

func addGPRect(pos: Vector2, size: Vector2, rotation: float) -> void:
    addRoundedRectPiece(size, rotation, pos, PieceType.GP_RECT)
    addJoint(pos, 0, ObjType.JOINT_WHEEL_CENTER)
    addJoint(Vector2(size.x * 0.5, size.y * 0.5).rotated(rotation) + pos, 0, ObjType.JOINT_NORMAL)
    addJoint(Vector2(-size.x * 0.5, size.y * 0.5).rotated(rotation) + pos, 0, ObjType.JOINT_NORMAL)
    addJoint(Vector2(size.x * 0.5, -size.y * 0.5).rotated(rotation) + pos, 0, ObjType.JOINT_NORMAL)
    addJoint(Vector2(-size.x * 0.5, -size.y * 0.5).rotated(rotation) + pos, 0, ObjType.JOINT_NORMAL)

func addGPCirc(pos: Vector2, radius: float, rotation: float) -> void:
    addJointedCircle(radius, rotation, pos, PieceType.GP_CIRC)

func addWood(pos: Vector2, size: Vector2, rotation: float) -> void:
    addJointedRod(size, rotation, pos, PieceType.WOOD)

const waterWidthPadding: float = 6
func addWater(pos: Vector2, size: Vector2, rotation: float) -> void:
    addJointedRod(Vector2(size.x, size.y + waterWidthPadding), rotation, pos, PieceType.WATER)

func addCW(pos: Vector2, radius: float, rotation: float) -> void:
    addDecalCircle(radius, rotation, pos, PieceType.CW)

func addCCW(pos: Vector2, radius: float, rotation: float) -> void:
    addDecalCircle(radius, rotation, pos, PieceType.CCW)

func addUPW(pos: Vector2, radius: float, rotation: float) -> void:
    addDecalCircle(radius, rotation, pos, PieceType.UPW)

func addBuildArea(pos: Vector2, size: Vector2, rotation: float) -> void:
    addArea(size, rotation, pos, PieceType.BUILD)

func addGoalArea(pos: Vector2, size: Vector2, rotation: float) -> void:
    addArea(size, rotation, pos, PieceType.GOAL)

var renderDataImg: Image = Image.create_empty(128, 128, false, Image.FORMAT_RGBAF)
var renderDataTxt: ImageTexture = ImageTexture.create_from_image(renderDataImg)
func _ready() -> void:
    setupVisuals()
    setupRenderDataTexAll()
    setupPieceArrays()

func _process(_delta: float) -> void:
    resetRenderObjects()

    #TODO: remove mind the gap lollll
    addBuildArea(Vector2(90, 109), Vector2(404, 166), 0)
    addGoalArea(Vector2(562.8, 123.4), Vector2(159.10000000000002, 135.70000000000002), 0)
    addStaticRect(Vector2(94.75, 228.35), Vector2(412, 92), 0)
    addStaticRect(Vector2(528.8, 229.4), Vector2(254, 90), 0)
    addStaticCirc(Vector2(-101.3, 231.75), 50, 0)
    addStaticCirc(Vector2(662.1, 279.1), 93.4, 0)
    addStaticCirc(Vector2(27.75, 27.749999999999996), 61.3, 0)
    addStaticRect(Vector2(640.1500000000001, 35.8), Vector2(42.3, 68.60000000000001), 2.050224006112992)
    addStaticCirc(Vector2(444.1, 268.8), 50, 0)
    addStaticCirc(Vector2(158.4, 316.8), 96.4, 0)
    addStaticCirc(Vector2(521.45, 305.5500000000001), 71.5, 0)
    addGPCirc(Vector2(223.25, 63.54999999999999), 26 * 0.5, 0)
    addUPW(Vector2(152.25, 146.9), 40 * 0.5, 0)
    addCW(Vector2(102.25, 146.9), 40 * 0.5, 0)
    addCCW(Vector2(52.25, 146.9), 40 * 0.5, 0)
    addWater(Vector2(187.75, 105.225), Vector2(109.49074161772768, 4), -0.8652410242593587)
    addWood(Vector2(272, 104.925), Vector2(150.85248589267596, 8), 1.7568161828669435)

    render()

func _unhandled_input(event): #TODO: remove
    if event is InputEventKey && event.pressed:
        if event.keycode == KEY_I:
            zoom(1.1, get_viewport().get_mouse_position())
        elif event.keycode == KEY_O:
            zoom(1. / 1.1, get_viewport().get_mouse_position())
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
            zoom(1. / 1.1, get_viewport().get_mouse_position())
        elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
            zoom(1.1, get_viewport().get_mouse_position())
