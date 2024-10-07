extends Node2D

@export var bgm : AudioStream

func _ready() -> void:
	if bgm:
		SoundManager.play_bgm(bgm)


func _on_check_mouse_entered() -> void:
	print("鼠标移入")
	Game.can_cancel = false


func _on_check_mouse_exited() -> void:
	print("鼠标移出")
	Game.can_cancel = true
