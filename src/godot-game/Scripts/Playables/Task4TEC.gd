extends Control

func _ready():
	if TecGlobals.currentTask == 4:
		$Area2D/CollisionShape2D.disabled = false
		Global.activeObjective[0] = true
		Global.activeObjective[1] = get_parent().get_node("Task4TEC/Position2D").global_position
		Global.activeObjective[2] = "O chefe quer falar com voce"
		get_parent().get_node("Player").objective(true)

func _on_Area2D_body_entered(body):
	if body == get_parent().get_node("Player"):
		Global.activeObjective[0] = false
		Global.canMove = false
		$"DialogBox 25".visible = true
		$"DialogBox 25/TexturaCaixa".connect("finish", self, "on_dialog_finish")
		$"DialogBox 25/TexturaCaixa"._startDialog()

func on_dialog_finish():
	SceneTransition.change_scene("res://Scenes/Playables/Environment/Limbo4.tscn", 1, 1)
