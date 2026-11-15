extends Node2D

@export var player: CharacterBody2D


func _on_spiekes_body_entered(body: Node2D) -> void:
	print(body)
	if body.has_method("hurt"):
		body.hurt(11)
		queue_free()
