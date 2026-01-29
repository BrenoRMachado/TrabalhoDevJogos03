extends Control

func _ready():
	# IMPORTANTE: Solta o mouse para o jogador poder clicar
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_btn_reiniciar_pressed():
	# Recarrega a cena atual (o jogo recomeça)
	get_tree().reload_current_scene()

func _on_btn_menu_pressed():
	# Troca para o menu principal
	get_tree().change_scene_to_file("res://MenuPrincipal.tscn")
