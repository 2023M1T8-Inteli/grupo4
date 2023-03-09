extends VideoPlayer

func _on_ZeAnim_finished():
	SceneTransition.change_scene("res://Scenes/Prelude.tscn",0.5 ,0.5)
