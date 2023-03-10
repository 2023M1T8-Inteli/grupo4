extends CanvasLayer

# Função que executa a animação de "spook"
func spook():
	# Inicia a animação de "dissolve"
	$AnimationPlayer2.play('dissolve')
	# Aguarda o término da animação
	yield($AnimationPlayer2, 'animation_finished')
	# Inicia a animação de "dissolve" em sentido contrário
	$AnimationPlayer2.play_backwards('dissolve')
	pass
	
# Função que é chamada quando o sinal "spook" é emitido
func _on_TexturaCaixa_spook(Boolean):
	# Chama a função "spook"
	spook()
