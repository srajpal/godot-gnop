extends StaticBody2D

signal player_2_hit

var speed: float = 500.0
		
func _process(delta: float) -> void:
	# playing against cpu vs player
	if not Globals.game_is_against_player:
		var ball = Globals.ball_position
		# if ball is near the cpu side of the screen and it is not above the paddle
		if (ball.x > Globals.screen_center.x && ball.y < position.y + 20):
			position.y -= speed * delta
		# if the ball is near the cpu side of the screen and it is not bellow the paddle
		elif (ball.x > Globals.screen_center.x && ball.y > position.y + 80):
			position.y += speed * delta
	else:
		if Input.is_action_pressed("up_p2"):
			position.y -= speed * delta
		elif Input.is_action_pressed("down_p2"):
			position.y += speed * delta
	
	# dont allow the paddle to go off the screen
	if position.y < 10:
		position.y = 10
	
	# dont allow the paddle to go off the screen
	if position.y > 540:
		position.y = 540

# original way to move the cpu paddle when it was a CharacterBody2D		
#func _physics_process(_delta: float) -> void:
	#var target = Globals.ball_position
	#if (target.x > 500 && target.y < 600):
		#velocity = position.direction_to(Vector2(position.x,target.y - 50)) * speed
		#move_and_slide()

	

func _on_area_2d_body_entered(body: Node2D) -> void:
	emit_signal("player_2_hit")
