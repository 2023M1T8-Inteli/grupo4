extends Node2D

var closeToADM = true

onready var lockIf1 = true

func _ready():
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $admAncora.global_position
	$Player.global_position = pos.posCidade
	
	# Mostra o personagem principal e esconde o fantasma
	get_node("Player/Ze").visible = true
	get_node("Player/Fantasma").visible = false
	
	# Passa o controle para o próximo método
	pass

func _process(_delta):
	if $Player/HitBox.global_position.distance_to($admAncora.global_position) < 90:
		Global.closeToSomething = true
		closeToADM = true
	else:
		Global.closeToSomething = false
		closeToADM = false

func _on_admButton_pressed():
	if closeToADM and lockIf1:
		lockIf1 = false
		yield(get_tree().create_timer(0.15), "timeout")
		pos.posCidade = $Player.global_position
		if get_tree().change_scene("res://Scenes/Administrativo.tscn") != OK:
				print("ERRO")

