extends Node2D

# Função que é chamada quando a cena é carregada
func _ready():
	# Obtém a textura da caixa de diálogo e conecta o sinal "finish" a esta cena
	var textura_dialogo =  $"DialogBox 1/TexturaCaixa"
	textura_dialogo.connect("finish", self, "_on_TexturaCaixa_finish")
	
	# Torna o nó do fantasma visível e o nó do Ze invisível
	get_node("Player/Fantasma").visible = true
	get_node("Player/Ze").visible = false

# Função que é chamada quando a animação da caixa de diálogo termina
func _on_TexturaCaixa_finish():
	
	# Muda para a cena "Cidade.tscn" usando a classe "SceneTransition"
	SceneTransition.change_scene("res://Scenes/Cidade.tscn")
