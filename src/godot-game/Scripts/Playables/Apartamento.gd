extends Node2D

var taskFeita = false

func _ready():
	$Player/Camera2D.limit_left = 257-97
	$Player/Camera2D.limit_right = 519-97
	$Player/Camera2D.limit_bottom = 208+64
	$Player/Camera2D.limit_top = -32+64
	
	Global.canMove = false
	
	$Player/Camera2D.current = true
	$Player/Camera2D.zoom = Vector2(0.3, 0.3)
	
	_abordagem_anim()
	
func animate():
	$TaskRoteador/Tween.interpolate_property($TaskRoteador/TextureProgress, "value", 0, 100, 2.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$TaskRoteador/Tween.start()

func _on_TouchScreenButton_pressed():
	if taskFeita == false:
		if ($Player.global_position).distance_to($TaskRoteador/RoteadorAncora.global_position) < 30:
			Global.activeObjective[0] = false
			
			$TaskRoteador/TextureProgress.visible = true
			Global.activeObjective[0] = false
			Global.canMove = false
			
			animate()
			yield(get_tree().create_timer(2.5), "timeout")
			
			Global.canMove = true
			$TaskRoteador/TextureProgress.visible = false
			$TaskRoteador/BalaoObj.visible = false
			
			taskFeita = true
			
			Global.activeObjective[0] = true
			Global.activeObjective[1] = $SpriteBlogueira/Position2D.global_position
			Global.activeObjective[2] = "Fale com a Blogueira"
			
			$SpriteBlogueira/TouchScreenButton.visible = true
			
			$Player.objective(false)
			
			
func _abordagem_anim():
	yield(get_tree().create_timer(1), "timeout")
	
	$AnimationPlayer.play("Abordagem")
	
	yield($AnimationPlayer, "animation_finished")
	
	$"DialogBox 22".visible = true
	if $"DialogBox 22/TexturaCaixa".connect("finish", self, "_on_dialog1_finish") != OK:
		print("ERRO AO CONECTAR")
	$"DialogBox 22/TexturaCaixa"._startDialog()

func _on_dialog1_finish():
	$AnimationPlayer.play_backwards("Abordagem")
	
	yield($AnimationPlayer, "animation_finished")
	
	$TaskRoteador.visible = true
	$"DialogBox 22".visible = false
	
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $TaskRoteador/RoteadorAncora.global_position
	Global.activeObjective[2] = "Conserte o roteador"
	$Player.objective(false)
	
	Global.canMove = true

func _on_BlogueiraButton_pressed():
	if $Player.global_position.distance_to($SpriteBlogueira/Position2D.global_position) < 50:
		Global.activeObjective[0] = false
	
		$SpriteBlogueira/TouchScreenButton.visible = false
		Global.canMove = false
		$"DialogBox 23".visible = true
		if $"DialogBox 23/TexturaCaixa".connect("finish", self, "_on_dialog2_finish") != OK:
			print("ERRO AO CONECTAR")
		$"DialogBox 23/TexturaCaixa"._startDialog()
	
func _on_dialog2_finish():
	$QuizTask.visible = true
	if $QuizTask.connect("quizFinish", self, "_on_quiz_finish") != OK:
		print("ERRO AO CONECTAR")
	$QuizTask._startQuiz()
	
func _on_quiz_finish():
	$"DialogBox 24".visible = true
	$"DialogBox 24/TexturaCaixa"._startDialog()
	if $"DialogBox 24/TexturaCaixa".connect("finish", self, "_on_dialog3_finish") != OK:
		print("ERRO AO CONECTAR")
	
func _on_dialog3_finish():
	Global.canMove = true
	
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $PortaAncora.global_position
	Global.activeObjective[2] = "Volte para o campo"
	$Player.objective(false)
	
	$Area2D/CollisionShape2D.disabled = false
	
	


func _on_Area2D_body_entered(body):
	if body == $Player:
		SceneTransition.change_scene("res://Scenes/Playables/Environment/Tecnico.tscn", 1, 1)
		TecGlobals.currentTask = 3
