extends Node


signal money_changed

@export var max_money: int = 99999

@onready var money: int = 0:    #理智值
	set(v):
		v = clampi(v, 0, max_money)
		if money == v: return
		money = v
		money_changed.emit()


func init() -> void:
	money = 0
