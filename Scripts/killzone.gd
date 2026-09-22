extends Area2D


#Signal of body entered connected to self.
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		# Access the die() method in player
		body.die()
		
	
