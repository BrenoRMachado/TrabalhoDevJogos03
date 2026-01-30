extends Control

# Aqui criamos "gavetas" para você arrastar as cenas depois.
# O "*.tscn" filtra para só aceitar arquivos de cena.
@export_file("*.tscn") var cena_do_jogo 
@export_file("*.tscn") var cena_dos_creditos

func _ready():
	# IMPORTANTE PARA SHOOTER 3D:
	# Garante que a setinha do mouse apareça quando o menu abrir
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

# --- FUNÇÕES DOS BOTÕES ---

func _on_btn_jogar_pressed():
	if cena_do_jogo:
		get_tree().change_scene_to_file(cena_do_jogo)
	else:
		print("O botão JOGAR funciona! (Falta criar a cena do jogo)")

func _on_btn_creditos_pressed():
	if cena_dos_creditos:
		get_tree().change_scene_to_file(cena_dos_creditos)

func _on_btn_sair_pressed():
	# Fecha o jogo
	get_tree().quit()
