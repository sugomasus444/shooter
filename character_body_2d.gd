extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -600.0

var doublejump = false
func _physics_process(delta: float) -> void:
	if(global_position.y > 5600):
		global_position =  Vector2(3904.0, -1400)
	if(global_position.y == 5152.0 and global_position.x == -1424.0 or global_position.distance_to(Vector2(-1424, 5152))<30):
		global_position = Vector2(-848.0, -104.0)
	if(global_position.y == 3816 and global_position.x == 4352 or global_position.distance_to(Vector2(4352.0, 3816))<30):
		global_position = Vector2(4040, -344.0)
	if(global_position.y == 3336 and global_position.x == 712 or global_position.distance_to(Vector2(712, 3336))<30):
		global_position = Vector2(1040, 2872)
	if(global_position.y == 520 and global_position.x == 3320 or global_position.distance_to(Vector2(3320, 520))<30):
		global_position = Vector2(1320, 1320)
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		doublejump = false
		
	
	if Input.is_action_just_pressed("ui_accept") and !is_on_floor() and !doublejump:
		doublejump = true
		velocity.y = JUMP_VELOCITY
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
var health = 10
func hurt(dmg):
	health -= dmg
	$CanvasLayer/Label.text = str(health)+"/10"
	if health<=0:
		get_tree().reload_current_scene()
	
	
var bulletScene = preload("res://bullet.tscn")
@export var bulletSpeed = 1000

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		var mousePos =get_global_mouse_position()
		
		var newBullet = bulletScene.instantiate()
		add_child(newBullet)
		newBullet.global_position = global_position
		newBullet.look_at(mousePos)
		newBullet.velocity = global_position.direction_to(mousePos) * 1000
