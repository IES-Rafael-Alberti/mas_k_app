class_name Conversation
extends Node

@export var conversation_panel: ConversationPanel

var normal_text_scene: PackedScene = load("res://scenes/line_text.tscn")
var masked_text_scene: PackedScene = load("res://scenes/line_edit.tscn")

func _init(file_name, _conversation_panel):
	conversation_panel = _conversation_panel
	load_file(file_name, _conversation_panel.get_panel())

func load_file(file_name: String, text_container):
	var text = load_from_file(file_name)
	var normal:bool = true
	var temporal_text: String = ""
	for character in text:
		match character:
			"_":
				if normal:
					normal = false
					add_normal_text(temporal_text, text_container)
					temporal_text = "_"
				else:
					temporal_text += "_"
			" ":
				if not normal:
					normal = true
					add_masked_text(temporal_text, text_container)
					temporal_text = " "
				else:
					temporal_text += " "
			_:
				temporal_text += character
	if temporal_text:
		if normal:
			add_normal_text(temporal_text, text_container)
		else:
			add_masked_text(temporal_text, text_container)

func load_from_file(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content = file.get_as_text()
	return content

func add_normal_text(text: String, text_container):
	var instance = normal_text_scene.instantiate()
	instance.text = text
	text_container.add_child(instance)

func add_masked_text(text: String, text_container):
	var instance = masked_text_scene.instantiate()
	instance.placeholder_text = text
	text_container.add_child(instance)
