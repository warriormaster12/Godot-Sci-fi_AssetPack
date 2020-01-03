extends KinematicBody


var camera_angle = 0
export var mouse_sensitivity = 0.3
var camera_change = Vector2()

# Camera shake variables
export var Health = 100 
var Number_of_jumps=0
export var Max_Jumps = 1
export var Jump_Height = 8
var velocity = Vector3()
var direction = Vector3()


#Walk variables 
export (float) var crouch_speed = 3
export (float) var walk_speed = 7
export (float) var running_speed = 10
var gravity = -9.8 * 3
var speed = 0.0
const ACCEL = 10 
const DEACCEL = 10



# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	


func _process(delta):
	if(Input.is_action_pressed("Exit")): 
		get_tree().quit() 
		
func _physics_process(delta):
	aim() 
	GroundMovement(delta)

func _input(event):
	if event is InputEventMouseMotion:
		camera_change = event.relative 
		
func GroundMovement(delta): 
		
	direction = Vector3()
	var aim = $Head/Camera.get_camera_transform().basis
	
	if Input.is_action_pressed("move_f"):
		direction -= aim.z
	if Input.is_action_pressed("move_b"):
		direction += aim.z
	if Input.is_action_pressed("move_r"):
		direction += aim.x
	if Input.is_action_pressed("move_l"):
		direction -= aim.x
	direction.y = 0
	direction = direction.normalized()
	
	velocity.y += gravity * delta
	
	var temp_velocity = velocity
	temp_velocity.y = 0
	
	
	var target = direction * speed
	
	var acceleration 
	if direction.dot(temp_velocity) > 0: 
		acceleration = ACCEL
	else: 
		acceleration = DEACCEL
	
	temp_velocity = temp_velocity.linear_interpolate(target, acceleration * delta)
	
	velocity.x = temp_velocity.x
	velocity.z = temp_velocity.z
	
	velocity = move_and_slide(velocity, Vector3(0,1,0))
	
	if Input.is_action_pressed("Sprint"): 
		speed = running_speed
	else: 
		speed = walk_speed
#	if Input.is_action_pressed("Crouch"):
#		speed = crouch_speed
#		$CollisionShape.set("shape/height",0.4)
#		$Head.transform.basis.y = Vector3(0,0.45,0)
#	else: 
#		speed = walk_speed
#		$Head.transform.basis.y = Vector3(0,0.45,0)
#		$CollisionShape.set("shape/height",0.8)
#
	if Input.is_action_pressed("Jump") and is_on_floor(): 
		if Number_of_jumps != Max_Jumps:
			velocity.y = Jump_Height
			Number_of_jumps += 1
	else: 
		Number_of_jumps = 0 
	
func aim(): 
	if camera_change.length() > 0:
		$Head.rotate_y(deg2rad(-camera_change.x * mouse_sensitivity))
	var change = -camera_change.y * mouse_sensitivity
	if change + camera_angle < 90 and change + camera_angle > -90: 
		$Head/Camera.rotate_x(deg2rad(change))
		camera_angle += change 
	camera_change = Vector2()
	


	
