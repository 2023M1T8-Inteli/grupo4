extends Control

func _on_TouchScreenButton_pressed():
	if get_parent().get_node("Player").global_position.distance_to($Position2D.global_position) < 100:
		Global.canMove = false
		SceneTransition.change_scene("res://Scenes/Playables/Environment/Apartamento.tscn", 1, 1)
		pos.posTecnico = get_parent().get_node("Player").global_position

func _ready():
	get_parent().get_node("Player").global_position = pos.posTecnico
	if TecGlobals.currentTask == 2:
		$Caminhao.rotation = -180
		$BalaoObj.visible = true
		$Caminhao/TouchScreenButton.visible = true
	elif TecGlobals.currentTask == 3:
		self.visible = true
		$Caminhao.rotation = 0
		$BalaoObj.visible = false
		$Caminhao/TouchScreenButton.visible = false
		
		Global.activeObjective[0] = true
		Global.activeObjective[1] = self.get_parent().get_node("Task3TEC/Position2D").global_position
		Global.activeObjective[2] = "Se prepare para subir no poste!"
		get_parent().get_node("Player").objective(true)

func _process(_delta):
	$StaticBody2D/CollisionShape2D.disabled = not self.visible
