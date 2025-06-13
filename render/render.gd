extends Node

var sm: ShaderMaterial = load("res://render/render.tres")

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

var cornerRadii: Array[float]
func setCornerRadii() -> void:
    cornerRadii.resize(ObjType.size())
    cornerRadii[ObjType.STATIC_RECT_BORDER] = 3
    cornerRadii[ObjType.DYNAMIC_RECT_BORDER] = 3
    cornerRadii[ObjType.GP_RECT_BORDER] = 3
    cornerRadii[ObjType.WOOD_BORDER] = 2
    cornerRadii[ObjType.WATER_BORDER] = 2
    cornerRadii[ObjType.BUILD_BORDER] = 2
    cornerRadii[ObjType.GOAL_BORDER] = 2

func setShaderCornerRadii() -> void:
    var shaderCornerRadii: PackedFloat32Array
    shaderCornerRadii.resize(ObjType.size())
    for i in range(ObjType.size()):
        shaderCornerRadii[i] = cornerRadii[i]
    sm.set_shader_parameter("cornerRadiiGlobal", shaderCornerRadii)

var borderThicknesses: Array[float]
func setBorderThicknesses() -> void:
    borderThicknesses.resize(ObjType.size())
    borderThicknesses[ObjType.STATIC_RECT_BORDER] = 4; borderThicknesses[ObjType.STATIC_CIRC_BORDER] = 4
    borderThicknesses[ObjType.DYNAMIC_RECT_BORDER] = 4; borderThicknesses[ObjType.DYNAMIC_CIRC_BORDER] = 4
    borderThicknesses[ObjType.GP_RECT_BORDER] = 4; borderThicknesses[ObjType.GP_CIRC_BORDER] = 4
    borderThicknesses[ObjType.STATIC_RECT_BORDER] = 4; borderThicknesses[ObjType.STATIC_CIRC_BORDER] = 4
    borderThicknesses[ObjType.WOOD_BORDER] = 3; borderThicknesses[ObjType.WATER_BORDER] = 3
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

        sizes[renderSpot] = abs(size)
        rotations[renderSpot] = rotation
        poses[renderSpot] = pos
        centers[renderSpot] = abs(center)
        objTypes[renderSpot] = type
        renderSpot += 1

    func resetRenderObjects() -> void:
        renderSpot = 0

    func renderPartial(renderDataImg: Image) -> void: #doesn't directly send data to the shaders. outer.render does that.
        mmi.set_instance_shader_parameter("scale", outer.scale)
        mmi.set_instance_shader_parameter("aaWidth", outer.aaWidth)
        mmi.multimesh.visible_instance_count = renderSpot
        var aaVec: Vector2 = Vector2(outer.aaWidth, outer.aaWidth) * 2
        for i in range(renderSpot):
            var transform_ := Transform2D()
            transform_ = transform_.rotated_local(rotations[i])
            transform_ = transform_.scaled_local((sizes[i] + aaVec) * outer.scale) #added so AA doesn't get cut off
            transform_.origin = poses[i] * outer.scale + outer.shift
            mmi.multimesh.set_instance_transform_2d(i, transform_)

            var data: Color = outer.packDataToColor(sizes[i] * outer.scale, centers[i] * outer.scale, objTypes[i])
            #data = Color(float(i) / renderSpot, 0., 0., 1.)
            @warning_ignore("integer_division")
            renderDataImg.set_pixel(i % 128 + layerID * 128, i / 128, data)

@onready var areasLayer: RenderLayer = RenderLayer.new($FTRender/mmAreas, 0, self)
@onready var bordersLayer: RenderLayer = RenderLayer.new($FTRender/mmBorders, 1, self)
@onready var insidesLayer: RenderLayer = RenderLayer.new($FTRender/mmInsides, 2, self)

var renderDataImg: Image = Image.create_empty(128 * 3, 128, false, Image.FORMAT_RGBAF)
var renderDataTex: ImageTexture = ImageTexture.create_from_image(renderDataImg)

func resetRenderObjects() -> void:
    areasLayer.resetRenderObjects()
    bordersLayer.resetRenderObjects()
    insidesLayer.resetRenderObjects()

func render() -> void:
    areasLayer.renderPartial(renderDataImg)
    bordersLayer.renderPartial(renderDataImg)
    insidesLayer.renderPartial(renderDataImg)
    renderDataTex.update(renderDataImg)
    sm.set_shader_parameter("data", renderDataTex)

#TODO: make this good
const aaWidth: float = 0.5
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

func getRealInsideSize(size: float, borderThickness: float) -> float:
    return abs(size - 2 * borderThickness)

const ghostRodPadding: float = 1
func getRealBorderSize(size: float, insideSize: float) -> float:
    return max(size, insideSize + ghostRodPadding * 2)

func addRoundedRect(size: Vector2, rotation: float, pos: Vector2, type: PieceType, borderLayer: RenderLayer, insideLayer: RenderLayer) -> void:
    var borderType: ObjType = pieceBorders[type]
    var insideType: ObjType = pieceInsides[type]
    var borderOffset = Vector2(borderThicknesses[borderType], borderThicknesses[borderType])
    var insideSize: Vector2 = Vector2(getRealInsideSize(size.x, borderOffset.x), getRealInsideSize(size.y, borderOffset.y));
    var borderSize: Vector2 = Vector2(getRealBorderSize(size.x, insideSize.x), getRealBorderSize(size.y, insideSize.y))
    borderLayer.addRenderObject(borderSize, rotation, pos, borderSize * 0.5, borderType)
    insideLayer.addRenderObject(insideSize, rotation, pos, insideSize * 0.5, insideType)

func addRoundedRectPiece(size: Vector2, rotation: float, pos: Vector2, type: PieceType) -> void:
    addRoundedRect(size, rotation, pos, type, bordersLayer, insidesLayer)

func addArea(size: Vector2, rotation: float, pos: Vector2, type: PieceType) -> void:
    addRoundedRect(size, rotation, pos, type, areasLayer, areasLayer)

func addCirclePiece(radius: float, rotation: float, pos: Vector2, type: PieceType) -> void:
    addRoundedRectPiece(Vector2(radius, radius) * 2, rotation, pos, type)

const jointRadius: float = 4
func addJoint(pos: Vector2, rotation: float, type: ObjType) -> void:
    var size: Vector2 = Vector2(jointRadius, jointRadius) * 2
    insidesLayer.addRenderObject(Vector2(jointRadius, jointRadius) * 2, rotation, pos, size * 0.5, type)

func addJointedRod(size: Vector2, rotation: float, pos: Vector2, type: PieceType) -> void:
    addRoundedRectPiece(size, rotation, pos, type)
    addJoint(Vector2(size.x * 0.5, 0).rotated(rotation) + pos, 0, ObjType.JOINT_NORMAL)
    addJoint(Vector2(-size.x * 0.5, 0).rotated(rotation) + pos, 0, ObjType.JOINT_NORMAL)

func addRodJoints(size: Vector2, rotation: float, pos: Vector2) -> void:
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

func addDecalCircle(radius: float, rotation: float, pos: Vector2, type: PieceType) -> void:
    addCirclePiece(radius, rotation, pos, type)
    var size: Vector2 = Vector2(radius, radius) * 2
    var borderType: ObjType = pieceBorders[type]
    var borderOffset = Vector2(borderThicknesses[borderType], borderThicknesses[borderType])
    var insideSize: Vector2 = size - 2 * borderOffset
    insidesLayer.addRenderObject(insideSize, rotation, pos, insideSize * 0.5, pieceDecals[type]) #maybe make this a seperate function if i ever wanna add just a decal
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
    addCirclePiece(radius, rotation, pos, PieceType.GP_CIRC)
    addCircleJoints(radius, rotation, pos)

const woodSizePadding: Vector2 = Vector2(-2, 2) #TODO: decide if this padding even looks good
func addWood(pos: Vector2, size: Vector2, rotation: float) -> void:
    addRoundedRectPiece(size + woodSizePadding, rotation, pos, PieceType.WOOD)
    addRodJoints(size, rotation, pos)

const waterSizePadding: Vector2 = Vector2(-2, 6)
func addWater(pos: Vector2, size: Vector2, rotation: float) -> void:
    addRoundedRectPiece(size + waterSizePadding, rotation, pos, PieceType.WATER)
    addRodJoints(size, rotation, pos)

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

func _ready() -> void:
    setupVisuals()
    setupPieceArrays()

func _process(_delta: float) -> void:
    resetRenderObjects()

    #mind the gap test design
    # addBuildArea(Vector2(90, 109), Vector2(404, 166), 0)
    # addGoalArea(Vector2(562.8, 123.4), Vector2(159.10000000000002, 135.70000000000002), 0)
    # addStaticRect(Vector2(94.75, 228.35), Vector2(412, 92), 0)
    # addStaticRect(Vector2(528.8, 229.4), Vector2(254, 90), 0)
    # addStaticCirc(Vector2(-101.3, 231.75), 50, 0)
    # addStaticCirc(Vector2(662.1, 279.1), 93.4, 0)
    # addStaticCirc(Vector2(27.75, 27.749999999999996), 61.3, 0)
    # addStaticRect(Vector2(640.1500000000001, 35.8), Vector2(42.3, 68.60000000000001), 2.050224006112992)
    # addStaticCirc(Vector2(444.1, 268.8), 50, 0)
    # addStaticCirc(Vector2(158.4, 316.8), 96.4, 0)
    # addStaticCirc(Vector2(521.45, 305.5500000000001), 71.5, 0)
    # addGPCirc(Vector2(223.25, 63.54999999999999), 26 * 0.5, 0)
    # addCW(Vector2(152.25, 146.9), 40 * 0.5, 0)
    # addUPW(Vector2(102.25, 146.9), 40 * 0.5, 0)
    # addCCW(Vector2(52.25, 146.9), 40 * 0.5, 0)
    # addWater(Vector2(187.75, 105.225), Vector2(109.49074161772768, 4), -0.8652410242593587)
    # addWood(Vector2(272, 104.925), Vector2(150.85248589267596, 8), 1.7568161828669435)

    #galois
    addBuildArea    (Vector2(215.2,    -348.05),    Vector2(662.4,   346),      0);
    addGoalArea     (Vector2(159.45,   -96.95),     Vector2(100,     100),      0);

    addDynamicRect  (Vector2(-309.2,   368.7),      Vector2(0,       200),      0.7616229195038193);
    addDynamicRect  (Vector2(-287.5,   70.9),       Vector2(0,       200),      1.5712846080060914);
    addDynamicRect  (Vector2(224.15,   145.75),     Vector2(0,       600),      0);

    addStaticRect   (Vector2(-76.7,    -154.1),     Vector2(646.6,   44.6),     0);
    addStaticRect   (Vector2(-80.25,   436.6),      Vector2(640.4,   46.9),     0);
    addStaticRect   (Vector2(70.8,     -516),       Vector2(383.9,   46.4),     0);
    addStaticRect   (Vector2(224.0,    24.0),       Vector2(47,      396.7),    0);
    addStaticRect   (Vector2(-376.8,   142.15),     Vector2(47.4,    634.2),    0);
    addStaticRect   (Vector2(-418.05,  131.45),     Vector2(58.9,    40.7),     0);
    addStaticRect   (Vector2(-402.3,   239.4),      Vector2(12,      200.3),    0);
    addStaticRect   (Vector2(-410.7,   224.75),     Vector2(12,      199.1),    0);
    addStaticRect   (Vector2(-418.35,  218),        Vector2(12,      181.9),    0);
    addStaticRect   (Vector2(-426.5,   210.5),      Vector2(12,      165.7),    0);
    addStaticRect   (Vector2(-434.2,   203),        Vector2(12,      149),      0);
    addStaticRect   (Vector2(-441.4,   195.35),     Vector2(12,      134.8),    0);

    addDynamicRect  (Vector2(-423.75,  86.5),       Vector2(47.3,    49.3),     0);

    addStaticRect   (Vector2(-248.15,  254.15),     Vector2(47.3,    147.2),    0);
    addStaticRect   (Vector2(-87.0,    69.15),      Vector2(377.9,   42.2),     0);
    addStaticRect   (Vector2(46.3,     -43.3),      Vector2(361,     40.5),     0);
    addStaticRect   (Vector2(-284.6,   -43.35),     Vector2(201.8,   39.8),     0);
    addStaticRect   (Vector2(-82.55,   182.6),      Vector2(43.8,    226),      0);
    addStaticRect   (Vector2(140.7,    200.25),     Vector2(214.3,   45.5),     0);
    addStaticRect   (Vector2(73.0,     -838.65),    Vector2(44.5,    641.9),    0);

    addGPCirc       (Vector2(-330.2,   360.6),      32 * 0.5,                  0);

    addWater        (Vector2(379.25,   -196.075),   Vector2(86.29671198834865, 4),  3.0586438866944072);
    addWater        (Vector2(452.825,  -195.55),    Vector2(61.69734597209198, 4),  0.1333012777782165);
    addWater        (Vector2(409.825,  -191.975),   Vector2(147.15374612968583,4), -3.1344571987492262);
    addWater        (Vector2(468.8,    -191.35),    Vector2(29.20068492347458, 4),  3.1347434456258823);
    addWater        (Vector2(395.225,  -191.875),   Vector2(117.95662338334323,4), -3.1309953394168);
    addWater        (Vector2(352.1,    -192.725),   Vector2(204.22130765422037,4), -3.1271470375307753);
    addWater        (Vector2(245.5,    -194.2),     Vector2(181.53184293671455,4), -3.122862061977511);
    addWater        (Vector2(162.025,  -194.375),   Vector2(175.95034810991456,4), -3.139603454735795);
    addWater        (Vector2(293.125,  -193.35),    Vector2(86.26675199635127, 4), -3.121885060464321);
    addWater        (Vector2(202.375,  -195.05),    Vector2(95.26516939574518, 4), -3.1237467792919253);
    addWater        (Vector2(114.4,    -195.225),   Vector2(80.71129103167681, 4),  3.1248655892769728);
    addWater        (Vector2(-21.7,    -193.1),     Vector2(191.52195696577445,4),  3.126450207918391);
    addWater        (Vector2(-63.15,   -192.45),    Vector2(108.61178573248861,4), -0.01473189916762867);
    addWater        (Vector2(32.6,     -193.9),     Vector2(82.91019237705319, 4), -0.015680258798107236);
    addWater        (Vector2(514.05,   -191.6),     Vector2(61.30073409022155,4),  3.1366987285498813);
    addWater        (Vector2(405.125,  -347.475),   Vector2(444.5841483903805, 4),  2.2595011244730445);
    addWater        (Vector2(274.4,    -491.4),     Vector2(546.8136428437019,4),  3.0401042993549403);
    addWater        (Vector2(546.25,   -449.225),   Vector2(139.75032200320686,4), -1.568649639573619);
    addWater        (Vector2(483.475,  -195.7),     Vector2(122.7045740793721,4),  0.06442683942554964);

    addWood         (Vector2(438.5749999999997, -222.50000000000023), Vector2(69.87712429686785, 8), -2.034443935795703);
    addWater        (Vector2(464.97499999999974, -198.95000000000027),Vector2(26.487025125521328,4),  2.5211237249947596);
    addWood         (Vector2(449.34999999999985, -230.2),           Vector2(70.75485849042454, 8),  0.7284029022430051);
    addWater        (Vector2(375.5500000000001,   -349.925),        Vector2(463.2249372605065,4),  2.319168724537061);
    addWater        (Vector2(144.55000000000024,  -299.125),        Vector2(279.50467348507806,4), -2.1237638752234416);
    addWater        (Vector2(302.1500000000002,   -468.85),         Vector2(473.03970235065873,4), -0.21646772040968099);
    addWater        (Vector2(117.25000000000023,  -379.225),        Vector2(120.54195327768667,4), -2.4416496870166715);
    addWater        (Vector2(199.84999999999997,  -334.2),          Vector2(311.8070717607289,4),  1.564061342035788);
    addWater        (Vector2(-56.24999999999966,  -321.25),         Vector2(308.10274260382687,4), -1.1802245913381395);
    addWater        (Vector2(268.62499999999983,  -286.3),          Vector2(585.3227421687963,4),  -0.32356043383270094);
    addWater        (Vector2(154.37500000000023,  -346.325),        Vector2(634.2669824293231,4), -0.5565353606564786);
    addWater        (Vector2(312.2749999999999,   -346.075),        Vector2(402.75472064272594,4),  2.156836325693652);
    addWater        (Vector2(495.0,               -361.975),        Vector2(324.449244875065,4),  -1.3334051685046733);
    addWater        (Vector2(546.225,             -434.175),        Vector2(109.65028499734963,4), -1.5685163489854193);
    addWater        (Vector2(405.1,               -332.425),        Vector2(421.74538823797496,4),  2.3047834407342354);

    addWood         (Vector2(488.3500000000001, -190.7500000000001), Vector2(68.58141147570585, 8),  0.4062320114064488);
    addWood         (Vector2(537.675,           -310.62500000000006),Vector2(268.48162879422483,8),  1.6123381174178268);

    addWater        (Vector2(349.42499999999984,-421.09999999999985),Vector2(390.525047212084, 4), -0.12141709605955493);
    addWater        (Vector2(345.7499999999999, -338.84999999999985),Vector2(397.9496576201573,4),  0.2989423331866208);
    addWater        (Vector2(534.0,              -228.375),          Vector2(103.81956703820325,4),  1.607406467825042);

    addWood         (Vector2(231.37499999999991,-349.2750000000001), Vector2(710.0056513859589,8), -0.4927203566580412);
    addWood         (Vector2(231.37499999999991,-349.2750000000001), Vector2(710.0056513859589,8), -0.4927203566580412);
    addWood         (Vector2(231.37499999999991,-349.2750000000001), Vector2(710.0056513859589,8), -0.4927203566580412);
    addWood         (Vector2(231.37499999999991,-349.2750000000001), Vector2(710.0056513859589,8), -0.4927203566580412);
    addWood         (Vector2(231.37499999999991,-349.2750000000001), Vector2(710.0056513859589,8), -0.4927203566580412);

    addWater        (Vector2(40.975000000000065,-260.87500000000006),Vector2(291.88947394519045,4),  2.5653251506057138);
    addWater        (Vector2(269.27499999999975,-337.10000000000014),Vector2(322.68246388671304,4), -1.5371656007531562);
    addWater        (Vector2(72.12499999999997, -179.84999999999985),Vector2(350.1532128940128,4),  3.137308801457009);
    addWater        (Vector2(514.0999999999999, -215.15),           Vector2(24.82841114529855,4),  -1.229939817279838);
    addWater        (Vector2(527.3250000000004, -197.60000000000025),Vector2(36.66677651498721,4),  0.3247690877039665);
    addWater        (Vector2(130.75,             -335.625),        Vector2(337.59933723276214,4), -1.1558502302577351);
    addWater        (Vector2(140.32500000000005,-180.67499999999984),Vector2(155.25290657504635,4),  0.006119086266999844);
    addWater        (Vector2(19.99999999999949, -287.775),         Vector2(348.8034726031263,4),   2.4615011758759584);
    addWater        (Vector2(129.3250000000001, -268.6750000000004),Vector2(314.84130129320675,4),  2.641929071123555);
    addWater        (Vector2(163.4249999999999, -251.92500000000018),Vector2(363.985885715366,4),   2.8133261184332174);

    addWood         (Vector2(72.9500000000001,  -194.5750000000004), Vector2(163.62146100068904,8),  3.125396026019772);

    addWater        (Vector2(-107.22499999999997,-335.4499999999998),Vector2(312.8168673521299,4),  -1.5981320167854722);
    addWater        (Vector2(85.87499999999994, -338.7249999999999),Vector2(494.5099442882822,4),   2.4397988389431307);
    addWater        (Vector2(260.9499999999998, -339.47499999999997),Vector2(318.9377878207599,4),  1.657127236708582);

    addWood         (Vector2(232.025,            -349.625),         Vector2(711.4821325936441,8), -0.49272289052708557);

    addWater        (Vector2(-113.57500000000005,-452.3999999999999),Vector2(78.90920415262073,4),   1.6234126917661362);
    addWater        (Vector2(65.77499999999989,  -296.79999999999995),Vector2(430.89428227814767,4),  0.569657219266125);
    addWater        (Vector2(-107.97500000000028,-335.4000000000002),Vector2(314.96939930729775,4), -1.5223599878467753);

    addWood         (Vector2(231.975,            -349.4),           Vector2(711.1812515104712,8), -0.49223192003735156);
    addWood         (Vector2(301.5999999999999,  -327.3499999999998),Vector2(75.98348504773897, 8), -2.6850079053678657);

    addWater        (Vector2(282.85,             -283.44999999999993),Vector2(125.12465784169015,4),1.3229101316402645);
    addWater        (Vector2(316.9499999999998,  -266.6999999999997), Vector2(95.4729804709162,4),  -1.167142333853729);
    addWater        (Vector2(370.0749999999998,  -363.0),            Vector2(315.1003371943612,4),-1.0970717045624165);
    addWater        (Vector2(185.05,             -320.35000000000025),Vector2(464.3715968919716,4),0.6654249637962599);
    addWater        (Vector2(315.77499999999975, -176.42500000000024),Vector2(103.85636716157573,4),3.130519442257947);
    addWater        (Vector2(-109.30000000000001, -296.0499999999999), Vector2(234.2445303523651,4),1.516552882577663);

    addWood         (Vector2(521.2383613395593, -230.95875350267696),Vector2(10.161133566986708,8), -0.9419718692625559);
    addWood         (Vector2(502.4807280900011, -204.3471359549996), Vector2(15.045913170991634,8),-3.0220550653574283);

    addWater        (Vector2(531.4750000000001, -209.30000000000024),Vector2(43.950113765495765,4),  0.9250199090725243);
    addWater        (Vector2(534.4633613395599, -213.4087535026772),Vector2(47.9120182982993,4), -2.012311520187584);
    addWater        (Vector2(197.4,              -334.12499999999994),Vector2(317.63452661825,4),  1.3830019044139767);
    addWater        (Vector2(249.37500000000009, -331.5500000000001), Vector2(655.1964762573133,4),-0.4859351721081133);
    addWater        (Vector2(249.45000049999996, -331.5500000000002), Vector2(655.3291166726838,4),-0.48582827041977533);
    addWater        (Vector2(249.45000000000002, -331.5500000000002), Vector2(655.3291157883954,4),-0.4858282711323042);
    addWater        (Vector2(24.624999999999986, -311.3750000000001), Vector2(295.6872418620728,4),-1.1161479454681489);

    addWood         (Vector2(311.1,             -449.22499999999985),Vector2(50.576007157544964,8), -1.3087929297870304);
    addWood         (Vector2(339.6,             -458.8249999999999), Vector2(52.974828928463815,8),0.5940234732009722);

    addWater        (Vector2(232.07500000000005,-235.2249999999999), Vector2(618.430727729469,4),  3.117416208582593);
    addWater        (Vector2(387.1500000000001, -211.4749999999998),  Vector2(314.3654123786524,4),-0.1999845306398804);
    addWater        (Vector2(498.8250000000003, -340.12499999999983),Vector2(212.48314050766496,4),-1.9810644053656885);
    addWater        (Vector2(488.9250000000003, -364.4499999999998), Vector2(159.97794379226184,4),1.1527306669274615);
    addWater        (Vector2(531.3000000000003, -267.0249999999997), Vector2(52.52487505934682,4), 1.1842797692665337);
    addWater        (Vector2(510.2000000000001, -277.8749999999997), Vector2(35.0437226903766,4), 2.2642558313101344);
    addWater        (Vector2(180.7500000000001, -334.3249999999999), Vector2(312.7326693839322,4), 1.487562153167915);
    addWater        (Vector2(58.35000000000002, -203.12500000000006),Vector2(275.2420798133894,4), -2.9616904097684973);
    addWater        (Vector2(34.674999999999976,-335.57499999999993),Vector2(333.6282736819526,4), -1.2049567150001823);
    addWater        (Vector2(142.27499999999998,-334.6749999999997), Vector2(327.68192656904364,4),1.273946503531019);
    addWater        (Vector2(411.22500000000014,-417.8749999999998), Vector2(98.63886151005633,4), -0.4103496660628211);
    addWater        (Vector2(493.7750000000001, -351.35),           Vector2(237.09873997978212,4),-1.9823615110919248);
    addWater        (Vector2(451.4000000000001, -448.77500000000015),Vector2(24.617321137768517,4), 1.148035010404229);
    addWater        (Vector2(406.17499999999995,-429.1),            Vector2(101.3674627284321,4), 2.485957175915139);
    addWater        (Vector2(367.07499999999993,-348.3999999999999),Vector2(491.20637465326143,4),-0.7667551576276914);
    addWater        (Vector2(217.95,            -273.975),          Vector2(229.72368728539965,4),-2.567535052828205);

    addWood         (Vector2(333.6500000000002, -423.02499999999986),Vector2(86.02739389287599,8),  2.743493100483446);
    addWater        (Vector2(230.87500000000006,-448.2499999999998), Vector2(151.53053322680555,4),-2.555603408720134);
    addWater        (Vector2(510.32500000000016,-242.04999999999984),Vector2(61.763682694606445,4), 3.1205431314527505);
    addWater        (Vector2(201.19999999999993,-234.57500000000002),Vector2(556.6673804885645,4), 3.1170692689775787);
    addWater        (Vector2(489.22499999999997,-252.89999999999986),Vector2(30.186130921335128,4), 2.2752903910371147);
    addWater        (Vector2(78.02499999999989, -204.0),             Vector2(313.7662704944559,4), -2.989621792239287);
    addWater        (Vector2(273.75,            -195.9249999999999), Vector2(87.13502453089697,4),  2.773553661168991);
    addWater        (Vector2(177.29999999999995,-258.3),            Vector2(191.88999452811518,4),-2.191469875271229);
    addWater        (Vector2(101.84999999999992,-258.225),          Vector2(161.11658046271984,4), 1.8172050657194116);
    addWater        (Vector2(128.92499999999995,-335.9999999999999), Vector2(325.5029070530707,4), -1.2796043667157695);
    addWater        (Vector2(198.45000000000036,-334.325),          Vector2(318.4319118744224,4), 1.4271005931631653);
    addWater        (Vector2(100.35000000000004,-180.77500000000006),Vector2(250.7075836507545,4), 3.1338145894655076);
    addWater        (Vector2(188.7,             -181.17500000000007),Vector2(74.0089352713578,4),  3.126053363925027);
    addWater        (Vector2(116.9499999999999, -180.34999999999997),Vector2(69.50179853787958,4),  3.1343985330994997);
    addWater        (Vector2(354.4749999999999, -433.34999999999974),Vector2(25.571712887485667,4), 2.1571720337301);
    addWater        (Vector2(325.9749999999999, -423.7499999999997), Vector2(42.90142771517041,4), -3.0926236650644974);
    addWater        (Vector2(332.525,            -448.1749999999999),Vector2(58.999703389085056,4),-2.0992977867246085);
    addWater        (Vector2(356.69999999999993, -410.4499999999997),Vector2(30.76052665348906,4), 0.9214435292675521);
    addWater        (Vector2(260.5250000000001,  -292.22499999999997),Vector2(237.8662754574508,4), 1.856112300080174);
    addWater        (Vector2(300.1750000000002,  -308.90000000000003),Vector2(299.70589333544973,4),-1.0610241619609253);
    addWater        (Vector2(158.29999999999998, -311.1500000000001), Vector2(299.5253912442148,4), 1.0938599674468634);

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
