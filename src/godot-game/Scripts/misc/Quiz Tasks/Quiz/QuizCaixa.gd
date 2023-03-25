extends TextureRect

# Define o caminho do arquivo de diálogo
export var dialogPath = "" # Define o caminho do arquivo de diálogo como exportável, permitindo alterações através do editor.

# Define a velocidade do texto
export(float) var textSpeed = 0.05 # Define a velocidade do texto como exportável, permitindo alterações através do editor.

# Define se o diálogo foi finalizado
export var finished = false # Define a variável finished como exportável, permitindo o acesso em outros scripts.

export(Array) var jumpStartQuery # Define a variável jumpStartQuery como exportável, permitindo o acesso em outros scripts.
export(Array) var jumpStartFeedBack # Define a variável jumpStartFeedBack como exportável, permitindo o acesso em outros scripts.

# Emite um sinal quando o diálogo termina
signal finishDialog(Boolean) # Sinal para quando o diálogo termina, recebe um valor booleano.

signal quizCorrect # Sinal para quando o quiz é respondido corretamente.


# Variáveis utilizadas no código
var dialog # Variável que armazena o conteúdo do arquivo de diálogo.
var buttonPressed # Variável que armazena o estado do botão pressionado.
var phraseNum # Variável que armazena o número da frase atual.
var startPhraseNum # Variável que armazena o número da primeira frase do diálogo.
var howManyPhrases # Variável que armazena o número total de frases do diálogo.

var deadbolt = true # Variável sem uso aparente.

func _ready():
	set_process(false) # Desativa a execução do código até ser chamado.

func jumpStart(startPhraseNumber, howMany):
	set_process(true) # Ativa a execução do código.
	$FinishArrow/AnimationPlayer.play("hover") # Animação de hover no botão de finalizar diálogo.
	$ReturnArrow/ReturnButton.mouse_filter = Control.MOUSE_FILTER_IGNORE # Desativa o botão de retorno de diálogo.
	phraseNum = startPhraseNumber # Define a frase atual.
	startPhraseNum = startPhraseNumber # Define a primeira frase.
	howManyPhrases = howMany # Define o número total de frases.
	# Define o tempo de espera do Timer
	$Timer.wait_time = textSpeed
	
	# Obtém o diálogo
	dialog = getDialog() # Chama a função getDialog() para obter o diálogo.

	# Verifica se o diálogo foi encontrado
	assert(dialog, "Dialog not found") # Verifica se o diálogo foi encontrado, caso contrário emite uma mensagem de erro.
	# Avança para a próxima frase
	nextPhrase() # Chama a função nextPhrase() para avançar para a próxima frase.

func jumpStartQuiz():
	jumpStart(jumpStartQuery[0], jumpStartQuery[1]) # Chama a função jumpStart() para o início do quiz.

func _process(_delta):
	# Torna as setinhas visíveis quando o diálogo termina e ativa o botão de retorno de diálogo
	# delta representa o tempo entre atualizações do jogo
	# É uma boa prática usar snake_case para nomes de variáveis e funções em vez de camelCase
	$FinishArrow.visible = finished
	if (phraseNum - startPhraseNum) > 1 and finished == true:
		$ReturnArrow.color = "ffffff"  # as aspas são desnecessárias aqui
		$ReturnArrow/ReturnButton.mouse_filter = Control.MOUSE_FILTER_STOP
	else:
		$ReturnArrow.color = "656565"


func getDialog() -> Array:
	# Cria um novo arquivo
	var file = File.new()

	# Verifica se o arquivo de diálogo existe
	# Use assert para garantir que o programa pare se algo inesperado acontecer
	# A mensagem de erro é exibida no console se o teste falhar
	assert(file.file_exists(dialogPath), "O caminho do arquivo não existe")

	# Abre o arquivo de diálogo e obtém seu conteúdo como texto
	file.open(dialogPath, File.READ)
	var json = file.get_as_text()

	# Analisa o JSON e retorna seu conteúdo como um array
	# É importante verificar o tipo de saída antes de usá-lo
	var output = parse_json(json)
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []


func nextPhrase() -> void:
	# Se não houver mais frases, termina o diálogo
	if (phraseNum - startPhraseNum) == howManyPhrases:
		if startPhraseNum == 2:
			# Esconde o diálogo e emite o sinal de "quizCorrect" se o jogador respondeu corretamente a um quiz
			self.get_parent().get_parent().visible = false
			emit_signal("quizCorrect")
		return
	
	# Define o diálogo como não finalizado
	finished = false

	# Define o nome do NPC e o texto da frase atual
	$NomeNPC.bbcode_text = dialog[phraseNum]["Name"]
	$Label.bbcode_text = dialog[phraseNum]["Text"]
	# Define a quantidade de caracteres visíveis como zero
	$Label.visible_characters = 0

	# Exibe gradualmente o texto da frase
	while $Label.visible_characters < len($Label.text):
		$Label.visible_characters += 1
		$Timer.start()
		yield($Timer, "timeout")

	# Define o diálogo como finalizado
	finished = true

	# Avança para a próxima frase
	phraseNum += 1

	return


func _on_TextureButton_pressed():
	# Avança para a próxima frase se o diálogo foi finalizado
	if finished:
		nextPhrase()
	# Caso contrário, exibe todo o texto da frase
	else:
		$Label.visible_characters = len($Label.text)
		
	# Verifica se o diálogo foi finalizado e emite o sinal de "finish"
	if phraseNum == jumpStartQuery[1] and finished == true:
		emit_signal("finishDialog")


# Função que é chamada quando o botão de retorno é pressionado
func _on_ReturnButton_pressed():
	# Verifica se o diálogo está finalizado e se a frase atual não é a primeira
	if finished and phraseNum > 1:
		# Retrocede duas frases
		phraseNum -= 2
		# Define o diálogo como não finalizado
		finished = false
		# Executa a animação de "flash" no botão de retorno
		$ReturnArrowFlash/AnimationPlayer.play("flash")
		# Avança para a próxima frase
		nextPhrase()

# Função que é chamada quando o sinal "quizCorrect" é emitido
func _answered_quiz():
	# Espera 1.2 segundos
	yield(get_tree().create_timer(1.2), "timeout")
	# Chama a função "jumpStart" para iniciar um novo diálogo
	jumpStart(jumpStartFeedBack[0], jumpStartFeedBack[1])
	# Imprime uma mensagem de debug
	print("jumpstarted")
