class_name Projectile extends Area2D

@export var direction: Vector2
@export var damage: int

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _init( _direction: Vector2=Vector2(0, 0), _damage: int=1) -> void:
	direction = _direction
	damage = _damage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += direction.x * delta
	position.y += direction.y * delta
	
func _on_area_entered(area: Area2D) -> void:
	if area is Damageable:
		area.damage(damage)
		#TODO: explosion animation or something
		
		queue_free()
