extends Node

var parte

# Flag que controla se o diálogo de numero 1 foi exibido ou não
var finishDialog1 = false

# Flag que controla se o personagem está bêbado ou não
var isDrunk = false

# Flag que controla se esta e a primeira vez que o player esta jogando o jogo ou nao
var firstTime = true

var quizAnswered = false
# Variável que guarda o index da resposta correta do quiz 1
var correctBoxQuiz


# Variável que guarda o objetivo ativo, composto por uma flag e uma posição
var activeObjective = [false, Vector2(0,0), " "]

# Flag que controla se a tarefa de fios foi completada ou não
var amongDone = false

# Flag que controla se o jogador pode se mover ou não
var canMove = true

# Flag que controla se o personagem está se movendo ou não (controla a animação do personagem)
var moving = false

# Variavel que armazena playback position da musica sendo tocada
var playbackPos = 0.0

# Variavel que armazena a % de volume do jogo
var volPercentage = 100

# Variavel que armazena o volume do jogo
var volume = (volPercentage * 0.25) - 35

# Variavel que controla a visibilidade do celular no GUI
var celularVisible = false

var currentApp = "null"

var celularComplianceTask = 0
