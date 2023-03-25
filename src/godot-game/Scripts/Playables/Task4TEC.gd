extends Control

func _ready():
	# Verifica se a tarefa atual é a número 4
	if TecGlobals.currentTask == 4:
		# Habilita o colisor da área e define a primeira
		# parte do objetivo como concluída
		$Area2D/CollisionShape2D.disabled = false
		Global.activeObjective[0] = true
		# Armazena a posição do segundo objetivo
		Global.activeObjective[1] = get_parent().get_node("Task4TEC/Position2D").global_position
		# Define a mensagem do segundo objetivo
		Global.activeObjective[2] = "O chefe quer falar com você!"
		# Ativa o objetivo na interface do jogador
		get_parent().get_node("Player").objective(true)
		
		# Conecta o sinal "finish" do diálogo à função
		# "on_dialog_finish" para mudar de cena quando o
		# diálogo terminar
		if $"DialogBox 25/TexturaCaixa".connect("finish", self, "on_dialog_finish") != OK:
			print("ERRO AO CONECTAR")

func _on_Area2D_body_entered(body):
	# Verifica se o corpo que entrou na área é o jogador
	if body == get_parent().get_node("Player"):
		# Define a primeira parte do objetivo como não concluída
		Global.activeObjective[0] = false
		# Impede que o jogador se mova
		Global.canMove = false
		# Exibe a caixa de diálogo e inicia o diálogo
		$"DialogBox 25".visible = true
		$"DialogBox 25/TexturaCaixa"._startDialog()

func on_dialog_finish():
	# Muda para a cena "Limbo4.tscn" quando o diálogo terminar
	SceneTransition.change_scene("res://Scenes/Playables/Environment/Limbo4.tscn", 1, 1)
