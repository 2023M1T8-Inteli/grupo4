extends CanvasLayer

# Variável para armazenar se a interface do usuário estava visível antes da pausa
onready var guiWasVisible

var couldMove

var localCurrentApp = "null"

signal finishedCompliance1

signal finishedCompliance2

var phoneOpen = false

func _ready():
	#Global.celularVisible = true
	#Global.currentApp = "linkedIn"
	# Define a posicao do HSlider na tela de pause como o volume definido globalmente
	$PauseScreen/HSlider.value = Global.volPercentage
	
	
func _process(_delta):
	$Celular/CelularBase/IconeInsta.rect_pivot_offset = Vector2(27.5*$Celular/CelularBase/IconeInsta.rect_scale.x, 25*$Celular/CelularBase/IconeInsta.rect_scale.y)
	$Celular/CelularBase/IconeLinkedin.rect_pivot_offset = Vector2(27.5*$Celular/CelularBase/IconeLinkedin.rect_scale.x, 25*$Celular/CelularBase/IconeLinkedin.rect_scale.y)
	$Celular/CelularBase/IconeTempo.rect_pivot_offset = Vector2(27.5*$Celular/CelularBase/IconeTempo.rect_scale.x, 25*$Celular/CelularBase/IconeTempo.rect_scale.y)
	$Celular/CelularBase/IconeEmail.rect_pivot_offset = Vector2(27.5*$Celular/CelularBase/IconeEmail.rect_scale.x, 25*$Celular/CelularBase/IconeEmail.rect_scale.y)
	
	
	if $Celular.visible != Global.celularVisible:
		$Celular.visible = Global.celularVisible
		
	if Global.currentApp != "null" or localCurrentApp != "null":
		$InteractablePlayer.play(Global.currentApp)
		localCurrentApp = "null"
	elif Global.currentApp != localCurrentApp:
		$InteractablePlayer.stop()
		localCurrentApp = Global.currentApp
		
	if phoneOpen == true:
		Global.canMove = false
func _on_HSlider_value_changed(value):
	# Set volume global com o valor do slider
	Global.volPercentage = value
	$Audio.set_volume(value)
	
func _on_PauseButton_pressed():
	# Desabilita o movimento do jogador
	if Global.canMove == false:
		Global.canMove = false
		couldMove = false
	elif Global.canMove == true:
		Global.canMove = false
		couldMove = true
	
	# Esconde a interface do usuário
	$GUI.visible = false
	
	# Mostra a tela de pausa
	$PauseScreen.visible = true
	
	

func _on_StartButton_pressed():
	# Habilita o movimento do jogador
	Global.canMove = couldMove

	# Mostra novamente a interface do usuário
	$GUI.visible = true
		
	# Esconde a tela de pausa
	$PauseScreen.visible = false


func _on_QuitButton_pressed():
	# Executa a função de salvar a posição e cena atual do jogador e sair para tela de início (essa função é executada no script Player.gd)
	pos.savePosCommand = true
	SceneTransition.change_scene("res://Scenes/Non Playables/misc/Title Screen.tscn", 1.5 , 1.5)


func _on_EthicButton_pressed():
	# redireciona para site da vtal no browser
	if OS.shell_open("https://www.vtal.com/wp-content/uploads/2022/10/man-00002-codigo-de-etica-e-conduta-da-vtal.pdf") != OK:
		print("ERRO AO ABRIR LINK")
	

func shake_phone_icon(value):
	if value == true:
		$PhoneIconShaker.play("shake_phone")
	else:
		$PhoneIconShaker.stop()

func _phone(value):
	if value == true:
		phoneOpen = true
		$GUI/Pause.visible = false
		$Celular/MouseFilter.visible = value
		$Celular/OpenButton.visible = not value
		Global.canMove = not value
		
		$Celular/BlackScreen.visible = value
		$AnimationPlayer.play("slideUp")
		yield(get_tree().create_timer(1.2), "timeout")
		$Celular/LoadingScreen.visible = value
		yield(get_tree().create_timer(1), "timeout")
		$Celular/LoadingScreen.visible = not value
		yield(get_tree().create_timer(.2), "timeout")
		$Tween.interpolate_property($Celular/BlackScreen, "modulate", Color(1, 1, 1, 1) , Color(1, 1, 1, 0), .3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		yield($Tween, "tween_completed")
		$Celular/CloseArrow.visible = value
		$AnimationPlayer.play("popup")
		yield($AnimationPlayer, "animation_finished")
		$AnimationPlayer.play("hover")
	else:
		phoneOpen = false
		$GUI/Pause.visible = true
		$AnimationPlayer.stop()
		$AnimationPlayer.play_backwards("popup")
		$Tween.interpolate_property($Celular/BlackScreen, "modulate", Color(1, 1, 1, 0) , Color(1, 1, 1, 1), .3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		yield($AnimationPlayer, "animation_finished")
		$Celular/CloseArrow.visible = value
		$AnimationPlayer.play_backwards("slideUp")
		yield($AnimationPlayer, "animation_finished")
		
		Global.canMove = not value
		$Celular/OpenButton.visible = not value
		
		$Celular/MouseFilter.visible = value
		
		
func _on_OpenButton_pressed():
	shake_phone_icon(false)
	_phone(true)

func _on_CloseButton_pressed():
	_phone(false)


func _on_IconeInsta_pressed():
	# Global.currentApp = "insta"
	if Global.currentApp != "insta":
		$InteractablePlayer.play("insta_error")


func _on_IconeLinkedin_pressed():
	# Global.currentApp = "linkedin"
	if Global.currentApp != "linkedIn":
		$InteractablePlayer.play("linkedin_error")
	else:
		Global.activeObjective[0] = false
		$AnimationPlayer.stop()
		$AnimationPlayer.play_backwards("popup")
		yield($AnimationPlayer, "animation_finished")
		$Celular/CloseArrow.visible = false
		Global.currentApp = "null"
		$"Celular/LinkedIn Control/WhiteScreen".visible = true
		$"Celular/LinkedIn Control/WhiteScreen".modulate = Color(1, 1, 1, 0)
		$Tween.interpolate_property($"Celular/LinkedIn Control/WhiteScreen", "modulate", Color(1, 1, 1, 0) , Color(1, 1, 1, 1), .3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		yield($Tween, "tween_completed")
		yield(get_tree().create_timer(.3), "timeout")
		$"Celular/LinkedIn Control/LinkedIn TitleScreen".visible = true
		$Tween.interpolate_property($"Celular/LinkedIn Control/LinkedIn TitleScreen", "modulate", Color(1, 1, 1, 0) , Color(1, 1, 1, 1), .3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		yield($Tween, "tween_completed")
		yield(get_tree().create_timer(2), "timeout")
		$LinkedInTask.visible = true
		$LinkedInTask/LinkedIn.visible = true
		$"Celular/LinkedIn Control/WhiteScreen".visible = false
		$"Celular/LinkedIn Control/LinkedIn TitleScreen".visible = false
		yield(get_tree().create_timer(4), "timeout")
		$LinkedInTask/Comentarios.visible = true
		yield(get_tree().create_timer(5), "timeout")
		$LinkedInTask/QuizTask.visible = true
		if $LinkedInTask/QuizTask.connect("quizFinish", self, "_on_linkedin_quiz_finished") != OK:
			print("ERRO AO CONECTAR")
		$LinkedInTask/QuizTask._startQuiz()
		Global.activeObjective[0] = true
		Global.activeObjective[2] = "No seu celular, acesse o app do Email"
		get_parent().get_node("Player").objective(true)
		yield(get_tree().create_timer(0.5), "timeout")
		Global.canMove = false
	
func _on_linkedin_quiz_finished():
	yield(get_tree().create_timer(2), "timeout")
	Global.currentApp = "email"
	$LinkedInTask.visible = false
	$"Celular/LinkedIn Control".visible = false
	$InteractablePlayer.play("email")
	$Celular/CloseArrow.visible = true
	$AnimationPlayer.stop()
	$AnimationPlayer.play("popup")
	yield($AnimationPlayer, "animation_finished")

func _on_IconeEmail_pressed():
	# Global.currentApp = "email"
	if Global.currentApp != "email":
		$InteractablePlayer.play("email_error")
	else:
		
		$AnimationPlayer.stop()
		$AnimationPlayer.play_backwards("popup")
		yield($AnimationPlayer, "animation_finished")
		$Celular/CloseArrow.visible = false
		$Celular/CloseArrow.visible = false
		Global.currentApp = "null"
		$"Celular/Email Control/WhiteScreen".visible = true
		$"Celular/Email Control/WhiteScreen".modulate = Color(1, 1, 1, 0)
		$Tween.interpolate_property($"Celular/Email Control/WhiteScreen", "modulate", Color(1, 1, 1, 0) , Color(1, 1, 1, 1), .3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		yield($Tween, "tween_completed")
		yield(get_tree().create_timer(.3), "timeout")
		$"Celular/Email Control/Email Logo".visible = true
		$Tween.interpolate_property($"Celular/Email Control/Email Logo", "modulate", Color(1, 1, 1, 0) , Color(1, 1, 1, 1), .3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		yield($Tween, "tween_completed")
		yield(get_tree().create_timer(2), "timeout")
		$"Celular/Email Control/ComplianceTela".visible = true
		yield(get_tree().create_timer(2), "timeout")
		
		# DIALOGO POS LINKEDIN
		if Global.celularComplianceTask == 0:
			$"Celular/Email Control/ControlDialogo1/Fala1".visible = true
			yield(get_tree().create_timer(2), "timeout")
			$"Celular/Email Control/ControlDialogo1/Fala2".visible = true
			yield(get_tree().create_timer(2), "timeout")
			$Tween.interpolate_property($"Celular/Email Control/ControlDialogo1/Fala2", "rect_position", Vector2($"Celular/Email Control/ControlDialogo1/Fala2".rect_position.x, $"Celular/Email Control/ControlDialogo1/Fala2".rect_position.y), Vector2($"Celular/Email Control/ControlDialogo1/Fala2".rect_position.x, $"Celular/Email Control/ControlDialogo1/Fala2".rect_position.y-60), .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$Tween.interpolate_property($"Celular/Email Control/ControlDialogo1/Fala1", "rect_position", Vector2($"Celular/Email Control/ControlDialogo1/Fala1".rect_position.x, $"Celular/Email Control/ControlDialogo1/Fala1".rect_position.y), Vector2($"Celular/Email Control/ControlDialogo1/Fala1".rect_position.x, $"Celular/Email Control/ControlDialogo1/Fala1".rect_position.y-60), .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			yield($Tween, "tween_completed")
			#$"Celular/Email Control/ControlDialogo1/Fala1".visible = false
			yield(get_tree().create_timer(2), "timeout")
			$"Celular/Email Control/ControlDialogo1/Fala3".visible = true
			yield(get_tree().create_timer(2), "timeout")
			$Tween.interpolate_property($"Celular/Email Control/ControlDialogo1/Fala2", "rect_position", Vector2($"Celular/Email Control/ControlDialogo1/Fala2".rect_position.x, $"Celular/Email Control/ControlDialogo1/Fala2".rect_position.y), Vector2($"Celular/Email Control/ControlDialogo1/Fala2".rect_position.x, $"Celular/Email Control/ControlDialogo1/Fala2".rect_position.y-134), 1.12, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$Tween.interpolate_property($"Celular/Email Control/ControlDialogo1/Fala3", "rect_position", Vector2($"Celular/Email Control/ControlDialogo1/Fala3".rect_position.x, $"Celular/Email Control/ControlDialogo1/Fala3".rect_position.y), Vector2($"Celular/Email Control/ControlDialogo1/Fala3".rect_position.x, $"Celular/Email Control/ControlDialogo1/Fala3".rect_position.y-134), 1.12, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			yield($Tween, "tween_completed")
			#$"Celular/Email Control/ControlDialogo1/Fala2".visible = false
			yield(get_tree().create_timer(2), "timeout")
			$"Celular/Email Control/ControlDialogo1/Fala4".visible = true
			yield(get_tree().create_timer(2), "timeout")
			$Tween.interpolate_property($"Celular/Email Control/ControlDialogo1/Fala4", "rect_position", Vector2($"Celular/Email Control/ControlDialogo1/Fala4".rect_position.x, $"Celular/Email Control/ControlDialogo1/Fala4".rect_position.y), Vector2($"Celular/Email Control/ControlDialogo1/Fala4".rect_position.x, $"Celular/Email Control/ControlDialogo1/Fala4".rect_position.y-77), 0.641667, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$Tween.interpolate_property($"Celular/Email Control/ControlDialogo1/Fala3", "rect_position", Vector2($"Celular/Email Control/ControlDialogo1/Fala3".rect_position.x, $"Celular/Email Control/ControlDialogo1/Fala3".rect_position.y), Vector2($"Celular/Email Control/ControlDialogo1/Fala3".rect_position.x, $"Celular/Email Control/ControlDialogo1/Fala3".rect_position.y-77), 0.641667, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			yield($Tween, "tween_completed")
			#$"Celular/Email Control/ControlDialogo1/Fala3".visible = false
			yield(get_tree().create_timer(2), "timeout")
			$"Celular/Email Control/ControlDialogo1/Fala5".visible = true
			yield(get_tree().create_timer(2), "timeout")
			$Tween.interpolate_property($"Celular/Email Control/ControlDialogo1/Fala4", "rect_position", Vector2($"Celular/Email Control/ControlDialogo1/Fala4".rect_position.x, $"Celular/Email Control/ControlDialogo1/Fala4".rect_position.y), Vector2($"Celular/Email Control/ControlDialogo1/Fala4".rect_position.x, $"Celular/Email Control/ControlDialogo1/Fala4".rect_position.y-131), 1.09, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$Tween.interpolate_property($"Celular/Email Control/ControlDialogo1/Fala5", "rect_position", Vector2($"Celular/Email Control/ControlDialogo1/Fala5".rect_position.x, $"Celular/Email Control/ControlDialogo1/Fala5".rect_position.y), Vector2($"Celular/Email Control/ControlDialogo1/Fala5".rect_position.x, $"Celular/Email Control/ControlDialogo1/Fala5".rect_position.y-131), 1.09, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			yield($Tween, "tween_completed")
			#$"Celular/Email Control/ControlDialogo1/Fala4".visible = false
			yield(get_tree().create_timer(2), "timeout")
			$"Celular/Email Control/ControlDialogo1/Fala6".visible = true
			yield(get_tree().create_timer(2), "timeout")
			$"Celular/Email Control/ControlDialogo1".visible = false
			
			emit_signal("finishedCompliance1")
		
		elif Global.celularComplianceTask == 1:
			$"Celular/Email Control/ControlDialogo2/Fala1".visible = true
			yield(get_tree().create_timer(2), "timeout")
			$"Celular/Email Control/ControlDialogo2/Fala2".visible = true
			yield(get_tree().create_timer(2), "timeout")
			$"Celular/Email Control/ControlDialogo2/Fala3".visible = true
			yield(get_tree().create_timer(2), "timeout")
			$Tween.interpolate_property($"Celular/Email Control/ControlDialogo2/Fala1", "rect_position", Vector2($"Celular/Email Control/ControlDialogo2/Fala1".rect_position.x, $"Celular/Email Control/ControlDialogo2/Fala1".rect_position.y), Vector2($"Celular/Email Control/ControlDialogo2/Fala1".rect_position.x, $"Celular/Email Control/ControlDialogo2/Fala1".rect_position.y-110), 0.916667, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$Tween.interpolate_property($"Celular/Email Control/ControlDialogo2/Fala2", "rect_position", Vector2($"Celular/Email Control/ControlDialogo2/Fala2".rect_position.x, $"Celular/Email Control/ControlDialogo2/Fala2".rect_position.y), Vector2($"Celular/Email Control/ControlDialogo2/Fala2".rect_position.x, $"Celular/Email Control/ControlDialogo2/Fala2".rect_position.y-110), 0.916667, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$Tween.interpolate_property($"Celular/Email Control/ControlDialogo2/Fala3", "rect_position", Vector2($"Celular/Email Control/ControlDialogo2/Fala3".rect_position.x, $"Celular/Email Control/ControlDialogo2/Fala3".rect_position.y), Vector2($"Celular/Email Control/ControlDialogo2/Fala3".rect_position.x, $"Celular/Email Control/ControlDialogo2/Fala3".rect_position.y-110), 0.916667, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			yield($Tween, "tween_completed")
			$"Celular/Email Control/ControlDialogo2/Fala1".visible = false
			$"Celular/Email Control/ControlDialogo2/Fala2".visible = false
			yield(get_tree().create_timer(2), "timeout")
			$"Celular/Email Control/ControlDialogo2/Fala4".visible = true
			yield(get_tree().create_timer(2), "timeout")
			$Tween.interpolate_property($"Celular/Email Control/ControlDialogo2/Fala3", "rect_position", Vector2($"Celular/Email Control/ControlDialogo2/Fala3".rect_position.x, $"Celular/Email Control/ControlDialogo2/Fala3".rect_position.y), Vector2($"Celular/Email Control/ControlDialogo2/Fala3".rect_position.x, $"Celular/Email Control/ControlDialogo2/Fala3".rect_position.y-80), 0.666667, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$Tween.interpolate_property($"Celular/Email Control/ControlDialogo2/Fala4", "rect_position", Vector2($"Celular/Email Control/ControlDialogo2/Fala4".rect_position.x, $"Celular/Email Control/ControlDialogo2/Fala4".rect_position.y), Vector2($"Celular/Email Control/ControlDialogo2/Fala4".rect_position.x, $"Celular/Email Control/ControlDialogo2/Fala4".rect_position.y-80), 0.666667, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			yield($Tween, "tween_completed")
			$"Celular/Email Control/ControlDialogo2/Fala3".visible = false
			yield(get_tree().create_timer(2), "timeout")
			$"Celular/Email Control/ControlDialogo2/Fala5".visible = true
			yield(get_tree().create_timer(2), "timeout")
			$Tween.interpolate_property($"Celular/Email Control/ControlDialogo2/Fala4", "rect_position", Vector2($"Celular/Email Control/ControlDialogo2/Fala4".rect_position.x, $"Celular/Email Control/ControlDialogo2/Fala4".rect_position.y), Vector2($"Celular/Email Control/ControlDialogo2/Fala4".rect_position.x, $"Celular/Email Control/ControlDialogo2/Fala4".rect_position.y-72), 0.600000, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$Tween.interpolate_property($"Celular/Email Control/ControlDialogo2/Fala5", "rect_position", Vector2($"Celular/Email Control/ControlDialogo2/Fala5".rect_position.x, $"Celular/Email Control/ControlDialogo2/Fala5".rect_position.y), Vector2($"Celular/Email Control/ControlDialogo2/Fala5".rect_position.x, $"Celular/Email Control/ControlDialogo2/Fala5".rect_position.y-72), 0.600000, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			yield($Tween, "tween_completed")
			$"Celular/Email Control/ControlDialogo2/Fala4".visible = false
			yield(get_tree().create_timer(2), "timeout")
			$"Celular/Email Control/ControlDialogo2/Fala6".visible = true
			yield(get_tree().create_timer(2), "timeout")
			$Tween.interpolate_property($"Celular/Email Control/ControlDialogo2/Fala5", "rect_position", Vector2($"Celular/Email Control/ControlDialogo2/Fala5".rect_position.x, $"Celular/Email Control/ControlDialogo2/Fala5".rect_position.y), Vector2($"Celular/Email Control/ControlDialogo2/Fala5".rect_position.x, $"Celular/Email Control/ControlDialogo2/Fala5".rect_position.y-103), 0.858333, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$Tween.interpolate_property($"Celular/Email Control/ControlDialogo2/Fala6", "rect_position", Vector2($"Celular/Email Control/ControlDialogo2/Fala6".rect_position.x, $"Celular/Email Control/ControlDialogo2/Fala6".rect_position.y), Vector2($"Celular/Email Control/ControlDialogo2/Fala6".rect_position.x, $"Celular/Email Control/ControlDialogo2/Fala6".rect_position.y-103), 0.858333, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			yield($Tween, "tween_completed")
			$"Celular/Email Control/ControlDialogo2/Fala5".visible = false
			yield(get_tree().create_timer(2), "timeout")
			$"Celular/Email Control/ControlDialogo2/Fala7".visible = true
			yield(get_tree().create_timer(2), "timeout")
			$Tween.interpolate_property($"Celular/Email Control/ControlDialogo2/Fala6", "rect_position", Vector2($"Celular/Email Control/ControlDialogo2/Fala6".rect_position.x, $"Celular/Email Control/ControlDialogo2/Fala6".rect_position.y), Vector2($"Celular/Email Control/ControlDialogo2/Fala6".rect_position.x, $"Celular/Email Control/ControlDialogo2/Fala6".rect_position.y-101), 0.841667, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$Tween.interpolate_property($"Celular/Email Control/ControlDialogo2/Fala7", "rect_position", Vector2($"Celular/Email Control/ControlDialogo2/Fala7".rect_position.x, $"Celular/Email Control/ControlDialogo2/Fala7".rect_position.y), Vector2($"Celular/Email Control/ControlDialogo2/Fala7".rect_position.x, $"Celular/Email Control/ControlDialogo2/Fala7".rect_position.y-101), 0.841667, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			yield($Tween, "tween_completed")
			$"Celular/Email Control/ControlDialogo2/Fala6".visible = false
			yield(get_tree().create_timer(2), "timeout")
			$"Celular/Email Control/ControlDialogo2/Fala8".visible = true
			yield(get_tree().create_timer(2), "timeout")
			
			emit_signal("finishedCompliance2")
			
			$"Celular/Email Control".visible = false
		
		$"Celular/Email Control/WhiteScreen".visible = false
		$"Celular/Email Control/Email Logo".visible = false
		$"Celular/Email Control/ComplianceTela".visible = false
		$InteractablePlayer.stop()
		$Celular/CloseArrow.visible = true
		$AnimationPlayer.stop()
		$AnimationPlayer.play("popup")

		
func _on_IconeTempo_pressed():
	# Global.currentApp = "tempo"
	if Global.currentApp != "tempo":
		$InteractablePlayer.play("tempo_error")
