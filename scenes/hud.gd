extends CanvasLayer

@onready var money: Label = $money
@onready var settings_menu: Control = $SettingsMenu
@onready var time: Node = $TimeGUI/TimeSystem
@onready var night: ColorRect = $Night/ColorRect



func _ready() -> void:
	_update_money()
	Stats.money_changed.connect(_update_money)
	settings_menu.hide()


func _update_money() -> void:
	money.text = str(Stats.money)


func _on_settings_pressed() -> void:
	settings_menu.show()


func _on_time_gui_day() -> void:
	var t = create_tween()
	t.tween_property(night, "color:a", 0.0, 5)


func _on_time_gui_night() -> void:
	var t = create_tween()
	t.set_trans(Tween.TRANS_SINE)
	t.tween_property(night, "color:a", 0.7, 5)
