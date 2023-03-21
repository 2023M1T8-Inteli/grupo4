extends Node2D

# Variável que indica se o jogador está perto do poste
var closeToPoste = false

# Variáveis de controle de travamento de botões
var lockIf0 = true
var lockIf1 = true

func _ready():
	Global.canMove = true
	
	# Define um objetivo como ativo e sua posição
	#Global.activeObjective[0] = true
	#Global.activeObjective[1] = $PosteCaixa/Node2D.global_position
	#Global.activeObjective[2] = "Vá até o poste instalar a fibra!"
	
	# Coloca o player na sua posição global
	$Player.global_position = pos.posPrelude

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
