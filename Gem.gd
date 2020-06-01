extends Node2D

export (Texture) var t01
export (Texture) var t02

signal dropped

enum COLOR{
  white,
  red,
  green,
  yellow,
  blue,
}

export (COLOR) var _color

enum STATE{
	base,
	moving,
	droped,	
}

var _state = STATE.base

var coursorOn = false
var hasToMove = false
var fieldCenter = Vector2()
export var startingPos = Vector2()

func _ready():
	$Sprite.texture = t01
	position = startingPos
	$Body/CollisionShape2D.get_shape().extents = $Sprite.texture.get_size() / 2

func _process( delta ):
	startMoving()
	move()
	drop()
	pass

func startMoving():
	if Input.is_action_just_pressed("mouse_left_click") and coursorOn and _state == STATE.base:
		_state = STATE.moving

func move():
	if _state == STATE.moving:
		position = get_global_mouse_position()

func drop():
	if Input.is_action_just_released("mouse_left_click") and _state == STATE.moving:
		if fieldCenter:
			position = fieldCenter
			emit_signal( 'dropped', get_node("."), position )
			_state = STATE.droped
		else:
			position = startingPos
			_state = STATE.base
	
func getCurrentFieldCenter( _position ):
	fieldCenter = _position
	pass
	
func getColor():
	return _color

func _on_Body_mouse_entered():
	coursorOn = true
	$Sprite.texture  = t02


func _on_Body_mouse_exited():
	print("mouse area entered")
	coursorOn = false
	$Sprite.texture  = t01
