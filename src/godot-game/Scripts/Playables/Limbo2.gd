extends Node2D

func _ready():
	# RESETAR POSICAO DEFAULT CIDADE
	pos.posCidade = Vector2(368, 624)
	
	# Define variáveis globais para controle do jogo
	Global.canMove = false  # Indica se o jogador pode se mover
	Global.isDrunk = false  # Indica se o jogador está bêbado
	$LimboAmbience.playing = true  # Toca o barulho de fundo do limbo
	$LimboMusic.playing = true  # Toca a música do limbo
	
	# Espera 3.3 segundos antes de exibir a caixa de diálogo
	yield(get_tree().create_timer(3.3), "timeout")
	$"DialogBox 4".visible = true  # Exibe a caixa de diálogo
	$"DialogBox 4/TexturaCaixa"._startDialog()  # Inicia a animação da caixa de diálogo
	
	# Conecta o sinal "finish" da textura da caixa de diálogo a esta cena
	if $"DialogBox 4/TexturaCaixa".connect("finish", self, "_on_TexturaCaixa_finish") != OK:
		print("ERRO AO CONECTAR")
	if $QuizTask.connect("quizFinish", self, "_quiz1_finish") != OK:
		print("ERRO AO CONECTAR")
	if $QuizTask2.connect("quizFinish", self, "_quiz2_finish") != OK:
		print("ERRO AO CONECTAR")
	if $"DialogBox 5/TexturaCaixa".connect("finish", self, "_on_TexturaCaixa2_finish") != OK:
		print("ERRO AO CONECTAR")

# Esta função é chamada quando a animação da caixa de diálogo termina
func _on_TexturaCaixa_finish():
	# Torna o nó QuizTask visível
	$QuizTask.visible = true
	# Chama a função _startQuiz do nó QuizTask
	$QuizTask._startQuiz()

# Função chamada quando o primeiro quiz é finalizado
func _quiz1_finish():
	# Torna o nó QuizTask invisível
	$QuizTask.visible = false
	# Torna o nó QuizTask2 visível
	$QuizTask2.visible = true
	# Chama a função _startQuiz do nó QuizTask2
	$QuizTask2._startQuiz()
	
# Função chamada quando o segundo quiz é finalizado
func _quiz2_finish():
	# Torna o nó "DialogBox 5" visível
	$"DialogBox 5".visible = true
	# Chama a função _startDialog do nó "TexturaCaixa" do "DialogBox 5"
	$"DialogBox 5/TexturaCaixa"._startDialog() 

# Função chamada quando a animação da segunda caixa de diálogo termina
func _on_TexturaCaixa2_finish():
	# Define a variável global "parte" como "administrativo"
	Global.parte = "administrativo"
	# Muda a cena para "res://Scenes/Non Playables/Animations/ComecoJonas.tscn" com uma transição suave
	SceneTransition.change_scene("res://Scenes/Non Playables/Animations/ComecoJonas.tscn", 1, 1)
