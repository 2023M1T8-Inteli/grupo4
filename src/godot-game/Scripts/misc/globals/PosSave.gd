extends Node

# Define se o comando de salvar posição está ativo ou não
var savePosCommand = false

# Define as posições padrão das cidades, ADM e Prelude
var posCidade = Vector2(368, 624)
var posADM = Vector2(294,87)
var posPrelude = Vector2(117, 175)
var posTecnico = Vector2(915, 748)

# Define a posição da cena atual e a posição atual do jogador
var posScene
var currentPos = Vector2(0,0)

# Armazena a posição do toque do jogador
var touchPos:Vector2
