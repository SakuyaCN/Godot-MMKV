extends NodeMMKV

var player_name = "sakuya"
var hp = 0
var lv = 1
var attr = {}

func _init():
	isBinding = true #开启自动绑定
	save_tikc = 0.05 #自动存储间隔 ms

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

