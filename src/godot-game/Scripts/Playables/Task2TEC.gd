extends Control

# Quando o botão da tela for pressionado
func _on_TouchScreenButton_pressed():
	# Verifica se o jogador está perto do objeto Position2D
	if get_parent().get_node("Player").global_position.distance_to($Position2D.global_position) < 100:
		# Define a variável global como false e muda de cena
		Global.canMove = false
		SceneTransition.change_scene("res://Scenes/Playables/Environment/Apartamento.tscn", 1, 1)
		# Define a posição técnica como a posição do jogador
		pos.posTecnico = get_parent().get_node("Player").global_position

func _ready():
	# Define a posição global do jogador como a posição técnica
	get_parent().get_node("Player").global_position = pos.posTecnico
	
	# Se a tarefa atual for 2
	if TecGlobals.currentTask == 2:
		# Rotaciona o objeto Caminhão e ativa a visibilidade dos objetos Balão e Botão de tela
		$Caminhao.rotation = -180
		$BalaoObj.visible = true
		$Caminhao/TouchScreenButton.visible = true
		
	# Se a tarefa atual for 3
	elif TecGlobals.currentTask == 3:
		# Ativa a visibilidade deste objeto, desativa a visibilidade do objeto Balão e Botão de tela
		self.visible = true
		$Caminhao.rotation = 0
		$BalaoObj.visible = false
		$Caminhao/TouchScreenButton.visible = false
		
		# Define o objetivo ativo como true e define sua posição e descrição
		Global.activeObjective[0] = true
		Global.activeObjective[1] = self.get_parent().get_node("Task3TEC/Position2D").global_position
		Global.activeObjective[2] = "Se prepare para subir no poste!"
		get_parent().get_node("Player").objective(true)

# A cada frame, verifica se o objeto CollisionShape2D está desativado
func _process(_delta):
	$StaticBody2D/CollisionShape2D.disabled = not self.visible
