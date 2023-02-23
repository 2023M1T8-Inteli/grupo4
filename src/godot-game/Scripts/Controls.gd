extends Control

# Define a função que será chamada quando o botão "BackButton" for pressionado
func _on_BackButton_pressed() -> void:
	# Obtém a árvore de cenas e muda para a cena "Title Screen.tscn" quando o botão é pressionado
	get_tree().change_scene("res://Scenes/Title Screen.tscn")
