extends CharacterBody2D

var player


func _ready():
	get_node("AnimatedSprite2D").play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
