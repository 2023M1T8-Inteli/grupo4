extends Control

# Caminho para o arquivo de perguntas (exportado para ser acessível no editor)
export var questionPath = ""

# Referência às caixas de texto usadas para exibir as opções de resposta
onready var caixasTexto = [$Opcao1/Opcao1, $Opcao2/Opcao2]

# Armazena as perguntas lidas do arquivo
var questions = []

# Número da pergunta atual
var phraseNum = 0

func _ready():
	# Oculta o filtro do mouse na inicialização do jogo
	$MouseFilter.visible = false

# Inicia o quiz, tornando este control visível e carregando as perguntas
func startQuiz():
	self.visible = true
	questions = getQuestions()
	renderQuestions()

func _process(_delta):
	# Oculta o filtro do mouse quando o quiz é respondido
	$MouseFilter.visible = Global.quizAnswered

func getQuestions() -> Array:
	# Cria um novo arquivo
	var f = File.new()

	# Verifica se o arquivo de diálogo existe
	assert(f.file_exists(questionPath), "O caminho do arquivo não existe")

	# Abre o arquivo de perguntas e obtém seu conteúdo como texto
	f.open(questionPath, File.READ)
	var json = f.get_as_text()

	# Analisa o JSON e retorna seu conteúdo como um array
	var output = parse_json(json)

	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []

func renderQuestions() -> void:
	# Embaralha aleatoriamente as perguntas antes de renderizar
	var retries = randi() % 20
	randomize()
	for i in retries:
		questions.shuffle()

	# Renderiza as perguntas nas caixas de texto
	for i in caixasTexto:
		i.bbcode_text = "[center]"+questions[phraseNum]["Resposta"]+"[/center]"
		
		# Define a caixa de texto correta (usada para verificar a resposta do jogador)
		if questions[phraseNum]["IsCorrect"] == "Y":
			Global.correctBoxQuiz = i
		
		phraseNum += 1
		print('asd')
		
	return
