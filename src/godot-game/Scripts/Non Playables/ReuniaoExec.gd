extends CanvasLayer

func _ready():
	$"DialogBox 2/TexturaCaixa"._startDialog()

func _on_dialog_finish():
	yield(get_tree().create_timer(1.0), "timeout")
	if get_tree().change_scene("res://Scenes/Playables/Environment/Executivo.tscn") != OK:
		print("ERRO AO MUDAR DE CENA")