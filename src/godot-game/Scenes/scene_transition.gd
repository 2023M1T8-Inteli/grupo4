# Este script é uma extensão do CanvasLayer, que é um nó que representa uma camada de canvas,
# responsável por desenhar elementos em um espaço 2D.

extends CanvasLayer

# A variável warnFix é inicializada com None, indicando que ainda não possui um valor atribuído.

var warnFix = null

# A função change_scene recebe uma string como parâmetro, que representa o nome da cena que
# deseja-se transicionar. A função retorna None.

func change_scene(target: String) -> void:
	
	# A função play do nó AnimationPlayer é chamada, com o parâmetro 'dissolve', que
	# representa a animação de transição entre as cenas.
	
	$AnimationPlayer.play('dissolve')
	
	# O código é pausado até que a animação atual seja finalizada.
	
	yield($AnimationPlayer, 'animation_finished')
	
	# A função get_tree() é chamada, que retorna o nó SceneTree, responsável pela gerência
	# da cena atual e das transições entre cenas. A função change_scene é chamada, passando
	# como parâmetro a string recebida na função change_scene.
	
	warnFix = get_tree().change_scene(target);
	
	# A função play_backwards do nó AnimationPlayer é chamada, com o parâmetro 'dissolve', que
	# representa a animação inversa da transição entre as cenas.
	
	$AnimationPlayer.play_backwards('dissolve')
	
	# A palavra-chave 'pass' é utilizada para finalizar a função.

	pass
