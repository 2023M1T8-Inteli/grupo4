extends Node2D

# Função que é chamada quando a cena é carregada
func _ready():
	Global.isDrunk = false
	$LimboAmbience.playing = true
	
	# Torna o nó do fantasma visível e o nó do Ze invisível
	get_node("Player/Fantasma").visible = true
	get_node("Player/Ze").visible = false
	
	yield(get_tree().create_timer(3.3), "timeout")
	BangSound.playing = false
	$LimboMusic.playing = true
	$"DialogBox 1".visible = true
	$"DialogBox 1/TexturaCaixa".start_dialog()
	# Obtém a textura da caixa de diálogo e conecta o sinal "finish" a esta cena
	var textura_dialogo =  $"DialogBox 1/TexturaCaixa"
	textura_dialogo.connect("finish", self, "_on_TexturaCaixa_finish")
	
	
# Função que é chamada quando a animação da caixa de diálogo termina
func _on_TexturaCaixa_finish():
	Global.finishDialog1 = true
	# Muda para a cena "Cidade.tscn" usando a classe "SceneTransition"
	SceneTransition.change_scene("res://Scenes/Cidade.tscn", 1, 1)
