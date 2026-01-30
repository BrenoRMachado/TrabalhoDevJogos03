extends Control

@onready var sfx_hover = $SfxHover

func _ready():
	# Garante que o mouse esteja visível
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_btn_voltar_pressed():
	# Volta para o menu principal
	get_tree().change_scene_to_file("res://Cenas/menu_principal.tscn")


func _on_rich_text_label_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta)) # Replace with function body.

# --- FUNÇÃO DO SOM DE HOVER ---
# Esta é a função que todos os botões vão usar
func _on_botao_mouse_entered():
	# Dica Pro: Variar levemente o tom (pitch) deixa o som menos robótico
	sfx_hover.pitch_scale = randf_range(0.9, 1.1) 
	
	# Toca o som
	sfx_hover.play()
