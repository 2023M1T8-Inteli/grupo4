extends Node2D

signal is_drunk

func _ready():
	emit_signal("is_drunk")
	print(12232)
	$Player/Ze.visible = true
	$Player/Fantasma.visible = false
