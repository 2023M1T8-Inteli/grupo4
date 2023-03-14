extends Node

# Flag que controla se o diálogo de numero 1 foi exibido ou não
var finishDialog1 = false

# Flag que controla se o personagem está bêbado ou não
var isDrunk = false


var jumpStartQuiz = true
# Flag que controla se o quiz 1 deve ser iniciado ou não
var startQuiz = false
# Variável que guarda o index da resposta correta do quiz 1
var correctBoxQuiz
# Flag que controla se a resposta selecionada no quiz 1 é correta ou não
var correctAnswerQuiz = false

# Variável que guarda o objetivo ativo, composto por uma flag e uma posição
var activeObjective = [false, Vector2(0,0)]

# Flag que controla se a tarefa de fios foi completada ou não
var amongDone = false

# Flag que controla se o jogador pode se mover ou não
var canMove = true

# Flag que controla se o personagem está se movendo ou não (controla a animação do personagem)
var moving = false
