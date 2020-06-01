extends Node2D

export (Vector2) var gridSize = Vector2(7,7)
export (int) var blockSize = 20
export (int) var spaceBetween = 2

onready var field = preload("res://field.tscn")

signal gemPlaced

var fieldsArray = Array()

func _ready():
	makeGrid( gridSize, blockSize, spaceBetween )
	pass

func makeGrid( _gridSize, _size, _spaceBetween ):
	for i in range( _gridSize.y ):
		for j in range( _gridSize.x ):
			var _field = field.instance()
			_field.init(Vector2(( j * _size ) + ( j * _spaceBetween ),
				( i * _size ) + ( i * _spaceBetween )), _size)
			add_child( _field )
		pass
	pass
	fieldsArray = get_children()

func _on_Gem_dropped( dropedGemRef, dropedGemPos ):
	var fieldOn = null
	for v in fieldsArray:
		if ( v.get_global_position() == dropedGemPos ):
			fieldOn = v
			emit_signal( "gemPlaced", fieldsArray.size() - 1 - fieldsArray.find(v), dropedGemRef.getColor() )
			break
	if fieldOn:
	 	fieldOn.makeOccupied()

func getCenter():
	return fieldsArray[25].get_global_position()