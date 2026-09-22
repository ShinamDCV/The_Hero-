extends CanvasLayer

@onready var start: Button = $Menu/VBoxContainer/Start
@onready var quit: Button = $Menu/VBoxContainer/Quit
@onready var menu: ColorRect = $Menu
@onready var win: TextureRect = $Win
@onready var lose: TextureRect = $lose


#For menu to show or not as well for game to pause or not
func _input(event):
	if event.is_action_pressed("pause"):
		if self.visible:
			# If menu is open, close it and resume
			$Menu/pause.play()
			self.hide()
			get_tree().paused = false
		else:
			# If menu is closed, open it and pause
			$Menu/pause.play()
			self.show()
			menu.show()
			get_tree().paused = true


func _ready() -> void:
#To Ensure all screens are hidden initially, as well as the UI node
	win.hide()
	lose.hide()
	menu.hide()
	get_tree().paused=false
	self.hide()

#After self.show(). To handle Interaction with UI
#When start(now restart) button is pressed.
func _on_start_pressed() -> void:
	menu.hide()
	get_tree().paused = false
	get_tree().reload_current_scene()

#When quit button is pressed.
func _on_quit_pressed() -> void:
	get_tree().quit()

#Function which takes input from other nodes for end_screen
func end_screen(type: String):
#As the whole UI Node's process is set to 'Always', we can set game_tree to pause at the start of method
	self.show()
	menu.hide()
	get_tree().paused=true
	if type=="lose":
		$lose/cursed.play()
		lose.show()

	elif type=="win":
		$Win/Wow.play()
		win.show()

	#Delay while showing message (compensated for longer time of win audio).
	await get_tree().create_timer(2.81).timeout
	win.hide()
	lose.hide()
	menu.show()
	get_tree().paused=true
	
	

	
