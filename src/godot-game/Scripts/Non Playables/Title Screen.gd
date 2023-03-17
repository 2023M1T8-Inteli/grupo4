extends Control

# Load Musica como uma variavel para poder trocar de cenas sem parar a musica

# Este script é responsável por controlar as funcionalidades dos botões da tela inicial.
func _ready():
	# Checa se o jogador já passou pelo diálogo do limbo, se sim, disponibiliza o botão como "Voltar" e não como "Jogar"
	if Global.finishDialog1 == false:
		$StartButton/RichTextLabel.bbcode_text = "[center]JOGAR[/center]"
	elif Global.parte == "tecnico":
		$StartButton.mouse_filter = Control.MOUSE_FILTER_IGNORE
		$StartButton/RichTextLabel.bbcode_text = "[center]AQUI ACABOU![/center]"
	else:
		$StartButton/RichTextLabel.bbcode_text = "[center]VOLTAR[/center]"
	
	if Global.playbackPos == 0:
		$Audio.set_playback_pos("res://Audio Files/TitleScreen.mp3" , 0)
	else:
		$Audio.set_playback_pos("res://Audio Files/TitleScreen.mp3" , Global.playbackPos)
	$Audio.set_volume(Global.volPercentage)
# Quando o botão "Jogar" é pressionado, é feita a transição para a cena principal do jogo.
func _on_StartButton_pressed() -> void:
	# Checa se o jogador já passou pelo diálogo do limbo:
	# Se sim, manda o jogador para a cena em que ele estava quando saiu, 
	# Se não, inicia o jogo pela animação do hospital.
	if Global.finishDialog1 == false:
		SceneTransition.change_scene("res://Scenes/Non Playables/Animations/ZeAnim.tscn", 1, 1)
	else:
		SceneTransition.change_scene(pos.posScene, 1, 1)

# Quando o botão "Controles" é pressionado, a cena com informações sobre as mecânicas do jogo é exibida.
func _on_ControlsButton_pressed():
	if get_tree().change_scene("res://Scenes/Non Playables/misc/Controls.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the scene")

# Quando o botão super secreto é pressionado, a cena super secreta é exibida.
func _on_OvoButton_pressed():
	if get_tree().change_scene("res://Sprites/Ze/Ovo.tscn") != OK:
		print("ERRO OVO")

func _on_Title_Screen_tree_exiting():
	$Audio.get_playback_pos()
	
# AS FUNÇÕES ABAIXO ESTÃO COMENTADAS, POIS ELAS NÃO ESTÃO SENDO UTILIZADAS (POR ENQUANTO)

# Quando o botão "Sair" é pressionado, o programa é encerrado. 
#func _on_QuitButton_pressed():
#	get_tree().quit()
