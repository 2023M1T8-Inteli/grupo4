extends Node2D

var closeToPorta

onready var camera = $Player/Camera2D


func _ready():
	Global.canMove = true
	$Player.global_position = pos.posADM
	camera.zoom = Vector2(0.5,0.5)
	
	if AdmGlobals.currentTask == 1:
		Global.activeObjective[0] = true
		Global.activeObjective[1] = $SegInfo/NPC1/NPC1Ancora.global_position
		Global.activeObjective[2] = "Fale com a equipe de S.I"
		$SegInfo/NPC1/NPC1Botao.visible = true
		$SegInfo/NPC1/BalaoExclamacao.visible = true
		$Player.objective(true)
		
	elif AdmGlobals.currentTask == 2 or AdmGlobals.currentTask == 3:
		Global.activeObjective[0] = true
		Global.activeObjective[1] = $"Eq Compliance/NPC2 (O BOM)/NPCBomAncora".global_position
		Global.activeObjective[2] = "Fale com a Eq. de Compliance."
		$"Eq Compliance/NPC2 (O BOM)/NPCBomBotao".visible = true
		$"Eq Compliance/NPC2 (O BOM)/BalaoExclamacao".visible = true
		$Player.objective(true)

	if $"SegInfo/DialogBox 16/TexturaCaixa".connect("finish", self, "_on_SegInfo_dialog_finish") != OK:
		print("ERRO AO CONECTAR")
	if $"Eq Compliance/NPC2 (O BOM)/DialogBox 17/TexturaCaixa".connect("finish", self, "_on_eq_compliance_dialog_finish") != OK:
		print("ERRO AO CONECTAR")
	if $"Eq Compliance/NPC2 (O BOM)/DialogBox 19/TexturaCaixa".connect("finish", self, "_on_eq_compliance_dialog2_finish") != OK:
		print("ERRO AO CONECTAR")

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
	elif closeToPorta and AdmGlobals.currentTask == 1 or AdmGlobals.currentTask == 2:
		# Impede o movimento do jogador durante a transição de cena
		Global.canMove = false
		# Aguarda um curto período antes de mudar de cena, para que a animação da porta seja executada
		yield(get_tree().create_timer(0.15), "timeout")
		# Tenta mudar para a cena "Cidade.tscn", exibindo uma mensagem de erro em caso de falha		
		if get_tree().change_scene("res://Scenes/Playables/Environment/Administrativo.tscn") != OK:
			print("ERRO")
	elif closeToPorta and AdmGlobals.currentTask == 3:
		# Impede o movimento do jogador durante a transição de cena
		Global.canMove = false
		# Aguarda um curto período antes de mudar de cena, para que a animação da porta seja executada
		yield(get_tree().create_timer(0.15), "timeout")
		# Tenta mudar para a cena "Cidade.tscn", exibindo uma mensagem de erro em caso de falha		
		SceneTransition.change_scene("res://Scenes/Playables/Environment/Limbo3.tscn", 1, 1)

func _on_NPC1Botao_pressed():
	$SegInfo/NPC1/NPC1Botao.visible = false
	$SegInfo/NPC1/BalaoExclamacao.visible = false
	$"SegInfo/DialogBox 16".visible = true
	$"SegInfo/DialogBox 16/TexturaCaixa"._startDialog()
	Global.canMove = false
	Global.activeObjective[0] = false
	$map/Elevador/TextureButton.visible = true
		
func _on_SegInfo_dialog_finish():
	Global.canMove = true
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $PortaAncora.global_position
	Global.activeObjective[2] = "Volte para o setor Administrativo."
	$Player.objective(false)

func _on_eq_compliance_dialog_finish():
	Global.canMove = true
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $PortaAncora.global_position
	Global.activeObjective[2] = "Volte para o setor Administrativo."
	$Player.objective(true)
	
func _on_eq_compliance_dialog2_finish():
	Global.canMove = true
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $PortaAncora.global_position
	Global.activeObjective[2] = "Saia do prédio."
	$Player.objective(true)
	
func _on_NPCBomBotao_pressed():
	$"Eq Compliance/NPC2 (O BOM)/NPCBomBotao".visible = false
	$"Eq Compliance/NPC2 (O BOM)/BalaoExclamacao".visible = false
	if AdmGlobals.currentTask == 2:
		$"Eq Compliance/NPC2 (O BOM)/DialogBox 17".visible = true
		$"Eq Compliance/NPC2 (O BOM)/DialogBox 17/TexturaCaixa"._startDialog()
	elif AdmGlobals.currentTask == 3:
		$"Eq Compliance/NPC2 (O BOM)/DialogBox 19".visible = true
		$"Eq Compliance/NPC2 (O BOM)/DialogBox 19/TexturaCaixa"._startDialog()
	Global.canMove = false
	Global.activeObjective[0] = false
	$map/Elevador/TextureButton.visible = true
