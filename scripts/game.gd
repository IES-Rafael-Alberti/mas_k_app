extends Node2D

@export var text_file: String

@export var normal_text_scene: PackedScene
@export var masked_text_scene: PackedScene
@export var typed_text_scene: PackedScene

@export var text_container_p1: PackedScene
@export var text_container_p2: PackedScene

@onready var conversations_panel = $ScrollContainer/Conversations
@onready var scroll_container = $ScrollContainer

var container_margin = 10.0 
var current_conversation: Conversation

var players: Array[PackedScene]
var current_player = 0
var current_phase = 0

func _ready() -> void:
	players = [text_container_p1, text_container_p2]
	next_player(true)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if event.is_action_pressed("next") and not current_phase:
		next_action()
	scroll_container.set_deferred("scroll_vertical", scroll_container.get_v_scroll_bar().max_value)

func next_action():
	if current_phase:
		next_player()
		current_phase = 0
	else:
		current_conversation.conversation_panel.show_emojis()
		current_phase = 1
		current_conversation.conversation_panel.emojis_selected.connect(next_action)

func next_player(first: bool = false):
	if not first:
		current_player += 1
		current_player %= 2
	var conversation = players[current_player].instantiate()
	conversations_panel.add_child(conversation)
	current_conversation = Conversation.new(text_file, conversation)
	
