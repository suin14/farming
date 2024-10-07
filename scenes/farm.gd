extends Node2D

@export var bgm : AudioStream

func _ready() -> void:
	if bgm:
		SoundManager.play_bgm(bgm)


func _on_check_mouse_entered() -> void:
	Game.can_cancel = false


func _on_check_mouse_exited() -> void:
	Game.can_cancel = true
