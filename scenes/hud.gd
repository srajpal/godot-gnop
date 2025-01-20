extends Control

signal new_game_players
signal new_game_cpu
signal music_button

func _ready() -> void:
	$MusicButton/MusicOff.hide()
	$MusicButton/MusicOn.show()

func hide_buttons() -> void:
	$ButtonNewGameCPU.hide()
	$ButtonNewGamePlayer.hide()
	$LabelMessage.hide()
	$MusicButton.hide()
	
func show_buttons() -> void:
	$ButtonNewGameCPU.show()
	$ButtonNewGamePlayer.show()
	$LabelMessage.show()
	$MusicButton.show()

func update_scores() -> void:
	$Player2Score.text = str(Globals.player_1_score)
	$Player1Score.text = str(Globals.player_2_score)

func _on_button_new_game_player_pressed() -> void:
	hide_buttons()
	emit_signal("new_game_players")

func _on_button_new_game_cpu_pressed() -> void:
	hide_buttons()
	emit_signal("new_game_cpu")

func _on_music_button_pressed() -> void:
	if $MusicButton/MusicOn.visible:
		$MusicButton/MusicOn.hide()
		$MusicButton/MusicOff.show()
	else:
		$MusicButton/MusicOn.show()
		$MusicButton/MusicOff.hide()
	emit_signal("music_button")
