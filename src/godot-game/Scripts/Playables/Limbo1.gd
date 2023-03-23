extends Node2D

func _ready():
	# Define variáveis globais para controle do jogo
	Global.canMove = false  # Indica se o jogador pode se mover
	Global.isDrunk = false  # Indica se o jogador está bêbado
	
	$Audio.set_volume(Global.volPercentage) # Define o volume
	$Audio.play_ambient("res://Audio Files/wind woosh loop.ogg") # Toca o barulho de fundo do limbo
	$Audio.set_playback_pos("res://Audio Files/deepblue.mp3" , 0) # Toca a música do limbo
	
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
	Global.parte = "executivo"
	# Muda para a cena "Cidade.tscn" usando a classe "SceneTransition"
	SceneTransition.change_scene("res://Scenes/Non Playables/Animations/ComecoTereza.tscn", 1, 1)
	
