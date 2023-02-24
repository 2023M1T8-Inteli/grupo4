extends CanvasLayer

onready var blueButtons = [$blueWire/blueYellowButton, $blueWire/blueBlueButton, $blueWire/bluePurpleButton, $blueWire/blueRedButton]
onready var redButtons = [$redWire/redYellowButton, $redWire/redBlueButton, $redWire/redPurpleButton, $redWire/redRedButton]
onready var yellowButtons = [$yellowWire/yellowYellowButton, $yellowWire/yellowBlueButton, $yellowWire/yellowPurpleButton, $yellowWire/yellowRedButton]
onready var purpleButtons = [$purpleWire/purpleYellowButton, $purpleWire/purpleBlueButton, $purpleWire/purplePurpleButton, $purpleWire/purpleRedButton]

signal task_complete

onready var blueWires = [$blueWire/blueToYellow, $blueWire/blueToBlue, $blueWire/blueToPurple, $blueWire/blueToRed]
onready var redWires = [$redWire/redToYellow, $redWire/redToBlue, $redWire/redToPurple, $redWire/redToRed]
onready var yellowWires = [$yellowWire/yellowToYellow, $yellowWire/yellowToBlue, $yellowWire/yellowToPurple, $yellowWire/yellowToRed]
onready var purpleWires = [$purpleWire/purpleToYellow, $purpleWire/purpleToBlue, $purpleWire/purpleToPurple, $purpleWire/purpleToRed]


var blueCorrect = false
var redCorrect = false
var purpleCorrect = false
var yellowCorrect = false


func _process(delta):
	if blueCorrect == true and redCorrect == true and purpleCorrect == true and yellowCorrect == true:
		print("TODOS MEUS OVOS COLORIDOS")
		emit_signal("task_complete")
		$ColorRect.visible = true
		blueCorrect = false
		redCorrect = false
		purpleCorrect = false
		yellowCorrect = false

func _on_blueButton_pressed():
	for i in blueButtons:
		i.mouse_filter = Control.MOUSE_FILTER_STOP
	for i in redButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for i in yellowButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for i in purpleButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
func _on_redButton_pressed():
	for i in blueButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for i in redButtons:
		i.mouse_filter = Control.MOUSE_FILTER_STOP
	for i in yellowButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for i in purpleButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
func _on_yellowButton_pressed():
	for i in blueButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for i in redButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for i in yellowButtons:
		i.mouse_filter = Control.MOUSE_FILTER_STOP
	for i in purpleButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
func _on_purpleButton_pressed():
	for i in blueButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for i in redButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for i in yellowButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for i in purpleButtons:
		i.mouse_filter = Control.MOUSE_FILTER_STOP



func _on_blueYellowButton_pressed():
	for i in blueWires:
		i.visible = false
	$blueWire/blueToYellow.visible = true
func _on_blueBlueButton_pressed():
	for i in blueWires:
		i.visible = false
	$blueWire/blueToBlue.visible = true
	print("MEUS OVOS AZUIS")
	blueCorrect = true
	
	for i in blueButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$blueWire/blueButton.mouse_filter = Control.MOUSE_FILTER_IGNORE
		
func _on_blueRedButton_pressed():
	for i in blueWires:
		i.visible = false
	$blueWire/blueToRed.visible = true
func _on_bluePurpleButton_pressed():
	for i in blueWires:
		i.visible = false
	$blueWire/blueToPurple.visible = true

func _on_redPurpleButton_pressed():
	for i in redWires:
		i.visible = false
	$redWire/redToPurple.visible = true
func _on_redRedButton_pressed():
	for i in redWires:
		i.visible = false
	$redWire/redToRed.visible = true
	print("MEUS OVOS VERMELHOS")
	redCorrect = true
	
	for i in redButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$redWire/redButton.mouse_filter = Control.MOUSE_FILTER_IGNORE
func _on_redBlueButton_pressed():
	for i in redWires:
		i.visible = false
	$redWire/redToBlue.visible = true
func _on_redYellowButton_pressed():
	for i in redWires:
		i.visible = false
	$redWire/redToYellow.visible = true

func _on_yellowYellowButton_pressed():
	for i in yellowWires:
		i.visible = false
	$yellowWire/yellowToYellow.visible = true
	print("MEUS OVOS AMARELOS")
	yellowCorrect = true
	
	for i in yellowButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$yellowWire/yellowButton.mouse_filter = Control.MOUSE_FILTER_IGNORE
func _on_yellowBlueButton_pressed():
	for i in yellowWires:
		i.visible = false
	$yellowWire/yellowToBlue.visible = true
func _on_yellowRedButton_pressed():
	for i in yellowWires:
		i.visible = false
	$yellowWire/yellowToRed.visible = true
func _on_yellowPurpleButton_pressed():
	for i in yellowWires:
		i.visible = false
	$yellowWire/yellowToPurple.visible = true

func _on_purpleYellowButton_pressed():
	for i in purpleWires:
		i.visible = false
	$purpleWire/purpleToYellow.visible = true
func _on_purpleRedButton_pressed():
	for i in purpleWires:
		i.visible = false
	$purpleWire/purpleToRed.visible = true
func _on_purpleBlueButton_pressed():
	for i in purpleWires:
		i.visible = false
	$purpleWire/purpleToBlue.visible = true
func _on_purplePurpleButton_pressed():
	for i in purpleWires:
		i.visible = false
	$purpleWire/purpleToPurple.visible = true
	print("MEUS OVOS ROXOS")
	purpleCorrect = true
	
	for i in purpleButtons:
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$purpleWire/purpleButton.mouse_filter = Control.MOUSE_FILTER_IGNORE
