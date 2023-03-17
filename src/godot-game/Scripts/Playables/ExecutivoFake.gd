extends Node2D

var closeToPorta

onready var camera = $Player/Camera2D


func _ready():
	Global.canMove = true
	$Player.global_position = pos.posADM
	camera.zoom = Vector2(0.5,0.5)
	
	
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $SegInfo/NPC1/NPC1Ancora.global_position
	Global.activeObjective[2] = "Fale com a equipe de S.I"
	$Player.objective(true)
	
	$"SegInfo/DialogBox 16/TexturaCaixa".connect("finish", self, "_on_SegInfo_dialog_finish")

func _process(_delta):
	# Define os limites da câmera para o tamanho do mapa
	camera.limit_left = 0
	camera.limit_top = 0
	camera.limit_right = 576
	camera.limit_bottom = 640
	
	if $Player/HitBox.global_position.distance_to($PortaAncora.global_position) < 40:
		closeToPorta = true
	else:
		closeToPorta = false

func _on_TextureButton_pressed():
	# Verifica se o jogador está perto da porta
	if closeToPorta and AdmGlobals.currentTask == 0:
		# Impede o movimento do jogador durante a transição de cena
		Global.canMove = false
		# Aguarda um curto período antes de mudar de cena, para que a animação da porta seja executada
		yield(get_tree().create_timer(0.15), "timeout")
		# Tenta mudar para a cena "Cidade.tscn", exibindo uma mensagem de erro em caso de falha		
		if get_tree().change_scene("res://Scenes/Playables/Environment/Cidade.tscn") != OK:
			print("ERRO")
	elif closeToPorta and AdmGlobals.currentTask == 1:
		# Impede o movimento do jogador durante a transição de cena
		Global.canMove = false
		# Aguarda um curto período antes de mudar de cena, para que a animação da porta seja executada
		yield(get_tree().create_timer(0.15), "timeout")
		# Tenta mudar para a cena "Cidade.tscn", exibindo uma mensagem de erro em caso de falha		
		if get_tree().change_scene("res://Scenes/Playables/Environment/Administrativo.tscn") != OK:
			print("ERRO")


func _on_NPC1Botao_pressed():
	$SegInfo/NPC1/NPC1Botao.visible = false
	$SegInfo/NPC1/BalaoExclamacao.visible = false
	$"SegInfo/DialogBox 16".visible = true
	$"SegInfo/DialogBox 16/TexturaCaixa"._startDialog()
	Global.canMove = false
	Global.activeObjective[0] = false
	
func _on_SegInfo_dialog_finish():
	Global.canMove = true
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $PortaAncora.global_position
	Global.activeObjective[2] = "Volte para o setor Administrativo"
	$Player.objective(false)
