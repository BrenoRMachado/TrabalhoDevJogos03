extends Control

@onready var sfx_hover = $SfxHover

func _ready():
	# IMPORTANTE: Solta o mouse para o jogador poder clicar
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_btn_reiniciar_pressed():
	# Recarrega a cena atual (o jogo recomeça)
	get_tree().reload_current_scene()

func _on_btn_menu_pressed():
	# Troca para o menu principal
	get_tree().change_scene_to_file("res://Cenas/menu_principal.tscn")

# --- FUNÇÃO DO SOM DE HOVER ---
# Esta é a função que todos os botões vão usar
func _on_botao_mouse_entered():
	# Dica Pro: Variar levemente o tom (pitch) deixa o som menos robótico
	sfx_hover.pitch_scale = randf_range(0.9, 1.1) 
	
	# Toca o som
	sfx_hover.play()
