extends ImmediateGeometry

var lines := []
var arrows := []

class Line:
	var from: Vector3
	var to: Vector3
	var color: Color
	var width: float
	
	func _init(_from: Vector3, _to: Vector3, _color: Color, _width: float) -> void:
		self.from = _from
		self.to = _to
		self.color = _color
		self.width = _width

func draw_line(from: Vector3, to: Vector3, color: Color = Color(1.0, 0.0, 0.0, 1.0), width: float = 0.025) -> void:
	lines.append(Line.new(from, to, color, width))

func draw_arrow(from: Vector3, to: Vector3, color: Color = Color(1.0, 0.0, 0.0, 1.0), width: float = 0.025) -> void:
	arrows.append(Line.new(from, to, color, width))

func _draw_all_lines() -> void:
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

func _draw_all_arrows() -> void:
	for arrow in arrows:
		var along: Vector3 = arrow.to - arrow.from
		var perp = along.cross(Vector3.UP).normalized()
		var norm = perp.cross(along).normalized()
		begin(Mesh.PRIMITIVE_TRIANGLES)
		
		# base of arrow
		set_color(arrow.color)
		set_normal(norm)
		add_vertex(arrow.from + perp * arrow.width * 0.5)
		
		set_color(arrow.color)
		set_normal(norm)
		add_vertex(arrow.from - perp * arrow.width * 0.5)
		
		set_color(arrow.color)
		set_normal(norm)
		add_vertex(arrow.to + perp * arrow.width * 0.5)
		
		set_color(arrow.color)
		set_normal(norm)
		add_vertex(arrow.from - perp * arrow.width * 0.5)
		
		set_color(arrow.color)
		set_normal(norm)
		add_vertex(arrow.to - perp * arrow.width * 0.5)
		
		set_color(arrow.color)
		set_normal(norm)
		add_vertex(arrow.to + perp * arrow.width * 0.5)
		
		# tip of arrow
		set_color(arrow.color)
		set_normal(norm)
		add_vertex(arrow.to + perp * arrow.width * 1.5)
		
		set_color(arrow.color)
		set_normal(norm)
		add_vertex(arrow.to - perp * arrow.width * 1.5)
		
		set_color(arrow.color)
		set_normal(norm)
		add_vertex(arrow.to + along.normalized() * arrow.width * 1.5)
		
		end()
	arrows = []

func _process(_delta: float) -> void:
	clear()
	_draw_all_lines()
	_draw_all_arrows()
	
	

