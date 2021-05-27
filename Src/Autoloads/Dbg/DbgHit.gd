extends MultiMeshInstance

var index: int = -1

func create(pos: Vector3, color: Color = Color(1.0, 0.0, 0.0, 1.0), scale: Vector3 = Vector3(1.0, 1.0, 1.0)) -> void:
	index += 1
	index = index % multimesh.instance_count
	var basis := Basis().scaled(scale)
	var xform: Transform = Transform(basis, pos)
	multimesh.set_instance_color(index, color)
	multimesh.set_instance_transform(index, xform)
