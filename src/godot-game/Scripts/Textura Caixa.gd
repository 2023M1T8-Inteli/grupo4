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

func _ready():
	# Define o tempo de espera do Timer
	$Timer.wait_time = textSpeed
	
	# Obtém o diálogo
	dialog = getDialog()

	# Verifica se o diálogo foi encontrado
	assert(dialog, "Dialog not found")

	# Avança para a próxima frase
	nextPhrase()
	
func _process(_delta):
	# Torna o Polygon2D visível quando o diálogo termina
	$Polygon2D.visible = finished

	# Verifica se o botão de interação foi pressionado
	if Input.is_action_just_pressed("interact"):
		# Avança para a próxima frase se o diálogo foi finalizado
		if finished:
			nextPhrase()
		# Caso contrário, exibe todo o texto da frase
		else:
			$Label.visible_characters = len($Label.text)

	# Verifica se o diálogo foi finalizado e o botão de interação foi pressionado
	if phraseNum == len(dialog) and finished == true and Input.is_action_just_pressed("interact"):
		emit_signal("finish")

	# Realiza uma animação quando a terceira frase é exibida
	if phraseNum == 3 and finished == false:
		$'SpookRect/SpookPlayer'.play('dissolve')
		yield($'SpookRect/SpookPlayer', 'animation_finished')
		$'SpookRect/SpookPlayer'.play_backwards('dissolve')
		pass


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
		queue_free()
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
	if phraseNum == len(dialog) and finished == true:
		emit_signal("finish")
