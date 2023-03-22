extends Node2D

func _ready():
	# Mostra a primeira animação na tela
	$zeHosp.visible = true
	# Define o frame inicial da animação do nó $zeHosp como 0
	$zeHosp.frame = 0
	# Define que a animação está em execução
	$zeHosp.playing = true
	
	# Continua tocando o som de explosao apos transicao de cenas
	$Audio.set_volume(Global.volPercentage)
	$Audio.set_playback_pos("res://Audio Files/explosion.mp3" , Global.playbackPos)
	
	# Faz com que a função pause a execução por 3.3 segundos antes de continuar
	yield(get_tree().create_timer(3.3), "timeout")
	$Audio.stop()

func _on_zeHosp_animation_finished():
	# Quando a animação do nó $zeHosp terminar, a função change_scene será chamada para mudar a cena atual para "res://Scenes/Playables/Environment/Limbo1.tscn"
	SceneTransition.change_scene("res://Scenes/Playables/Environment/Limbo1.tscn", 1, 0.1)
