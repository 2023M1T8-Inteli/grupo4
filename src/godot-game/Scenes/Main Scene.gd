extends Node2D

# Função que é chamada quando a cena é carregada
func _ready():
	# Obtém a textura da caixa de diálogo e conecta o sinal "finish" a esta cena
	var textura_dialogo =  $"DialogBox 1/TexturaCaixa"
	textura_dialogo.connect("finish", self, "_on_TexturaCaixa_finish")
	
	# Torna o nó da GUI invisível e o nó da caixa de diálogo visível
###	get_node("Player/Camera2D/GUI").visible = false
#	get_node("Player/Camera2D/DialogBox").visible = true
	
	# Define o filtro do mouse do botão da textura como "Control.MOUSE_FILTER_STOP"
	# Isso impede que cliques no botão passem para outros nós
#	get_node("Player/Camera2D/TextureButton").mouse_filter = Control.MOUSE_FILTER_STOP
	
	# Torna o nó do fantasma visível e o nó do Ze invisível
	get_node("Player/Fantasma").visible = true
	get_node("Player/Ze").visible = false

# Função que é chamada quando a animação da caixa de diálogo termina
func _on_TexturaCaixa_finish():
	# Torna o nó da caixa de diálogo invisível
#	get_node("Player/Camera2D/DialogBox").visible = false
	
	# Muda para a cena "Cidade.tscn" usando a classe "SceneTransition"
	SceneTransition.change_scene("res://Scenes/Cidade.tscn")
