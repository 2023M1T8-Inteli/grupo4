extends Node2D

var closeToEscada
onready var lockIf1 = true
onready var lockIf0 = true
onready var lockIf2 = true
var closeToAmong = false
var amongComplete = false

func _ready():
	# Conecta o sinal de conclusão da tarefa ao método task_complete
	if $ColorRect/WiresTask.connect("task_complete", self, "task_complete") != OK:
		print ("An unexpected error occured when trying to connect to the signal")
	
	$Player/Ze.visible = true

func _process(_delta):
	if $Player/HitBox.global_position.distance_to($EscadaAncora.global_position) < 45:
		Global.closeToSomething = true
		closeToEscada = true
	elif $Player/HitBox.global_position.distance_to($ColorRect/AmongAncora.global_position) < 60 and amongComplete == false:
		Global.closeToSomething = true
		closeToAmong = true
	else:
		Global.closeToSomething = false
		closeToEscada = false
		closeToAmong = false
	
	
	if closeToAmong and Global.midPress and lockIf0:
		lockIf0 = false
		yield(get_tree().create_timer(0.15), "timeout")
		renderAmong(true)
	
	if closeToEscada and Global.midPress and lockIf1:
		lockIf1 = false
		yield(get_tree().create_timer(0.15), "timeout")
		if get_tree().change_scene("res://Scenes/Prelude.tscn") != OK:
			print("ERRO")

func renderAmong(value):
	# Esconde a interface do usuário e mostra a tarefa de fios
	$GUI.visible = not value
	$ColorRect/WiresTask.visible = value
	
	if value == true:
		$ExplodeTimer.wait_time = 1
		$ExplodeTimer.start()
	
func task_complete():
	# Inicia o temporizador após a conclusão da tarefa
	$ColorRect/Timer.start()
	
	# Aguarda o temporizador chegar ao fim antes de prosseguir
	yield($ColorRect/Timer, "timeout")
	
	# Mostra a interface do usuário novamente e esconde a tarefa de fios
	renderAmong(false)
	
	# Desativa o filtro de mouse do botão de textura e muda a cor do retângulo de cores
	$ColorRect/TextureButton.mouse_filter = Control.MOUSE_FILTER_IGNORE
	#$ColorRect.color = Color("34921d")
	
	#$ColorRect/WiresTask.queue_free()
	amongComplete = true
	
	

func _on_ExplodeTimer_timeout():
	if lockIf2 == true:
		lockIf2 = false
		renderAmong(false)
		$ExplodeSprite.frame = 0
		$ExplodeSprite.visible = true
		$ExplodeSprite.playing = true
		$SceneChangeTimer.start()

func _on_SceneChangeTimer_timeout():
	SceneTransition.change_scene("res://Scenes/Limbo1.tscn", 3, 0.1)
