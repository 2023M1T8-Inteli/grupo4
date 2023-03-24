extends CanvasLayer

# Variável para armazenar se a interface do usuário estava visível antes da pausa
onready var guiWasVisible

var couldMove

func _ready():
	$PauseScreen/HSlider.value = Global.volPercentage

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
