extends CanvasLayer

@onready var barra_vida = $BarraVida
@onready var tela_vermelha = $OverlayDano

func _ready():
	barra_vida.max_value = 5
	barra_vida.value = 5
	tela_vermelha.visible = false

func atualizar_vida(nova_vida):
	tela_vermelha.visible = true
	await get_tree().create_timer(0.15).timeout
	tela_vermelha.visible = false
	
	barra_vida.value = nova_vida
