extends Node2D

var taskFeita = false

func _ready():
	Global.canMove = false
	
	$Player/Camera2D.zoom = Vector2(0.4, 0.4)
	
	_abordagem_anim()
	
func animate():
	$TaskRoteador/Tween.interpolate_property($TaskRoteador/TextureProgress, "value", 0, 100, 2.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$TaskRoteador/Tween.start()

func _on_TouchScreenButton_pressed():
	if taskFeita == false:
		if ($Player.global_position).distance_to($TaskRoteador/RoteadorAncora.global_position) < 30:
			$TaskRoteador/TextureProgress.visible = true
			Global.activeObjective[0] = false
			Global.canMove = false
			
			animate()
			yield(get_tree().create_timer(2.5), "timeout")
			
			Global.canMove = true
			$TaskRoteador/TextureProgress.visible = false
			$TaskRoteador/BalaoObj.visible = false
			
			taskFeita = true
			
			Global.activeObjective[1] = $SpriteBlogueira/Position2D.global_position
			Global.activeObjective[2] = "Fale com a Blogueira"
			
			$SpriteBlogueira/TouchScreenButton.visible = true
			
			$Player.objective(false)
			
			
func _abordagem_anim():
	yield(get_tree().create_timer(1), "timeout")
	
	$AnimationPlayer.play("Abordagem")
	
	yield($AnimationPlayer, "animation_finished")
	
	$"DialogBox 22/TexturaCaixa".connect("finish", self, "_on_dialog1_finish")
	$"DialogBox 22".visible = true
	$"DialogBox 22/TexturaCaixa"._startDialog()

func _on_dialog1_finish():
	$TaskRoteador.visible = true
	$"DialogBox 22".visible = false
	
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $TaskRoteador/RoteadorAncora.global_position
	Global.activeObjective[2] = "Consertar o roteador"
	$Player.objective(true)


func _on_BlogueiraButton_pressed():
	$"DialogBox 23".visible = true
	$"DialogBox 23/TexturaCaixa".connect("finish", self, "_on_dialog2_finish")
	
func _on_dialog2_finish():
	$QuizTask.visible = true
	$QuizTask.connect("quizFinish", self, "_on_quiz_finish")
	$QuizTask._startQuiz()
	
func _on_quiz_finish():
	$"DialogBox 24".visible = true
	$"DialogBox 24/TexturaCaixa".connect("finish", self, "_on_dialog3_finish")
