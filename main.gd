extends Node

var current_line = null
var p1 = Vector2()
var p2 = p1

var last_mouse_pos = Vector2()

func _ready():
	
	yield(get_tree().create_timer(5), "timeout")
	
	spawn_emitter("bell", Vector2(0.3, 0.2))
	spawn_emitter("kick", Vector2(0.3, 0.6))
	spawn_emitter("snare", Vector2(0.7, 0.2))
	spawn_emitter("laser", Vector2(0.7, 0.6))
	
	
func spawn_emitter(name, pos):
	var emitter = preload("res://emitter.tscn").instance()
	emitter.sound = name
	emitter.position = pos * OS.window_size
	add_child(emitter)

func _process(delta):
	
	last_mouse_pos = $cam.get_global_mouse_position()
	
	p2 = last_mouse_pos
	
	if current_line != null:
		current_line.set_ends(p1, p2)
		
func _input(event):
	
	if (event.is_action_released("ui_cancel")):
		get_tree().quit()
		
	if event is InputEventMouseButton:
		
		if event.pressed and event.button_index == BUTTON_LEFT:
			
			p1 = last_mouse_pos
			p2 = p1
			
			current_line = preload("res://line.tscn").instance()
			current_line.set_ends(p1, p2)
			add_child(current_line)
			
		else:
			
			current_line = null