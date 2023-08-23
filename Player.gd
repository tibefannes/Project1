extends CharacterBody2D


const speed = 740
const jump_power = -333.0
const walljump_scalor = 0.6
const walljump_pushback = 300
const boost_reducer = 370
const max_speed = 185
const min_speed = 8
#dit gedeelt door 60 is het aantal seconden
const max_wall = 10
const max_walljump_count = 1
#dit gedeelt door 60 is het aantal seconden 
const max_floor = 12
const max_jump_count = 1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var floor_counter = max_floor
var jump_count = max_jump_count
var wall_counter = max_wall
var walljump_count = max_walljump_count


func _physics_process(delta):
	run_idle_anim()
	add_gravity(delta)
	update_floor_counter()
	update_wall_counter()
	if not walljump_allowed():
		jump()
	move_left_right(delta)
	walljump()
	print(velocity.x)
	move_and_slide()
	
func move_left_right(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		if move_direction() * velocity.x < max_speed:
			velocity.x += direction * speed * delta
		else:
			velocity.x -= move_direction() * boost_reducer * delta
	else:
		#velocity.x = move_toward(velocity.x, 0, speed)
		if move_direction() * velocity.x > min_speed:
			velocity.x -= move_direction() * speed * delta
		else:
			velocity.x = 0
	
func add_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
func jump_allowed():
	return floor_counter > 0 and jump_count > 0
	
func jump():
	if Input.is_action_just_pressed("ui_accept"): 
		if jump_allowed():
			velocity.y = jump_power
			jump_count = 0
	
func update_floor_counter():
	if is_on_floor():
		jump_count = max_jump_count
		floor_counter = max_floor
	elif floor_counter > 0:
		floor_counter -= 1
	
func walljump_allowed():
	return wall_counter > 0 and walljump_count > 0 and not is_on_floor()
	
func walljump():
	if Input.is_action_just_pressed("ui_accept"):
		if walljump_allowed():
			if Input.is_action_pressed("ui_left"):
				velocity.y = walljump_scalor * jump_power
				velocity.x = walljump_pushback
			elif Input.is_action_pressed("ui_right"):
				velocity.y = walljump_scalor * jump_power
				velocity.x = -walljump_pushback
			walljump_count = 0
	
func move_direction():
	if velocity.x < 0:
		return -1
	else:
		return 1
	
func update_wall_counter():
	if is_on_wall():
		walljump_count = max_walljump_count
		wall_counter = max_wall
	elif wall_counter > 0:
		wall_counter -= 1
	
func run_idle_anim():
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	elif direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	
	if move_direction() * velocity.x == 0:
			get_node("AnimatedSprite2D").play("idle")
	elif move_direction() * velocity.x > 50:
			get_node("AnimatedSprite2D").play("run")
	else:
			get_node("AnimatedSprite2D").play("runslow")
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

