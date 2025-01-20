extends Node2D

var ball_scene: PackedScene = preload("res://scenes/ball.tscn")
var ball: CharacterBody2D
var playing: bool = false

func _ready() -> void:
	#restart()
	pass
	
func _process(_delta: float) -> void:
	if Input.is_action_pressed("start") and not playing:
		restart()
	if Input.is_action_pressed("restart") and playing:
		ball.queue_free()
		restart()
	if Input.is_action_pressed("quit") and playing:
		quit()
	if not Globals.game_is_against_player:
		if Globals.player_2_score > 9 or Globals.player_1_score > 9:
			$GameOver.play()
			quit()
			
func quit() -> void:
	playing = false
	$HUD.show_buttons()
	
func restart() -> void:
	playing = true
	ball = ball_scene.instantiate() as CharacterBody2D
	ball.scale = Vector2(.30,.30)
	ball.position = Globals.screen_center
	ball.position.y += randf_range(-250.0,250.0)
	Globals.ball_position = ball.position
	ball.start_moving()
	$Balls.add_child(ball)

func _on_walls_ball_hit_left_wall() -> void:
	#print("Main::_on_walls_ball_hit_left_wall()")
	ball.queue_free()
	Globals.player_2_score += 1
	$HUD.update_scores()
	$Out.play()
	restart()

func _on_walls_ball_hit_right_wall() -> void:
	#print("Main::_on_walls_ball_hit_right_wall()")
	ball.queue_free()
	Globals.player_1_score += 1
	$HUD.update_scores()
	$Out.play()
	restart()


func _on_hud_new_game_cpu() -> void:
	Globals.player_1_score = 0
	Globals.player_2_score = 0
	Globals.game_is_against_player = false
	$HUD.update_scores()
	restart()

func _on_hud_new_game_players() -> void:
	Globals.player_1_score = 0
	Globals.player_2_score = 0
	Globals.game_is_against_player = true
	$HUD.update_scores()
	restart()

func player_paddle_hit():
	$PaddleHit.play()
	
func wall_hit():
	$WallHit.play()

func _on_player_1_player_1_hit() -> void:
	player_paddle_hit()

func _on_player_2_player_2_hit() -> void:
	player_paddle_hit()

func _on_walls_ball_hit_bottom_wall() -> void:
	wall_hit()

func _on_walls_ball_hit_top_wall() -> void:
	wall_hit()

func _on_hud_music_button() -> void:
	if Globals.music_on:
		$BGMusic.stop()
		Globals.music_on = false
	else:
		$BGMusic.play()
		Globals.music_on = true
