extends CharacterBody3D


@export var velocidade = 3.0
@export var distancia_ataque = 1.5
@export var vida = 3
@export var player : CharacterBody3D

@onready var pathfinding = $NavigationAgent3D
@onready var visual = $Knight
@onready var animacao = $Knight/AnimationPlayer

var selection = SelectorNode.new(self)
var pode_atacar = true

func _ready() -> void:
	var no_atacar = Atacar.new(self)
	var no_perseguir = Perseguir.new(self)
	
	selection.add_child(no_atacar)
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
	if not pode_atacar:
		return
	velocity.x = 0
	velocity.z = 0
	
	var direcao_ao_player = global_position.direction_to(player.global_position)
	visual.look_at(global_position + direcao_ao_player, Vector3.UP)
	visual.rotate_object_local(Vector3.UP, PI)
	animacao.play("Rig_Medium_General/Throw")
	
	pode_atacar = false
	await animacao.animation_finished
	animacao.play("Rig_Medium_General/Idle_A")
	await get_tree().create_timer(2.0).timeout
	pode_atacar = true
	
func receber_dano():
	vida -= 1
	print("Inimigo atingido! Vida: ", vida)
	animacao.play("Rig_Medium_General/Hit_A")
	if vida <= 0:
		animacao.play("Rig_Medium_General/Death_A")
		await animacao.animation_finished
		queue_free()
