# O CÓDIGO ABAIXO ESTÁ PARCIALMENTE COMENTADO, POIS NÃO ESTA IMPLEMENTADO NO JOGO AINDA E ESTEVE SERVINDO SOMENTE PARA TESTAGEM

extends Control

export var questionPath = ""


onready var caixasTexto = [$Opcao1/Opcao1, $Opcao2/Opcao2, $Opcao3/Opcao3]

var questions = []

var phraseNum = 0

func _ready():
	$MouseFilter.visible = false

func startQuiz():
	self.visible = true
	questions = getQuestions()
	renderQuestions()

func _process(_delta):
	$MouseFilter.visible = Global.quizAnswered
func getQuestions() -> Array:
	# Cria um novo arquivo
	var f = File.new()

	# Verifica se o arquivo de diálogo existe
	assert(f.file_exists(questionPath), "File path does not exist")

	# Abre o arquivo de diálogo e obtém seu conteúdo como texto
	f.open(questionPath, File.READ)
	var json = f.get_as_text()

	# Analisa o JSON e retorna seu conteúdo como um array
	var output = parse_json(json)

	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []
		
func renderQuestions() -> void:
	var retries = randi() % 20
	randomize()
	for i in retries:
		questions.shuffle()
	
	for i in caixasTexto:
		i.bbcode_text = "[center]"+questions[phraseNum]["Resposta"]+"[/center]"
		if questions[phraseNum]["IsCorrect"] == "Y":
			Global.correctBoxQuiz = i
		phraseNum += 1
		print('asd')
	return
