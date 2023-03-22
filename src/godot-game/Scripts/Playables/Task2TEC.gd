extends Control

func _on_TouchScreenButton_pressed():
	Global.canMove = false
	SceneTransition.change_scene("res://Scenes/Playables/Environment/Apartamento.tscn", 1, 1)
	pos.posTecnico = get_parent().get_node("Player").global_position

func _ready():
	get_parent().get_node("Player").global_position = pos.posTecnico
	if TecGlobals.currentTask == 2:
		$Caminhao.rotation = -180
		$BalaoObj.visible = true
	elif TecGlobals.currentTask == 3:
		$Caminhao.rotation = 0
		$BalaoObj.visible = false
