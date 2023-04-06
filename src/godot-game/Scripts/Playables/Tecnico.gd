extends Node2D

func _ready():
	Global.celularVisible = false
	# Ativa a movimentacao do player
	Global.canMove = true
	
	# Coloca o player na sua posição global
	$Player.global_position = pos.posTecnico
	
	# Caso a task seja 0, inicia a task0, animacao de reuniao
	if TecGlobals.currentTask == 0:
		$Task0TEC.reuniaoAnim()

	
func _process(_delta):
	# Define a visibilidade das tasks do Tecnico dependendo dos valores da variavel global controladora de taks
	$Task0TEC.visible = true if (TecGlobals.currentTask <= 2) else false
	$Task1TEC.visible = true if (TecGlobals.currentTask >= 1) else false
	$Task2TEC.visible = true if (TecGlobals.currentTask >= 2) else false
	$Task3TEC.visible = true if (TecGlobals.currentTask >= 3) else false
	$Task4TEC.visible = true if (TecGlobals.currentTask >= 4) else false

