extends Node3D

func _ready():
	gerar_colisao_recursiva(self)

func gerar_colisao_recursiva(no):
	if no is MeshInstance3D:
		no.create_trimesh_collision()
	
	for filho in no.get_children():
		gerar_colisao_recursiva(filho)
