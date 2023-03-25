# Este script implementa o rolamento de créditos de fim de jogo.
# Ele adiciona cada linha dos créditos como um objeto Line a um Node2D denominado CreditsContainer, 
# e rola as linhas verticalmente para simular a rolagem de créditos.
# O script também permite ao jogador acelerar a rolagem de créditos pressionando e segurando um botão.

extends Node2D

# Definição de constantes usadas para a animação
const section_time := 2.0  # Tempo em segundos para cada seção dos créditos (cada lista dentro de credits)
const line_time := 0.3  # Tempo em segundos para cada linha
const base_speed := 60  # Velocidade base para rolar as linhas em pixels por segundo
const speed_up_multiplier := 10.0  # Fator de multiplicação para acelerar a rolagem quando o botão é pressionado
const title_color := Color("D5FF00")  # Cor do título da seção dos créditos

# Definição de variáveis
var buttonPressed  # Armazena se o botão foi pressionado naquele frame
var scroll_speed := base_speed  # Velocidade de rolagem atual, afetada pela aceleração do botão
var speed_up := false  # Flag indicando se o botão está pressionado

onready var line := $CreditsContainer/Line  # Referência ao objeto Line que será duplicado para cada linha de crédito
var started := false  # Flag indicando se os créditos começaram a rolar
var finished := false  # Flag indicando se os créditos terminaram de rolar

var section  # Lista atual de linhas de crédito sendo exibida
var section_next := true  # Flag indicando se é hora de carregar a próxima seção dos créditos
var section_timer := 0.0  # Tempo acumulado para a seção atual
var line_timer := 0.0  # Tempo acumulado para a linha atual
var curr_line := 0  # Índice da linha atual na seção
var lines := []  # Lista de objetos Line atualmente exibidos

# Lista completa dos créditos
var credits = [
	[
		"Agradecemos por jogar Moralética!",
		"",
		"Esperamos que tenha aprendido um pouco,",
		"afinal, na realidade temos apenas uma única vida...",
		"e devemos usá-la da melhor forma possível.",
		"Esperamos que nosso jogo tenha",
		"feito parte da sua jornada,",
		"não só como profissional, mas como alguém melhor."
	],[
		"Um forte abraço, dos desenvolvedores:",
		
		"Gabrielle Dias Cartaxo",
		"Gustavo Wagon Widman",
		"Izadora Luz Rodrigues Novaes",
		"Matheus Ferreira Mendes",
		"Olin Medeiros Costa",
		"Thomas Reitzfeld"
	],[
		"Desenvolvido usando Godot Engine",
		"https://godotengine.org/license"
	],[
		"Arte criada usando Aseprite",
		"https://www.aseprite.org/"
	],[
		"Dedicado à",
		"Nathalia e Fabrício da V.tal"
	],[
		"Agradecimentos Especiais",
		"Egon Daxbacher",
		"Guilherme Henrique de Oliveira Cestari",
		"Leonardo Bontempo",
		"Luciano Galdino",
		"Marcelo Gonçalves"
	], [
		""
	], [
		"E lembre-se..."
	], [
		"Respeite o código de ética!!"
	]
]

# Esta função é chamada a cada quadro renderizado.
func _process(delta):
	# Cálculo da velocidade de scroll baseado na velocidade base e o tempo desde o último quadro.
	var scroll_speedProc = base_speed * delta

	# Se estamos em uma nova seção dos créditos.
	if section_next:
		# Cálculo do timer de seção.
		section_timer += delta * speed_up_multiplier if speed_up else delta
		# Verificação se a seção atual atingiu o tempo máximo.
		if section_timer >= section_time:
			# Reseta o timer de seção.
			section_timer -= section_time

			# Se ainda há linhas para exibir.
			if credits.size() > 0:
				# Seta a variável 'started' como verdadeira para iniciar a exibição dos créditos.
				started = true
				# Pega a próxima seção.
				section = credits.pop_front()
				# Reseta o contador de linhas exibidas.
				curr_line = 0
				# Adiciona a primeira linha.
				add_line()

	# Se estamos exibindo as linhas.
	else:
		# Cálculo do timer de linha.
		line_timer += delta * speed_up_multiplier if speed_up else delta
		# Verificação se a linha atual atingiu o tempo máximo.
		if line_timer >= line_time:
			# Reseta o timer de linha.
			line_timer -= line_time
			# Adiciona a próxima linha.
			add_line()

	# Se a velocidade de scroll está acelerada.
	if speed_up:
		# Multiplica a velocidade de scroll pela multiplicador de velocidade.
		scroll_speedProc *= speed_up_multiplier

	# Se ainda há linhas para exibir.
	if lines.size() > 0:
		# Para cada linha exibida.
		for l in lines:
			# Move a linha para baixo de acordo com a velocidade de scroll.
			l.rect_position.y -= scroll_speedProc
			# Se a linha saiu da tela.
			if l.rect_position.y < -l.get_line_height():
				# Remove a linha da lista e a destroi.
				lines.erase(l)
				l.queue_free()
	# Se os créditos já começaram e todas as linhas foram exibidas.
	elif started:
		# Finaliza a exibição dos créditos.
		finish()


# Esta função finaliza a exibição dos créditos.
func finish():
	# Se ainda não finalizamos.
	if not finished:
		# Marca como finalizado.
		finished = true

		# NOTA: Esta parte é chamada quando os créditos terminam.
		# - Conecte seu código para retornar à cena relevante aqui, ex...
		# Espera 2 segundos antes de mudar de cena.
		yield(get_tree().create_timer(2), "timeout")
		# Muda para a cena do menu principal.
		if get_tree().change_scene("res://Scenes/Non Playables/misc/Title Screen.tscn") != OK:
			print("ERRO AO MUDAR DE CENA")
		Global.parte = "fim"


# Esta função adiciona a próxima linha aos créditos.
func add_line():
	# Duplica a linha original para criar uma nova linha
	var new_line = line.duplicate()
	# Define o texto da nova linha como o próximo elemento na lista de seções
	new_line.text = section.pop_front()
	# Adiciona a nova linha à lista de linhas
	lines.append(new_line)
	# Se a nova linha for a primeira da seção, muda a cor da fonte, aumenta o tamanho e move sua posição horizontal
	if curr_line == 0:
		new_line.add_color_override("font_color", title_color)
		new_line.rect_position = Vector2(new_line.rect_position.x - 35, new_line.rect_position.y)
		new_line.set_scale(Vector2(1.2, 1.2))
		# Adiciona a nova linha como uma criança do nó CreditsContainer para ser exibido na tela
		$CreditsContainer.add_child(new_line)
	
	# Verifica se ainda existem elementos na lista de seções. Se existir, avança para a próxima linha da seção atual.
	if section.size() > 0:
		curr_line += 1
		section_next = false
	# Se não houver mais elementos na lista de seções, avança para a próxima seção.
	else:
		section_next = true

# Quando o botão é pressionado, a velocidade é aumentada
func _on_TextureButton_button_down():
	buttonPressed = true
	speed_up = true

# Quando o botão é solto, a velocidade é restaurada
func _on_TextureButton_button_up():
	buttonPressed = false
	speed_up = false
