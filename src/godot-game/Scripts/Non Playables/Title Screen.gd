extends Control

# Este script é responsável por controlar as funcionalidades dos botões da tela inicial.

func _ready():
	if Global.finishDialog1 == false:
		$StartButton/RichTextLabel.text = " JOGAR"
	else:
		$StartButton/RichTextLabel.text = " VOLTAR"

# Quando o botão "Jogar" é pressionado, é feita a transição para a cena principal do jogo.
func _on_StartButton_pressed() -> void:
	if Global.finishDialog1 == false:
		SceneTransition.change_scene("res://Scenes/Non Playables/Animations/ZeAnim.tscn", 1, 1)
	else:
		SceneTransition.change_scene(pos.posScene, 1, 1)

# Quando o botão "Sair" é pressionado, o programa é encerrado.
#func _on_QuitButton_pressed():
#	get_tree().quit()

# Quando o botão "Controles" é pressionado, a cena com informações sobre as mecânicas do jogo é exibida.
func _on_ControlsButton_pressed():
	if get_tree().change_scene("res://Scenes/Non Playables/misc/Controls.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the scene")


func _on_OvoButton_pressed():
	if get_tree().change_scene("res://Sprites/Ze/Ovo.tscn") != OK:
		print("ERRO OVO")
