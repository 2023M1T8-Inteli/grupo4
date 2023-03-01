extends Node2D

signal is_drunk

func _ready():
	emit_signal("is_drunk")
	$Player/Ze.visible = true
	$Player/Fantasma.visible = false
