extends Node2D

func _ready():
	$zeAcordando.playing = true
	$zeAcordando.frame = 0
	$zeAcordando.visible = true



func _on_TextureButton_pressed():
	SceneTransition.change_scene("res://Scenes/Playables/Environment/Prelude.tscn",0.5 ,0.5)


func _on_zeAcordando_animation_finished():
	$zeAcordando.visible = false
	$zeQuarto.visible = true
	$zeQuarto.playing = true
	$zeQuarto.frame = 0


func _on_zeQuarto_animation_finished():
	$zeQuarto.visible = false
	$zeCozinha.visible = true
	$zeCozinha.playing = true
	$zeCozinha.frame = 0


func _on_zeCozinha_animation_finished():
	$zeCozinha.visible = false
	$zeTransito.visible = true
	$zeTransito.playing = true
	$zeTransito.frame = 0


func _on_zeTransito_animation_finished():
	SceneTransition.change_scene("res://Scenes/Playables/Environment/Prelude.tscn",0.5 ,0.5)
