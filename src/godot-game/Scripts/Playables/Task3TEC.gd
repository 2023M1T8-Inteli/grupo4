extends Control

func _ready():
	# Verifica se a tarefa atual é a número 4.
	if TecGlobals.currentTask == 4:
		# Se for, desativa o objetivo ativo.
		Global.activeObjective[0] = false
		
		# Esconde o balão e o botão de subir no poste.
		$BalaoPoste.visible = false
		$posteSobeButton.visible = false
		
	# Conecta o sinal "finish" da checklist com a função "on_checklist_finish".
	# Caso ocorra algum erro na conexão, imprime uma mensagem de erro.
	if $Checklist.connect("finish", self, "on_checklist_finish") != OK:
		print("ERRO AO CONECTAR FINISH CHECKLIST")

func _on_posteSobeButton_pressed():
	# Esconde o balão e mostra a checklist.
	# Impede que o jogador se mova enquanto estiver na tela da checklist.
	$BalaoPoste.visible = false
	$Checklist.visible = true
	Global.canMove = false

# Função que é chamada quando a checklist é concluída.
func on_checklist_finish():
	# Espera 0.2 segundos antes de mudar de cena.
	yield(get_tree().create_timer(0.2), "timeout")
	
	# Tenta mudar para a cena "PosteCima2.tscn".
	# Caso ocorra algum erro, imprime uma mensagem de erro.
	if get_tree().change_scene("res://Scenes/Playables/Environment/PosteCima2.tscn") != OK:
		print("ERRO AO MUDAR DE CENA")
	
	# Define a posição do jogador como a posição global do nó pai "Player".
	pos.posTecnico = get_parent().get_node("Player").global_position
