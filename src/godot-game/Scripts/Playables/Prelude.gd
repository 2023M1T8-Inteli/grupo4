extends Node2D

# Variável que indica se o jogador está perto do poste
var closeToPoste = false

# Variáveis de controle de travamento de botões
var lockIf0 = true
var lockIf1 = true

func _ready():
	# Define que o jogador não pode se mover até que seja permitido
	Global.canMove = false
	
	# Define qual personagem deve aparecer na cena
	get_node("Player/Ze").visible = true
	get_node("Player/Fantasma").visible = false
	get_node("Player/Tereza").visible = false
	get_node("Player/Jonas").visible = false
	
	# Define um objetivo como ativo e sua posição
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $PosteCaixa/Node2D.global_position
	
	# Coloca o player na sua posição global
	$Player.global_position = pos.posPrelude

	# Define a visibilidade do prompt e do filtro de cores
	$Prompt.visible = true
	$DrunkFilter.visible = false

func _process(_delta):
	# Verifica se o jogador está perto do poste
	if $Player/HitBox.global_position.distance_to($PosteCaixa/Node2D.global_position) < 150:
		closeToPoste = true
	else:
		closeToPoste = false

func _on_posteSobeButton_pressed():
	print("pressed")
	
	# Verifica se o jogador está perto do poste e se o botão está travado
	if closeToPoste and lockIf1:
		# Impede que o jogador se mova e destrava o botão
		Global.canMove = false
		lockIf1 = false
		
		# Espera um pequeno intervalo de tempo antes de prosseguir
		yield(get_tree().create_timer(0.15), "timeout")
		
		# Define a posição de prelúdio do jogador e muda para a cena do topo do poste
		pos.posPrelude = $Player.global_position
		if get_tree().change_scene("res://Scenes/Playables/Environment/PosteCima.tscn") != OK:
			print("ERRO")

func _on_TextureButton_pressed():
	# Permite que o jogador se mova e ativa o filtro de cores
	Global.canMove = true
	Global.isDrunk = true
	
	# Esconde o prompt
	$Prompt/CanvasLayer.visible = false
	$Prompt.visible = false
	
	# Mostra o filtro de cores
	$DrunkFilter.visible = true
