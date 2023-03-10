extends Camera2D

var amplitude = 30
var frequency = 3

func _process(_delta):
	if Global.isDrunk == true:
		var time = OS.get_ticks_msec() / 1000.0
		var x_offset = amplitude * sin(time * frequency)
		var y_offset = amplitude * cos(time * frequency)
		var offset = Vector2(x_offset, y_offset)
		var player_pos = get_parent().global_position
		var new_pos = player_pos + offset
		set_global_position(new_pos)
