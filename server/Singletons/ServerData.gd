extends Node

var bullet_data

func _ready():
	print("Loading bullet JSON")
	var bullet_data_file = File.new()
	bullet_data_file.open("res://Data/bullet.json", File.READ)
	var bullet_data_json = JSON.parse(bullet_data_file.get_as_text())
	bullet_data_file.close()
	bullet_data = bullet_data_json.result
 
