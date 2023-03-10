extends Node2D

func _ready():
	$zeHosp.visible = true
	$zeHosp.frame = 0
	$zeHosp.playing = true

func _on_zeHosp_animation_finished():
	SceneTransition.change_scene("res://Scenes/Limbo1.tscn", 1, 0.1)
