extends Node2D


var plant : Item
var plant_growing = false
var plant_grown = false

@onready var grow_timer: Timer = $GrowTimer
@onready var plant_animation: AnimatedSprite2D = $plant_animation


func _ready() -> void:
	plant_animation.play("default") 



@warning_ignore("unused_parameter")
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("interact"):
		if plant and plant_grown: 
			Stats.money += plant.price
			plant_animation.play("default")
			plant_growing = false
			plant_grown = false
			plant = null
		elif not plant_growing:
			plant = Game.inventory.active_item
			if plant:
				plant_growing = true
				grow_timer.start()
				plant_animation.play(plant.name)



func _on_grow_timer_timeout() -> void:
	plant_animation.frame += 1
	if plant_animation.frame == plant.grown_period - 1:
		plant_grown = true
		grow_timer.stop()
	if not plant_grown:
		grow_timer.start()
