extends Node2D

func _ready():
	$zeHosp.visible = true
	$zeHosp.frame = 0
	$zeHosp.playing = true
	
	yield(get_tree().create_timer(3.3), "timeout")
	BangSound.playing = false
func _on_zeHosp_animation_finished():
	SceneTransition.change_scene("res://Scenes/Playables/Environment/Limbo1.tscn", 1, 0.1)
