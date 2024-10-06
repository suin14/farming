extends Control


func _ready() -> void:
	hide()
	
	visibility_changed.connect(func ():
		get_tree().paused = visible
	)


func _on_resume_pressed() -> void:
	hide()


func _on_quit_pressed() -> void:
	get_tree().quit()
