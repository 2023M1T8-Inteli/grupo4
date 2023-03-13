extends Node2D

func _ready():
	# Define variáveis globais para controle do jogo
	Global.canMove = false  # Indica se o jogador pode se mover
	Global.isDrunk = false  # Indica se o jogador está bêbado
	$LimboAmbience.playing = true  # Toca o barulho de fundo do limbo
	$LimboMusic.playing = true  # Toca a música do limbo
	
	# Configura o estado inicial dos personagens
	get_node("Player/Fantasma").visible = true  # Deixa o fantasma visível
	get_node("Player/Ze").visible = false  # Esconde o personagem Ze
	get_node("Player/Tereza").visible = false  # Esconde a personagem Tereza
	get_node("Player/Jonas").visible = false  # Esconde o personagem Jonas
	
	# Espera 3.3 segundos antes de exibir a caixa de diálogo
	yield(get_tree().create_timer(3.3), "timeout")
	$"DialogBox 1".visible = true  # Exibe a caixa de diálogo
	$"DialogBox 1/TexturaCaixa".start_dialog()  # Inicia a animação da caixa de diálogo
	
	# Conecta o sinal "finish" da textura da caixa de diálogo a esta cena
	var textura_dialogo =  $"DialogBox 1/TexturaCaixa"
	textura_dialogo.connect("finish", self, "_on_TexturaCaixa_finish")
	

# Função chamada quando a animação da caixa de diálogo termina
func _on_TexturaCaixa_finish():
	Global.finishDialog1 = true  # Indica que a caixa de diálogo acabou / já foi tocada
	# Muda para a cena "Cidade.tscn" usando a classe "SceneTransition"
	SceneTransition.change_scene("res://Scenes/Playables/Environment/Cidade.tscn", 1, 1)
