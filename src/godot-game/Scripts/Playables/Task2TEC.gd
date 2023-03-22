extends Control

func _on_TouchScreenButton_pressed():
	SceneTransition.change_scene("res://Scenes/Playables/Environment/Apartamento.tscn", 1, 1)
	TecGlobals.currentTask = 3
