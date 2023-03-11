# O CÓDIGO ABAIXO ESTÁ PARCIALMENTE COMENTADO, POIS NÃO ESTA IMPLEMENTADO NO JOGO AINDA E ESTEVE SERVINDO SOMENTE PARA TESTAGEM

extends Control

export var questionPath = ""

onready var caixasTexto = [$Opcao1/Opcao1, $Opcao2/Opcao2, $Opcao3/Opcao3]

var dialog = []
var questions = []

var phraseNum = 0

#var correctQuestion

func startQuiz1():
	dialog = getQuestions()
	renderQuestions()

func _process(_delta):
	if Global.startQuiz1:
		startQuiz1()
		Global.startQuiz1 = false

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
	questions.append(dialog[4])
	questions.append(dialog[5])
	questions.append(dialog[6])
	for i in caixasTexto:
		i.bbcode_text = questions[phraseNum]["Resposta"]
		print(questions[phraseNum]["Resposta"])
		if questions[phraseNum]["IsCorrect"] == "Y":
			Global.correctBoxQuiz1 = i
			print(Global.correctBoxQuiz1)
		phraseNum += 1

	return
