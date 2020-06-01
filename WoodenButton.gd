extends TextureButton

export (String) var _text

func _ready():
	$ButtonText.text = _text

