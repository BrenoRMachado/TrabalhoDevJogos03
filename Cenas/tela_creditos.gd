extends Control

func _ready():
	# Garante que o mouse esteja visível
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_btn_voltar_pressed():
	# Volta para o menu principal
	get_tree().change_scene_to_file("res://Cenas/menu_principal.tscn")


func _on_rich_text_label_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta)) # Replace with function body.
