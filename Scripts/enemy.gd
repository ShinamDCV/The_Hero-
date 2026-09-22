extends Node2D

const SPEED = 60
var direction = 1

@onready var sound_animation: AnimationPlayer = $sound_animation
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite= $AnimatedSprite2D
@onready var hitbox = $Hitbox

	
func _process(delta: float) -> void:
	position.x += direction*60*delta
	
#The ray_cast tells whether the enemy is about to collide on right or left
	if ray_cast_right.is_colliding():
		#The direction is changed accordingly
		direction = -1
		animated_sprite.flip_h=true
	elif ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h=false
		
	#Death
func _on_hitbox_body_entered(body: Node2D) -> void:
	#AnimationPlayer helps time the audio queue.
	sound_animation.play("death")
