extends Node2D

export(String, "bell", "kick", "snare", "laser") var sound

var angle = 0

func _on_timer_timeout():
	
	var ball = preload("res://ball.tscn").instance()
	ball.position = position
	ball.sound = sound
	ball.vel = Vector2(4, 0).rotated(deg2rad(angle+45))
	ball.notes = gen_notes()

	
	var ball_container = get_tree().get_nodes_in_group("ball_container")[0]
	ball_container.add_child(ball)
	
	angle += 90
	angle %= 360


func gen_notes():
	
	var notes = []
	
	#seed(hash(angle+1))
	seed(3) # seed = 2 is nice
	randi()
	
	var base_pitch = 0.06#rand_range(0.05, 0.2)
	# print(base_pitch)
		
	var note1 = randi() % 12
	var note2 = randi() % 12
	var note3 = randi() % 12
	
	notes.push_back(2 * base_pitch)
	notes.push_back(pow(2, 1 + note1/12.0) * base_pitch)
	notes.push_back(pow(2, 1 + note2/12.0) * base_pitch)
	notes.push_back(pow(2, 1 + note3/12.0) * base_pitch)
	
	for i in 100:
		var n1 = notes[-1]
		var n2 = notes[-2]
		var n3 = notes[-3]
		var n4 = notes[-4]		
		
		notes.push_back(n1 * 2)
		notes.push_back(n2 * 2)
		notes.push_back(n3 * 2)
		notes.push_back(n4 * 2)	
		
	randomize()
		
	return notes