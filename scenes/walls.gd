extends Node2D

signal ball_hit_left_wall
signal ball_hit_right_wall
signal ball_hit_top_wall
signal ball_hit_bottom_wall

var cr_needed: int = 16
var cr_x: float = 571.0
var cr_y: float = 15.0
var cr_y_increment: float = 40.0

func _ready() -> void:
	for i in cr_needed:
		var cr = ColorRect.new()
		cr.size = Vector2(10.0, 20.0)
		cr.position = Vector2(cr_x, cr_y)
		cr_y += cr_y_increment
		cr.modulate = Color(1.0, 1.0, 1.0, 0.5)
		$CenterLine.add_child(cr)
	pass

func _on_left_body_entered(_body: Node2D) -> void:
	#print("Walls::_on_left_body_entered()")
	emit_signal("ball_hit_left_wall")

func _on_right_body_entered(_body: Node2D) -> void:
	#print("Walls::_on_right_body_entered()")
	emit_signal("ball_hit_right_wall")

func _on_area_2d_top_body_entered(body: Node2D) -> void:
	emit_signal("ball_hit_top_wall")

func _on_area_2d_bottom_body_entered(body: Node2D) -> void:
	emit_signal("ball_hit_bottom_wall")
