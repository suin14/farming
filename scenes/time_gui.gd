extends Panel

@onready var hours: Label = $HBoxContainer/Hour
@onready var label: Label = $HBoxContainer/Label
@onready var minutes: Label = $HBoxContainer/Minutes


signal night
signal day


func _on_time_system_updated(date_time: DateTime) -> void:
	var minu = date_time.minutes - (date_time.minutes % 5)
	update_label(hours, date_time.hours, true)
	update_label(minutes, minu, true)
	
	if date_time.hours == 19 and date_time.minutes == 0:
		night.emit()
	elif date_time.hours == 6 and date_time.minutes == 0:
		day.emit()
	


@warning_ignore("shadowed_variable")
func add_leading_zero(label: Label, value: int) -> void:
	if value < 10:
		label.text += '0'

@warning_ignore("shadowed_variable")
func update_label(label: Label, value: int, should_have_zero: bool = true) -> void:
	label.text = ""
	
	if should_have_zero:
		add_leading_zero(label, value)
		
	label.text += str(value)
