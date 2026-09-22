extends Node2D

@onready var scoreboard: Label = $scoreboard

var points=0
# Called when the node enters the scene tree for the first time.
func score():
	#keeps count of how many coins are collected 
	points += 1
	#Prints no. of coins collected under UI(So that it is always visible)
	scoreboard.text = "You collected " + str(points) + " of 10 coins."
