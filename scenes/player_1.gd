extends StaticBody2D

signal player_1_hit

var speed: float = 500.0

func _process(delta: float) -> void:
	if Input.is_action_pressed("up_p1"):
		position.y -= speed * delta
	elif Input.is_action_pressed("down_p1"):
		position.y += speed * delta
		
	if position.y < 10:
		position.y = 10
		
	if position.y > 540:
		position.y = 540
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	emit_signal("player_1_hit")
