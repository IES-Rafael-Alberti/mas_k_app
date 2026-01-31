class_name ConversationPanel
extends TextureRect

signal emojis_selected

var emojis_selection: bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if emojis_selection and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print(event.position)
			var rect = $Emojis_panel.get_global_rect()
			var mouse_position = $Emojis_panel.get_global_mouse_position()
			if rect.has_point(mouse_position):
				emojis_selection = false
				show_emojis(false)
				emojis_selected.emit()

func get_panel():
	return $Panel/TextContainer
	
func show_emojis(_visible:bool = true):
	$Emojis_panel.visible = _visible
	emojis_selection = _visible
	
