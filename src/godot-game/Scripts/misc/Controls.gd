extends Control
onready var volPer = get_node("volPercentageLabel")

# Define a função que será chamada quando o botão "BackButton" for pressionado
func _on_BackButton_pressed() -> void:
	# Obtém a árvore de cenas e muda para a cena "Title Screen.tscn" quando o botão é pressionado
	if get_tree().change_scene("res://Scenes/Non Playables/misc/Title Screen.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the scene")

func _ready():
	volPer.text = str(100) + " %"
	$HSlider.connect("value_changed", self, "_on_HSlider_value_changed")
	
func setVolPercentage(vol):
	volPer.text = str(vol) + " %"
	
func _on_HSlider_value_changed(value):
	# Set volume global com o valor do slider
	AudioServer.set_bus_volume_db(0, linear2db(value))
	setVolPercentage(value)
	
