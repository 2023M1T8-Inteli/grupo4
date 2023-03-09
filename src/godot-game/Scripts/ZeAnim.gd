extends VideoPlayer

func _on_ZeAnim_finished():
	SceneTransition.change_scene("res://Scenes/Prelude.tscn",0.5 ,0.5)


func _on_TextureButton_pressed():
	SceneTransition.change_scene("res://Scenes/Prelude.tscn",0.5 ,0.5)
