extends Node2D

#var gemScene = load("res://Gem.tscn")

var activePlayer
var gameOver = false
var playersArray = Array()

func _ready():
	playersArray.push_back( $Player01 )
	playersArray.push_back( $Player02 )
	activePlayer = playersArray.back()
	activePlayer.setActive( true )

	$WhiteGem.set_position( $Grid.getCenter() )
	$WhiteGem.getCurrentFieldCenter( $Grid.getCenter() )
	$WhiteGem.emit_signal( 'dropped', get_node($WhiteGem.get_path()), $WhiteGem.get_position() )
	$WhiteGem._state = $WhiteGem.STATE.droped
	pass

func _on_Gem_dropped( dropedGem, dropedGemPos ):
	var newGem = dropedGem.duplicate(15)
	add_child( newGem )

func _on_gemPlaced( boardIndex, color ):
	for v in playersArray:
		v.setScoreBoard( boardIndex, color )
		v.checkGameBoard()
	nextPlayer()
	
func nextPlayer():
	if( !gameOver ):
		activePlayer.setActive( false )
		var id = playersArray.find(activePlayer)
		if ( id+1 == playersArray.size() ):
			activePlayer = playersArray.front()
		else:
			activePlayer = playersArray[id+1]
		activePlayer.setActive( true )

func on_win( winningPlayer ):
	gameOver = true
	$WinScreen/WinPopup.popup()
	$WinScreen/WinPopup/WonPlayerLabel.set_text( winningPlayer.playerName + " won!" )

func _on_ExitButton_pressed():
	get_tree().change_scene("res://Menu.tscn")

func _on_PlayAgainButton_pressed():
	get_tree().change_scene("res://Main.tscn")

func _on_ReturnButton_pressed():
	get_tree().change_scene("res://Menu.tscn")
