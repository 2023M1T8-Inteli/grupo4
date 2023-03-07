extends Node2D

var closeToPoste = false
var closeToADM = false


onready var lockIf0 = true
onready var lockIf1 = true
onready var lockIf2 = true

#signal go_to_prelude

func _ready():
	$Player.global_position = pos.posCidade
	
	# Mostra o personagem principal e esconde o fantasma
	get_node("Player/Ze").visible = true
	get_node("Player/Fantasma").visible = false
	
	
	
	# Passa o controle para o próximo método
	pass

func _process(_delta):
	if $Player/HitBox.global_position.distance_to($PosteAncora.global_position) < 90:
		Global.closeToSomething = true
		closeToPoste = true
	elif $Player/HitBox.global_position.distance_to($admAncora.global_position) < 90:
		Global.closeToSomething = true
		closeToADM = true
	else:
		Global.closeToSomething = false
		closeToPoste = false
		closeToADM = false
	
	
	if closeToPoste and Global.midPress and lockIf0:
		lockIf0 = false
		yield(get_tree().create_timer(0.15), "timeout")
		pos.posCidade = $Player.global_position
		if get_tree().change_scene("res://Scenes/PosteCima.tscn") != OK:
			print("ERRO")
	if closeToADM and Global.midPress and lockIf1:
		lockIf1 = false
		yield(get_tree().create_timer(0.15), "timeout")
		pos.posCidade = $Player.global_position
		if get_tree().change_scene("res://Scenes/Administrativo.tscn") != OK:
			print("ERRO")
