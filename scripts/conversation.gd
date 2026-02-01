class_name Conversation
extends Node

@export var conversation_panel: ConversationPanel

var normal_text_scene: PackedScene = load("res://scenes/line_text.tscn")
var masked_text_scene: PackedScene = load("res://scenes/line_edit.tscn")
var meca_text_scene: PackedScene = load("res://scenes/line_edit.tscn")

var masked_fields: Array[LineEdit]

enum states {NORMAL, MECA, MASKED}

func _init(file_name, _conversation_panel):
	conversation_panel = _conversation_panel
	load_file(file_name, _conversation_panel.get_panel())
	print(masked_fields.size())

func load_file(file_name: String, text_container):
	var text = load_from_file(file_name)
	var current_state = states.NORMAL
	var temporal_text: String = ""
	for character in text:
		match character:
			"_":
				if current_state == states.NORMAL:
					current_state = states.MASKED
					add_normal_text(temporal_text, text_container)
					temporal_text = "_"
				else:
					temporal_text += "_"
			"%":
				if current_state == states.MECA:
					current_state = states.NORMAL
					add_meca_text(temporal_text, text_container)
					temporal_text = ""
				elif current_state == states.NORMAL:
					current_state = states.MECA
					add_normal_text(temporal_text, text_container)
					temporal_text = ""
				else:
					current_state = states.MECA
					add_masked_text(temporal_text, text_container)
					temporal_text = ""
			" ":
				if current_state == states.MASKED:
					current_state = states.NORMAL
					add_masked_text(temporal_text, text_container)
					temporal_text = " "
				else:
					temporal_text += " "
			_:
				temporal_text += character
	if temporal_text:
		if current_state == states.NORMAL:
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
	masked_fields.append(instance)
	text_container.add_child(instance)

func add_meca_text(text: String, text_container):
	var instance = meca_text_scene.instantiate()
	instance.placeholder_text = text
	masked_fields.append(instance)
	text_container.add_child(instance)
