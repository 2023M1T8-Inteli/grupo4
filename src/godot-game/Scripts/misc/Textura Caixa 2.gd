extends TextureRect

# Define o caminho do arquivo de diálogo
export var dialogPath = ""

# Define a velocidade do texto
export(float) var textSpeed = 0.05

# Define se o diálogo foi finalizado
export var finished = false

# Emite um sinal quando o diálogo termina
signal finish(Boolean)

# Variáveis utilizadas no código
var dialog
var buttonPressed
var phraseNum = 0

func _reset():
	# Reseta o diálogo
	phraseNum = 0
	$Label.visible_characters = 0

func _ready():
	#_startDialog()
	pass

func _startDialog():
	$FinishArrow/AnimationPlayer.play("hover")
	$ReturnArrow/ReturnButton.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	# Define o tempo de espera do Timer
	$Timer.wait_time = textSpeed
	
	# Obtém o diálogo
	dialog = getDialog()

	# Verifica se o diálogo foi encontrado
	assert(dialog, "Dialog not found")

	# Avança para a próxima frase
	nextPhrase()
	
func _process(_delta):
	# Torna as setinhas visíveis quando o diálogo termina e ativa o botao de retorno de dialogo
	$FinishArrow.visible = finished
	if phraseNum > 1 and finished == true:
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
	# Verifica se o diálogo foi concluído
	if phraseNum >= len(dialog):
		self.get_parent().visible = false
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
	print("CURRENT PHRASE NUMBER IS ", phraseNum)
	return


func _on_TextureButton_pressed():
	# Avança para a próxima frase se o diálogo foi finalizado
	if finished:
		nextPhrase()
	# Caso contrário, exibe todo o texto da frase
	else:
		$Label.visible_characters = len($Label.text)
		
	# Verifica se o diálogo foi finalizado e emite o sinal de "finish"
	if phraseNum == len(dialog) and finished == true:
		emit_signal("finish")


# Funcao que roda para voltar falas
func _on_ReturnButton_pressed():
	# Checa se o dialogo acabou de rolar e se ha alguma fala para voltar (fala > 1)
	if finished and phraseNum > 1:
		# Volta a variavel de falas por 2 (Compensa o terminar da fala o terminar da fala anterior)
		phraseNum -= 2
		# Define o rolamento de diálogo como não terminado
		finished = false
		# Toca a animação de voltar dialogo
		$ReturnArrowFlash/AnimationPlayer.play("flash")
		# Prossegue o dialogo
		nextPhrase()
