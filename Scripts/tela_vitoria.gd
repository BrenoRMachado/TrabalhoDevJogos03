extends Control

func _ready():
	# Solta o mouse
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_btn_menu_pressed():
	# Volta para o menu
	get_tree().change_scene_to_file("res://Cenas/menu_principal.tscn")

func _on_btn_sair_pressed():
	# Fecha o jogo com chave de ouro
	get_tree().quit()
