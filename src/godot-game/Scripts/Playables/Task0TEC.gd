extends Control

# Variáveis onready são inicializadas quando o nó pai é carregado
onready var pai = get_parent()
onready var player = get_parent().get_node("Player")

func _ready():
	# Verifica se a tarefa atual é a número 1
	if TecGlobals.currentTask == 1:
		# Esconde os nós Node2D e NPCBoss
		$Node2D.visible = false
		$NPCBoss.visible = false

# Função responsável por executar animação de reunião
func reuniaoAnim():
	# Conecta o sinal "finish" da TexturaCaixa ao método on_dialog_finish desta cena
	if $"DialogBox 9/TexturaCaixa".connect("finish", self, "on_dialog_finish") != OK:
		# Se não for possível conectar, exibe uma mensagem de erro
		print("ERRO AO CONECTAR TEXTURACAIXA")
	
	# Impede o jogador de se mover durante a reunião
	Global.canMove = false
	
	# Desativa a câmera do jogador e ativa a câmera da cena da reunião
	player.get_node("Camera2D").current = false
	$Camera2D.current = true
	
	# Exibe a caixa de diálogo e inicia a animação
	$"DialogBox 9".visible = true
	$"DialogBox 9/TexturaCaixa"._startDialog()
	
# Método chamado quando a caixa de diálogo é finalizada
func on_dialog_finish():
	# Aguarda 0.3 segundos
	yield(get_tree().create_timer(.3), "timeout")
	
	# Executa a animação de movimentação da câmera
	$AnimationPlayer.play("cameraMove")
	
	# Aguarda o término da animação
	yield($AnimationPlayer, "animation_finished")
	
	# Esconde os nós Node2D e NPCBoss
	$Node2D.visible = false
	$NPCBoss.visible = false
	
	# Ativa a câmera do jogador e desativa a câmera da cena da reunião
	player.get_node("Camera2D").current = true
	$Camera2D.current = false
	
	# Permite que o jogador se mova novamente
	Global.canMove = true
	
	# Atualiza a tarefa atual para a número 1
	TecGlobals.currentTask = 1
	
	# Define o objetivo atual como falar com os colegas
	Global.activeObjective[0] = true
	Global.activeObjective[1] = self.get_parent().get_node("Task1TEC/Position2D").global_position
	Global.activeObjective[2] = "Fale com seus colegas."
	
	# Exibe a indicação do objetivo na tela do jogador
	self.get_parent().get_node("Player").objective(true)
