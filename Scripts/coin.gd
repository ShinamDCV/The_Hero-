extends Area2D

@onready var game_manager: Node2D = %game_manager
@onready var scoreboard: Label = $UI/scoreboard/game_manager/scoreboard
@onready var sound_animation: AnimationPlayer = $sound_animation



func _on_body_entered(body: Node2D) -> void:
	#As soon as the player hits the hitbox of the coin, it updates the score_counter
	game_manager.score()
	#AnimationPlayer lets the coin not interact with player while also giving time for audio
	sound_animation.play("coin ")
	
