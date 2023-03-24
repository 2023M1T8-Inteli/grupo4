extends Control

onready var pai = get_parent()
onready var player = get_parent().get_node("Player")

func _process(_delta):
	if $"DialogBox 20".visible == true:
		player.get_node("Camera2D").current = false if $"DialogBox 20/TexturaCaixa/NomeNPC".bbcode_text != "Joao" else true
		$Camera2D.current = true if $"DialogBox 20/TexturaCaixa/NomeNPC".bbcode_text != "Joao" else false

func _on_Area2D_body_entered(body):
	if str(body).get_slice(":", 0) == "Player":
		Global.activeObjective[0] = false
		
		$NPCs/ColorRect/BalaoExclamacao.visible = false
		$NPCs/ColorRect2/BalaoExclamacao.visible = false
		$NPCs/ColorRect3/BalaoExclamacao.visible = false
		
		Global.canMove = false
		
		var playerCameraZoom = player.get_node("Camera2D").get_zoom()
		var playerCameraPos = player.get_node("Camera2D").get_global_position()
		
		player.get_node("Camera2D").current = false
		$Camera2D.current = true
		
		$AnimationPlayer.get_animation("cameraMove").track_set_key_value(0, 0, playerCameraZoom)
		$AnimationPlayer.get_animation("cameraMove").track_set_key_value(1, 0, playerCameraPos)
		
		$AnimationPlayer.play("cameraMove")
		
		yield($AnimationPlayer, "animation_finished")
		
		player.get_node("Camera2D").zoom = Vector2(0.6, 0.6)
		
		if $"DialogBox 20/TexturaCaixa".connect("finish", self, "on_dialog1_finish") != OK:
			print("ERRO AO CONECTAR")
		$"DialogBox 20".visible = true
		player.get_node("Camera2D").set_enable_follow_smoothing(false)
		$"DialogBox 20/TexturaCaixa"._startDialog()
		
func on_dialog1_finish():
	player.get_node("Camera2D").zoom = Vector2(1, 1)
	var playerCameraZoom = player.get_node("Camera2D").get_zoom()
	var playerCameraPos = player.get_node("Camera2D").get_global_position()
	
	$AnimationPlayer.get_animation("cameraMoveBack").track_set_key_value(0, 1, playerCameraZoom)
	$AnimationPlayer.get_animation("cameraMoveBack").track_set_key_value(1, 1, playerCameraPos)
	
	$AnimationPlayer.play("cameraMoveBack")
	
	yield($AnimationPlayer, "animation_finished")
	
	if $QuizTask.connect("quizFinish", self, "_on_quiz_finish") != OK:
		print("ERRO AO CONECTAR")
	$QuizTask.visible = true
	$QuizTask._startQuiz()
	$"DialogBox 20".visible = false
	player.get_node("Camera2D").set_enable_follow_smoothing(true)

func _on_quiz_finish():
	$AnimationPlayer.play_backwards("cameraMoveBack")
	
	yield($AnimationPlayer, "animation_finished")
	
	if $"DialogBox 21/TexturaCaixa".connect("finish", self, "on_dialog2_finish") != OK:
		print("ERRO AO CONECTAR")
	$"DialogBox 21".visible = true
	$"DialogBox 21/TexturaCaixa"._startDialog()

func on_dialog2_finish():
	$AnimationPlayer.play_backwards("cameraMove")
	yield($AnimationPlayer, "animation_finished")
	
	Global.canMove = true
	
	player.get_node("Camera2D").current = true
	$Camera2D.current = false
	
	TecGlobals.currentTask = 2
	get_parent().get_node("Task2TEC").visible = true
	
	$Area2D/CollisionShape2D.disabled = true
	
	Global.activeObjective[0] = true
	Global.activeObjective[1] = self.get_parent().get_node("Task2TEC/Position2D").global_position
	Global.activeObjective[2] = "Entre na van de transporte."
	self.get_parent().get_node("Player").objective(true)
