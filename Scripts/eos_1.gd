extends Area2D


#A body entering, signalled by eos_1 node
#Connected the signal to eos_1 node itself as the functions are to be done for eos_1 node only..
func _on_body_entered(body: Node2D) -> void:
	#To remove the blocks when the player enters.
	queue_free()
