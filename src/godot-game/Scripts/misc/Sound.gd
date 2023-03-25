extends Node

# Variável para guardar a posição atual da música
var currentPos

# Variável para guardar o volume da música
var volume

# Função para obter a posição atual da música
func get_playback_pos():
	# Obtém a posição atual da música usando o nó Music
	Global.playbackPos = $Music.get_playback_position()
	# Guarda a posição atual na variável currentPos
	currentPos = Global.playbackPos
	# Retorna a posição atual da música
	return currentPos

# Função para definir a posição de reprodução da música
func set_playback_pos(path, pos):
	# Carrega o arquivo de música especificado pelo caminho (path)
	$Music.stream = load(path)
	# Define a posição de reprodução da música usando o valor de pos
	$Music.play(pos)

# Função para parar a reprodução da música
func stop():
	# Define a propriedade playing do nó Music como false para parar a reprodução da música
	$Music.playing = false

# Função para definir o volume da música
func set_volume(vol):
	# Se o valor do volume for 0, define volume como -80. Caso contrário, calcula o valor do volume em decibéis usando a fórmula (vol * 0.25) - 35
	if vol == 0:
		volume = -80
	else:
		volume = (vol*0.25) - 35

	# Define a variável global volume como o valor calculado
	Global.volume = volume
	# Define a propriedade volume_db dos nós Music e Ambient como o valor calculado
	$Music.set_volume_db(volume)
	$Ambient.set_volume_db(volume)

# Função para reproduzir música ambiente
func play_ambient(path):
	# Carrega o arquivo de música ambiente especificado pelo caminho (path)
	$Ambient.stream = load(path)
	# Define o volume da música ambiente usando a variável global volume
	$Ambient.set_volume_db(Global.volume)
	# Inicia a reprodução da música ambiente
	$Ambient.play()

# Função chamada quando o valor do slider é alterado
func _on_HSlider_value_changed(value):
	# Define a variável global volPercentage como o valor atual do slider
	Global.volPercentage = value
	# Define o volume da música e da música ambiente usando o valor do slider
	set_volume(value)
