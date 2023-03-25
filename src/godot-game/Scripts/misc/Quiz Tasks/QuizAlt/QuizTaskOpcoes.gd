extends Control

# Variáveis exportadas para o editor
export var questionPath = ""
export(int) var firstCorrect

# Referência às caixas de texto das opções
onready var caixasTexto = [$Opcao1/Opcao1, $Opcao2/Opcao2]

# Array que armazena as perguntas do quiz
var dialog = []
var questions = []

# Número da pergunta atual
var phraseNum = 0

func _ready():
	# Torna o filtro do mouse invisível
	$MouseFilter.visible = false

# Função que inicia o quiz
func startQuiz():
	dialog = getQuestions()
	renderQuestions()

func _process(_delta):
	# Esconde o filtro do mouse quando o quiz já foi respondido
	$MouseFilter.visible = Global.quizAnswered

# Função que obtém as perguntas do arquivo JSON
func getQuestions() -> Array:
	# Cria um novo arquivo
	var f = File.new()

	# Verifica se o arquivo de diálogo existe
	assert(f.file_exists(questionPath), "O caminho do arquivo não existe")

	# Abre o arquivo de diálogo e obtém seu conteúdo como texto
	f.open(questionPath, File.READ)
	var json = f.get_as_text()

	# Analisa o JSON e retorna seu conteúdo como um array
	var output = parse_json(json)

	# Verifica se o conteúdo é um array
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []

# Função que renderiza as perguntas nas caixas de texto
func renderQuestions() -> void:
	# Adiciona as perguntas corretas no array de perguntas
	questions.append(dialog[firstCorrect])
	questions.append(dialog[firstCorrect+1])

	# Embaralha as perguntas aleatoriamente
	randomize()
	var retries = randi() % 20
	for i in retries:
		questions.shuffle()

	# Renderiza as perguntas nas caixas de texto
	for i in caixasTexto:
		i.bbcode_text = questions[phraseNum]["Resposta"]

		# Armazena a caixa de texto com a resposta correta
		if questions[phraseNum]["IsCorrect"] == "Y":
			Global.correctBoxQuiz = i

		phraseNum += 1

	return
