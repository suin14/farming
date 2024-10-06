extends VBoxContainer

var _hand_outro: Tween


@onready var prev: TextureButton = $ItemBar/Prev
@onready var prop: Sprite2D = $ItemBar/Use/Prop
@onready var hand: Sprite2D = $ItemBar/Use/Hand
@onready var next: TextureButton = $ItemBar/Next


func _ready() -> void:
	hand.hide()
	hand.modulate.a = 0.0

	Game.inventory.changed.connect(_update_ui)
	_update_ui(true)


func _on_hand_outro() -> void:
	_hand_outro = create_tween()
	_hand_outro.set_trans(Tween.TRANS_SINE).set_parallel()
	_hand_outro.tween_property(hand, "modulate:a", 0.0, 0.15)
	_hand_outro.chain().tween_callback(hand.hide)
	Game.inventory.active_item = null


func _update_ui(is_init:= false):
	var count := Game.inventory.get_item_count()
	#visible = count > 0
	prev.disabled = count < 2
	next.disabled = count < 2
	
	var item := Game.inventory.get_current_item()
	if not item: return
	prop.texture = item.texture
	
	# 物品出现动画
	if is_init: return  #初始化节点时不调用
	var tween := create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property(prop, "scale", Vector2.ONE, 0.15).from(Vector2.ZERO)



func _on_prev_pressed() -> void:
	Game.inventory.select_prev()
	if Game.inventory.active_item:
		_on_hand_outro()


func _on_next_pressed() -> void:
	Game.inventory.select_next()
	if Game.inventory.active_item:
		_on_hand_outro()


func _on_use_pressed() -> void:
	if Game.inventory.active_item:
		_on_hand_outro()
	else:
		Game.inventory.active_item = Game.inventory.get_current_item()
		
		if _hand_outro and _hand_outro.is_valid():
			_hand_outro.kill()
			_hand_outro = null
		hand.show()
		
		var tween := create_tween()
		tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).set_parallel()
		tween.tween_property(hand, "scale", Vector2.ONE, 0.15).from(Vector2.ZERO)
		tween.tween_property(hand, "modulate:a", 1.0, 0.15)
