extends AnimatedSprite

# Controlamos a animacao, definindo ela como tocando
func _ready():
	self.playing = true
	
# Quando a animacao acaba, mudamos a cena para a cidade
func _on_ComecoTereza_animation_finished():
	if Global.parte != "fim" and Global.parte != "tecnico":
		if get_tree().change_scene("res://Scenes/Playables/Environment/Cidade.tscn") != OK:
			print("ERRO AO MUDAR DE CENA")
	elif Global.parte == "tecnico":
		if get_tree().change_scene("res://Scenes/Playables/Environment/Tecnico.tscn") != OK:
			print("ERRO AO MUDAR DE CENA")
	elif Global.parte == "fim":
		if get_tree().change_scene("res://Scenes/Non Playables/misc/Title Screen.tscn") != OK:
			print("ERRO AO MUDAR DE CENA")
