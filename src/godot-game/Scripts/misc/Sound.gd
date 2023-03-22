extends Node

var currentPos
var volume

func get_playback_pos():
	Global.playbackPos = $Music.get_playback_position()
	currentPos = Global.playbackPos
	return currentPos

func set_playback_pos(path, pos):
	$Music.stream = load(path)
	$Music.play(pos)

func stop():
	$Music.playing = false

func set_volume(vol):
	if vol == 0:
		volume = -80
	else:
		volume = (vol * 0.25) - 35
	Global.volume = volume
	$Music.set_volume_db(volume)
	$Ambient.set_volume_db(volume)
	
func play_ambient(path):
	$Ambient.stream = load(path)
	$Ambient.set_volume_db(Global.volume)
	$Ambient.play()


func _on_HSlider_value_changed(value):
	# Set volume global com o valor do slider
	Global.volPercentage = value
	set_volume(value)
