extends MultiMeshInstance2D

# data layout:
# 96 bytes to work with (6*16 bit floats)
# size: 32 bytes | center: 32 bytes | rect rounding index : 4 bytes | border thickness index: 4 bytes | inside color index : 8 bytes | border color index : 8 bytes

func packDataToColors(meshSize: Vector2, rectSize: Vector2, rectCenter: Vector2, insideColorIndex: int, borderColorIndex: int, out: Array[Color]) -> void:
	out[0] = Color(meshSize.x, meshSize.y, rectSize.x, rectSize.y)
	out[1] = Color(rectCenter.x, rectCenter.y, float(insideColorIndex * 256 + borderColorIndex), 0)

var rectSizes : Array[Vector2]
var rectPoses : Array[Vector2]
var rectCenters : Array[Vector2]
var rectRotations : Array[float]
var insideColorIndexes : Array[int]
var borderColorIndexes : Array[int]

func _ready() -> void:
	var windowSize := get_viewport().get_visible_rect().size
	
	seed(12345)
	for i in range(multimesh.instance_count):
		rectSizes.append(Vector2(randf_range(1280, 1280), randf_range(720, 720)))
		rectPoses.append(Vector2(randf_range(0, windowSize.x), randf_range(0, windowSize.y)))
		rectCenters.append(rectSizes[-1] / 2.)
		rectRotations.append(randf_range(0, 2 * PI))
		var col = randi_range(0, 2)
		insideColorIndexes.append(col * 2 + 1)
		borderColorIndexes.append(col * 2)

func _process(delta: float) -> void:
	for i in range(len(rectRotations)):
		rectRotations[i] += delta
	
	for i in range(multimesh.instance_count):
		var transform_ := Transform2D()
		transform_ = transform_.rotated_local(rectRotations[i])
		transform_ = transform_.scaled_local(rectSizes[i])
		transform_.origin = rectPoses[i]
		multimesh.set_instance_transform_2d(i, transform_)
		
		var colors : Array[Color] = [Color(), Color()]
		packDataToColors(rectSizes[i], rectSizes[i], rectCenters[i], insideColorIndexes[i], borderColorIndexes[i], colors)
		multimesh.set_instance_color(i, colors[0])
		multimesh.set_instance_custom_data(i, colors[1])
