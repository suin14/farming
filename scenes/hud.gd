extends CanvasLayer

@onready var money: Label = $money
@onready var settings_menu: Control = $SettingsMenu


func _ready() -> void:
	_update_money()
	Stats.money_changed.connect(_update_money)
	settings_menu.hide()


func _update_money() -> void:
	money.text = str(Stats.money)


func _on_settings_pressed() -> void:
	settings_menu.show()
