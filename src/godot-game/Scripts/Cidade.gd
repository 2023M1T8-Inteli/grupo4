extends Node2D

var closeToPoste = false
var closeToAmong = false
var closeToADM = false

var amongComplete = false

onready var lockIf0 = true
onready var lockIf1 = true
onready var lockIf2 = true

#signal go_to_prelude

func _ready():
	
	$Player.global_position = pos.posCidade
	
	# Mostra o personagem principal e esconde o fantasma
	get_node("Player/Ze").visible = true
	get_node("Player/Fantasma").visible = false
	
	# Conecta o sinal de conclusão da tarefa ao método task_complete
	if $ColorRect/WiresTask.connect("task_complete", self, "task_complete") != OK:
		print ("An unexpected error occured when trying to connect to the signal")
	
	
	# Passa o controle para o próximo método
	pass

func _process(_delta):
	if $Player/HitBox.global_position.distance_to($PosteAncora.global_position) < 90:
		Global.closeToSomething = true
		closeToPoste = true
	elif $Player/HitBox.global_position.distance_to($ColorRect/AmongAncora.global_position) < 90 and amongComplete == false:
		Global.closeToSomething = true
		closeToAmong = true
	elif $Player/HitBox.global_position.distance_to($admAncora.global_position) < 90:
		Global.closeToSomething = true
		closeToADM = true
	else:
		Global.closeToSomething = false
		closeToPoste = false
		closeToAmong = false
		closeToADM = false
	
	
	if closeToAmong and Global.midPress and lockIf0:
		lockIf0 = false
		yield(get_tree().create_timer(0.15), "timeout")
		_on_TextureButton_pressed()
	if closeToPoste and Global.midPress and lockIf1:
		lockIf1 = false
		yield(get_tree().create_timer(0.15), "timeout")
		pos.posCidade = $Player.global_position
		if get_tree().change_scene("res://Scenes/PosteCima.tscn") != OK:
			print("ERRO")
	if closeToADM and Global.midPress and lockIf1:
		lockIf2 = false
		yield(get_tree().create_timer(0.15), "timeout")
		#pos.posADM = $Player.global_position #gustavo -> nao entendi mto bem como funciona o pos.[....] entao quando der arruma isso
		if get_tree().change_scene("res://Scenes/Administrativo.tscn") != OK:
			print("ERRO")	
	
	
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
	
	amongComplete = true

func _on_PreludeButton_pressed():
	SceneTransition.change_scene("res://Scenes/Prelude.tscn")
