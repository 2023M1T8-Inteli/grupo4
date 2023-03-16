extends Node2D

# Variável que indica se o jogador está perto do objeto 'ADM' (Representa a entrada do prédio)
var closeToADM = true

func _ready():
	if Global.parte == "executivo":
		# Define que o primeiro objetivo está ativo e qual é a posição do objeto 'ADM' (Representa a entrada do prédio)
		Global.activeObjective[0] = true
		Global.activeObjective[1] = $Predio/admAncora.global_position
		Global.activeObjective[2] = "Entre no predio da V.Tal"
		$Player.objective(true)
		
	elif Global.parte == "administrativo":
		# Define que o primeiro objetivo está ativo e qual é a posição do objeto 'ADM' (Representa a entrada do prédio)
		Global.activeObjective[0] = true
		Global.activeObjective[1] = $Predio/admAncora.global_position
		Global.activeObjective[2] = "Entre no predio da V.Tal"
		$Player.objective(true)
		
		
	# Verifica se o jogador tem uma posição salva na cena Cidade
	if pos.posScene == "res://Scenes/Playables/Environment/Cidade.tscn":
		# Redefine a posição atual do jogador
		$Player.global_position = pos.currentPos
		pos.posScene = null
	else:
		# Caso contrário, define a posição do jogador na cidade como a posição padrão
		$Player.global_position = pos.posCidade

	# Permite o movimento do jogador
	Global.canMove = true

func _process(_delta):
	# Verifica se o jogador está perto do objeto 'ADM' (Representa a entrada do prédio)
	if $Player/HitBox.global_position.distance_to($Predio/admAncora.global_position) < 150:
		closeToADM = true
	else:
		closeToADM = false

func _on_admButton_pressed():
	# Verifica se o jogador está perto do objeto 'ADM' (Representa a entrada do prédio)
	if closeToADM and Global.parte == "executivo":
		# Impede o movimento do jogador temporariamente
		Global.canMove = false
		# Espera um curto período de tempo antes de continuar
		yield(get_tree().create_timer(0.15), "timeout")
		# Define a posição do jogador na cidade para a posição atual do objeto 'ADM'
		pos.posCidade = $Player.global_position
		# Tenta mudar para a cena 'Administrativo'
		if get_tree().change_scene("res://Scenes/Playables/Environment/Executivo.tscn") != OK:
			print("ERRO")
	elif closeToADM and Global.parte == "administrativo":
		# Impede o movimento do jogador temporariamente
		Global.canMove = false
		# Espera um curto período de tempo antes de continuar
		yield(get_tree().create_timer(0.15), "timeout")
		# Define a posição do jogador na cidade para a posição atual do objeto 'ADM'
		pos.posCidade = $Player.global_position
		# Tenta mudar para a cena 'Administrativo'
		if get_tree().change_scene("res://Scenes/Playables/Environment/Administrativo.tscn") != OK:
			print("ERRO")

