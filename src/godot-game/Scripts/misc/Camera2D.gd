extends Camera2D

# Define a amplitude e frequência da oscilação da câmera
var amplitude = 30
var frequency = 3

func _process(_delta):
	# Verifica se o jogador está bêbado
	if Global.isDrunk == true:
		# Obtém o tempo atual em segundos
		var time = OS.get_ticks_msec() / 1000.0

		# Calcula o deslocamento em X e Y usando seno e cosseno
		var x_offset = amplitude * sin(time * frequency)
		var y_offset = amplitude * cos(time * frequency)

		# Cria um vetor a partir dos deslocamentos
		var offset = Vector2(x_offset, y_offset)

		# Obtém a posição global do pai da câmera (que deve ser o jogador)
		var player_pos = get_parent().global_position

		# Calcula a nova posição da câmera adicionando o deslocamento à posição do jogador
		var new_pos = player_pos + offset

		# Define a nova posição global da câmera
		set_global_position(new_pos)
