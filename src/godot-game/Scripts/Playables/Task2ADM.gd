extends Control

func _on_Area2D_body_entered(body):
	if body == get_parent().get_node("Player") and $Area2D/CollisionShape2D.visible == true and AdmGlobals.currentTask == 2:
		$Area2D/CollisionShape2D.visible = false
		Global.currentApp = "linkedIn"
		Global.activeObjective[0] = true
		Global.activeObjective[1] = $ComputadorAncora.global_position
		Global.activeObjective[2] = "No seu celular, acesse o app do LinkedIn"
		$BalaoObj.visible = false
		get_parent().get_node("Player").objective(false)
		get_parent().get_node("GUI").shake_phone_icon(true)
		if get_parent().get_node("GUI").connect("finishedCompliance1", self, "finished_cellphone_task") != OK:
			print("ERRO AO CONECTAR")
		
func finished_cellphone_task():
	AdmGlobals.currentTask = 3
	self.visible = false
	Global.activeObjective[0] = true
	Global.activeObjective[1] = get_parent().get_node("Task1ADM/ComputadorAncora").global_position
	Global.activeObjective[2] = "Arrume suas coisas e vá para casa."
	get_parent().get_node("Player").objective(false)
	get_parent().get_node("Task3ADM").visible = true
