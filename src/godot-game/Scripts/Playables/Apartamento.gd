extends Node2D

func _ready():
	Global.canMove = true
	
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $TaskRoteador/RoteadorAncora.global_position
	Global.activeObjective[2] = "Consertar o roteador"

func animate():
	$TaskRoteador/Tween.interpolate_property($TaskRoteador/TextureProgress, "value", 0, 100, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$TaskRoteador/Tween.start()

func _on_TouchScreenButton_pressed():
	$TaskRoteador/TextureProgress.visible = true
	if ($Player.global_position).distance_to($TaskRoteador/RoteadorAncora.global_position) < 90:
		Global.activeObjective[0] = false
		Global.canMove = false
		
		animate()
		yield(get_tree().create_timer(1), "timeout")
		
		Global.canMove = true
		$TaskRoteador/TextureProgress.visible = false
		$TaskRoteador/BalaoObj.visible = false
		
		
		
	
