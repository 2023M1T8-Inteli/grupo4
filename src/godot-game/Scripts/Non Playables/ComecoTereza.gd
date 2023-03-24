extends AnimatedSprite

func _ready():
	self.playing = true
	

func _on_ComecoTereza_animation_finished():
	if get_tree().change_scene("res://Scenes/Playables/Environment/Cidade.tscn") != OK:
		print("ERRO AO MUDAR DE CENA")
