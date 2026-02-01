extends LineEdit

@export var meca_text: String

var container_margin = 10.0

func set_meca_text(_text: String):
	meca_text = text
	placeholder_text = "_".repeat(meca_text.length())

func activate():
	editable = true
	grab_focus()
	
func deactivate():
	editable = false

func _on_text_changed(_new_text: String) -> void:
	pass # Replace with function body.

func _on_editing_toggled(_toggled_on: bool) -> void:
	if _toggled_on:
		text = meca_text


func _on_line_edit_editing_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.


func _on_line_edit_text_changed(new_text: String) -> void:
	pass # Replace with function body.


func _on_resized() -> void:
	var line_edit = get_viewport().gui_get_focus_owner()
	if line_edit:
		var container = line_edit.get_parent()
		if container.size.x - line_edit.size.x < container_margin:
			line_edit.max_length = line_edit.text.length()
			line_edit.caret_column = line_edit.max_length


func _on_line_edit_resized() -> void:
	pass # Replace with function body.
