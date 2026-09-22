extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		# Access the UI node in main game scene
		#win is given as string input to ensure that win part of func end_screen() is played
		get_tree().root.get_node("Game/UI").end_screen("win")
