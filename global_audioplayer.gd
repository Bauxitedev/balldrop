extends Node

var container
func _ready():
	
	container = preload("res://global_audiocontainer.tscn").instance()

func play_at(sound_name, pos, pitch):
	
	var player = container.get_node("player_" + sound_name).duplicate()
	player.stream = player.stream.duplicate()
	player.stream.mix_rate = pitch * 44100.0
	player.position = pos
	player.play()
	$"/root".add_child(player)
	
	player.connect("finished", player, "queue_free")