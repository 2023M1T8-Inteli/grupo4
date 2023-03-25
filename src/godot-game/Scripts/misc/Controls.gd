extends Control

# Define a variável onready para guardar a referência ao label "volPercentageLabel"
onready var volPer = get_node("volPercentageLabel")

# Função chamada quando o botão "BackButton" for pressionado
func _on_BackButton_pressed() -> void:
	# Obtém a árvore de cenas e muda para a cena "Title Screen.tscn" quando o botão é pressionado
	if get_tree().change_scene("res://Scenes/Non Playables/misc/Title Screen.tscn") != OK:
		print("Ocorreu um erro ao tentar mudar para a cena.")

# Função executada quando a cena estiver pronta
func _ready():
	# Atualiza o label com o valor do volume global
	volPer.text = str(Global.volPercentage) + " %"
	
	# Atualiza o valor do slider com o valor do volume global
	$HSlider.value = Global.volPercentage
	
	# Conecta o sinal "value_changed" do slider com a função "_on_HSlider_value_changed"
	if $HSlider.connect("value_changed", self, "_on_HSlider_value_changed") != OK:
		print("Ocorreu um erro ao conectar o sinal.")
	
	# Define a posição de playback do áudio
	$Audio.set_playback_pos("res://Audio Files/TitleScreen.mp3", Global.playbackPos)
	
	# Define o volume do áudio
	$Audio.set_volume(Global.volPercentage)

# Função chamada quando o valor do slider for alterado
func _on_HSlider_value_changed(value):
	# Redefine o volume global com o valor do slider
	Global.volPercentage = value
	
	# Define o volume do áudio
	$Audio.set_volume(value)
	
	# Atualiza o label com o valor do volume global
	volPer.text = str(value) + " %"

# Função chamada quando a cena de controles estiver fechando
func _on_Controls_tree_exiting():
	# Imprime a posição atual de playback do áudio
	print($Audio.get_playback_pos())
