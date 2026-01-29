extends CanvasLayer

@onready var barra_vida = $BarraVida
@onready var anim_player = $AnimationPlayer # Pegue a referência do AnimationPlayer

func atualizar_vida(nova_vida):
	# Se a vida diminuiu (tomou dano), toca o flash
	if nova_vida < barra_vida.value:
		anim_player.play("dano")
		
	barra_vida.value = clamp(nova_vida, 0, 100)
