extends CanvasLayer

func _ready():
	# Inicia o diálogo ao carregar a cena
	$"DialogBox 2/TexturaCaixa"._startDialog()

func _on_dialog_finish():
	# Aguarda 1 segundo antes de mudar a cena
	yield(get_tree().create_timer(1.0), "timeout")
	
	# Muda a cena para "Executivo.tscn" quando o diálogo terminar
	if get_tree().change_scene("res://Scenes/Playables/Environment/Executivo.tscn") != OK:
		# Em caso de erro ao mudar de cena, imprime mensagem no console
		print("ERRO AO MUDAR DE CENA")
