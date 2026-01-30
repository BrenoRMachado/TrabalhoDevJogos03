extends CharacterBody3D

@onready var visual = $Skeleton_Rogue
@onready var animacao = $Skeleton_Rogue/AnimationPlayer
@onready var spawn_flecha = $Skeleton_Rogue/Rig_Medium/Skeleton3D/BoneAttachment3D/Skeleton_Crossbow2/Arrow_Spawn
@onready var centro_camera = $CameraCentro

@export var hud : CanvasLayer
@export var andando = 5.0
@export var correndo = 8.0
@export var forca_pulo = 11.0
@export var rotacao = 10.0
@export var vida = 5

@export var sensibilidade_mouse = 0.005

const CENA_FLECHA = preload("res://Cenas/Player/Flecha.tscn")

var gravidade = ProjectSettings.get_setting("physics/3d/default_gravity")
var esta_atacando = false
var esta_pulando = false
var esta_apanhando = false

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		centro_camera.rotate_y(-event.relative.x * sensibilidade_mouse)
		
		var braco = centro_camera.get_child(0)
		braco.rotation.x = clamp(braco.rotation.x - event.relative.y * sensibilidade_mouse, -1.2, 0.5)

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y -= gravidade * delta
	
	if is_on_floor():
		esta_pulando = false
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not esta_atacando:
		esta_pulando = true
		velocity.y = forca_pulo
		animacao.play("Rig_Medium_MovementBasic/Jump_Idle")
	
	if Input.is_action_just_pressed("left_click") and not esta_atacando and not esta_pulando:
		ataque()
	
	movimento(delta)
	move_and_slide()

func movimento(delta: float) -> void:
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direcao = (centro_camera.global_transform.basis * Vector3(input.x, 0, input.y)).normalized()
	var velocidade_atual = andando
	
	if Input.is_key_pressed(KEY_SHIFT):
		velocidade_atual = correndo
	
	if direcao:
		velocity.x = direcao.x * velocidade_atual
		velocity.z = direcao.z * velocidade_atual
		
		var alvo_rotacao = atan2(direcao.x, direcao.z)
		visual.rotation.y = lerp_angle(visual.rotation.y, alvo_rotacao, delta * 10.0)
		
		if not esta_atacando and not esta_pulando and not esta_apanhando:
			animacao.play("Rig_Medium_MovementBasic/Running_A")
	
	else:
		velocity.x = move_toward(velocity.x, 0, velocidade_atual)
		velocity.z = move_toward(velocity.z, 0, velocidade_atual)
		
		if not esta_atacando and not esta_pulando and not esta_apanhando:
			animacao.play("Rig_Medium_General/Idle_A")

func ataque():
	esta_atacando = true
	animacao.play("Rig_Medium_General/Interact")
	
	var flecha = CENA_FLECHA.instantiate()
	get_tree().root.add_child(flecha)
	
	flecha.global_position = spawn_flecha.global_position
	
	flecha.global_rotation = Vector3(0, visual.global_rotation.y, 0)
	
	flecha.rotate_object_local(Vector3.RIGHT, deg_to_rad(-90))
	
	await animacao.animation_finished
	esta_atacando = false
	
func receber_dano():
	vida -= 1
	esta_apanhando = true
	
	if hud and hud.has_method("atualizar_vida"):
		hud.atualizar_vida(vida)
	
	var tree = get_tree()
	
	animacao.play("Rig_Medium_General/Hit_A")
	
	if vida <= 0:
		animacao.play("Rig_Medium_General/Death_A")
		await animacao.animation_finished
		if tree:
			tree.change_scene_to_file("res://Cenas/Telas/tela_game_over.tscn")
	else:
		await animacao.animation_finished
		esta_apanhando = false
