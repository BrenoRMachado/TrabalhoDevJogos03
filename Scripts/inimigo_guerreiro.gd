extends CharacterBody3D


@export var velocidade = 3.0
@export var distancia_ataque = 0.8
@export var vida = 3
@export var player : CharacterBody3D
var esta_morto = false

@onready var pathfinding = $NavigationAgent3D
@onready var visual = $Knight
@onready var animacao = $Knight/AnimationPlayer
@onready var espada = $Knight/Rig_Medium/Skeleton3D/BoneAttachment3D/sword_1handed2/Area3D
@onready var colisao_espada = $Knight/Rig_Medium/Skeleton3D/BoneAttachment3D/sword_1handed2/Area3D/CollisionShape3D
@onready var som_ataque = $SomAtaque
@onready var som_dano = $SomDano

var selection = SelectorNode.new(self)
var pode_atacar = true

func _ready() -> void:
	var no_atacar = Atacar.new(self)
	var no_perseguir = Perseguir.new(self)
	
	colisao_espada.disabled = true
	espada.body_entered.connect(_on_espada_body_entered)
	
	selection.add_child(no_atacar)
	selection.add_child(no_perseguir)

func _physics_process(_delta: float) -> void:
	if esta_morto:
		return

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

func _on_espada_body_entered(body):
	if body == player and body.has_method("receber_dano"):
		body.receber_dano()
		colisao_espada.set_deferred("disabled", true)

func atacar():
	if not pode_atacar:
		return
	velocity.x = 0
	velocity.z = 0
	
	var direcao_ao_player = global_position.direction_to(player.global_position)
	visual.look_at(global_position + direcao_ao_player, Vector3.UP)
	visual.rotate_object_local(Vector3.UP, PI)
	animacao.play("Rig_Medium_General/Throw")
	
	if som_ataque:
		som_ataque.pitch_scale = randf_range(0.8, 1.2) # Variedade no som
		som_ataque.play()
	
	colisao_espada.disabled = false
	
	pode_atacar = false
	await animacao.animation_finished
	animacao.play("Rig_Medium_General/Idle_A")
	colisao_espada.disabled = true
	await get_tree().create_timer(2.0).timeout
	pode_atacar = true
	
func receber_dano():
	if esta_morto:
		return

	vida -= 1
	
	if som_dano:
		som_dano.play()
	
	print("Inimigo atingido! Vida: ", vida)
	animacao.play("Rig_Medium_General/Hit_A")
	
	if vida <= 0:
		esta_morto = true
		velocity = Vector3.ZERO
		animacao.play("Rig_Medium_General/Death_A")
		await animacao.animation_finished
		queue_free()
	else:
		animacao.play("Rig_Medium_General/Hit_A")
