# Este script lida com a reprodução de animações e as alinha de acordo.

extends Node2D

# A função _ready() é executada assim que a cena é carregada
func _ready():
	# Configurando a animação "zeAcordando"
	$zeAcordando.playing = true  # Inicia a animação
	$zeAcordando.frame = 0  # Define o quadro inicial
	$zeAcordando.visible = true  # Torna a animação visível na tela
	
	# Set variavel global playbackPos para 0 para ser usada para a cidade
	Global.playbackPos = 0

# Função chamada quando o botão de pular animação é pressionado
func _on_TextureButton_pressed():
	SceneTransition.change_scene("res://Scenes/Playables/Environment/Prelude.tscn", 0.5, 0.5)


# Função chamada quando a animação "zeAcordando" termina
func _on_zeAcordando_animation_finished():
	$zeAcordando.visible = false  # Torna a animação "zeAcordando" invisível
	$zeQuarto.visible = true  # Torna a animação "zeQuarto" visível
	$zeQuarto.playing = true  # Inicia a animação "zeQuarto"
	$zeQuarto.frame = 0  # Define o quadro inicial da animação "zeQuarto"


# Função chamada quando a animação "zeQuarto" termina
func _on_zeQuarto_animation_finished():
	$zeQuarto.visible = false  # Torna a animação "zeQuarto" invisível
	$zeCozinha.visible = true  # Torna a animação "zeCozinha" visível
	$zeCozinha.playing = true  # Inicia a animação "zeCozinha"
	$zeCozinha.frame = 0  # Define o quadro inicial da animação "zeCozinha"
	
	$Audio.set_playback_pos("res://Audio Files/BebendoCerveja.mp3" , 0)
	$Audio.set_volume(Global.volPercentage)
	yield(get_tree().create_timer(2.83), "timeout")
	$Audio.stop()
# Função chamada quando a animação "zeCozinha" termina
func _on_zeCozinha_animation_finished():
	$zeCozinha.visible = false  # Torna a animação "zeCozinha" invisível
	$zeTransito.visible = true  # Torna a animação "zeTransito" visível
	$zeTransito.playing = true  # Inicia a animação "zeTransito"
	$zeTransito.frame = 0  # Define o quadro inicial da animação "zeTransito"
	
	yield(get_tree().create_timer(1.5), "timeout")
	$Audio.set_playback_pos("res://Audio Files/BusBrakes.mp3" , 0)
	$Audio.set_volume(Global.volPercentage)
	yield(get_tree().create_timer(1.40), "timeout")
	$Audio.stop()
	
	$Audio.set_playback_pos("res://Audio Files/Busao.mp3" , 0)
	$Audio.set_volume(Global.volPercentage)
	yield(get_tree().create_timer(5), "timeout")
	$Audio.stop()
	
# Função chamada quando a animação "zeTransito" termina
func _on_zeTransito_animation_finished():
	SceneTransition.change_scene("res://Scenes/Playables/Environment/Prelude.tscn", 0.5, 0.5)
