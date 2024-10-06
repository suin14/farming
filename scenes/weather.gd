extends CanvasLayer


signal changed

@onready var timer: Timer = $Timer
@onready var rain: GPUParticles2D = $rain
@onready var rain_colour: CanvasModulate = $rain_colour


var _current_weather := "sunny"


func _ready() -> void:
	hide()
	rain_colour.color.a = 0.0
	timer.wait_time = randi_range(10,30)
	timer.start()


func _on_timer_timeout() -> void:
	if _current_weather == "sunny":
		_current_weather = "rainy"
	elif _current_weather == "rainy":
		_current_weather = "sunny"

	timer.wait_time = randi_range(20,40)
	timer.start()
	changed.emit()


func _update_weather() -> void:
	if _current_weather == "rainy":
		show()
		var t = create_tween()
		t.tween_property(rain_colour, "color:a", 0.6, 3)

	else:  # sunny
		var t = create_tween()
		t.tween_property(rain_colour, "color:a", 0.0, 3)
		t.tween_callback(self.hide)
