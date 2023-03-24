extends Node2D

const section_time := 2.0
const line_time := 0.3
const base_speed := 60
const speed_up_multiplier := 10.0
const title_color := Color("D5FF00")

var buttonPressed

var scroll_speed := base_speed
var speed_up := false

onready var line := $CreditsContainer/Line
var started := false
var finished := false

var section
var section_next := true
var section_timer := 0.0
var line_timer := 0.0
var curr_line := 0
var lines := []

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


func _process(delta):
	var scroll_speedProc = base_speed * delta
	
	if section_next:
		section_timer += delta * speed_up_multiplier if speed_up else delta
		if section_timer >= section_time:
			section_timer -= section_time
			
			if credits.size() > 0:
				started = true
				section = credits.pop_front()
				curr_line = 0
				add_line()
	
	else:
		line_timer += delta * speed_up_multiplier if speed_up else delta
		if line_timer >= line_time:
			line_timer -= line_time
			add_line()
	
	if speed_up:
		scroll_speedProc *= speed_up_multiplier
	
	if lines.size() > 0:
		for l in lines:
			l.rect_position.y -= scroll_speedProc
			if l.rect_position.y < -l.get_line_height():
				lines.erase(l)
				l.queue_free()
	elif started:
		finish()


func finish():
	if not finished:
		finished = true
		
		# NOTE: This is called when the credits finish
		# - Hook up your code to return to the relevant scene here, eg...
		yield(get_tree().create_timer(2), "timeout")
		if get_tree().change_scene("res://Scenes/Non Playables/misc/Title Screen.tscn") != OK:
			print("ERROR ON SCENE CHANGE")
		Global.parte = "fim"

func add_line():
	var new_line = line.duplicate()
	new_line.text = section.pop_front()
	lines.append(new_line)
	if curr_line == 0:
		new_line.add_color_override("font_color", title_color)
		new_line.rect_position = Vector2(new_line.rect_position.x-35, new_line.rect_position.y)
		new_line.set_scale(Vector2(1.2, 1.2))
	$CreditsContainer.add_child(new_line)
	
	if section.size() > 0:
		curr_line += 1
		section_next = false
	else:
		section_next = true


func _on_TextureButton_button_down():
	buttonPressed = true
	speed_up = true


func _on_TextureButton_button_up():
	buttonPressed = false
	speed_up = false
