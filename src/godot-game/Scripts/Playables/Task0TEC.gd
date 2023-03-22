extends Control

onready var pai = get_parent()
onready var player = get_parent().get_node("Player")

func reuniaoAnim():
	if $"DialogBox 9/TexturaCaixa".connect("finish", self, "on_dialog_finish") != OK:
		print("ERRO AO CONECTAR TEXTURACAIXA")
	
	Global.canMove = false
	
	player.get_node("Camera2D").current = false
	$Camera2D.current = true
	
	$"DialogBox 9".visible = true
	$"DialogBox 9/TexturaCaixa"._startDialog()
	
func on_dialog_finish():
	var playerCameraZoom = player.get_node("Camera2D").get_zoom()
	var playerCameraPos = player.get_node("Camera2D").get_global_position()
	
	$AnimationPlayer.get_animation("cameraMove").track_set_key_value(0, 1, playerCameraZoom)
	$AnimationPlayer.get_animation("cameraMove").track_set_key_value(1, 1, playerCameraPos)
	
	yield(get_tree().create_timer(.3), "timeout")
	
	$AnimationPlayer.play("cameraMove")
	
	yield($AnimationPlayer, "animation_finished")
	
	player.get_node("Camera2D").current = true
	$Camera2D.current = false
	
	Global.canMove = true
	
	TecGlobals.currentTask = 1
