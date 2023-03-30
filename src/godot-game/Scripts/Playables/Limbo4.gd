extends Node2D

func _ready():
	# RESETAR POSICAO DEFAULT CIDADE
	pos.posCidade = Vector2(368, 624)
	
	# Define variáveis globais para controle do jogo
	Global.canMove = false  # Indica se o jogador pode se mover
	Global.isDrunk = false  # Indica se o jogador está bêbado
	
	$Audio.set_volume(Global.volPercentage) # Define o volume
	$Audio.play_ambient("res://Audio Files/wind woosh loop.ogg") # Toca o barulho de fundo do limbo
	$Audio.set_playback_pos("res://Audio Files/deepblue.mp3" , 0) # Toca a música do limbo
	
	# Espera 3.3 segundos antes de exibir a caixa de diálogo
	yield(get_tree().create_timer(3.3), "timeout")
	$"DialogBox 10".visible = true  # Exibe a caixa de diálogo
	$"DialogBox 10/TexturaCaixa"._startDialog()  # Inicia a animação da caixa de diálogo
	
	# Conecta o sinal "finish" da textura da caixa de diálogo a esta cena
	if $"DialogBox 10/TexturaCaixa".connect("finish", self, "_on_TexturaCaixa_finish") != OK:
		print("ERRO AO CONECTAR")
	if $QuizTask.connect("quizFinish", self, "_quiz1_finish") != OK:
		print("ERRO AO CONECTAR")
	if $QuizTask2.connect("quizFinish", self, "_quiz2_finish") != OK:
		print("ERRO AO CONECTAR")
	if $"DialogBox 11/TexturaCaixa".connect("finish", self, "_on_TexturaCaixa2_finish") != OK:
		print("ERRO AO CONECTAR")

# Função chamada quando a animação da caixa de diálogo termina
func _on_TexturaCaixa_finish():
	# Torna o nó QuizTask visível
	$QuizTask.visible = true
	# Inicia o quiz
	$QuizTask._startQuiz()

# Função chamada quando o primeiro quiz é finalizado
func _quiz1_finish():
	# Torna o nó QuizTask invisível
	$QuizTask.visible = false
	# Torna o nó QuizTask2 visível
	$QuizTask2.visible = true
	# Inicia o segundo quiz
	$QuizTask2._startQuiz()
	
# Função chamada quando o segundo quiz é finalizado
func _quiz2_finish():
	# Torna o nó "DialogBox 11" visível
	$"DialogBox 11".visible = true
	# Inicia o diálogo
	$"DialogBox 11/TexturaCaixa"._startDialog() 
	
# Função chamada quando a animação da segunda caixa de diálogo termina
func _on_TexturaCaixa2_finish():
	# Define a variável global "parte" como "fim"
	Global.parte = "fim"
	# Muda para a cena Reincarn.tscn usando a SceneTransition
	SceneTransition.change_scene("res://Scenes/Non Playables/misc/Reincarn.tscn", 1, 1)
