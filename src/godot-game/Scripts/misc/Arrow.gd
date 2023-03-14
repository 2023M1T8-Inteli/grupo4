extends Sprite

# Variável que guarda o objetivo ativo
var active_objective = Global.activeObjective[1]

func _ready():
	# Verifica se o objetivo está ativo, caso esteja, desativa (para impedir de que haja objetivos ativos em outras cenas)
	if Global.activeObjective[0] == true:
		Global.activeObjective[0] = false

func _process(_delta):
	# Verifica se o objetivo está ativo
	if Global.activeObjective[0] == true:
		# Calcula o ângulo entre o objeto atual e o objetivo
		var angle = atan2(active_objective.y - self.global_position.y, active_objective.x - self.global_position.x)
		# Define o raio do círculo ao redor do objetivo
		var radius = 45  # Ajuste aqui para mudar o raio do círculo
		# Calcula as coordenadas do objeto dentro do círculo ao redor do objetivo
		var x = cos(angle) * radius
		var y = sin(angle) * radius
		# Posiciona o objeto dentro do círculo
		self.global_position = self.get_parent().global_position + Vector2(x, y)
		# Rotaciona o objeto em direção ao objetivo
		self.rotation = angle
	# Caso o objetivo não esteja ativo, torna o objeto invisível
	if Global.activeObjective[0] == false:
		self.visible = false
