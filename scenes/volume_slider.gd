extends HBoxContainer

@export var bus : StringName = "Master"

@onready var bus_index := AudioServer.get_bus_index(bus)

@onready var volume_slider: TextureProgressBar = $VolumeSlider


func _ready() -> void:
	volume_slider.value = SoundManager.get_volume(bus_index)


func _on_decrease_pressed() -> void:
	volume_slider.value -= 0.1


func _on_increase_pressed() -> void:
	volume_slider.value += 0.1


func _on_volume_slider_value_changed(value: float) -> void:
	SoundManager.set_volume(bus_index, value)
