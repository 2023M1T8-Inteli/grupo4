extends Node2D

# Função que faz com que o jogador possa voltar a tela de início
func _on_TextureButton_pressed():
	if Global.parte == "administrativo":
		SceneTransition.change_scene("res://Scenes/Playables/Environment/Limbo3.tscn", 1, 1)
	elif Global.parte == "tecnico":
		SceneTransition.change_scene("res://Scenes/Non Playables/misc/Title Screen.tscn", 1.5 , 1.5)
