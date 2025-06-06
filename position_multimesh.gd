extends MultiMeshInstance2D

func packDataToColors(meshSize: Vector2, rectSize: Vector2, rectCenter: Vector2, insideColorIndex: int, borderColorIndex: int, out: Array[Color]) -> void:
	out[0] = Color(meshSize.x, meshSize.y, rectSize.x, rectSize.y)
	out[1] = Color(rectCenter.x, rectCenter.y, float(insideColorIndex * 256 + borderColorIndex), 0)

var time = 0
func _process(delta: float) -> void:
	var windowSize := get_viewport().get_visible_rect().size
	
	var rectSizes : Array[Vector2] = [Vector2(128, 256), Vector2(512, 64), Vector2(48, 48)]
	var rectPoses : Array[Vector2] = [Vector2(560, 180), Vector2(900, 400), Vector2(600, 350)]
	var rectCenters : Array[Vector2]
	for size in rectSizes:
		rectCenters.append(size / 2.)	
	var rectRotations : Array[float] = [deg_to_rad(20), deg_to_rad(45), deg_to_rad(70)]
	var insideColorIndexes : Array[int] = [1, 3, 5]
	var borderColorIndexes : Array[int] = [0, 2, 4]
	
	for i in range(3):
		var transform_ := Transform2D()
		transform_ = transform_.rotated_local(rectRotations[i])
		transform_ = transform_.scaled_local(rectSizes[i])
		transform_.origin = rectPoses[i]
		multimesh.set_instance_transform_2d(i, transform_)
		
		var colors : Array[Color] = [Color(), Color()]
		packDataToColors(rectSizes[i], rectSizes[i], rectCenters[i], insideColorIndexes[i], borderColorIndexes[i], colors)
		multimesh.set_instance_color(i, colors[0])
		multimesh.set_instance_custom_data(i, colors[1])
	
	time += delta
