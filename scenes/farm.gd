extends Node2D

@export var bgm : AudioStream

func _ready() -> void:
	if bgm:
		SoundManager.play_bgm(bgm)
