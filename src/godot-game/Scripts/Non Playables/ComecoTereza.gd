extends AnimatedSprite

# Controlamos a animacao, definindo ela como tocando
func _ready():
	self.playing = true
	
# Quando a animacao acaba, mudamos a cena para a cidade
func _on_ComecoTereza_animation_finished():
	if get_tree().change_scene("res://Scenes/Playables/Environment/Cidade.tscn") != OK:
		print("ERRO AO MUDAR DE CENA")
