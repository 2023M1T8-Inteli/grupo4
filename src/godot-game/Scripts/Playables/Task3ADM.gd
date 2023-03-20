extends Control

func _ready():
	$QuizTask.connect("quizFinish", self, "_on_quiz_finish")
	$"DialogBox 18/TexturaCaixa".connect("finish", self, "_finish_dialog")
	
func animate():
	$Tween.interpolate_property($TextureProgress, "value", 0, 100, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()


func _on_BotaoObj_pressed():
	if (self.get_parent().get_node("Player").global_position).distance_to($ComputadorAncora.global_position) < 150:
		Global.canMove = false
		animate()
		yield(get_tree().create_timer(1), "timeout")
		Global.canMove = true
		$TextureProgress.visible = false
		$BalaoObj.visible = false
		yield(get_tree().create_timer(0.2), "timeout")
		Global.activeObjective[1] = get_parent().get_node("PortaAncora").global_position
		Global.activeObjective[2] = "Saia do prédio."
		get_parent().get_node("Player").objective(true)
		AdmGlobals.currentTask = 3

func _on_Area2D_body_entered(body):
	if str(body).get_slice(":", 0) == "Player" and AdmGlobals.currentTask == 3:
		Global.canMove = false
		
		yield(get_tree().create_timer(0.2), "timeout")
		
		Global.activeObjective[0] = false
		
		get_parent().get_node("AnimationHandler").get_animation("AbordagemAnim").track_set_key_value(0, 0, Vector2(470, 160))
		get_parent().get_node("AnimationHandler").get_animation("AbordagemAnim").track_set_key_value(0, 1, Vector2(get_parent().get_node("Player").position.x-106, 160))
		get_parent().get_node("AnimationHandler").play("AbordagemAnim")
		yield(get_parent().get_node("AnimationHandler"), "animation_finished")
		
		$"DialogBox 18".visible = true
		$"DialogBox 18/TexturaCaixa"._startDialog()

func _finish_dialog():
	$QuizTask.visible = true
	$QuizTask._startQuiz()
	
func _on_quiz_finish():
	get_parent().get_node("AnimationHandler").get_animation("AbordagemAnim").track_set_key_value(0, 0, Vector2(get_parent().get_node("Player").position.x-106, 160))
	get_parent().get_node("AnimationHandler").get_animation("AbordagemAnim").track_set_key_value(0, 1, Vector2(470, 160))
	get_parent().get_node("AnimationHandler").play("AbordagemAnim")
	yield(get_parent().get_node("AnimationHandler"), "animation_finished")
	
	Global.canMove = true
	
	Global.activeObjective[0] = true
	get_parent().get_node("Player").objective(false)
	
	self.visible = false
