extends Node2D

# Função que faz com que o jogador possa voltar a tela de início
func _on_TextureButton_pressed():
	SceneTransition.change_scene("res://Scenes/Non Playables/misc/Title Screen.tscn", 1.5 , 1.5)
