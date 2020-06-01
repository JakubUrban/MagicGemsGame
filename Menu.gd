extends Control

func _ready():
	#$AboutPopup/AboutText.set_text("dsadadsdasa")

	pass

func _on_NewGame_pressed():
	get_tree().change_scene("res://Main.tscn")
	pass

func _on_GameRules_pressed():
#	var ScreenSize = get_viewport().get_size()
#	$GameRulesPopup.popup_centered( Vector2( ScreenSize.x *0.8, ScreenSize.y * 0.8 ))
#	$GameRulesPopup/GameRulesButton.rect_size = $GameRulesPopup.get_size()
#	$GameRulesPopup/GameRulesButton.rect_position = Vector2(0,0)
	get_tree().change_scene("res://Main.tscn")


func _on_About_pressed():
	var ScreenSize = get_viewport().get_size()
	$AboutPopup.popup_centered( Vector2( ScreenSize.x *0.8, ScreenSize.y * 0.8 ))
	$AboutPopup/AboutButton.rect_size = $AboutPopup.get_size()
	$AboutPopup/AboutButton.rect_position = Vector2(0,0)

func _on_Exit_pressed():
	get_tree().quit()

func _on_AboutButton_pressed():
	$AboutPopup.hide()
	pass


func _on_GameRulesButton_pressed():
	$GameRulesPopup.hide()
	pass
