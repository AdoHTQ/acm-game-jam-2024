class_name Unit extends CharacterBody2D

@export var unitPower: int

@export var speedMultiplier: int

@export var audioPlayer: AudioStreamPlayer2D

@export var enabled = false

@export var directionalSprite: DirectionalSprite

var hero: Hero

var heroLock: bool

var destination: Vector2

var currentHitbox

func _ready() -> void:
	hero = get_node("/root/Factory/Hero")

func _init() -> void:
	destination = position

func _physics_process(_delta: float) -> void:
	if enabled:
		if heroLock: destination = hero.position
	
		if (abs(position - destination) > Vector2(3, 3)):
			velocity = (destination - position).normalized() * speedMultiplier
		else:
			velocity = Vector2.ZERO

		move_and_slide()
	
func lock_hero(toggle: bool) -> void:
	heroLock = toggle

func _on_damageable_area_entered(body: Node2D) -> void:
	if enabled:
		speedMultiplier = 0
		audioPlayer.play()
		directionalSprite.oneshot("attack")
		if (not body.get_parent() is Unit) and body is Damageable:
			body.damage(20)
			await get_tree().create_timer(0.5).timeout
