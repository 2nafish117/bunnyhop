extends Control

func get_all_nested_children(node: Node):
	var all_children = []
	for c in node.get_children():
		all_children.append(c)
		if c.get_child_count() > 0:
			all_children += get_all_nested_children(c)
	return all_children

func set_mouse_filter_nested(filter):
	var nested_children = get_all_nested_children(self)
	for n in nested_children:
		n.mouse_filter = filter

func _ready() -> void:
	set_mouse_filter_nested(MOUSE_FILTER_IGNORE)
	pass
