extends CharacterBody2D

const Block_ht = 179.0
const SPEED = Block_ht/2
const JUMP_VELOCITY = -1*Block_ht

var allow_rolling = false
var is_rolling = false
@onready var animation = $AnimatedSprite2D


#Default template to add physics to PLayer
func _physics_process(delta: float) -> void:
	#Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	#Handle jump movement.
	if Input.is_action_just_pressed("jump") and is_on_floor() and velocity.x == 0:
		velocity.y = JUMP_VELOCITY
		$jump_sfx.play()
	#Handle Double Jump movement.
	elif Input.is_action_just_pressed("jump") and is_on_floor() and velocity.x != 0 :
		velocity.y = JUMP_VELOCITY*1.414
		$jump_sfx.play()
		
	#Defines direction of movement according to input action
	var direction := Input.get_axis("move_left", "move_right")
	
	#Defines whether player is rolling or not
	if Input.is_action_just_pressed("roll") and not is_rolling and is_on_floor() and allow_rolling:
		is_rolling=true

	#Collision Shape based on rolling
	if is_rolling:
		$CollisionNormal.disabled=true
		$CollisionRolling.disabled=false
	else:
		$CollisionNormal.disabled=false
		$CollisionRolling.disabled=true
		

	#To Handle flip animation of player Sprite.
	if direction>0:
		animation.flip_h = false
	elif direction<0:
		animation.flip_h = true


	#Handle Movement and animation together.
	#Rolling movement + animation
	if is_rolling:
		animation.play("ROLL")
		velocity.x = direction * (1.5*SPEED)
	#Run movement + animation
	elif direction != 0:
		velocity.x = direction * SPEED
		if is_on_floor():
			animation.play("RUN")
		else:
			#Jump animation
			animation.play("JUMP")

	#Stopping Movement
	else:
		velocity.x=move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			animation.play("IDLE")
		else:
			animation.play("JUMP")

	move_and_slide()
	
	#Running sound effect:
	if is_on_floor() and abs(velocity.x) != 0:
		if not $run_sfx.playing:
					$run_sfx.play()
	else:
		if $run_sfx.playing:
			$run_sfx.stop()

#Trigger rolling off
func _on_animated_sprite_2d_animation_finished() -> void:
	if animation.animation == "ROLL":
		is_rolling = false

#Allow Global rolling according to power-up acquired or not.
func _on_eos_3_superpower_body_entered(body: Node2D) -> void:
	allow_rolling=true

#Death of Player (func used in Killzone script)
func die():
	animation.play("JUMP")
	$jump_sfx.stop()
	$run_sfx.stop()
	#Disable Player
	set_physics_process(false)
	
	#Now show death screen and then UI
	get_tree().root.get_node("Game/UI").end_screen("lose")
