extends CanvasLayer

# Variável para armazenar se a interface do usuário estava visível antes da pausa
onready var guiWasVisible

func _on_PauseButton_pressed():
	Global.canMove = false
	
	# Verifica se a interface do usuário está visível
	if $GUI.visible == true:
		# Esconde a interface do usuário e armazena que ela estava visível antes da pausa
		$GUI.visible = false
		guiWasVisible = true
	else:
		# Esconde a interface do usuário e armazena que ela estava escondida antes da pausa
		$GUI.visible = false
		guiWasVisible = false
	
	# Mostra a tela de pausa
	$PauseScreen.visible = true
	
	# Define o filtro de mouse dos botões de início e saída da tela de pausa para não permitir interação
	get_node("PauseScreen/StartButton").mouse_filter = Control.MOUSE_FILTER_STOP
	get_node("PauseScreen/QuitButton").mouse_filter = Control.MOUSE_FILTER_STOP
	

func _on_StartButton_pressed():
	Global.canMove = true
	
	# Define o filtro de mouse dos botões de início e saída da tela de pausa para permitir interação
	get_node("PauseScreen/StartButton").mouse_filter = Control.MOUSE_FILTER_IGNORE
	get_node("PauseScreen/QuitButton").mouse_filter = Control.MOUSE_FILTER_IGNORE

	# Se a interface do usuário estava visível antes da pausa, mostra novamente
	if guiWasVisible:
		$GUI.visible = true
		
	# Esconde a tela de pausa
	$PauseScreen.visible = false


func _on_QuitButton_pressed():
	pos.savePosCommand = true
	# Muda a cena para a tela de título
