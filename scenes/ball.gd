extends CharacterBody2D

var speed: float = 300.0
var speed_increment: float = 1.05
var moving: bool = false

func _ready() -> void:
	var rand_x: float = randf_range(-0.75, 0.75)
	var rand_y: float = randf_range(-0.75, 0.75)
	velocity = Vector2(rand_x,rand_y).normalized() * speed
	#velocity = Vector2(0,1) * speed

func _physics_process(delta: float) -> void:
	if moving:
		var collision_info: KinematicCollision2D = move_and_collide(velocity * delta)
		if collision_info: # collision occured
			# get the new vector after the bounce
			var normal: Vector2 = collision_info.get_normal()
			# check to make sure we are no longer making contact and dont get stuck
			# without this check the ball would sometimes get stuck to the paddle 
			# because the physics process would run again before contact had ended
			if normal.dot(velocity.normalized()) <= 1.0:
				velocity = velocity.bounce(normal) * speed_increment
		Globals.ball_position = position
			
func start_moving():
	moving = true
