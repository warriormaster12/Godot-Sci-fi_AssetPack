extends Spatial

var original_position = Vector3()
export (Vector3) var new_position 
export var speed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	print(new_position-original_position)
	