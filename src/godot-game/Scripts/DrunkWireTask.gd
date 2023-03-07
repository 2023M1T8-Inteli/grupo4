# Estende a classe CanvasLayer, que é uma classe especial que é exibida sobre as outras camadas na tela.
extends CanvasLayer

# Declaração de variáveis globais que armazenam os botões de cada cor e seus respectivos fios, bem como o sinal para indicar que o objetivo foi concluído.
# O identificador onready é usado para inicializar as variáveis assim que o script é iniciado.
onready var blueButtons = [$blueWire/blueYellowButton, $blueWire/blueBlueButton, $blueWire/bluePurpleButton, $blueWire/blueRedButton]
onready var redButtons = [$redWire/redYellowButton, $redWire/redBlueButton, $redWire/redPurpleButton, $redWire/redRedButton]
onready var yellowButtons = [$yellowWire/yellowYellowButton, $yellowWire/yellowBlueButton, $yellowWire/yellowPurpleButton, $yellowWire/yellowRedButton]
onready var purpleButtons = [$purpleWire/purpleYellowButton, $purpleWire/purpleBlueButton, $purpleWire/purplePurpleButton, $purpleWire/purpleRedButton]


onready var blueWires = [$blueWire/blueToYellow, $blueWire/blueToBlue, $blueWire/blueToPurple, $blueWire/blueToRed]
onready var redWires = [$redWire/redToYellow, $redWire/redToBlue, $redWire/redToPurple, $redWire/redToRed]
onready var yellowWires = [$yellowWire/yellowToYellow, $yellowWire/yellowToBlue, $yellowWire/yellowToPurple, $yellowWire/yellowToRed]
onready var purpleWires = [$purpleWire/purpleToYellow, $purpleWire/purpleToBlue, $purpleWire/purpleToPurple, $purpleWire/purpleToRed]

onready var sprites = [$DrunkRect/BigSpark, $DrunkRect/BigSpark2, $DrunkRect/BigSpark3, $DrunkRect/BigSpark4, $DrunkRect/SmallSpark, $DrunkRect/SmallSpark2, $DrunkRect/SmallSpark3, $DrunkRect/SmallSpark4, $DrunkRect/SmallSpark5, $DrunkRect/SmallSpark6, $DrunkRect/SmallSpark7]

# Criando o sinal que representa quando a task foi completada
signal task_complete

# Variáveis que guardam o estado da interação do usuário com os botões.
var blueCorrect = false
var redCorrect = false
var purpleCorrect = false
var yellowCorrect = false
var alpha

func _ready():
	$DrunkRect/AnimationPlayer.play("flash")
	$Timer.start()

func _on_Timer_timeout():
	for sprite in sprites:
		alpha = rand_range(0, 150) / 255.0
		sprite.modulate.a = alpha
	$Timer.start()

# Função que é chamada a cada quadro do jogo, verificando se o objetivo foi alcançado.
func _process(_delta):
	
	if blueCorrect == true and redCorrect == true and purpleCorrect == true and yellowCorrect == true:
		emit_signal("task_complete")
		# Define como visível o retângulo verde que mostra ao usuário que a task foi feita com sucesso.
		$ColorRect.visible = true
		# Redefine o estado das variaveis que guardam o estado da da interação do usuário com os botões.
		blueCorrect = false
		redCorrect = false
		purpleCorrect = false
		yellowCorrect = false
	

# Funções que são chamadas ao clicar nos botões correspondentes.
func _on_blueButton_pressed():
	# Desativa o filtro de mouse dos botões azuis.
	for i in blueButtons:
		i.mouse_filter = Control.MOUSE_FILTER_STOP
	# Ignora o clique nos outros botões.
	for i in redButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for i in yellowButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for i in purpleButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
func _on_redButton_pressed():
	# Ignora o clique nos outros botões.
	for i in blueButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	# Desativa o filtro de mouse dos botões vermelhos.
	for i in redButtons:
		i.mouse_filter = Control.MOUSE_FILTER_STOP
	# Ignora o clique nos outros botões.
	for i in yellowButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for i in purpleButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
func _on_yellowButton_pressed():
	# Ignora o clique nos outros botões.
	for i in blueButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for i in redButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	# Desativa o filtro de mouse dos botões amarelos.
	for i in yellowButtons:
		i.mouse_filter = Control.MOUSE_FILTER_STOP
	# Ignora o clique nos outros botões.
	for i in purpleButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
func _on_purpleButton_pressed():
	# Ignora o clique nos outros botões.
	for i in blueButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for i in redButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for i in yellowButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	# Desativa o filtro de mouse dos botões roxos.
	for i in purpleButtons:
		i.mouse_filter = Control.MOUSE_FILTER_STOP



# Função chamada quando o botão blueYellowButton é pressionado
func _on_blueYellowButton_pressed():
	# Oculta todos os fios azuis
	for i in blueWires:
		i.visible = false
	# Mostra o fio azul que vai para o amarelo
	$blueWire/blueToYellow.visible = true

# Função chamada quando o botão blueBlueButton é pressionado
func _on_blueBlueButton_pressed():
	# Oculta todos os fios azuis
	for i in blueWires:
		i.visible = false
	# Mostra o fio azul que vai para o azul
	$blueWire/blueToBlue.visible = true
	# Define que a resposta azul está correta
	blueCorrect = true
	
	# Desabilita os botões azuis e o botão que conecta o fio azul
	for i in blueButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$blueWire/blueButton.mouse_filter = Control.MOUSE_FILTER_IGNORE
		
# Função chamada quando o botão blueRedButton é pressionado
func _on_blueRedButton_pressed():
	# Oculta todos os fios azuis
	for i in blueWires:
		i.visible = false
	# Mostra o fio azul que vai para o vermelho
	$blueWire/blueToRed.visible = true

# Função chamada quando o botão bluePurpleButton é pressionado
func _on_bluePurpleButton_pressed():
	# Oculta todos os fios azuis
	for i in blueWires:
		i.visible = false
	# Mostra o fio azul que vai para o roxo
	$blueWire/blueToPurple.visible = true

# Função chamada quando o botão redPurpleButton é pressionado
func _on_redPurpleButton_pressed():
	# Oculta todos os fios vermelhos
	for i in redWires:
		i.visible = false
	# Mostra o fio vermelho que vai para o roxo
	$redWire/redToPurple.visible = true

# Função chamada quando o botão redRedButton é pressionado
func _on_redRedButton_pressed():
	# Oculta todos os fios vermelhos
	for i in redWires:
		i.visible = false
	# Mostra o fio vermelho que vai para o vermelho
	$redWire/redToRed.visible = true
	# Define que a resposta vermelha está correta
	redCorrect = true
	
	# Desabilita os botões vermelhos e o botão que conecta o fio vermelho
	for i in redButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$redWire/redButton.mouse_filter = Control.MOUSE_FILTER_IGNORE

# Função chamada quando o botão redBlueButton é pressionado
func _on_redBlueButton_pressed():
	# Oculta todos os fios vermelhos
	for i in redWires:
		i.visible = false
	# Mostra o fio vermelho que vai para o azul
	$redWire/redToBlue.visible = true

func _on_redYellowButton_pressed():
	# Oculta todos os fios vermelhos
	for i in redWires:
		i.visible = false
	# Mostra o fio vermelho que vai para o azul
	$redWire/redToYellow.visible = true

# Função chamada quando o botão yellowYellowButton é pressionado
func _on_yellowYellowButton_pressed():
	# Oculta todos os fios amarelos
	for i in yellowWires:
		i.visible = false
	# Mostra o fio amarelo que vai para o amarelo
	$yellowWire/yellowToYellow.visible = true
	# Define que a resposta amarela está correta
	yellowCorrect = true
	
	# Desabilita os botões amarelos e o botão que conecta o fio amarelo
	for i in yellowButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$yellowWire/yellowButton.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
# Função chamada quando o botão yellowBlueButton é pressionado
func _on_yellowBlueButton_pressed():
	# Oculta todos os fios amarelos
	for i in yellowWires:
		i.visible = false
	# Mostra o fio amarelo que vai para o azul
	$yellowWire/yellowToBlue.visible = true
	
# Função chamada quando o botão yellowRedButton é pressionado
func _on_yellowRedButton_pressed():
	# Oculta todos os fios amarelos
	for i in yellowWires:
		i.visible = false
	# Mostra o fio amarelo que vai para o vermelho
	$yellowWire/yellowToRed.visible = true
	
# Função chamada quando o botão yellowPurpleButton é pressionado
func _on_yellowPurpleButton_pressed():
	# Oculta todos os fios amarelos
	for i in yellowWires:
		i.visible = false
	# Mostra o fio amarelo que vai para o roxo
	$yellowWire/yellowToPurple.visible = true

# Função chamada quando o botão purpleYellowButton é pressionado
func _on_purpleYellowButton_pressed():
	# Oculta todos os fios roxos
	for i in purpleWires:
		i.visible = false
	# Mostra o fio roxo que vai para o amarelo
	$purpleWire/purpleToYellow.visible = true
	
# Função chamada quando o botão purpleRedButton é pressionado
func _on_purpleRedButton_pressed():
	# Oculta todos os fios roxos
	for i in purpleWires:
		i.visible = false
	# Mostra o fio roxo que vai para o vermelho
	$purpleWire/purpleToRed.visible = true
	
# Função chamada quando o botão purpleBlueButton é pressionado
func _on_purpleBlueButton_pressed():
	# Oculta todos os fios roxos
	for i in purpleWires:
		i.visible = false
	# Mostra o fio roxo que vai para o azul
	$purpleWire/purpleToBlue.visible = true
	
# Função chamada quando o botão purplePurpleButton é pressionado
func _on_purplePurpleButton_pressed():
	# Oculta todos os fios roxos
	for i in purpleWires:
		i.visible = false
	# Mostra o fio roxo que vai para o roxo
	$purpleWire/purpleToPurple.visible = true
	# Define que a resposta roxa está correta
	purpleCorrect = true
	
	# Desabilita os botões roxos e o botão que conecta o fio roxo
	for i in purpleButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$purpleWire/purpleButton.mouse_filter = Control.MOUSE_FILTER_IGNORE

