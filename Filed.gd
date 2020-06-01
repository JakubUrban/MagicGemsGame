extends Node2D

var _position = Vector2()
var _size = 0
var fieldFree = true

func init( _position, _size ):
	set_position( _position )
	makePolygon( _position, _size )
	makeCollisionShape( _size )
	
func makePolygon( _position, _size ):
	var poolArray =  PoolVector2Array()
	poolArray.append(( Vector2( _position.x, _position.y )))
	poolArray.append(( Vector2( _position.x + _size, _position.y )))
	poolArray.append(( Vector2( _position.x + _size, _position.y + _size )))
	poolArray.append(( Vector2( _position.x, _position.y + _size )))
	
func makeCollisionShape( _size ):
	$FieldArea/FieldAreaCollision.get_shape().extents =  Vector2(_size/2,_size/2)
	pass
	
func makeOccupied():
	fieldFree = false
	pass

func _on_FieldArea_area_entered( area ):
	if( area.name == "GemCenter" ) and fieldFree:
		area.get_parent().getCurrentFieldCenter( global_position )

func _on_FieldArea_area_exited( area ):
	if	area.get_parent().fieldCenter == global_position:
		area.get_parent().getCurrentFieldCenter(null)
