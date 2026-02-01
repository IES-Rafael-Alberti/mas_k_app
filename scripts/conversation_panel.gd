class_name ConversationPanel
extends TextureRect

signal emojis_selected

var emojis_selection: bool = false

#func _input(event: InputEvent) -> void:
	#pass
	#if event is InputEventMouseButton:
		#if emojis_selection and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#print(event.position)
			#var rect: Rect2 = $Emojis_panel.get_global_rect()
			#rect.size.x -= _margin.x*2
			#rect.size.y -= _margin.y*2
			#rect.position.x += _margin.x
			#rect.position.y += _margin.y
			#print(rect)
			#var mouse_position = $Emojis_panel.get_global_mouse_position()
			#if rect.has_point(mouse_position):
				#emojis_selection = false
				#show_emojis(false)
				#emojis_selected.emit()

func _on_emoji_selected(_emoji):
	emojis_selection = false
	show_emojis(false)
	emojis_selected.emit()

func get_panel():
	return $Panel/TextContainer
	
func show_emojis(_visible:bool = true):
	$Emojis_panel.visible = _visible
	emojis_selection = _visible
	
