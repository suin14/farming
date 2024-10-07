extends Node

const WHEAT = preload("res://scripts/objects/wheat.tres")
const TOMATO = preload("res://scripts/objects/tomato.tres")
const POTATO = preload("res://scripts/objects/potato.tres")

var can_cancel := true

class Inventory:
	signal changed
	
	var active_item: Item
	var _items := [WHEAT, TOMATO, POTATO]
	var _current_item_index := 0
	
	func get_item_count() -> int:
		return _items.size()
	
	func get_current_item() -> Item:
		if _current_item_index == -1:  # 背包没有东西
			return null
		return _items[_current_item_index]
	
	func add_item(item: Item):
		if item in _items: return
		_items.append(item)
		_current_item_index = _items.size() - 1  # 当前显示物品变为刚拾取的物品
		changed.emit()
	
	func select_next():
		if _current_item_index == -1: return
		_current_item_index = (_current_item_index + 1) % _items.size()
		changed.emit()
	
	func select_prev():
		if _current_item_index == -1: return
		_current_item_index = (_current_item_index - 1 + _items.size()) % _items.size()
		changed.emit()


var inventory := Inventory.new()
