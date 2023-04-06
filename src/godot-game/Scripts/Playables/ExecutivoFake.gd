# Declaração da classe que extende Node2D
extends Node2D

# Variável global closeToPorta
var closeToPorta

# Variável onready que armazena a câmera
onready var camera = $Player/Camera2D

# Função _ready é executada ao iniciar o jogo
func _ready():
	# Define a variável global canMove como verdadeira
	Global.canMove = true
	# Define a posição global do jogador como a posição da variável posADM
	$Player.global_position = pos.posADM
	# Define o zoom da câmera em 0.5,0.5
	camera.zoom = Vector2(0.5,0.5)
	
	# Verifica o valor da variável global currentTask
	if AdmGlobals.currentTask == 1:
		# Define o primeiro objetivo como ativo
		Global.activeObjective[0] = true
		# Define a posição do segundo objetivo como a posição global do NPC1Ancora
		Global.activeObjective[1] = $SegInfo/NPC1/NPC1Ancora.global_position
		# Define a descrição do segundo objetivo
		Global.activeObjective[2] = "Fale com a equipe de S.I"
		# Torna o botão do NPC1 visível
		$SegInfo/NPC1/NPC1Botao.visible = true
		# Torna o balão de exclamação do NPC1 visível
		$SegInfo/NPC1/BalaoExclamacao.visible = true
		# Chama a função objective do jogador
		$Player.objective(true)

	
	# Conecta o sinal finish da TexturaCaixa do DialogBox 16 à função _on_SegInfo_dialog_finish
	if $"SegInfo/DialogBox 16/TexturaCaixa".connect("finish", self, "_on_SegInfo_dialog_finish") != OK:
		print("ERRO AO CONECTAR")

func _process(_delta):
	# Define os limites da câmera para o tamanho do mapa
	camera.limit_left = 0
	camera.limit_top = 0
	camera.limit_right = 576
	camera.limit_bottom = 640
	
	# Verifica se o jogador está próximo da porta
	if $Player/HitBox.global_position.distance_to($PortaAncora.global_position) < 40:
		closeToPorta = true
	else:
		closeToPorta = false

func _on_TextureButton_pressed():
	# Verifica se o jogador está próximo da porta e se a tarefa atual é igual a 1 ou 2
	if closeToPorta and AdmGlobals.currentTask == 2:
		# Impede o movimento do jogador durante a transição de cena
		Global.canMove = false
		# Aguarda um curto período antes de mudar de cena, para que a animação da porta seja executada
		yield(get_tree().create_timer(0.15), "timeout")
		# Tenta mudar para a cena "Cidade.tscn", exibindo uma mensagem de erro em caso de falha		
		if get_tree().change_scene("res://Scenes/Playables/Environment/Administrativo.tscn") != OK:
			print("ERRO")


func _on_NPC1Botao_pressed():
	# Esconde o botão e o balão de exclamação do NPC1
	$SegInfo/NPC1/NPC1Botao.visible = false
	$SegInfo/NPC1/BalaoExclamacao.visible = false
	
	# Exibe a caixa de diálogo apropriada
	$"SegInfo/DialogBox 16".visible = true
	
	# Inicia a caixa de diálogo
	$"SegInfo/DialogBox 16/TexturaCaixa"._startDialog()
	
	# Impede o movimento do jogador
	Global.canMove = false
	
	# Define que a primeira tarefa foi concluída
	Global.activeObjective[0] = false
	
	# Exibe o botão do elevador no mapa
	$map/Elevador/TextureButton.visible = true
		
# Esta função é chamada quando o jogador conclui a tarefa relacionada ao diálogo do "SegInfo".
func _on_SegInfo_dialog_finish():
	# Habilita a movimentação do jogador novamente.
	Global.canMove = true
	# Define que a primeira tarefa está concluída.
	Global.activeObjective[0] = true
	# Define a posição do objetivo seguinte.
	Global.activeObjective[1] = $PortaAncora.global_position
	# Define a descrição do objetivo seguinte.
	Global.activeObjective[2] = "Volte para o setor Administrativo."
	# Atualiza o objetivo do jogador no HUD.
	$Player.objective(false)
	
	AdmGlobals.currentTask = 2

