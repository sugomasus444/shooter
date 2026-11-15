extends CharacterBody2D

@export var player: CharacterBody2D
var speed = 200

func _ready() -> void:
	$AnimationPlayer.play("new_animation")

func _physics_process(delta: float) -> void:
	if global_position.distance_to(player.global_position) < 800:
		velocity = global_position.direction_to(player.global_position) * speed
	move_and_slide()

var health = 3
func hurt(dmg):
	health -= dmg
	if health<=0:
		queue_free()
		
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("hurt"):
		area.get_parent().hurt(1)
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("hurt"):
		body.hurt(1)
		queue_free()
