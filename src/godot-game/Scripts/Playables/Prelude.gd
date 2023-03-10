extends Node2D

var closeToPoste = false

var lockIf0 = true
var lockIf1 = true

func _ready():
	Global.canMove = false
	
	get_node("Player/Ze").visible = true
	get_node("Player/Fantasma").visible = false
	get_node("Player/Tereza").visible = false
	get_node("Player/Jonas").visible = false
	
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $PosteCaixa/Node2D.global_position
	$Player.global_position = pos.posPrelude


	$Prompt.visible = true
	$DrunkFilter.visible = false
	
func _process(_delta):
	if $Player/HitBox.global_position.distance_to($PosteCaixa/Node2D.global_position) < 150:
		Global.closeToSomething = true
		closeToPoste = true
	else:
		Global.closeToSomething = false
		closeToPoste = false

func _on_posteSobeButton_pressed():
	print("pressed")
	
	if closeToPoste and lockIf1:
		Global.canMove = false
		lockIf1 = false
		yield(get_tree().create_timer(0.15), "timeout")
		pos.posPrelude = $Player.global_position
		if get_tree().change_scene("res://Scenes/Playables/Environment/PosteCima.tscn") != OK:
			print("ERRO")


func _on_TextureButton_pressed():
	Global.canMove = true
	Global.isDrunk = true
	$Prompt/CanvasLayer.visible = false
	$Prompt.visible = false
	$DrunkFilter.visible = true
