extends Node2D

var taskFeita = false

func _ready():
	# Definindo os limites da câmera do jogador
	$Player/Camera2D.limit_left = 257-97
	$Player/Camera2D.limit_right = 519-97
	$Player/Camera2D.limit_bottom = 208+64
	$Player/Camera2D.limit_top = -32+64
	
	# Impedindo que o jogador se mova no início do jogo
	Global.canMove = false
	
	# Definindo as configurações iniciais da câmera do jogador
	$Player/Camera2D.current = true
	$Player/Camera2D.zoom = Vector2(0.3, 0.3)
	
	# Animando a abordagem inicial do jogador
	_abordagem_anim()

func animate():
	# Animando o progresso da tarefa
	$TaskRoteador/Tween.interpolate_property($TaskRoteador/TextureProgress, "value", 0, 100, 2.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$TaskRoteador/Tween.start()

func _on_TouchScreenButton_pressed():
	# Verificando se a tarefa ainda não foi concluída
	if taskFeita == false:
		# Verificando se o jogador está próximo ao objeto que precisa ser consertado
		if ($Player.global_position).distance_to($TaskRoteador/RoteadorAncora.global_position) < 50:
			taskFeita = true
			Global.activeObjective[0] = false
			
			# Configurando o progresso da tarefa
			$TaskRoteador/TextureProgress.visible = true
			Global.activeObjective[0] = false
			Global.canMove = false
			
			# Animando o progresso da tarefa
			animate()
			yield(get_tree().create_timer(2.5), "timeout")
			
			# Liberando o movimento do jogador após a conclusão da tarefa
			Global.canMove = true
			$TaskRoteador/TextureProgress.visible = false
			$TaskRoteador/BalaoObj.visible = false
			$SpriteBlogueira/BalaoObj.visible = true
			
			# Definindo a próxima tarefa e objetivo
			Global.activeObjective[0] = true
			Global.activeObjective[1] = $SpriteBlogueira/Position2D.global_position
			Global.activeObjective[2] = "Fale com a Blogueira."
			
			# Exibindo o botão para interagir com a próxima tarefa
			$SpriteBlogueira/TouchScreenButton.visible = true
			
			# Atualizando o objetivo do jogador
			$Player.objective(false)
			
			
func _abordagem_anim():
	yield(get_tree().create_timer(1), "timeout")  # Espera por 1 segundo antes de continuar

	$AnimationPlayer.play("Abordagem")  # Toca a animação "Abordagem"
	
	yield(get_tree().create_timer(1), "timeout")
	
	$SpriteBlogueira/AnimatedSprite.animation = "up"

	yield($AnimationPlayer, "animation_finished")  # Espera a animação terminar

	$SpriteBlogueira/AnimatedSprite.playing = false
	$SpriteBlogueira/AnimatedSprite.frame = 6
	
	$"DialogBox 22".visible = true  # Torna visível a caixa de diálogo "DialogBox 22"
	
	# Conecta o sinal "finish" do objeto "TexturaCaixa" à função "_on_dialog1_finish"
	if $"DialogBox 22/TexturaCaixa".connect("finish", self, "_on_dialog1_finish") != OK:
		print("ERRO AO CONECTAR")

	$"DialogBox 22/TexturaCaixa"._startDialog()  # Inicia a caixa de diálogo "TexturaCaixa"

# Função chamada quando a caixa de diálogo "_on_dialog1_finish" é fechada
func _on_dialog1_finish():
	$AnimationPlayer.play_backwards("Abordagem")  # Toca a animação "Abordagem" em reverso
	
	$SpriteBlogueira/AnimatedSprite.animation = "down"
	$SpriteBlogueira/AnimatedSprite.playing = true
	
	yield(get_tree().create_timer(0.5), "timeout")
	
	$SpriteBlogueira/AnimatedSprite.flip_h = true
	$SpriteBlogueira/AnimatedSprite.animation = "horizontal"
	
	yield($AnimationPlayer, "animation_finished")  # Espera a animação terminar
	
	$SpriteBlogueira/AnimatedSprite.playing = false
	$SpriteBlogueira/AnimatedSprite.flip_h = false
	$SpriteBlogueira/AnimatedSprite.frame = 2
	
	$TaskRoteador.visible = true  # Torna visível a tarefa "TaskRoteador"
	$"DialogBox 22".visible = false  # Torna invisível a caixa de diálogo "DialogBox 22"
	
	Global.activeObjective[0] = true  # Define o primeiro objetivo como ativo
	Global.activeObjective[1] = $TaskRoteador/RoteadorAncora.global_position  # Define a posição do roteador como segundo objetivo
	Global.activeObjective[2] = "Conserte o roteador."  # Define a descrição do objetivo
	$Player.objective(false)  # Atualiza a tela de objetivos
	
	Global.canMove = true  # Permite que o jogador se mova novamente

# Função chamada quando o botão "BlgueiraButton" é pressionado
func _on_BlogueiraButton_pressed():
	# Verifica se o jogador está próximo o suficiente da "SpriteBlogueira"
	if $Player.global_position.distance_to($SpriteBlogueira/Position2D.global_position) < 50:
		Global.activeObjective[0] = false  # Desativa o primeiro objetivo
		
		$SpriteBlogueira/TouchScreenButton.visible = false  # Torna invisível o botão de interação da blogueira
		Global.canMove = false  # Impede que o jogador se mova
		$"DialogBox 23".visible = true  # Torna visível a caixa de diálogo "DialogBox 23"
		
		# Conecta o sinal "finish" do objeto "TexturaCaixa" à função "_on_dialog2_finish"
		if $"DialogBox 23/TexturaCaixa".connect("finish", self, "_on_dialog3_finish") != OK:
			print("ERRO AO CONECTAR")
		$"DialogBox 23/TexturaCaixa"._startDialog()  # Inicia a caixa de diálogo "TexturaCaixa"
	
func _on_dialog3_finish():
	# Define a variável canMove como verdadeira para permitir o movimento do jogador
	Global.canMove = true
	
	# Define um novo objetivo para o jogador
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $PortaAncora.global_position
	Global.activeObjective[2] = "Volte para o campo."
	$Player.objective(false)
	$SpriteBlogueira/BalaoObj.visible = false
	
	# Ativa a colisão do objeto Area2D/CollisionShape2D
	$Area2D/CollisionShape2D.disabled = false
	
func _on_Area2D_body_entered(body):
	if body == $Player:
		# Muda para a cena Tecnico.tscn e define a tarefa atual como 3
		SceneTransition.change_scene("res://Scenes/Playables/Environment/Tecnico.tscn", 1, 1)
		TecGlobals.currentTask = 3
