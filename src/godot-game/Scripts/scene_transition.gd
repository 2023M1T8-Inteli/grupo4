extends CanvasLayer

# Função que recebe uma string (caminho da cena a ser trocada) e não retorna nada
func change_scene(target: String) -> void:
	# Acessa o nó AnimationPlayer e executa a animação 'dissolve'
	$AnimationPlayer.play('dissolve')
	# Pausa a execução da função até que a animação seja finalizada
	yield($AnimationPlayer, 'animation_finished')
	
	# Tenta mudar para a cena especificada, caso ocorra um erro, imprime mensagem
	if get_tree().change_scene(target) != OK:
		print ("An unexpected error occured when trying to switch to the scene")

	# Executa a animação 'dissolve' no sentido contrário, "desfazendo" a animação anterior
	$AnimationPlayer.play_backwards('dissolve')
	pass
