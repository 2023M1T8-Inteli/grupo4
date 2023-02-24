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
	
	get_node("ColorRect/WiresTask").connect("task_complete", self, "task_complete")
	
	pass



func _on_TextureButton_pressed():
	$GUI.visible = false
	$ColorRect/WiresTask.visible = true
	
	
func task_complete():
	$ColorRect/Timer.start()
	yield($ColorRect/Timer, "timeout")
	$GUI.visible = true
	$ColorRect/WiresTask.visible = false
	$ColorRect/TextureButton.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$ColorRect.color = Color("34921d")
