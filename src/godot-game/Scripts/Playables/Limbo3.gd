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
	$"DialogBox 7".visible = true  # Exibe a caixa de diálogo
	$"DialogBox 7/TexturaCaixa"._startDialog()  # Inicia a animação da caixa de diálogo
	
	# Conecta o sinal "finish" da textura da caixa de diálogo a esta cena
	if $"DialogBox 7/TexturaCaixa".connect("finish", self, "_on_TexturaCaixa_finish") != OK:
		print("ERRO AO CONECTAR")
	if $QuizTask.connect("quizFinish", self, "_quiz1_finish") != OK:
		print("ERRO AO CONECTAR")
	if $QuizTask2.connect("quizFinish", self, "_quiz2_finish") != OK:
		print("ERRO AO CONECTAR")
	if $"DialogBox 8/TexturaCaixa".connect("finish", self, "_on_TexturaCaixa2_finish") != OK:
		print("ERRO AO CONECTAR")

# Função chamada quando a animação da caixa de diálogo termina
func _on_TexturaCaixa_finish():
	# Quando a animação da caixa de diálogo termina, a variável 'visible' do nó 'QuizTask' é alterada para 'true'
	$QuizTask.visible = true
	# Em seguida, a função '_startQuiz()' é chamada no nó 'QuizTask' para iniciar o quiz
	$QuizTask._startQuiz()

# Função chamada quando o primeiro quiz é finalizado
func _quiz1_finish():
	# Quando o primeiro quiz é finalizado, a variável 'visible' do nó 'QuizTask' é alterada para 'false'
	$QuizTask.visible = false
	# Em seguida, a variável 'visible' do nó 'QuizTask2' é alterada para 'true'
	$QuizTask2.visible = true
	# A função '_startQuiz()' é chamada no nó 'QuizTask2' para iniciar o segundo quiz
	$QuizTask2._startQuiz()

# Função chamada quando o segundo quiz é finalizado
func _quiz2_finish():
	# Quando o segundo quiz é finalizado, a variável 'visible' do nó 'DialogBox 8' é alterada para 'true'
	$"DialogBox 8".visible = true
	# Em seguida, a função '_startDialog()' é chamada no nó 'TexturaCaixa' que está dentro de 'DialogBox 8', para iniciar uma nova caixa de diálogo
	$"DialogBox 8/TexturaCaixa"._startDialog() 
	
# Função chamada quando a animação da segunda caixa de diálogo termina
func _on_TexturaCaixa2_finish():
	# Quando a animação da segunda caixa de diálogo termina, a variável global 'parte' é atualizada para 'tecnico'
	Global.parte = "tecnico"
	# Em seguida, a função 'change_scene()' do nó 'SceneTransition' é chamada para mudar a cena para 'Tecnico.tscn'
	# Os dois últimos argumentos (1, 1) indicam que a transição será suave e a tela não será limpa antes da transição
	SceneTransition.change_scene("res://Scenes/Non Playables/Animations/ComecoJoao.tscn", 1, 1)
