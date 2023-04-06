extends CanvasLayer

# Define o sinal que dita quando a task foi feita
signal finished
signal prompt_pressed

var deadbolt = true

# Define as variáveis iniciais para os botões selecionados.
var blueSelect = false
var greenSelect = false
var yellowSelect = false
var pinkSelect = false

# Define as posições iniciais dos botões e da linha.
var bluePoint = Vector2(285, 167)
var greenPoint = Vector2(283, -77)
var yellowPoint = Vector2(282, 4)
var pinkPoint = Vector2(284, 85)

# Define as variáveis que armazenam o estado da interação do usuário com os botões.
var blueCorrect = false
var greenCorrect = false
var yellowCorrect = false
var pinkCorrect = false

# Define as variáveis que armazenam se os botões foram colocados corretamente.
var bluePlaced = false
var greenPlaced = false
var yellowPlaced = false
var pinkPlaced = false

# Define a posição do toque do usuário.
var touch_position


# Função que é chamada a cada quadro do jogo, verificando se o objetivo foi alcançado.
func _process(_delta):
	# Verifica se o botão azul está selecionado, colocado ou correto.
	if blueSelect or bluePlaced or blueCorrect:
		# Define a visibilidade do fio azul como verdadeira.
		$blueWire.visible = true
	else:
		# Define a visibilidade do fio azul como falsa.
		$blueWire.visible = false

	# Verifica se o botão verde está selecionado, colocado ou correto.
	if greenSelect or greenPlaced or greenCorrect:
		# Define a visibilidade do fio verde como verdadeira.
		$greenWire.visible = true
	else:
		# Define a visibilidade do fio verde como falsa.
		$greenWire.visible = false

	# Verifica se o botão amarelo está selecionado, colocado ou correto.
	if yellowSelect or yellowPlaced or yellowCorrect:
		# Define a visibilidade do fio amarelo como verdadeira.
		$yellowWire.visible = true
	else:
		# Define a visibilidade do fio amarelo como falsa.
		$yellowWire.visible = false

	# Verifica se o botão rosa está selecionado, colocado ou correto.
	if pinkSelect or pinkPlaced or pinkCorrect:
		# Define a visibilidade do fio rosa como verdadeira.
		$pinkWire.visible = true
	else:
		# Define a visibilidade do fio rosa como falsa.
		$pinkWire.visible = false

	# Verifica se os quatro botões estão corretamente posicionados.
	if blueCorrect == true and greenCorrect == true and yellowCorrect == true and pinkCorrect == true and deadbolt:
		deadbolt = false
		# Define que a tarefa foi concluída com sucesso.
		Global.amongDone = true
		# Define como visível o retângulo verde que mostra ao usuário que a tarefa foi concluída com sucesso.
		$ColorRect.visible = true
		# Emite o sinal que dita quando a task foi completada
		emit_signal("finished")
		# Redefine o estado das variáveis que armazenam o estado da interação do usuário com os botões.
		blueCorrect = false
		pinkCorrect = false
		greenCorrect = false
		yellowCorrect = false


	# Verifica se o usuário pressionou a tela.
	if Input.is_action_pressed("touch"):
		touch_position = get_viewport().get_mouse_position()

		if blueSelect:
			$blueWire.points[1] = Vector2(touch_position.x-$blueWire.position.x,touch_position.y-$blueWire.position.y)
		if greenSelect:
			$greenWire.points[1] = Vector2(touch_position.x-$greenWire.position.x,touch_position.y-$greenWire.position.y)
		if yellowSelect:
			$yellowWire.points[1] = Vector2(touch_position.x-$yellowWire.position.x,touch_position.y-$yellowWire.position.y)
		if pinkSelect:
			$pinkWire.points[1] = Vector2(touch_position.x-$pinkWire.position.x,touch_position.y-$pinkWire.position.y)
	
	
# ---------
# PARTE AZUL
# ---------

# O código abaixo verifica se o ponto final do fio azul está próximo de um dos pontos de conexão
# Se estiver, o fio é reposicionado no ponto de conexão, o botão azul fica invisível e a variável blueCorrect é definida como verdadeira.
# Caso não estiver correto, o fio e reposicionado no ponto de conexão.

	if $blueWire.points[1].distance_to(greenPoint) < 50 and blueSelect == false:
		$blueWire.points[1] = greenPoint
		bluePlaced = true
	if $blueWire.points[1].distance_to(yellowPoint) < 50 and blueSelect == false:
		$blueWire.points[1] = yellowPoint
		bluePlaced = true
	if $blueWire.points[1].distance_to(pinkPoint) < 50 and blueSelect == false:
		$blueWire.points[1] = pinkPoint
		bluePlaced = true
	if $blueWire.points[1].distance_to(bluePoint) < 50 and blueSelect == false:
		$blueWire.points[1] = bluePoint
		$blueButton.visible = false
		blueCorrect = true
		
		
		
# ------------
# PARTE VERDE
# ------------

# O código abaixo verifica se o ponto final do fio verde está próximo de um dos pontos de conexão
# Se estiver, o fio é reposicionado no ponto de conexão, o botão verde fica invisível e a variável greenCorrect é definida como verdadeira.
# Caso não estiver correto, o fio e reposicionado no ponto de conexão.

	if $greenWire.points[1].distance_to(bluePoint) < 50 and greenSelect == false:
		$greenWire.points[1] = bluePoint
		greenPlaced = true
	if $greenWire.points[1].distance_to(yellowPoint) < 50 and greenSelect == false:
		$greenWire.points[1] = yellowPoint
		greenPlaced = true
	if $greenWire.points[1].distance_to(pinkPoint) < 50 and greenSelect == false:
		$greenWire.points[1] = pinkPoint
		greenPlaced = true
	if $greenWire.points[1].distance_to(greenPoint) < 50 and greenSelect == false:
		$greenWire.points[1] = greenPoint
		$greenButton.visible = false
		greenCorrect = true



# ---------
# PARTE AMARELA
# ---------
	
# O código abaixo verifica se o ponto final do fio amarelo está próximo de um dos pontos de conexão
# Se estiver correto, o fio é reposicionado no ponto de conexão, o botão amarelo fica invisível e a variável yellowCorrect é definida como verdadeira.
# Caso não estiver correto, o fio e reposicionado no ponto de conexão.
	
	if $yellowWire.points[1].distance_to(greenPoint) < 50 and yellowSelect == false:
		$yellowWire.points[1] = greenPoint
		yellowPlaced = true
	if $yellowWire.points[1].distance_to(bluePoint) < 50 and yellowSelect == false:
		$yellowWire.points[1] = bluePoint
		yellowPlaced = true
	if $yellowWire.points[1].distance_to(pinkPoint) < 50 and yellowSelect == false:
		$yellowWire.points[1] = pinkPoint
		yellowPlaced = true
	if $yellowWire.points[1].distance_to(yellowPoint) < 50 and yellowSelect == false:
		$yellowWire.points[1] = yellowPoint
		$yellowButton.visible = false
		yellowCorrect = true
		
		
		
# ---------
# PARTE ROSA
# ---------

# O código abaixo verifica se o ponto final do fio rosa está próximo de um dos pontos de conexão
# Se estiver, o fio é reposicionado no ponto de conexão, o botão rosa fica invisível e a variável pinkCorrect é definida como verdadeira.
# Caso não estiver correto, o fio e reposicionado no ponto de conexão.

	if $pinkWire.points[1].distance_to(greenPoint) < 50 and pinkSelect == false:
		$pinkWire.points[1] = greenPoint
		pinkPlaced = true
	if $pinkWire.points[1].distance_to(bluePoint) < 50 and pinkSelect == false:
		$pinkWire.points[1] = bluePoint
		pinkPlaced = true
	if $pinkWire.points[1].distance_to(yellowPoint) < 50 and pinkSelect == false:
		$pinkWire.points[1] = yellowPoint
		pinkPlaced = true
	if $pinkWire.points[1].distance_to(pinkPoint) < 50 and pinkSelect == false:
		$pinkWire.points[1] = pinkPoint
		$pinkButton.visible = false
		pinkCorrect = true



# As funções abaixo tratam dos eventos de clique dos botões coloridos.
# Quando o botão é pressionado, a variável correspondente ao botão é marcada como selecionada e uma mensagem é exibida no console.
# Quando o botão é solto, se a seleção estiver correta, nada acontece.
# Caso contrário, a variável de seleção é desmarcada.

func _on_blueButton_button_down():
	blueSelect = true
	print("blue selected")
func _on_blueButton_button_up():
	if blueCorrect:
		pass
	else:
		blueSelect = false

func _on_greenButton_button_down():
	greenSelect = true
	print("green selected")
func _on_greenButton_button_up():
	if greenCorrect:
		pass
	else:
		greenSelect = false

func _on_yellowButton_button_down():
	yellowSelect = true
	print("yellow selected")
func _on_yellowButton_button_up():
	if yellowCorrect:
		pass
	else:
		yellowSelect = false

func _on_pinkButton_button_down():
	pinkSelect = true
	print("pink selected")
func _on_pinkButton_button_up():
	if pinkCorrect:
		pass
	else:
		pinkSelect = false



# Esta função é responsável por ocultar a caixa de diálogo de prompt quando o botão de textura é pressionado.
func _on_TextureButton_pressed():
	$Prompt.visible = false
	emit_signal("prompt_pressed")
