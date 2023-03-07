extends Node2D

var closeToPoste = false

var lockIf0 = true
var lockIf1 = true

func _ready():
	Global.isDrunk = true
	$Player.global_position = pos.posPrelude
	$Player/Ze.visible = true
	$Player/Fantasma.visible = false

func _process(_delta):
	if $Player/HitBox.global_position.distance_to($PosteCaixa/Node2D.global_position) < 90:
		Global.closeToSomething = true
		closeToPoste = true
	else:
		Global.closeToSomething = false
		closeToPoste = false
		
		
		
	if closeToPoste and Global.midPress and lockIf1:
		lockIf1 = false
		yield(get_tree().create_timer(0.15), "timeout")
		pos.posPrelude = $Player.global_position
		if get_tree().change_scene("res://Scenes/PosteCima.tscn") != OK:
			print("ERRO")
			
