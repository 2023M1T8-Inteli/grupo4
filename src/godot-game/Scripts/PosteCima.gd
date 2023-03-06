extends Node2D

var closeToEscada
var lockIf

func _ready():
	$Player/Ze.visible = true
	lockIf = true

func _process(_delta):
	if $Player/HitBox.global_position.distance_to($EscadaAncora.global_position) < 45:
		Global.closeToSomething = true
		closeToEscada = true
	else:
		Global.closeToSomething = false
		closeToEscada = false
	
	if closeToEscada and Global.midPress and lockIf:
		lockIf = false
		yield(get_tree().create_timer(0.15), "timeout")
		if get_tree().change_scene("res://Scenes/Cidade.tscn") != OK:
			print("ERRO")
