extends Node2D

var vel = Vector2()
var prevpos = Vector2()
var sound

var notes = [] # TODO generate this globally

func _ready():
	
	prevpos = position
	
	var goalcol = Color(0,0,0)
	
	match sound:
		
		"bell": goalcol = Color(0,1,1)
		"kick": goalcol = Color(1,0,0)
		"snare": goalcol = Color(0,1,0)
		"laser": goalcol = Color(1,1,0)
		
	$spr.modulate = goalcol
	goalcol *= 0.3
	
	$parts.modulate = goalcol
	
	
		

func _physics_process(delta):
	
	
	if position.y > 2000:
		queue_free()
	
	vel += Vector2(0, 20 * 1) * delta
	prevpos = position
	position += vel
	
	# manual collision for now
	
	var colliders = get_tree().get_nodes_in_group("line")
	
	for c in colliders:
		
		var p1 = c.a
		var p2 = c.b
		var norm = (p2-p1).tangent().normalized()
		var coll = Geometry.segment_intersects_segment_2d(prevpos, position, p1, p2)
		
		if coll != null:
			# print(norm)
			
			if vel.length() > 1.0:
					
				var pitch = vel.length()
				
				if sound == "bell":
					pass
				else:
					pitch *= 2
				
				pitch = notes[round(pitch)] #pow(2, round(log(pitch) / log(2)) / 3.0)
				
				#pitch *= round(rand_range(1,7))				
				pitch += rand_range(-1,1)*0.002
				AudioPlayer.play_at(sound, position, pitch)
				
			
			
			if vel.dot(norm) > 0:
				norm = -norm
			
			var restitution = 0.8
			vel = (-vel.reflect(norm)).linear_interpolate(vel.slide(norm), 1-restitution)
			
			position = coll + norm * 0.1
			
			var shockwave = preload("res://shockwave.tscn").instance()
			shockwave.position = position
			shockwave.modulate = $spr.modulate
			get_parent().add_child(shockwave)
			
			