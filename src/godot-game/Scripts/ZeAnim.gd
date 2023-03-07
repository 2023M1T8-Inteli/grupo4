extends VideoPlayer

func _on_ZeAnim_finished():
	if get_tree().change_scene("res://Scenes/Prelude.tscn") != OK:
		print("ERRO")
