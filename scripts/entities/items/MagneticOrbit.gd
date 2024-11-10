class_name MagneticOrbit extends ItemBase

var hero: Hero

var orb: PackedScene = preload("res://scenes/entities/OrbProjectile.tscn")

func _ready() -> void:
	hero = get_parent().get_parent()
	upgrade()

func _physics_process(delta: float) -> void:
	rotate(0.04)

func upgrade():
	get_tree().create_timer(1.).timeout.connect(attack)


func attack():
	var instance: Projectile = orb.instantiate()
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.randomize()
	instance.position = position + Vector2(rng.randf_range(-1., 1.), rng.randf_range(-1., 1.)).normalized() * 150.
	instance.damage *= hero.damageMultiplier
	add_child(instance)
	
	get_tree().create_timer(1.).timeout.connect(attack)
