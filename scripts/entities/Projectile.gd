class_name Projectile extends Area2D

@export var direction: Vector2
@export var damage: int
@export var speed: float
@export var lifetime: float

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	lifetime -= delta
	if lifetime < 0: queue_free()
	position += direction * speed
	
func _on_area_entered(area: Area2D) -> void:
	if area is Damageable:
		area.damage(damage)
		#TODO: explosion animation or somethingbwet
		queue_free()

func _on_body_entered(_body: Node2D) -> void:
	#TODO: explosion animation or something
	queue_free()
