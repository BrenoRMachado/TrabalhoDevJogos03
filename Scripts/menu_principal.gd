extends Control

# Aqui criamos "gavetas" para você arrastar as cenas depois.
# O "*.tscn" filtra para só aceitar arquivos de cena.
@export_file("*.tscn") var cena_do_jogo 
@export_file("*.tscn") var cena_dos_creditos
@onready var sfx_hover = $SfxHover


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

# --- FUNÇÃO DO SOM DE HOVER ---
# Esta é a função que todos os botões vão usar
func _on_botao_mouse_entered():
	# Dica Pro: Variar levemente o tom (pitch) deixa o som menos robótico
	sfx_hover.pitch_scale = randf_range(0.9, 1.1) 
	
	# Toca o som
	sfx_hover.play()
