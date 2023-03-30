extends CanvasLayer

# Variável para armazenar se a interface do usuário estava visível antes da pausa
onready var guiWasVisible

var couldMove

var localCurrentApp = "null"

func _ready():
	Global.celularVisible = true
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
	
func _phone(value):
	if value == true:
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
	_phone(true)

func _on_CloseButton_pressed():
	_phone(false)


func _on_IconeInsta_pressed():
	Global.currentApp = "insta"


func _on_IconeLinkedin_pressed():
	Global.currentApp = "linkedin"


func _on_IconeEmail_pressed():
	Global.currentApp = "email"


func _on_IconeTempo_pressed():
	Global.currentApp = "tempo"
