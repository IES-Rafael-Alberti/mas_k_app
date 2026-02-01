class_name ConversationPanel
extends TextureRect

signal emojis_selected

var emojis_selection: bool = false
var timeout: bool = true

func _process(_delta: float) -> void:
	if timeout and $Timer:
		$Label.text = "%.2f" % $Timer.time_left

func _on_emoji_selected(_emoji):
	emojis_selection = false
	show_emojis(false)
	$Emoji_selected.texture = _emoji.texture
	$Emoji_selected.visible = true
	emojis_selected.emit()

func get_panel():
	return $Panel/TextContainer
	
func show_emojis(_visible:bool = true):
	$Emojis_panel.visible = _visible
	emojis_selection = _visible

func stop_timer():
	$Timer.stop()
	timeout = false
	$Label.visible = false

func next_action():
	timeout = false
	$Label.visible = false
	get_parent().get_parent().get_parent().next_action()

func _on_timer_timeout() -> void:
	timeout = false
	$Label.visible = false
	next_action()
