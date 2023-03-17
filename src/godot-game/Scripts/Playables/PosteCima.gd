extends Node2D

var amongComplete = false # Variável para verificar se a tarefa de fois foi completada

onready var lockIf0 = true # Variável de controle para o método _on_ExplodeTimer_timeout()

func _ready():
	$GUI/Audio.set_volume(Global.volPercentage)
	Global.isDrunk = true # Define o personagem como bêbado
	Global.activeObjective[0] = false # Define a primeira tarefa como inativa

	# Se a tarefa do jogo Among Us já foi concluída, chama o método task_complete()
	if Global.amongDone:
		task_complete()
	
	# Habilita o movimento do jogador
	Global.canMove = true

func renderAmong(value):
	$AmongAncora/amongButton.visible = not value
	$EscadaAncora/escadaButton.visible = not value
	
	# Esconde a interface do usuário e mostra a tarefa de fios e desativa o filtro de cor
	$GUI.visible = not value
	$ColorRect/WiresTask.visible = value
	$DrunkFilter.visible = not value
	
	
	if value == true:
		$ExplodeTimer.wait_time = 3
		$ExplodeTimer.start() # Inicia o timer para a explosão do jogador
	
func task_complete():
	# Inicia o timer de sair da tarefa após a conclusão da tarefa
	$ColorRect/Timer.start()
	
	# Aguarda o timer chegar ao fim antes de prosseguir
	yield($ColorRect/Timer, "timeout")
	
	# Mostra a interface do usuário novamente e esconde a tarefa de fios
	renderAmong(false)
	
	# Define a task como completa
	amongComplete = true

func _on_ExplodeTimer_timeout():
	if lockIf0 == true: 
		lockIf0 = false  # Desativa a variável de controle
		renderAmong(false)  # Esconde a tarefa de fios
		$GUI/Audio.play_ambient("res://Audio Files/explosion.mp3") # Toca o som de explosão
		$ExplodeSprite.frame = 0  # Define o primeiro frame da animação de explosão
		$ExplodeSprite.visible = true  # Torna o sprite de explosão visível
		$ExplodeSprite.playing = true  # Inicia a animação de explosão
		$SceneChangeTimer.start()  # Inicia o timer para mudar de cena

func _on_SceneChangeTimer_timeout():
	# Muda para a cena do hospital utilizando a transição.
	SceneTransition.change_scene("res://Scenes/Non Playables/Animations/ZeHospital.tscn", 3, 1)

func _on_amongButton_pressed():
	Global.canMove = false  # Impede o jogador de se mover
	yield(get_tree().create_timer(0.15), "timeout")  # Espera por 0.15 segundos
	renderAmong(true)  # Mostra a tarefa "among us"
	Global.canMove = false  # Impede o jogador de se mover novamente

func _on_escadaButton_pressed():
	Global.canMove = false  # Impede o jogador de se mover
	yield(get_tree().create_timer(0.15), "timeout")  # Espera por 0.15 segundos
	# Muda para a cena "Prelude" e imprime uma mensagem de erro se houver algum problema
	if get_tree().change_scene("res://Scenes/Playables/Environment/Prelude.tscn") != OK:
		print("ERRO")
