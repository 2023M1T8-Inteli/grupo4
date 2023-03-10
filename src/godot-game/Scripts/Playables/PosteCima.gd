extends Node2D

onready var lockIf1 = true
onready var lockIf0 = true
onready var lockIf2 = true

#var closeToEscada = false
#var closeToAmong = false
var amongComplete = false

func _ready():
	Global.isDrunk = true
	Global.activeObjective[0] = false
	# Global.activeObjective[1] = nada
	# Conecta o sinal de conclusão da tarefa ao método task_complete
	if Global.amongDone:
		task_complete()
	
	Global.canMove = true
	
	$Player/Ze.visible = true

func _process(_delta):
	
#	if $Player/HitBox.global_position.distance_to($EscadaAncora.global_position) < 150:
#		closeToEscada = true
#	elif $Player/HitBox.global_position.distance_to($AmongAncora.global_position) < 150:
#		closeToAmong = true
#		print("close to among")
#	else:
#		closeToEscada = false
#		closeToAmong = false
		
	pass

func renderAmong(value):
	# Esconde a interface do usuário e mostra a tarefa de fios
	$GUI.visible = not value
	$ColorRect/WiresTask.visible = value
	$DrunkFilter.visible = not value
	
	if value == true:
		$ExplodeTimer.wait_time = 5
		$ExplodeTimer.start()
	
func task_complete():
	# Inicia o temporizador após a conclusão da tarefa
	$ColorRect/Timer.start()
	
	# Aguarda o temporizador chegar ao fim antes de prosseguir
	yield($ColorRect/Timer, "timeout")
	
	# Mostra a interface do usuário novamente e esconde a tarefa de fios
	renderAmong(false)
	
	
	#$ColorRect/WiresTask.queue_free()
	amongComplete = true

func _on_ExplodeTimer_timeout():
	if lockIf2 == true:
		lockIf2 = false
		renderAmong(false)
		BangSound.playing = true
		$ExplodeSprite.frame = 0
		$ExplodeSprite.visible = true
		$ExplodeSprite.playing = true
		$SceneChangeTimer.start()

func _on_SceneChangeTimer_timeout():
	SceneTransition.change_scene("res://Scenes/Non Playables/Animations/ZeHospital.tscn", 3, 1)

func _on_amongButton_pressed():
	print("amongPressed")
#	if closeToAmong:
	print("entrou")
	Global.canMove = false
	yield(get_tree().create_timer(0.15), "timeout")
	renderAmong(true)
	Global.canMove = false

func _on_escadaButton_pressed():
	print("pressed")
#	if closeToEscada:
	Global.canMove = false
	yield(get_tree().create_timer(0.15), "timeout")
	if get_tree().change_scene("res://Scenes/Playables/Environment/Prelude.tscn") != OK:
		print("ERRO")
