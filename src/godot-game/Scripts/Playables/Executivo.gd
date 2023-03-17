extends Node2D

# Variáveis para referenciar a câmera, o mapa e seus limites
onready var camera: Camera2D = get_node("Player/Camera2D")
onready var map = get_node("map")
onready var children = get_node("map").get_children()
var map_width = 0
var map_height = 0

# Variáveis para o controle de posição do jogador e para a interação com a porta
var lockIf0 = true
var closeToPorta

var updateTimer = false

var playerSavePos

func _ready():
	if ExecutivoGlobals.reuniao:
		# Define que o primeiro objetivo está ativo e qual é a posição do objeto 'ADM' (Representa a entrada do prédio)
		Global.activeObjective[0] = true
		Global.activeObjective[1] = $ReuniaoAncora.global_position
		Global.activeObjective[2] = "Atenda a \n reuniao"
		$Player.objective(true)
		$NPCQuiz1.visible = false
		
		$GUI/Audio.set_volume(Global.volPercentage)
		$GUI/Audio.play_ambient("res://Audio Files/OfficeAmbiente.mp3")
	# Habilita o movimento do jogador
	Global.canMove = true
	
	# Se a posição atual for em um cenário jogável, posicione o jogador na posição atual
	# Caso contrário, posicione-o na posição da cidade e toque a animação de transição
	if pos.posScene == "res://Scenes/Playables/Environment/Executivo.tscn":
		$Player.global_position = pos.currentPos
		pos.posScene = null
	else:
		$Player.global_position = pos.posADM
		#$WalkInPlayer.play("WalkIn")
		#Global.moving = true
	
	# Define o zoom da câmera e obtém os limites do mapa
	camera.zoom = Vector2(0.5,0.5)
	set_process(true)

func _process(_delta):
	# Define os limites da câmera para o tamanho do mapa
	camera.limit_left = 0
	camera.limit_top = 0
	camera.limit_right = 576
	camera.limit_bottom = 640
	
	# Verifica se o jogador está próximo da porta de interação
	if $Player/HitBox.global_position.distance_to($PortaAncora.global_position) < 40:
		closeToPorta = true
	else:
		closeToPorta = false
	
	if $"ReuniaoAncora/ReuniaoAnim/DialogBox 2/TexturaCaixa".phraseNum == 1 and $"ReuniaoAncora/ReuniaoAnim/DialogBox 2/TexturaCaixa".finished == false and ExecutivoGlobals.deadBolt0:
			ExecutivoGlobals.deadBolt0 = false
			$ReuniaoAncora/ReuniaoAnim/Camera2D.position = $Player/Camera2D.global_position
			#_reuniao_anim().resume()
			print("AGORA?")
	if $"ReuniaoAncora/ReuniaoAnim/DialogBox 2/TexturaCaixa".phraseNum == 2 and $"ReuniaoAncora/ReuniaoAnim/DialogBox 2/TexturaCaixa".finished == false and ExecutivoGlobals.deadBolt1:
			ExecutivoGlobals.deadBolt1 = false
			$ReuniaoAncora/ReuniaoAnim/Camera2D.position = Vector2(37,596)
	
	if updateTimer:
		$ControlQuiz2/CanvasLayer/RichTextLabel.text = str(int($ControlQuiz2/Timer.time_left))
	
func _on_TextureButton_pressed():
	# Verifica se o jogador está perto da porta
	if closeToPorta:
		# Impede o movimento do jogador durante a transição de cena
		Global.canMove = false
		# Aguarda um curto período antes de mudar de cena, para que a animação da porta seja executada
		yield(get_tree().create_timer(0.15), "timeout")
		# Tenta mudar para a cena "Cidade.tscn", exibindo uma mensagem de erro em caso de falha		
		if get_tree().change_scene("res://Scenes/Playables/Environment/Cidade.tscn") != OK:
			print("ERRO")

# Quando a animação de entrada do jogador termina, define a variável Global.moving (que controla a animação de andar) como false
func _on_WalkInPlayer_animation_finished(_anim_name):
	Global.moving = false

# LIDAR COM A ANIMACAO INGAME DE REUNIAO
func _reuniao_anim():
	Global.canMove = false
	$Player/Camera2D.current = false
	$GUI.visible = false
	Global.activeObjective[0] = false
	
	$ReuniaoAncora/ReuniaoAnim/Camera2D.global_position = $Player/Camera2D.global_position
	print($ReuniaoAncora/ReuniaoAnim/Camera2D.global_position, $ReuniaoAncora/ReuniaoAnim/Camera2D.position)
	$ReuniaoAncora/ReuniaoAnim/Camera2D.current = true
	$ReuniaoAncora/ReuniaoAnim.play("CameraZoomIn")
	yield($ReuniaoAncora/ReuniaoAnim, 'animation_finished')
	$ReuniaoAncora/ReuniaoAnim.get_animation("CameraFlyOver").track_set_key_value(0, 0, $Player/Camera2D.global_position)
	$ReuniaoAncora/ReuniaoAnim.play("CameraFlyOver")
	yield($ReuniaoAncora/ReuniaoAnim, 'animation_finished')
	$"ReuniaoAncora/ReuniaoAnim/DialogBox 2".visible = true
	$"ReuniaoAncora/ReuniaoAnim/DialogBox 2/TexturaCaixa"._startDialog()
	yield($"ReuniaoAncora/ReuniaoAnim/DialogBox 2/TexturaCaixa", "finish")
	$ReuniaoAncora/ReuniaoAnim.playback_speed = 2
	$ReuniaoAncora/ReuniaoAnim.play_backwards("CameraFlyOver")
	yield($ReuniaoAncora/ReuniaoAnim, 'animation_finished')
	
	$ReuniaoAncora/ReuniaoAnim.playback_speed = 1
	
	$ReuniaoAncora/ReuniaoAnim.play_backwards("CameraZoomIn")
	yield($ReuniaoAncora/ReuniaoAnim, 'animation_finished')
	$ReuniaoAncora/ReuniaoAnim/Camera2D.current = false
	$GUI.visible = true
	$Player/Camera2D.current = true
	Global.canMove = true
	
	$NPCQuiz1.visible = true
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $NPCQuiz1/AncoraQuiz1.global_position
	Global.activeObjective[2] = "Fale com o seu \n colega"

	$Player.objective(false)
	
	
func _assedio_anim():
	$ControlAssedio/ColorRect.visible = true
	
	Global.canMove = false
	Global.activeObjective[0] = false
	
	# desnecessario???
	$ControlAssedio/Camera2D.global_position = $Player/Camera2D.global_position
	$ControlAssedio/Camera2D.current = true
	$Player/Camera2D.current = false
	
	$ControlAssedio/AnimationPlayer.get_animation("WalkUp").track_set_key_value(0, 1, Vector2($Player.position.x-10, 191))
	$ControlAssedio/AnimationPlayer.get_animation("WalkUpBackwards").track_set_key_value(0, 0, Vector2($Player.position.x-10, 191))
	$ControlAssedio/AnimationPlayer.play("WalkUp")
	yield($ControlAssedio/AnimationPlayer, "animation_finished")
	
	$"ControlAssedio/DialogBox 12".visible = true
	$"ControlAssedio/DialogBox 12/TexturaCaixa"._startDialog()
	
	yield($"ControlAssedio/DialogBox 12/TexturaCaixa", "finish")
	
	$ControlAssedio/AnimationPlayer.play("WalkUpBackwards")
	yield($ControlAssedio/AnimationPlayer, "animation_finished")
	$ControlAssedio/ColorRect.visible = false
	$"ControlAssedio/Eq Compliance/NPC2 (O BOM)/BalaoExclamacao".visible = true
	$"ControlAssedio/Eq Compliance/NPC2 (O BOM)/NPCBomBotao".visible = true
	
	$Player/Camera2D.current = true
	$ControlAssedio/Camera2D.current = false
	$Assedio/CollisionShape2D.disabled = true
	Global.canMove = true
	
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $"ControlAssedio/Eq Compliance/NPC2 (O BOM)/NPCBomAncora".global_position
	Global.activeObjective[2] = "Fale com a equipe de compliance"

	$Player.objective(true)
	
	pass

# LIDAR COM O QUIZ #1
func _on_Quiz1Button_pressed():
	Global.activeObjective[0] = false
	$NPCQuiz1/BalaoExclamacao.visible = false
	$NPCQuiz1/Quiz1Button.visible = false
	$NPCQuiz1/QuizTask.visible = true
	$NPCQuiz1/QuizTask._startQuiz()
	Global.canMove = false
	if $NPCQuiz1/QuizTask/DialogBox/TexturaCaixa.connect("quizCorrect", self, "_finish_quiz1") != OK:
		print("ERROR ON QUIZCORRECT CONNECT")

func _finish_quiz1():
	yield(get_tree().create_timer(0.5), "timeout")
	Global.canMove = true
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $ControlQuiz2/Quiz2Ancora.global_position
	Global.activeObjective[2] = "Fale com seus \n colegas"

	
	
	$NPCQuiz1/QuizTask.visible = false
	$NPCQuiz1/QuizTask/DialogBox.visible = false
	
	
	$Player.objective(false)
	$Assedio/CollisionShape2D.disabled = false
	$Quiz2/CollisionShape2D.disabled = false
	
	

func _on_Area2D_body_entered(body):
	if body == $Player:
		playerSavePos = $Player.global_position
		
		$ControlQuiz2/QuizTask.visible = true
		$ControlQuiz2/QuizTask._startQuiz()
		
		Global.canMove = false
		Global.activeObjective[0] = false
		$ControlQuiz2/BaloesExclamacao.visible = false
		
		if $ControlQuiz2/QuizTask/DialogBox/TexturaCaixa.connect("quizCorrect", self, "_finish_quiz2") != OK:
			print("ERROR ON QUIZCORRECT CONNECT")
		
		#$ControlQuiz2/Tween.interpolate_property($Player/Camera2D, "global_position", self.global_position, Global.activeObjective[1], 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		#$ControlQuiz2/Tween.start()
		
		print("asdasd")

func _finish_quiz2():
	yield(get_tree().create_timer(0.5), "timeout")
	Global.canMove = true
#	Global.activeObjective[0] = true
#	Global.activeObjective[1] = $ControlQuiz2/Quiz2Ancora.global_position
#	Global.activeObjective[2] = "Fale com seus \n colegas"
#	$Player.objectiveAnim()
	$Quiz2/CollisionShape2D.disabled = true
	#$ControlQuiz2.visible = false
	
	$ControlQuiz2/CanvasLayer.visible = true
	$ControlQuiz2/Timer.start()
	updateTimer = true
	
	
	$"ControlQuiz2/Eq Compliance".visible = true
	Global.activeObjective[1] = $"ControlQuiz2/Eq Compliance/NPCBomAncora".global_position
	Global.activeObjective[2] = "Fale com a equipe de compliance"
	$Player.objective(false)

func _on_Reuniao_body_entered(body):
	if body == $Player and ExecutivoGlobals.reuniao:
		ExecutivoGlobals.reuniao = false
		pos.savePosCommand = true
		yield(get_tree().create_timer(0.05), "timeout")
		_reuniao_anim()


func _on_Assedio_body_entered(body):
	if body == $Player:
		_assedio_anim()

func _on_NPCBomBotao_pressed():
	if $Player/HitBox.global_position.distance_to($"ControlAssedio/Eq Compliance/NPC2 (O BOM)/NPCBomAncora".global_position) < 50:
		Global.canMove = false
		Global.activeObjective[0] = false
		$"ControlAssedio/Eq Compliance/NPC2 (O BOM)/DialogBox 13".visible = true
		$"ControlAssedio/Eq Compliance/NPC2 (O BOM)/DialogBox 13/TexturaCaixa"._startDialog()
		$"ControlAssedio/Eq Compliance/NPC2 (O BOM)/NPCBomBotao".visible = false
		$"ControlAssedio/Eq Compliance/NPC2 (O BOM)/BalaoExclamacao".visible = false
		print("yielded")
		yield($"ControlAssedio/Eq Compliance/NPC2 (O BOM)/DialogBox 13/TexturaCaixa", "finish")
		print("resumed")
		Global.canMove = true
		$"ControlAssedio/Eq Compliance/NPC2 (O BOM)/DialogBox 13".visible = false
		Global.activeObjective[0] = true
		Global.activeObjective[1] = $ControlQuiz2/Quiz2Ancora.global_position
		Global.activeObjective[2] = "Fale com seus \n colegas"
		$ControlQuiz2/BaloesExclamacao.visible = true
		$Player.objective(false)


func _on_Timer_timeout():
	_finish_quiz2_part2()

func _finish_quiz2_part2():
	$ControlQuiz2/CanvasLayer.visible = false
	updateTimer = false
	Global.canMove = false
	$"ControlQuiz2/DialogBox 14".visible = true
	$"ControlQuiz2/DialogBox 14/TexturaCaixa".phraseNum = 0
	$"ControlQuiz2/DialogBox 14/TexturaCaixa".dialog = null
	$"ControlQuiz2/DialogBox 14/TexturaCaixa".buttonPressed = null
	
	$"ControlQuiz2/DialogBox 14/TexturaCaixa"._startDialog()
	
	yield($"ControlQuiz2/DialogBox 14/TexturaCaixa", "finish")
	
	yield(get_tree().create_timer(0.4), "timeout")
	
	$ControlQuiz2/CanvasLayer2.visible = true
	
	$ControlQuiz2/AnimationPlayer.play("flash")
	yield($ControlQuiz2/AnimationPlayer, 'animation_finished')
	
	$Player.global_position = playerSavePos
	
	Global.quizAnswered = false
	$ControlQuiz2/QuizTask._reset()
	_on_Area2D_body_entered($Player)
	
	$ControlQuiz2/AnimationPlayer.play_backwards("flash")
	yield($ControlQuiz2/AnimationPlayer, 'animation_finished')
	
	$ControlQuiz2/CanvasLayer2.visible = false
	
	print("SEEXO")
	

func _on_NPCCompQuiz2Botao_pressed():
	if $Player/HitBox.global_position.distance_to($"ControlQuiz2/Eq Compliance/NPCBomAncora".global_position) < 50:
		$ControlQuiz2/CanvasLayer.visible = false
		$ControlQuiz2/Timer.stop()
		updateTimer = false
		
		Global.canMove = false
		Global.activeObjective[0] = false
		$"ControlQuiz2/Eq Compliance/DialogBox 15".visible = true
		$"ControlQuiz2/Eq Compliance/DialogBox 15/TexturaCaixa"._startDialog()
		$"ControlQuiz2/Eq Compliance/NPCCompQuiz2Botao".visible = false
		$"ControlQuiz2/Eq Compliance/BalaoExclamacao".visible = false
		print("yielded")
		yield($"ControlQuiz2/Eq Compliance/DialogBox 15/TexturaCaixa", "finish")
		print("resumed")
		Global.canMove = true
		$"ControlQuiz2/Eq Compliance/DialogBox 15".visible = false
		
		Global.activeObjective[0] = true
		Global.activeObjective[1] = $PortaAncora.global_position
		Global.activeObjective[2] = "Va para casa"
		$Player.objective(false)
		
		yield(get_tree().create_timer(3.0), "timeout")
		
		SceneTransition.change_scene("res://Scenes/Playables/Environment/Limbo2.tscn", 1, 1)
