extends CharacterBody2D


const SPEED = 175.0
const JUMP_VELOCITY = -333.0
#dit gedeelt door 60 is het aantal seconden 
const MAX_FLOOR = 12
const MAX_JUMP_COUNT = 1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var floor_counter = MAX_FLOOR
var jump_count = MAX_JUMP_COUNT


func _physics_process(delta):
	get_node("AnimatedSprite2D").play("idle")
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	update_floor_counter()
	print(floor_counter)

	# Handle Jump.

	if Input.is_action_just_pressed("ui_accept"): 
		if jump_allowed():
			velocity.y = JUMP_VELOCITY
			jump_count = 0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func jump_allowed():
	return floor_counter > 0 and jump_count > 0
	
			
func update_floor_counter():
	if is_on_floor():
		jump_count = MAX_JUMP_COUNT
		floor_counter = MAX_FLOOR
	elif floor_counter > 0:
		floor_counter -= 1

