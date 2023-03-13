extends Sprite

func _on_TextureButton_pressed():
	if get_tree().change_scene("res://Scenes/Non Playables/misc/Title Screen.tscn") != OK:
		print("OVO ERRO")
