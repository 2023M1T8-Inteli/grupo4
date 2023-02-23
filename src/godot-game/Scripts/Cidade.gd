extends Node2D

func _ready():
	
	# Define o comportamento quando a cena for carregada
	# Esconde a caixa de diálogo e mostra o HUD
###	get_node("Player/Camera2D/GUI").visible = true
###	get_node("Player/Camera2D/DialogBox").visible = false
	# Ignora cliques no botão de transição de cena
###	get_node("Player/Camera2D/TextureButton").mouse_filter = Control.MOUSE_FILTER_IGNORE

	# Mostra o personagem principal e esconde o fantasma
	get_node("Player/Ze").visible = true
	get_node("Player/Fantasma").visible = false

	pass
