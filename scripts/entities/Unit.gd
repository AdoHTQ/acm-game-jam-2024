class_name Unit extends CharacterBody2D

@export var unitPower: int

@export var speedMultiplier: int

@export var destination: Vector2

var hero: Hero

var heroLock: bool

var currentHitbox

func _ready() -> void:
	hero = get_node("/root/Factory/Hero")

func _init() -> void:
	speedMultiplier = 1
	destination = position

func _physics_process(delta: float) -> void:
	
	if heroLock: destination = hero.position
	
	if (abs(position - destination) > Vector2(3, 3)):
		velocity = (destination - position).normalized() * speedMultiplier
	else:
		velocity = Vector2.ZERO

	move_and_slide()
	
func lock_hero(toggle: bool) -> void:
	heroLock = toggle

func _on_damageable_area_entered(body: Node2D) -> void:
	if not body.get_parent() is Unit and body.has_method("damage"):
		print("haha lol")
		body.damage(20)
		await get_tree().create_timer(0.5).timeout
