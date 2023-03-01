extends Sprite

var leftPress
var rightPress
var upPress
var downPress


func _process(_delta):
	leftPress = Global.leftPress
	rightPress = Global.rightPress
	upPress = Global.upPress
	downPress = Global.downPress
	$JoystickLeftPressed.visible = leftPress
	$JoystickRightPressed.visible = rightPress
	$JoystickUpPressed.visible = upPress
	$JoystickDownPressed.visible = downPress

#	$JoystickMidPressed.visible = false
