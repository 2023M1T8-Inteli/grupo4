extends Control

func _on_EthicButton_pressed():
	# redireciona para site da vtal no browser
	if OS.shell_open("https://www.vtal.com/wp-content/uploads/2022/10/man-00002-codigo-de-etica-e-conduta-da-vtal.pdf") != OK:
		print("ERRO AO ABRIR LINK")


# Função chamada quando o botão "BackButton" for pressionado
func _on_BackButton_pressed() -> void:
	# Obtém a árvore de cenas e muda para a cena "Title Screen.tscn" quando o botão é pressionado
	if get_tree().change_scene("res://Scenes/Non Playables/misc/Title Screen.tscn") != OK:
		print("Ocorreu um erro ao tentar mudar para a cena.")
