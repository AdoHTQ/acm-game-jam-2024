class_name Projectile extends Area2D

@export var direction: Vector2
@export var damage: int
@export var speed: float

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)

func _init() -> void:
	direction = Vector2(0, 0)
	damage = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process() -> void:
	position += direction * speed
	
func _on_area_entered(area: Area2D) -> void:
	if area is Damageable:
		area.damage(damage)
		#TODO: explosion animation or somethingbwet
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	#TODO: explosion animation or something
	queue_free()
