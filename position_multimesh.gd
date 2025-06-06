extends MultiMeshInstance2D

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
    sm = material as ShaderMaterial

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
    return float(data - 2048)

# data layout:
# 96 bytes to work with (6*16 bit floats)
# size: 32 bytes | center: 32 bytes | corner radius index : 4 bytes | border thickness index: 4 bytes | inside color index : 8 bytes | border color index : 8 bytes
func packDataToColors(size: Vector2, center: Vector2, cornerRadiusIndex: int, borderThicknessIndex: int, insideColorIndex: int, borderColorIndex: int, out: Array[Color]) -> void:
    out[0] = Color(size.x, size.y, center.x, center.y);
    out[1] = Color(packIntToHalf(cornerRadiusIndex << 4 + borderThicknessIndex), packIntToHalf(insideColorIndex), packIntToHalf(borderColorIndex), 0);

var sizes: Array[Vector2]
var rotations: Array[float]
var poses: Array[Vector2]
var centers: Array[Vector2]
var cornerRadiusIndices: Array[int]
var borderThicknessIndices: Array[int]
var insideColorIndices: Array[int]
var borderColorIndices: Array[int]
var packedColors: Array[Color] = [Color(), Color()] # allocated once, used in process

func _ready() -> void:
    setupVisuals()
    sizes.resize(multimesh.instance_count);
    rotations.resize(multimesh.instance_count);
    poses.resize(multimesh.instance_count);
    centers.resize(multimesh.instance_count);
    cornerRadiusIndices.resize(multimesh.instance_count);
    borderThicknessIndices.resize(multimesh.instance_count);
    insideColorIndices.resize(multimesh.instance_count);
    borderColorIndices.resize(multimesh.instance_count);

func _process(_delta: float) -> void:
    for i in range(multimesh.instance_count):
        sizes[i] = Vector2(128, 256)
        rotations[i] = 1
        poses[i] = Vector2(640, 360)
        centers[i] = Vector2(64, 128)
        cornerRadiusIndices[i] = cornerRadiusNames.BUILD
        borderThicknessIndices[i] = borderThicknessNames.BUILD
        insideColorIndices[i] = colorNames.BUILD_INSIDE
        borderColorIndices[i] = colorNames.BUILD_BORDER

    for i in range(multimesh.instance_count):
        var transform_ := Transform2D()
        transform_ = transform_.rotated_local(rotations[i])
        transform_ = transform_.scaled_local(sizes[i])
        transform_.origin = poses[i]
        multimesh.set_instance_transform_2d(i, transform_)

        packDataToColors(sizes[i], centers[i], cornerRadiusIndices[i], borderThicknessIndices[i], insideColorIndices[i], borderColorIndices[i], packedColors)
        multimesh.set_instance_color(i, packedColors[0])
        multimesh.set_instance_custom_data(i, packedColors[1])
