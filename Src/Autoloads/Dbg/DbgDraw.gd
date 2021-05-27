extends ImmediateGeometry

var lines := []

class Line:
	var from: Vector3
	var to: Vector3
	var color: Color
	var width: float
	
	func _init(from: Vector3, to: Vector3, color: Color, width: float) -> void:
		self.from = from
		self.to = to
		self.color = color
		self.width = width

#func draw_line_interpolated(from: Vector3, to: Vector3, color: Color = Color(1.0, 0.0, 0.0, 1.0), width: float = 0.025)

func draw_line(from: Vector3, to: Vector3, color: Color = Color(1.0, 0.0, 0.0, 1.0), width: float = 0.025):
	lines.append(Line.new(from, to, color, width))
	
func _process(delta: float) -> void:
	clear()
	
	for line in lines:
		var along: Vector3 = line.to - line.from
		var perp = along.cross(Vector3.UP).normalized()
		var norm = perp.cross(along).normalized()
		begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
		
		set_color(line.color)
		set_normal(norm)
		add_vertex(line.from + perp * line.width * 0.5)
		
		set_color(line.color)
		set_normal(norm)
		add_vertex(line.from - perp * line.width * 0.5)
		
		set_color(line.color)
		set_normal(norm)
		add_vertex(line.to + perp * line.width * 0.5)
		
		set_color(line.color)
		set_normal(norm)
		add_vertex(line.to - perp * line.width * 0.5)
		
		end()
	lines = []

