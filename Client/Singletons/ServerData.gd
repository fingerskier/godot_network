extends Node

var bullet_data = {"speed": 200, "damage": 100}
var network = NetworkedMultiplayerENet.new()
var ip = "192.168.1.28"
var port = 1909


func _ready():
	print("Server setup")
	ConnectToServer()

func ConnectToServer():
	print("Connecting to server")
	network.create_client(ip, port)
	get_tree().set_network_peer(network)

	network.connect("connection_failed", self, "_OnConnectionFailed")
	network.connect("connection_succeeded", self, "_OnConnectionSuccess")

func FetchBulletData(name, requester):
	print("fetching bullet data")
	rpc_id(1, "FetchBulletData", name, requester)

remote func ReturnBulletDamage(damage, requester):
	print("received bullet damage info", damage, requester)
	instance_from_id(requester).SetDamage(damage)

func _OnConnectionFailed():
	print("Failed to connect to server")

func _OnConnectionSuccess():
	print("Connected to server")
