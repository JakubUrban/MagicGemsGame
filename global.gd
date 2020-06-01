extends Node

var game_board =  0

func SetScoreBoard(id):
	#print("game board 1: ", game_board)
	var tmp = 1
	tmp = tmp << id
	#print("tmp: ",tmp)
	game_board = game_board | tmp
	#print("game board 2: ", game_board)
