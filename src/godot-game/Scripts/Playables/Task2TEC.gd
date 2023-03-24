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
		self.visible = true
		$Caminhao.rotation = 0
		$BalaoObj.visible = false
		
		Global.activeObjective[0] = true
		Global.activeObjective[1] = self.get_parent().get_node("Task3TEC/Position2D").global_position
		Global.activeObjective[2] = "Se prepare para subir no poste!"
		get_parent().get_node("Player").objective(true)
