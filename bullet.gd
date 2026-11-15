extends CharacterBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("hurt"):
		area.get_parent().hurt(1)
		queue_free()


func _on_timer_timeout() -> void:
	queue_free()
