extends MultiMeshInstance2D

func packDataToColors(meshSize: Vector2, rectSize: Vector2, rectCenter: Vector2, insideColorIndex: int, borderColorIndex: int, out: Array[Color]) -> void:
	out[0] = Color(meshSize.x, meshSize.y, rectSize.x, rectSize.y)
	out[1] = Color(rectCenter.x, rectCenter.y, float(insideColorIndex * 256 + borderColorIndex), 0)

var time = 0
func _process(delta: float) -> void:
	var windowSize := get_viewport().get_visible_rect().size
	
	var rectSize := Vector2(128, 256)
	var rectPos := windowSize / 2. #position on screen
	var rectCenter := Vector2(64, 128) #position in shader
	var rectRotation := deg_to_rad(20)
	var insideColorIndex := 1
	var borderColorIndex := 2
	
	var i := 0
	var transform_ := Transform2D()
	transform_ = transform_.rotated_local(rectRotation)
	transform_ = transform_.scaled_local(rectSize)
	transform_.origin = rectPos
	multimesh.set_instance_transform_2d(i, transform_)
	
	var colors : Array[Color] = [Color(), Color()]
	packDataToColors(rectSize, rectSize, rectCenter, insideColorIndex, borderColorIndex, colors)
	#print(colors)
	multimesh.set_instance_color(i, colors[0])
	multimesh.set_instance_custom_data(i, colors[1])
	
	time += delta
