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
	$"DialogBox 4/TexturaCaixa".connect("finish", self, "_on_TexturaCaixa_finish")
	$QuizTask.connect("quizFinish", self, "_quiz1_finish")
	$QuizTask2.connect("quizFinish", self, "_quiz2_finish")
	$"DialogBox 5/TexturaCaixa".connect("finish", self, "_on_TexturaCaixa2_finish")
# Função chamada quando a animação da caixa de diálogo termina
func _on_TexturaCaixa_finish():
	$QuizTask.visible = true
	$QuizTask._startQuiz()

func _quiz1_finish():
	$QuizTask.visible = false
	$QuizTask2.visible = true
	$QuizTask2._startQuiz()
	
func _quiz2_finish():
	$"DialogBox 5".visible = true
	$"DialogBox 5/TexturaCaixa"._startDialog() 
	
func _on_TexturaCaixa2_finish():
	Global.parte = "administrativo"
	SceneTransition.change_scene("res://Scenes/Playables/Environment/Cidade.tscn", 1, 1)
