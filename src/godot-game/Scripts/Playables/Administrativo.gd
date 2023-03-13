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

func _ready():
	# Habilita o movimento do jogador
	Global.canMove = true
	
	# Se a posição atual for em um cenário jogável, posicione o jogador na posição atual
	# Caso contrário, posicione-o na posição da cidade e toque a animação de transição
	if pos.posScene == "res://Scenes/Playables/Environment/Administrativo.tscn":
		$Player.global_position = pos.currentPos
		pos.posScene = null
	else:
		$Player.global_position = pos.posCidade
		#$WalkInPlayer.play("WalkIn")
		#Global.moving = true
	
	# Define o zoom da câmera e obtém os limites do mapa
	camera.zoom = Vector2(0.8,0.8)
	_getMapLimits()
	set_process(true)
	
	# Salvaguarda para nao sair da cena antes de acabar o yield
	$map/Elevador/TextureButton.visible = false
	
	# Aguarda 3 segundos e toca a animação de transição para o novo cenário
#	yield(get_tree().create_timer(3.0), "timeout")
#	SceneTransition.change_scene("res://Scenes/Non Playables/misc/Reincarn.tscn", 1, 1)
#	pos.posScene = "res://Scenes/Playables/Environment/Cidade.tscn"
#	pos.currentPos = pos.posCidade

	$map/Elevador/TextureButton.visible = true
func _process(_delta):
	# Define os limites da câmera para o tamanho do mapa
	var camera_limits = Rect2(map.global_position, Vector2(map_width, map_height))
	camera.limit_left = camera_limits.position.x
	#camera.limit_top = camera_limits.position.y
	camera.limit_right = 768 #mudar depois para funcao que pega os limites
	camera.limit_bottom = 1344 #mudar depois para funcao que pega os limites
	
	# Verifica se o jogador está próximo da porta de interação
	if $Player/HitBox.global_position.distance_to($PortaAncora.global_position) < 160:
		closeToPorta = true
	else:
		closeToPorta = false
	

func _getMapLimits():
	# Itera por todos os nós filhos do mapa
	for child in children:
		# Verifica se o nó filho é um sprite
		if child is Sprite:
			# Obtém a posição global do sprite
			var sprite_pos = child.global_position
			# Atualiza a largura e altura do mapa, se necessário
			map_width = max(map_width, sprite_pos.x + child.texture.get_size().x * child.scale.x)
			map_height = max(map_height, sprite_pos.y + child.texture.get_size().y * child.scale.y)



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
