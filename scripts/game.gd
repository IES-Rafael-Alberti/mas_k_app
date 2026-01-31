extends Node2D

@export var text_file: String

@export var normal_text_scene: PackedScene
@export var masked_text_scene: PackedScene
@export var typed_text_scene: PackedScene

@onready var text_container = $Panel/TextContainer

var container_margin = 10.0 
var current_conversation: Conversation

func _ready() -> void:
	current_conversation = Conversation.new(text_file, text_container)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
