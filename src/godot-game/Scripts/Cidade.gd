extends Node2D

#signal go_to_prelude

func _ready():

	# Mostra o personagem principal e esconde o fantasma
	get_node("Player/Ze").visible = true
	get_node("Player/Fantasma").visible = false
	
	# Conecta o sinal de conclusão da tarefa ao método task_complete
	if $ColorRect/WiresTask.connect("task_complete", self, "task_complete") != OK:
		print ("An unexpected error occured when trying to connect to the signal")
	
	
	# Passa o controle para o próximo método
	pass



func _on_TextureButton_pressed():
	# Esconde a interface do usuário e mostra a tarefa de fios
	$GUI.visible = false
	$ColorRect/WiresTask.visible = true
	
	
func task_complete():
	# Inicia o temporizador após a conclusão da tarefa
	$ColorRect/Timer.start()
	
	# Aguarda o temporizador chegar ao fim antes de prosseguir
	yield($ColorRect/Timer, "timeout")
	
	# Mostra a interface do usuário novamente e esconde a tarefa de fios
	$GUI.visible = true
	$ColorRect/WiresTask.visible = false
	
	# Desativa o filtro de mouse do botão de textura e muda a cor do retângulo de cores
	$ColorRect/TextureButton.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$ColorRect.color = Color("34921d")


func _on_PreludeButton_pressed():
	SceneTransition.change_scene("res://Scenes/Prelude.tscn")
