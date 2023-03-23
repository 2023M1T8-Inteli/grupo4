extends Node2D

var amongComplete = false # Variável para verificar se a tarefa de fois foi completada

onready var lockIf0 = true # Variável de controle para o método _on_ExplodeTimer_timeout()

func _ready():
	$GUI/Audio.set_volume(Global.volPercentage)
	Global.playbackPos = 0
	Global.activeObjective[0] = false # Define a primeira tarefa como inativa
	
	# Habilita o movimento do jogador
	Global.canMove = true
	
	if $ColorRect/WiresTask.connect("finished", self, "on_among_finished") != OK:
		print("ERRO AO CONECTAR")

func renderAmong(value):
	$AmongAncora/amongButton.visible = not value
	$EscadaAncora/escadaButton.visible = not value
	
	# Esconde a interface do usuário e mostra a tarefa de fios e desativa o filtro de cor
	$GUI.visible = not value
	$ColorRect/WiresTask.visible = value

func on_among_finished():
		# Inicia o timer de sair da tarefa após a conclusão da tarefa
	$ColorRect/Timer.start()
	
	$BalaoExclamacao.visible = false
	
	# Aguarda o timer chegar ao fim antes de prosseguir
	yield($ColorRect/Timer, "timeout")
	
	# Mostra a interface do usuário novamente e esconde a tarefa de fios
	renderAmong(false)
	
	# Define a task como completa
	amongComplete = true
	
	$AmongAncora/amongButton.visible = false
	
	yield(get_tree().create_timer(1), "timeout")
	
	_on_escadaButton_pressed()
	
func _on_amongButton_pressed():
	Global.canMove = false  # Impede o jogador de se mover
	yield(get_tree().create_timer(0.15), "timeout")  # Espera por 0.15 segundos
	renderAmong(true)  # Mostra a tarefa "among us"
	Global.canMove = false  # Impede o jogador de se mover novamente

func _on_escadaButton_pressed():
	Global.canMove = false  # Impede o jogador de se mover
	yield(get_tree().create_timer(0.15), "timeout")  # Espera por 0.15 segundos
	# Muda para a cena "Prelude" e imprime uma mensagem de erro se houver algum problema
	if get_tree().change_scene("res://Scenes/Playables/Environment/Tecnico.tscn") != OK:
		print("ERRO")
	TecGlobals.currentTask = 4
