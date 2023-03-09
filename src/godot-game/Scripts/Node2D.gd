extends Sprite

var active_objective = Global.activeObjective[1]

func _ready():
	Global.activeObjective[0] == false
func _process(_delta):
	if Global.activeObjective[0] == true:
		var angle = atan2(active_objective.y - self.global_position.y, active_objective.x - self.global_position.x)
		var radius = 80  # adjust this to change the radius of the circle
		var x = cos(angle) * radius
		var y = sin(angle) * radius
		self.global_position = self.get_parent().global_position + Vector2(x, y)
		self.rotation = angle
	if Global.activeObjective[0] == false:
		self.visible = false
