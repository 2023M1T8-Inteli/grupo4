extends Control

# Este script é responsável por controlar as funcionalidades dos botões da tela inicial.

# Quando o botão "Jogar" é pressionado, é feita a transição para a cena principal do jogo.
func _on_StartButton_pressed() -> void:
	SceneTransition.change_scene("res://Scenes/Main Scene.tscn")

# O método _physics_process é executado a cada quadro renderizado. Quando a ação "start" é pressionada, 
# a cena principal do jogo é carregada.
func _physics_process(_delta):
	if Input.is_action_pressed("start"):
		SceneTransition.change_scene("res://Scenes/Main Scene.tscn")

# Quando o botão "Sair" é pressionado, o programa é encerrado.
func _on_QuitButton_pressed():
	get_tree().quit()

# Quando o botão "Controles" é pressionado, a cena com informações sobre as mecânicas do jogo é exibida.
func _on_ControlsButton_pressed():
	get_tree().change_scene("res://Scenes/Controls.tscn")
