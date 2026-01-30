extends CharacterBody3D


@export var velocidade = 3.0
@export var distancia_ataque = 10.0
@export var vida = 3
@export var player : CharacterBody3D
@export var CENA_FLECHA : PackedScene = preload("res://Cenas/Flecha.tscn")

@onready var pathfinding = $NavigationAgent3D
@onready var visual = $Ranger
@onready var animacao = $Ranger/AnimationPlayer
@onready var spawn_flecha = $Ranger/Rig_Medium/Skeleton3D/BoneAttachment3D/crossbow_1handed2/Arrow_Spawn

var selection = SelectorNode.new(self)
var pode_atirar = true

func _ready() -> void:
	var no_atirar = Atacar.new(self)
	var no_perseguir = Perseguir.new(self)
	
	selection.add_child(no_atirar)
	selection.add_child(no_perseguir)

func _physics_process(_delta: float) -> void:
	if selection:
		selection.process()
	move_and_slide()

func caminhar():
	
	pathfinding.target_position = player.global_position
	var proximo_ponto = pathfinding.get_next_path_position()
	var direcao = global_position.direction_to(proximo_ponto)
	
	velocity.x = direcao.x * velocidade
	velocity.z = direcao.z * velocidade
	
	if velocity.length() > 0.1:
		visual.look_at(global_position + Vector3(velocity.x, 0, velocity.z), Vector3.UP)
		visual.rotate_object_local(Vector3.UP, PI)
		animacao.play("Rig_Medium_MovementBasic/Running_A")

func player_perto():
	var distancia = global_position.distance_to(player.global_position)
	return distancia <= distancia_ataque

func atacar():
	if not pode_atirar:
		return
	
	velocity.x = 0
	velocity.z = 0
	
	var direcao_ao_player = global_position.direction_to(player.global_position)
	visual.look_at(global_position + direcao_ao_player, Vector3.UP)
	visual.rotate_object_local(Vector3.UP, PI)
	animacao.play("Rig_Medium_General/Interact")
	
	var flecha = CENA_FLECHA.instantiate()
	get_tree().root.add_child(flecha)
	flecha.global_position = spawn_flecha.global_position
	var alvo_horizontal = Vector3(player.global_position.x, spawn_flecha.global_position.y, player.global_position.z)
	flecha.look_at(alvo_horizontal, Vector3.UP)
	flecha.rotate_object_local(Vector3.UP, PI)
	flecha.rotate_object_local(Vector3.RIGHT, deg_to_rad(-90))
	
	pode_atirar = false
	await animacao.animation_finished
	animacao.play("Rig_Medium_General/Idle_A")
	await get_tree().create_timer(2.0).timeout
	pode_atirar = true
