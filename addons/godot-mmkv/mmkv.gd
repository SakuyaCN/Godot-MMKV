extends Node
class_name NodeMMKV

export(bool) var isBinding = false
export(float) var save_tikc = 0.1 setget set_save_tick

var _mmkv = load("res://addons/godot-mmkv/NodeMMKV.gdns").new()
var frameTimer = FrameTimer.new()
var local_list = []

func set_save_tick(tick):
	frameTimer.stop()
	frameTimer.wait_time = tick
	frameTimer.start()

func bindFile():
	var file_name = get_script().get_path()
	initMMKV("",file_name)

	var list = get_property_list()
	for item in list:
		if item['usage'] == PROPERTY_USAGE_SCRIPT_VARIABLE && item['name'] != "_mmkv" && item['name'] != "local_list":
			local_list.append(item)

func setAutoSave():
	frameTimer.wait_time = save_tikc
	frameTimer.connect("timeout",self,"timeoutSave")
	add_child(frameTimer)
	frameTimer.start()

func saveMMKV():
	if local_list.size() == 0:
		return
	var dict = {}
	for item in local_list:
		dict[item['name']] = get(item['name'])
	setDict("dict",dict)

func getPropertyList():
	var dict = getDict("dict")
	if dict == null:
		return
	for item in dict:
		set(item,dict[item])

func _enter_tree():
	if isBinding:
		bindFile()

func _ready():
	if isBinding:
		setAutoSave()
		getPropertyList()

func timeoutSave(_amount):
	saveMMKV()

#mmkv init
#local path C:\Users\{xxxx}\AppData\Roaming\Godot\{file_path}\{file_name}
#file_path = Godot-MMKV
#file_name = mmkv.default
func initMMKV(file_path:String ="",file_name:String=""):
	_mmkv.initMMKV(file_path,file_name)

#设置一个字符
func setString(_key_name:String,_value:String):
	_mmkv.setValue(_key_name,_value)

#设置一个字典
func setDict(_key_name:String,_value):
	_mmkv.setValue(_key_name,to_json(_value))

#设置一个浮点数
func setFloat(_key_name:String,_value:float):
	_mmkv.setFloat(_key_name,_value)

#设置一个浮点数
func setBool(_key_name:String,_value:bool):
	_mmkv.setBool(_key_name,_value)

#读取一个字符
func getString(_key_name:String) -> String:
	return _mmkv.getValue(_key_name)

#读取一个字典
func getDict(_key_name:String) -> Dictionary:
	var json = _mmkv.getValue(_key_name)
	if json == null || json == "":
		return {}
	return JSON.parse(_mmkv.getValue(_key_name)).result

#读取一个浮点数
func getFloat(_key_name:String) -> float:
	return _mmkv.getFloat(_key_name)

#读取一个浮点数
func getBool(_key_name:String) -> bool:
	return _mmkv.getBool(_key_name)
