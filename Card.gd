extends Node2D

var patternArray = Array()
var binaryPattern = 0

func drawPattern( _binaryPattern, gemSprite ):
	binaryPattern = _binaryPattern
	makePatternArray( gemSprite )
	var i = patternArray.size() - 1
	
	for v in patternArray:
		if( ( binaryPattern >> i ) & 1 ):
			var gemsprite = Sprite.new()
			gemsprite.texture = gemSprite
			gemsprite.set_scale( Vector2(2,2) )
			gemsprite.position = v
			$Pattern.add_child( gemsprite )
		
		i = i-1
	
func makePatternArray( gemSprite ):
	var gemsprite = Sprite.new()
	gemsprite.texture = gemSprite
	var spaceBetween = 0
	var _size = gemsprite.get_texture().get_size().x * 2
	
	for i in range(4):
		for j in range(3):
			patternArray.append( Vector2( ( j * _size ) + ( j * spaceBetween ),
				( i * _size ) + ( i * spaceBetween ))) 
			pass
		pass
		
func getLabel():
	return $GreenLabel