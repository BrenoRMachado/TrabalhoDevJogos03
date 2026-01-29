extends CanvasLayer

@onready var barra_vida = $BarraVida

# Essa função será chamada pelo script do Player (esqueleto) depois
func atualizar_vida(nova_vida):
	# Garante que a vida não passe de 100 nem seja menor que 0
	barra_vida.value = clamp(nova_vida, 0, 100)
