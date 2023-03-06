extends Sprite

var leftPress
var rightPress
var upPress
var downPress


func _process(_delta):
	$JoystickLeftPressed.visible = Global.leftPress
	$JoystickRightPressed.visible = Global.rightPress
	$JoystickUpPressed.visible = Global.upPress
	$JoystickDownPressed.visible = Global.downPress
	$JoystickMidPressed.visible = Global.midPress if Global.closeToSomething else false

	$JoystickMidUnavailable.visible = Global.closeToSomething
