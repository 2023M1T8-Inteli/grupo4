# O CÓDIGO ABAIXO ESTÁ PARCIALMENTE COMENTADO, POIS NÃO ESTA IMPLEMENTADO NO JOGO AINDA E ESTEVE SERVINDO SOMENTE PARA TESTAGEM

extends Control

# Caminho para o arquivo de perguntas (exportado para ser acessível no editor)
export var questionPath = ""
export(int) var firstCorrect

# Referência às caixas de texto usadas para exibir as opções de resposta
onready var caixasTexto = [$Opcao1/Opcao1, $Opcao2/Opcao2, $Opcao3/Opcao3]

# Armazena as perguntas lidas do arquivo
var dialog = []
var questions = []


# Número da pergunta atual
var phraseNum = 0

func _ready():
	$MouseFilter.visible = false

func startQuiz():
	dialog = getQuestions()
	renderQuestions()

func _process(_delta):
	$MouseFilter.visible = Global.quizAnswered

func getQuestions() -> Array:
	# Cria um novo arquivo
	var f = File.new()

	# Verifica se o arquivo de diálogo existe
	assert(f.file_exists(questionPath), "Caminho do arquivo não existe")

	# Abre o arquivo de diálogo e obtém seu conteúdo como texto
	f.open(questionPath, File.READ)
	var json = f.get_as_text()

	# Analisa o JSON e retorna seu conteúdo como um array
	var output = parse_json(json)

	# Verifica se o conteúdo analisado é do tipo array
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []

func renderQuestions() -> void:
	# Seleciona as perguntas corretas para o quiz
	var firstCorrect = randi() % len(dialog) - 1

	# Adiciona as duas primeiras perguntas corretas na lista de perguntas
	questions.append(dialog[firstCorrect])
	questions.append(dialog[firstCorrect+1])

	# Embaralha as perguntas restantes aleatoriamente
	randomize()
	var retries = randi() % 20
	for i in range(retries):
		questions.shuffle()

	# Exibe as perguntas nas caixas de texto
	for i in caixasTexto:
		i.bbcode_text = questions[phraseNum]["Resposta"]

		# Salva a caixa de texto com a resposta correta
		if questions[phraseNum]["IsCorrect"] == "Y":
			Global.correctBoxQuiz = i

		phraseNum += 1

	return
