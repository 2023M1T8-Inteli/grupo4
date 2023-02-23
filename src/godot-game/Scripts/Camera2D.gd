extends Camera2D

onready var guiWasVisible
onready var dialogWasVisible

#func _ready():
#	$GUI.visible = false
#	$DialogBox.visible = true

#func _on_TexturaCaixa_finish():
#	$DialogBox.visible = false
##	SceneTransition.change_scene("res://Scenes/Reincarn.tscn")
##	yield(get_tree().create_timer(10), "timeout")
#	$GUI.visible = true
#	SceneTransition.change_scene("res://Scenes/Cidade.tscn")

func _on_PauseButton_pressed():
	if $GUI.visible == true:
		$GUI.visible = false
		guiWasVisible = true
	else:
		$GUI.visible = false
		guiWasVisible = false
	if $DialogBox.visible == true:
		$DialogBox.visible = false
		dialogWasVisible = true
	else:
		$DialogBox.visible = false
		dialogWasVisible = false
	
	$PauseScreen.visible = true
	
	get_node("PauseScreen/StartButton").mouse_filter = Control.MOUSE_FILTER_STOP
	get_node("PauseScreen/QuitButton").mouse_filter = Control.MOUSE_FILTER_STOP
	

func _on_StartButton_pressed():
	get_node("PauseScreen/StartButton").mouse_filter = Control.MOUSE_FILTER_IGNORE
	get_node("PauseScreen/QuitButton").mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	if dialogWasVisible:
		$DialogBox.visible = true
	if guiWasVisible:
		$GUI.visible =true
		
	$PauseScreen.visible = false


func _on_QuitButton_pressed():
	SceneTransition.change_scene("res://Scenes/Title Screen.tscn")
