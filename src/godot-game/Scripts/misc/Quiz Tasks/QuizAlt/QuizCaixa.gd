# O CÓDIGO ABAIXO ESTÁ PARCIALMENTE COMENTADO, POIS NÃO ESTA IMPLEMENTADO NO JOGO AINDA E ESTEVE SERVINDO SOMENTE PARA TESTAGEM

extends TextureRect

# Define o caminho do arquivo de diálogo
export var dialogPath = ""

# Define a velocidade do texto
export(float) var textSpeed = 0.05

# Define se o diálogo foi finalizado
export var finished = false

export(Array) var jumpStartQuery
export(Array) var jumpStartFeedBack

# Emite um sinal quando o diálogo termina
signal finishDialog(Boolean)

signal quizCorrect


# Variáveis utilizadas no código
var dialog
var buttonPressed
var phraseNum
var startPhraseNum
var howManyPhrases

var deadbolt = true

func _ready():
	set_process(false)

func jumpStart(startPhraseNumber, howMany):
	set_process(true)
	$FinishArrow/AnimationPlayer.play("hover")
	$ReturnArrow/ReturnButton.mouse_filter = Control.MOUSE_FILTER_IGNORE
	phraseNum = startPhraseNumber
	startPhraseNum = startPhraseNumber
	howManyPhrases = howMany
	# Define o tempo de espera do Timer
	$Timer.wait_time = textSpeed
	
	# Obtém o diálogo
	dialog = getDialog()

	# Verifica se o diálogo foi encontrado
	assert(dialog, "Dialog not found")
	# Avança para a próxima frase
	nextPhrase()
	
func jumpStartQuiz():
	jumpStart(jumpStartQuery[0], jumpStartQuery[1])

func _process(_delta):
	# Torna as setinhas visíveis quando o diálogo termina e ativa o botao de retorno de dialogo
	$FinishArrow.visible = finished
	if (phraseNum - startPhraseNum) > 1 and finished == true:
		$ReturnArrow.color = ("ffffff") 
		$ReturnArrow/ReturnButton.mouse_filter = Control.MOUSE_FILTER_STOP
	else:
		$ReturnArrow.color = ("656565")

func getDialog() -> Array:
	# Cria um novo arquivo
	var f = File.new()

	# Verifica se o arquivo de diálogo existe
	assert(f.file_exists(dialogPath), "File path does not exist")

	# Abre o arquivo de diálogo e obtém seu conteúdo como texto
	f.open(dialogPath, File.READ)
	var json = f.get_as_text()

	# Analisa o JSON e retorna seu conteúdo como um array
	var output = parse_json(json)

	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []


func nextPhrase() -> void:
	if (phraseNum - startPhraseNum) == howManyPhrases:
		if startPhraseNum == 8:
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


func _on_ReturnButton_pressed():
	if finished and phraseNum > 1:
		phraseNum -= 2
		finished = false
		$ReturnArrowFlash/AnimationPlayer.play("flash")
		nextPhrase()

func _answered_quiz():
	yield(get_tree().create_timer(1.2), "timeout")
	jumpStart(jumpStartFeedBack[0], jumpStartFeedBack[1])
	#emit_signal("quizCorrect")
	print("jumpstarted")
