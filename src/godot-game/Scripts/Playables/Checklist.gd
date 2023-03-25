extends CanvasLayer

# Define uma variável que se refere a um nó da cena com a ID "ColorRect"
# Essa variável só será definida quando a cena for carregada
onready var c = $ColorRect

# Define uma variável booleana que trava a condicao if apos sua primeira execucao
var deadbolt = true

# Declara um sinal personalizado chamado "finish"
signal finish

# Define a função _process, que é chamada a cada quadro
func _process(_delta):
	# Verifica se todas as caixas de seleção estão pressionadas e a fechadura está trancada
	if c.get_node("CheckBox").pressed and c.get_node("CheckBox2").pressed and c.get_node("CheckBox3").pressed and c.get_node("CheckBox4").pressed and c.get_node("CheckBox5").pressed and deadbolt:
		# Define a variável "deadbolt" como falsa para indicar que a fechadura não está mais trancada
		deadbolt = false
		
		# Pausa a execução por 0,2 segundos usando um temporizador
		yield(get_tree().create_timer(.2), "timeout")
		
		# Libera o objeto atual (a própria cena) da memória
		self.queue_free()
		
		# Emite o sinal "finish"
		emit_signal("finish")
