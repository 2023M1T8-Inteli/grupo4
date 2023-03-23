extends CanvasLayer

onready var c = $ColorRect
var deadbolt = true

signal finish

func _process(_delta):
	if c.get_node("CheckBox").pressed == true and c.get_node("CheckBox2").pressed == true and c.get_node("CheckBox3").pressed == true and c.get_node("CheckBox4").pressed == true and c.get_node("CheckBox5").pressed == true and deadbolt:
		deadbolt = false
		yield(get_tree().create_timer(.2), "timeout")
		self.queue_free()
		emit_signal("finish")
