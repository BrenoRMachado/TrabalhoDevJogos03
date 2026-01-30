extends Node3D

@export var velocidade = 15.0
@export var tempo_vida = 4.0
@onready var area_deteccao = $Area3D

var direcao_voo = Vector3.ZERO
var atingiu = false


func _ready() -> void:
	get_tree().create_timer(tempo_vida).timeout.connect(queue_free)

func _physics_process(delta: float) -> void:
	var para_frente = -global_transform.basis.y
	if !atingiu:
		global_position += para_frente * velocidade * delta

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.has_method("receber_dano"):
		body.receber_dano() 
	queue_free() 
