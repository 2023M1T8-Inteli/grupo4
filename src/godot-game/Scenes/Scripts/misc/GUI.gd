extends CanvasLayer

# Variável para armazenar se a interface do usuário estava visível antes da pausa
onready var guiWasVisible

func _on_PauseButton_pressed():
	# Desabilita o movimento do jogador
	Global.canMove = false
	
	# Esconde a interface do usuário
	$GUI.visible = false
	
	# Mostra a tela de pausa
	$PauseScreen.visible = true
	
	

func _on_StartButton_pressed():
	# Habilita o movimento do jogador
	Global.canMove = true

	# Mostra novamente a interface do usuário
	$GUI.visible = true
		
	# Esconde a tela de pausa
	$PauseScreen.visible = false


func _on_QuitButton_pressed():
	# Executa a função de salvar a posição e cena atual do jogador e sair para tela de início (essa função é executada no script Player.gd)
	pos.savePosCommand = true
