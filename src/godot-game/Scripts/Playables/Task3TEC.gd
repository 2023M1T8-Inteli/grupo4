extends Control

func _ready():
	if TecGlobals.currentTask == 4:
		Global.activeObjective[0] = false
		
		$BalaoPoste.visible = false
		$posteSobeButton.visible = false
	if $Checklist.connect("finish", self, "on_checklist_finish") != OK:
		print("ERRO AO CONECTAR FINISH CHECKLIST")

func _on_posteSobeButton_pressed():
	$BalaoPoste.visible = false
	$Checklist.visible = true
	Global.canMove = false
	

func on_checklist_finish():
	yield(get_tree().create_timer(0.2), "timeout")
	get_tree().change_scene("res://Scenes/Playables/Environment/PosteCima2.tscn")
	pos.posTecnico = get_parent().get_node("Player").global_position
