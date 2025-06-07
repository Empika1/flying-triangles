extends Node

enum colorNames {
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
    JOINT_NORMAL_BORDER, JOINT_WHEEL_CENTER_BORDER, JOINT_INSIDE
}

var sm: ShaderMaterial
func setShaderMaterial() -> void:
    sm = bgal.mmi.material as ShaderMaterial

var colors: Array[Color]
func setColors() -> void:
    colors.resize(colorNames.size())
    colors[colorNames.STATIC_RECT_BORDER] = Color("#008009"); colors[colorNames.STATIC_RECT_INSIDE] = Color("#00be01")
    colors[colorNames.STATIC_CIRC_BORDER] = Color("#008009"); colors[colorNames.STATIC_CIRC_INSIDE] = Color("#00be01")
    colors[colorNames.DYNAMIC_RECT_BORDER] = Color("#c6560c"); colors[colorNames.DYNAMIC_RECT_INSIDE] = Color("#f9da2f")
    colors[colorNames.DYNAMIC_CIRC_BORDER] = Color("#c6560c"); colors[colorNames.DYNAMIC_CIRC_INSIDE] = Color("#f9da2f")
    colors[colorNames.GP_RECT_BORDER] = Color("#bb6666"); colors[colorNames.GP_RECT_INSIDE] = Color("#ff6666")
    colors[colorNames.GP_CIRC_BORDER] = Color("#bb6666"); colors[colorNames.GP_CIRC_INSIDE] = Color("#ff6666")
    colors[colorNames.WOOD_BORDER] = Color("#b55900"); colors[colorNames.WOOD_INSIDE] = Color("#6b3400")
    colors[colorNames.WATER_BORDER] = Color("#ffffff"); colors[colorNames.WATER_INSIDE] = Color("#0000ff")
    colors[colorNames.CW_BORDER] = Color("#fc8003"); colors[colorNames.CW_INSIDE] = Color("#ffec00"); colors[colorNames.CW_DECAL] = Color("#fc8003")
    colors[colorNames.CCW_BORDER] = Color("#d147a5"); colors[colorNames.CCW_INSIDE] = Color("#ffcccc"); colors[colorNames.CW_DECAL] = Color("#d147a5")
    colors[colorNames.UPW_BORDER] = Color("#0a69fd"); colors[colorNames.UPW_INSIDE] = Color("#89fae3"); colors[colorNames.CW_DECAL] = Color("#4a69fd")
    colors[colorNames.BUILD_BORDER] = Color("#7777ee"); colors[colorNames.BUILD_INSIDE] = Color("#bcdbf9")
    colors[colorNames.GOAL_BORDER] = Color("#bb6666"); colors[colorNames.GOAL_INSIDE] = Color("#f19191")
    colors[colorNames.JOINT_NORMAL_BORDER] = Color("#838383"); colors[colorNames.JOINT_WHEEL_CENTER_BORDER] = Color("#ffffff"); colors[colorNames.JOINT_INSIDE] = Color("#00000000")

func setShaderColors() -> void:
    var shaderColors: PackedVector4Array
    shaderColors.resize(colorNames.size())
    for i in range(colorNames.size()):
        shaderColors[i] = Vector4(colors[i][0], colors[i][1], colors[i][2], colors[i][3])
    sm.set_shader_parameter("colorsGlobal", shaderColors)

enum cornerRadiusNames {
    STATIC_RECT, DYNAMIC_RECT, GP_RECT, WOOD, WATER, BUILD, GOAL
}

var cornerRadii: Array[float]
func setCornerRadii() -> void:
    cornerRadii.resize(cornerRadiusNames.size())
    cornerRadii[cornerRadiusNames.STATIC_RECT] = 2.4
    cornerRadii[cornerRadiusNames.DYNAMIC_RECT] = 2.4
    cornerRadii[cornerRadiusNames.GP_RECT] = 2.4
    cornerRadii[cornerRadiusNames.WOOD] = 1.6
    cornerRadii[cornerRadiusNames.WATER] = 1.6
    cornerRadii[cornerRadiusNames.BUILD] = 1.6
    cornerRadii[cornerRadiusNames.GOAL] = 1.6

func setShaderCornerRadii() -> void:
    var shaderCornerRadii: PackedFloat32Array
    shaderCornerRadii.resize(cornerRadiusNames.size())
    for i in range(cornerRadiusNames.size()):
        shaderCornerRadii[i] = cornerRadii[i]
    sm.set_shader_parameter("cornerRadiiGlobal", shaderCornerRadii)

enum borderThicknessNames {
    STATIC_RECT, STATIC_CIRC,
    DYNAMIC_RECT, DYNAMIC_CIRC,
    GP_RECT, GP_CIRC,
    WOOD, WATER,
    CW, CCW, UPW,
    BUILD, GOAL,
    JOINT_NORMAL, JOINT_WHEEL_CENTER
}

var borderThicknesses: Array[float]
func setBorderThicknesses() -> void:
    borderThicknesses.resize(borderThicknessNames.size())
    borderThicknesses[borderThicknessNames.STATIC_RECT] = 4; borderThicknesses[borderThicknessNames.STATIC_CIRC] = 4
    borderThicknesses[borderThicknessNames.DYNAMIC_RECT] = 4; borderThicknesses[borderThicknessNames.DYNAMIC_CIRC] = 4
    borderThicknesses[borderThicknessNames.GP_RECT] = 4; borderThicknesses[borderThicknessNames.GP_CIRC] = 4
    borderThicknesses[borderThicknessNames.STATIC_RECT] = 4; borderThicknesses[borderThicknessNames.STATIC_CIRC] = 4
    borderThicknesses[borderThicknessNames.WOOD] = 2.8; borderThicknesses[borderThicknessNames.WATER] = 2.8
    borderThicknesses[borderThicknessNames.BUILD] = 4; borderThicknesses[borderThicknessNames.GOAL] = 4
    borderThicknesses[borderThicknessNames.JOINT_NORMAL] = 2; borderThicknesses[borderThicknessNames.JOINT_WHEEL_CENTER] = 2

func setShaderBorderThicknesses() -> void:
    var shaderBorderThicknesses: PackedFloat32Array
    shaderBorderThicknesses.resize(borderThicknessNames.size())
    for i in range(borderThicknessNames.size()):
        shaderBorderThicknesses[i] = borderThicknesses[i]
    sm.set_shader_parameter("borderThicknessesGlobal", shaderBorderThicknesses)

func setupVisuals() -> void:
    setShaderMaterial()
    setColors()
    setShaderColors()
    setCornerRadii()
    setShaderCornerRadii()
    setBorderThicknesses()
    setShaderBorderThicknesses()

#currently can only store 2*2048+1 = 4097 values from 0 to 4096
#TODO: update to be able to use all 65536 values
func packIntToHalf(data: int) -> float:
    return float(data - 2048) #ints in the range [-2048, 2048] have exact representations in a 16 bit float

# data layout:
# 96 bytes to work with (6*16 bit floats)
# size: 32 bytes | center: 32 bytes | corner radius index : 4 bytes | border thickness index: 4 bytes | inside color index : 8 bytes | border color index : 8 bytes
func packDataToColors(size: Vector2, center: Vector2, cornerRadiusIndex: int, borderThicknessIndex: int, insideColorIndex: int, borderColorIndex: int, out: Array[Color]) -> void:
    out[0] = Color(size.x, size.y, center.x, center.y);
    out[1] = Color(packIntToHalf(cornerRadiusIndex), packIntToHalf(borderThicknessIndex), packIntToHalf(insideColorIndex), packIntToHalf(borderColorIndex));

#render data
class RenderLayer extends RefCounted:
    var outer

    var mmi: MultiMeshInstance2D
    var sizes: Array[Vector2]
    var rotations: Array[float]
    var poses: Array[Vector2]
    var centers: Array[Vector2]
    var cornerRadiusIndices: Array[int]
    var borderThicknessIndices: Array[int]
    var insideColorIndices: Array[int]
    var borderColorIndices: Array[int]

    func _init(mmi_: MultiMeshInstance2D, outer_) -> void:
        outer = outer_
        mmi = mmi_
        var count = mmi.multimesh.instance_count
        sizes.resize(count)
        rotations.resize(count)
        poses.resize(count)
        centers.resize(count)
        cornerRadiusIndices.resize(count)
        borderThicknessIndices.resize(count)
        insideColorIndices.resize(count)
        borderColorIndices.resize(count)

    var renderSpot: int = 0
    func addRenderObject(size: Vector2, rotation: float, pos: Vector2, center: Vector2, cornerRadiusIndex: int, borderThicknessIndex: int, insideColorIndex: int, borderColorIndex: int) -> void:
        assert(renderSpot < mmi.multimesh.instance_count, "can't render this many objects")

        sizes[renderSpot] = size
        rotations[renderSpot] = rotation
        poses[renderSpot] = pos
        centers[renderSpot] = center
        cornerRadiusIndices[renderSpot] = cornerRadiusIndex
        borderThicknessIndices[renderSpot] = borderThicknessIndex
        insideColorIndices[renderSpot] = insideColorIndex
        borderColorIndices[renderSpot] = borderColorIndex
        renderSpot += 1

    func resetRenderObjects() -> void:
        renderSpot = 0

    static var packedColors: Array[Color]
    static func _static_init() -> void:
        packedColors.resize(2)

    func render() -> void:
        for i in range(renderSpot):
            var transform_ := Transform2D()
            transform_ = transform_.rotated_local(rotations[i])
            transform_ = transform_.scaled_local(sizes[i])
            transform_.origin = poses[i]
            mmi.multimesh.set_instance_transform_2d(i, transform_)

            outer.packDataToColors(sizes[i], centers[i], cornerRadiusIndices[i], borderThicknessIndices[i], insideColorIndices[i], borderColorIndices[i], packedColors)
            mmi.multimesh.set_instance_color(i, packedColors[0])
            mmi.multimesh.set_instance_custom_data(i, packedColors[1])

@onready var bgal = RenderLayer.new($BuildGoalAreaLayer, self)
@onready var ol = RenderLayer.new($OutlineLayer, self)
@onready var iajl = RenderLayer.new($InsideAndJointLayer, self)

func _ready() -> void:
    setupVisuals()

var packedColors: Array[Color] = [Color(), Color()] # allocated once, used in process
func _process(_delta: float) -> void:
    bgal.resetRenderObjects()
    bgal.addRenderObject(Vector2(128, 256), 1, Vector2(640, 360), Vector2(64, 128), cornerRadiusNames.BUILD, borderThicknessNames.BUILD, colorNames.BUILD_INSIDE, colorNames.BUILD_BORDER)

    ol.addRenderObject(Vector2(256, 126), 1, Vector2(640, 360), Vector2(128, 64), cornerRadiusNames.WOOD, borderThicknessNames.WOOD, colorNames.WOOD_INSIDE, colorNames.WOOD_BORDER)

    bgal.render()
    ol.render()
    #iajl.render()
