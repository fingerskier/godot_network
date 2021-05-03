extends Node

var network = NetworkedMultiplayerENet.new()
var port = 1909
var max_players = 100

func _ready():
	StartServer()
	
	
func StartServer():
	network.create_server(port, max_players)
	get_tree().set_network_peer(network)
	print("Server Started")
	
	network.connect("peer_connected", self, "_Peer_connected")
	network.connect("peer_connected", self, "_Peer_disconnected")
	
remote func FetchBulletData(name, requester):
	print("remote fetch bullet data")
	var player_id = get_tree().get_rpc_sender_id()
	var damage = ServerData.bullet_data.damage
	rpc_id(player_id, "ReturnBulletDamage", damage, requester)
	print("bullet damage sent: " + str(damage))

func _Peer_connected(player_id):
	print("User " + str(player_id) + " connected")

func _Peer_disconnected(player_id):
	print("User " + str(player_id) + " disconnected")
