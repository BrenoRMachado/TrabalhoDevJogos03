extends Control

@onready var sfx_hover = $SfxHover

func _ready():
	# Solta o mouse
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_btn_menu_pressed():
	# Volta para o menu
	get_tree().change_scene_to_file("res://Cenas/menu_principal.tscn")

func _on_btn_sair_pressed():
	# Fecha o jogo com chave de ouro
	get_tree().quit()

# --- FUNÇÃO DO SOM DE HOVER ---
# Esta é a função que todos os botões vão usar
func _on_botao_mouse_entered():
	# Dica Pro: Variar levemente o tom (pitch) deixa o som menos robótico
	sfx_hover.pitch_scale = randf_range(0.9, 1.1) 
	
	# Toca o som
	sfx_hover.play()
