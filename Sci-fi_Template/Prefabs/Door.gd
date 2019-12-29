extends Spatial

var has_entered = false
export (NodePath) var Position
export (float) var speed = 1
onready var original_position = get_node("DoorFrame/Door").translation
onready var pos_inst = get_node(Position).translation
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	if has_entered == true:
		$DoorFrame/Door.translation = $DoorFrame/Door.translation.linear_interpolate(pos_inst, speed * delta)
	else: 
		$DoorFrame/Door.translation = $DoorFrame/Door.translation.linear_interpolate(original_position, speed * delta)
	

func _on_Area_body_entered(body):
	if body.name == "Player":
		has_entered = true


func _on_Area_body_exited(body):
	if body.name == "Player":
		has_entered = false

