extends Node2D

signal win

export (String) var playerName

var playerPattern

var patternColorArray = [
[0,1,2],
[0,2,3],
[0,2,4],
[0,3,4],
[0,1,4],
[0,1,3] ]
# 0 white
# 1 red
# 2 green
# 3 yellow
# 4 blue

var gemColor
var gemSprite

var gameBoard =  0

func setScoreBoard( id, color ):
	if !gemColor.has( color ):
		return
		
	gameBoard = gameBoard | 1 << id

func _ready():
	$PlayerName.text = playerName
	
	getPatternColor()
	getPattern()
	$Card.drawPattern( playerPattern, gemSprite )
	
	connect( "win", get_parent(), "on_win" )
	pass
	
func checkForPattern( whiteGemIndex ):
	var checkPatternBit = 1 #bit do sprawdzania głównej tablicy gameBoard
	var checkPattern = 0  #wzór do spisania z glowniej tablicy gameBoard
	
	for j in range (12):
		var boardIndex = (24+j+4*int(j/3))-whiteGemIndex-4*int(whiteGemIndex/3)
		
		checkPatternBit = checkPatternBit << boardIndex
		
		if ( gameBoard & checkPatternBit == checkPatternBit ):
			checkPattern = checkPattern | 1 << j
		
		checkPatternBit = 1
		
	return  playerPattern & checkPattern == playerPattern 

func checkGameBoard():
	var playerPatternBit = 1 

	for i in range(12):
		if ( playerPatternBit & playerPattern == playerPatternBit ):
			
			if ( checkForPattern( i )):
				emit_signal( "win", get_node(".") )
				
		playerPatternBit = playerPatternBit << 1
	pass
	
func getPatternColor():
	randomize()
	var i = randi()%6
		
	match i:
		0:
			gemColor = patternColorArray[i]
			gemSprite = load("res://Assets/green-red.png")
		1:
			gemColor = patternColorArray[i]
			gemSprite = load("res://Assets/green-yellow.png")
		2:
			gemColor = patternColorArray[i]
			gemSprite = load("res://Assets/green-blue.png")
		3:
			gemColor = patternColorArray[i]
			gemSprite = load("res://Assets/blue-yellow.png")
		4:
			gemColor = patternColorArray[i]
			gemSprite = load("res://Assets/blue-red.png")
		5:
			gemColor = patternColorArray[i]
			gemSprite = load("res://Assets/yellow-red.png")
		
func getPattern():
	randomize()

	var _pattern = 0
	var i = 0
	var tmp
	
	while( i<6 ):
		tmp = 1
		tmp = tmp << randi()%12
		if(!( tmp & _pattern )):
			_pattern = tmp | _pattern
			i += 1
			
	playerPattern = _pattern
	
func setActive( _visible ):
	$Card.getLabel().set_visible( _visible )
	