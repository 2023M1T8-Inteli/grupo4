extends Node2D

var closeToPoste = false

var lockIf0 = true
var lockIf1 = true

func _ready():
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $PosteCaixa/Node2D.global_position
	$Player.global_position = pos.posPrelude
	$Player/Ze.visible = true
	$Player/Fantasma.visible = false
	
	$Prompt.visible = true
	$DrunkFilter.visible = false
	
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
			


func _on_TextureButton_pressed():
	Global.isDrunk = true
	$Prompt/CanvasLayer.visible = false
	$Prompt.visible = false
	$DrunkFilter.visible = true
