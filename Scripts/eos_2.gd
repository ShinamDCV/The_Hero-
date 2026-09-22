extends Area2D

@onready var platform = $Platforms
@onready var move = $Platforms/AnimationPlayer

#A body entering, signalled by eos_1 node
#Connected the signal to eos_1 node itself as the functions are to be done for eos_1 node only..
func _on_body_entered(body: Node2D) -> void: 
	#plarform + text label appear as soon as the player enters the region
	$"Gotcha !(text)".visible=true
	platform.visible=true 
	#The platform is static and only follows the animation when player has hit the detecter.
	move.play("slide0")
	
 
