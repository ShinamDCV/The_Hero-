2D Platformer (Godot)

A 2D platformer built in Godot with dynamic level elements: coin collection, patrolling enemies, a roll power-up, a checkpoint-triggered moving platform, kill zones, and a win/lose UI flow.

Features
Movement & combat-free platforming — run, jump, double jump, and a roll ability unlocked via a pickup.
Coin collection with a live scoreboard ("You collected X of 10 coins.").
Patrolling enemies that reverse direction using raycasts, with a death animation on contact.
Kill zones that instantly end the run.
Dynamic environment:
Blocks that despawn once the player passes a trigger zone.
A hidden platform that slides into place and reveals itself once the player reaches a checkpoint.
Win/Lose end screens with a pause menu and restart/quit options.
Controls
Action	Description
move_left / move_right	Horizontal movement
jump	Jump (press again mid-air while moving for a boosted double jump)
roll	Roll (only available after collecting the roll power-up)
pause	Open/close the pause menu

(Input action names are defined in the Godot Input Map; rebind as needed.)

Script Reference
player.gd

Attached to the player CharacterBody2D. Handles all core movement physics:

Gravity, jump, and a stronger double jump (triggered on a second jump press while moving horizontally).
Roll state, which swaps between a normal and a rolling CollisionShape2D and plays a faster roll animation.
Sprite flipping based on movement direction.
Run/jump/idle animation state machine and footstep/jump SFX handling.
die() — disables physics processing and calls the UI's lose screen.
_on_eos_3_superpower_body_entered() — enables rolling once the player touches the roll power-up trigger.
enemy.gd

Attached to a patrolling enemy. Moves at a constant speed and reverses direction using two RayCast2D nodes (RayCastRight / RayCastLeft) to detect upcoming edges or walls. Flips the sprite to match direction and plays a death sound/animation when its hitbox registers a collision with the player.

coin.gd

Attached to each collectible coin (Area2D). On player contact, calls game_manager.score() to increment the scoreboard and plays a pickup animation/sound before the coin is removed from play.

game_manager.gd

Tracks run state — currently the coin count. Exposes score(), which increments points and updates the scoreboard Label text. Intended as a shared/singleton-style node (%game_manager) referenced by other scripts.

superpower.gd

Attached to the roll power-up pickup (Area2D). Plays a pickup animation/sound on player contact. The actual "unlock rolling" logic lives in player.gd's _on_eos_3_superpower_body_entered(), which listens for this trigger.

killzone.gd

Attached to hazard/death regions (Area2D, e.g. pits or spikes). On player contact, calls the player's die() method to trigger the lose sequence.

game_end.gd

Attached to the level's finish trigger (Area2D). On player contact, calls the UI's end_screen("win") to trigger the win sequence.

eos_1.gd

Attached to a trigger zone ("end-of-section" gate) that removes a set of blocking geometry (queue_free()) once the player passes through — used to open up the level dynamically as the player progresses.

eos_2.gd

Attached to a second checkpoint trigger. Reveals a hidden platform and a "Gotcha!" text label, then plays a slide-in animation (slide0) so the platform animates into position only after the player reaches this point — this is the "dynamic environment" centerpiece of the level.

ui.gd

Attached to the main CanvasLayer UI. Manages:

The pause menu (toggled via the pause input action, pausing/unpausing the scene tree).
Initial hiding of all UI panels on _ready().
end_screen(type) — shown a "win" or "lose" string, displays the corresponding panel and sound, pauses the tree, waits ~2.8s, then hides the panel and shows the pause menu (with restart/quit options).
_on_start_pressed() — reloads the current scene (used as both "Start" and "Restart").
_on_quit_pressed() — quits the game.
Project Structure Notes
UI-related nodes are expected at fixed paths (e.g. Game/UI accessed via get_tree().root.get_node(...)), so the root scene should be named Game with a child UI node running the ui.gd script.
game_manager.gd is referenced via the unique name %game_manager, so its node should be marked as a scene-unique node in the editor.
.uid files are Godot's internal resource identifiers for each script and don't need to be edited manually.
Requirements
Godot 4.x (uses typed GDScript syntax such as body: Node2D, @onready, and unique-name % references).
Known Limitations / Possible Improvements
Coin target ("of 10 coins") is hardcoded in the scoreboard text rather than driven by a level-defined total.
No checkpoint/save system — death or restart reloads the entire scene.
Enemy movement is a simple raycast-based patrol with no player detection or attack behavior.
