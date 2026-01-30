extends CanvasLayer

func _ready():
	visible = false # Garante que começa escondido

func _input(event):
	# Se apertar ESC (ui_cancel já é configurado como ESC por padrão no Godot)
	if event.is_action_pressed("ui_cancel"):
		if visible:
			despausar()
		else:
			pausar()

func pausar():
	visible = true
	get_tree().paused = true # CONGELA O JOGO
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE # Solta o mouse pra clicar

func despausar():
	visible = false
	get_tree().paused = false # DESCONGELA O JOGO
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED # Prende o mouse de novo (pra mirar)

# --- Botões ---

func _on_btn_continuar_pressed():
	despausar()

func _on_btn_menu_pressed():
	# Antes de sair, precisa despausar, senão o Menu Principal carrega congelado!
	get_tree().paused = false 
	get_tree().change_scene_to_file("res://Cenas/menu_principal.tscn")
