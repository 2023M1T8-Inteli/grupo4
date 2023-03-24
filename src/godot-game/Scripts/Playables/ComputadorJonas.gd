extends Control

func _ready():
	if $QuizTask.connect("quizFinish", self, "_on_quiz_finish") != OK:
		print("ERRO AO CONECTAR")
	
func _on_BotaoComputador_pressed():
	if (self.get_parent().get_node("Player").global_position).distance_to($ComputadorAncora.global_position) < 150:
		Global.activeObjective[0] = false
		Global.canMove = false
		yield(get_tree().create_timer(0.05), "timeout")
		
		$BotaoComputador.visible = false
		get_parent().get_node("GUI").visible = false
		
		
		Global.activeObjective[1] = self.get_parent().get_node("PortaAncora").global_position
		Global.activeObjective[2] = "Vá para o setor Executivo."
		AdmGlobals.canGo = true
		
		$TelaComputador.visible = true
		yield(get_tree().create_timer(1), "timeout")
		$TelaComputador/AtaqueHacker.visible = true
		
		yield(get_tree().create_timer(5), "timeout")
		
		$QuizTask.visible = true
		$QuizTask._startQuiz()

		$BalaoObj.visible = false
		# SceneTransition.change_scene("res://Scenes/Non Playables/misc/Reincarn.tscn", 1, 1)

func _on_quiz_finish():
	Global.activeObjective[0] = true
	yield(get_tree().create_timer(0.5), "timeout")
	
	Global.canMove = true
	
	$TelaComputador.visible = false
	$TelaComputador/AtaqueHacker.visible = false
	
	AdmGlobals.currentTask = 1
	
	self.get_parent().get_node("Player").objective(true)
	
	get_parent().get_node("GUI").visible = true
