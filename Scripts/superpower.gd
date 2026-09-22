extends Area2D

@onready var sound_animation: AnimationPlayer = $sound_animation

#Activates on player collsion
func _on_body_entered(body: Node2D) -> void:
	#AnimationPLayer handles null interaction after 1st interaction and audio time
	sound_animation.play("pick_up")
