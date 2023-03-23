extends Control
onready var volPer = get_node("volPercentageLabel")
# Define a função que será chamada quando o botão "BackButton" for pressionado
func _on_BackButton_pressed() -> void:
	# Obtém a árvore de cenas e muda para a cena "Title Screen.tscn" quando o botão é pressionado
	if get_tree().change_scene("res://Scenes/Non Playables/misc/Title Screen.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the scene")

func _ready():
	volPer.text = str(Global.volPercentage) + " %"
	$HSlider.value = Global.volPercentage
	if $HSlider.connect("value_changed", self, "_on_HSlider_value_changed") != OK:
		print("ERRO AO CONECTAR")
	$Audio.set_playback_pos("res://Audio Files/TitleScreen.mp3" , Global.playbackPos)
	$Audio.set_volume(Global.volPercentage)

func _on_HSlider_value_changed(value):
	# Set volume global com o valor do slider
	Global.volPercentage = value
	$Audio.set_volume(value)
	volPer.text = str(value) + " %"

func _on_Controls_tree_exiting():
	$Audio.get_playback_pos()
	print($Audio.get_playback_pos())
