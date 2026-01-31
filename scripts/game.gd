extends Node2D

@export var text_file: String

@export var normal_text_scene: PackedScene
@export var masked_text_scene: PackedScene
@export var typed_text_scene: PackedScene

@onready var text_container = $Panel/TextContainer

var container_margin = 10.0 

func _ready() -> void:
	var text = load_from_file(text_file)
	var normal:bool = true
	var meca:bool = false
	var temporal_text: String = ""
	for character in text:
		match character:
			"_":
				if normal:
					normal = false
					var instance = normal_text_scene.instantiate()
					instance.text = temporal_text
					text_container.add_child(instance)
					temporal_text = "_"
				else:
					temporal_text += "_"
			" ":
				if not normal:
					normal = true
					var instance = masked_text_scene.instantiate()
					instance.placeholder_text = temporal_text
					text_container.add_child(instance)
					temporal_text = " "
				else:
					temporal_text += " "
			_:
				temporal_text += character
	if temporal_text:
		if normal:
			var instance = normal_text_scene.instantiate()
			instance.text = temporal_text
			text_container.add_child(instance)
		else:
			var instance = masked_text_scene.instantiate()
			instance.placeholder_text = temporal_text
			text_container.add_child(instance)
			temporal_text = " "


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func load_from_file(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content = file.get_as_text()
	return content
