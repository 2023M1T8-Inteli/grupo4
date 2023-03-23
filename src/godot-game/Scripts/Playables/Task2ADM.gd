extends Control

func _ready():
	$QuizTask.connect("quizFinish", self, "_on_quiz_finish")


func _on_BotaoComputador_pressed():
	if (self.get_parent().get_node("Player").global_position).distance_to($ComputadorAncora.global_position) < 150:
		$BalaoObj.visible = false
		Global.activeObjective[0] = false
		Global.canMove = false
		yield(get_tree().create_timer(0.05), "timeout")
		
		$BotaoComputador.visible = false
		
		Global.activeObjective[1] = self.get_parent().get_node("PortaAncora").global_position
		Global.activeObjective[2] = "Vá para o segundo andar."
		
		get_parent().get_node("GUI").visible = false
		
		$TelaComputador.visible = true
		yield(get_tree().create_timer(2), "timeout")
		$TelaComputador/LinkedIn.visible = true
		yield(get_tree().create_timer(2), "timeout")
		$TelaComputador/Comentarios.visible = true
		
		yield(get_tree().create_timer(5), "timeout")
		
		$QuizTask.visible = true
		$QuizTask._startQuiz()

func _on_quiz_finish():
	Global.activeObjective[0] = true
	yield(get_tree().create_timer(0.5), "timeout")
	
	Global.canMove = true
	
	$TelaComputador.visible = false
	
	get_parent().get_node("GUI").visible = true
	
	AdmGlobals.currentTask = 2
	self.get_parent().get_node("map/Elevador/TextureButton").visible = true
	
	self.get_parent().get_node("Player").objective(true)
	
	
