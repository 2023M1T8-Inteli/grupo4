# Estende a classe CanvasLayer, que é uma classe especial que é exibida sobre as outras camadas na tela.
extends CanvasLayer


var blueSelect = false
var greenSelect = false
var yellowSelect = false
var pinkSelect = false

var bluePoint = Vector2(285, 167)
var greenPoint = Vector2(283, -77)
var yellowPoint = Vector2(282, 4)
var pinkPoint = Vector2(284, 85)

# Variáveis que guardam o estado da interação do usuário com os botões.
var blueCorrect = false
var greenCorrect = false
var yellowCorrect = false
var pinkCorrect = false

var bluePlaced = false
var greenPlaced = false
var yellowPlaced = false
var pinkPlaced = false

var touch_position

# Função que é chamada a cada quadro do jogo, verificando se o objetivo foi alcançado.
func _process(_delta):
	if blueSelect or bluePlaced or blueCorrect:
		$blueWire.visible = true
	else:
		$blueWire.visible = false


	if greenSelect or greenPlaced or greenCorrect:
		$greenWire.visible = true
	else:
		$greenWire.visible = false

	if yellowSelect or yellowPlaced or yellowCorrect:
		$yellowWire.visible = true
	else:
		$yellowWire.visible = false

	if pinkSelect or pinkPlaced or pinkCorrect:
		$pinkWire.visible = true
	else:
		$pinkWire.visible = false
	
	
	if blueCorrect == true and greenCorrect == true and yellowCorrect == true and pinkCorrect == true:
		Global.amongDone = true
		# Define como visível o retângulo verde que mostra ao usuário que a task foi feita com sucesso.
		$ColorRect.visible = true
		# Redefine o estado das variaveis que guardam o estado da da interação do usuário com os botões.
		blueCorrect = false
		pinkCorrect = false
		greenCorrect = false
		yellowCorrect = false

	
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
	# BLUE PART
	# ---------
	
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
		
		
		
	# ---------
	# GREEN PART
	# ---------
		
		
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
	# YELLOW PART
	# ---------
	
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
	# PINK PART
	# ---------
	
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
