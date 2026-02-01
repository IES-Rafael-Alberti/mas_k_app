extends LineEdit

@export var meca_text: String

func set_meca_text(_text: String):
	meca_text = text
	placeholder_text = "_".repeat(meca_text.length())

func activate():
	$LineEdit.editable = true
	$LineEdit.grab_focus()
	
func deactivate():
	$LineEdit.editable = false

func _on_text_changed(_new_text: String) -> void:
	pass # Replace with function body.

func _on_editing_toggled(_toggled_on: bool) -> void:
	if _toggled_on:
		text = meca_text
