extends Control

onready var pai = get_parent()
onready var player = get_parent().get_node("Player")

func _on_Area2D_body_entered(body):
	if str(body).get_slice(":", 0) == "Player":
		Global.canMove = false
		
		player.get_node("Camera2D").current = false
		$Camera2D.current = true
		
		var playerCameraZoom = player.get_node("Camera2D").get_zoom()
		var playerCameraPos = player.get_node("Camera2D").get_global_position()
		
		$AnimationPlayer.get_animation("cameraMove").track_set_key_value(0, 0, playerCameraZoom)
		$AnimationPlayer.get_animation("cameraMove").track_set_key_value(1, 0, playerCameraPos)
		
		$AnimationPlayer.play("cameraMove")
		
