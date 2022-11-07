extends Control

var mmkv = load("res://addons/godot-mmkv/mmkv.gd").new()

func _ready():
	ProjectSettings
	mmkv.initMMKV()
	loadData()
	
	mmkvWrite()
	mmkvRead()
	
	fileWrite()
	fileRead()
	
func loadData():
	$Control2/HP.text = "HP:%s"%str(PlayerData.hp)
	$Control2/NAME.text ="昵称：" + PlayerData.player_name
	$Control2/dict.text = to_json(PlayerData.attr)
	$Control2/Lv.text = "LV:%s" %str(PlayerData.lv)

func mmkvWrite():
	var a = Time.get_ticks_usec()
	mmkv.setString("asd",str(randf()))
	$Control/Label3.text += "%s /us"%str(Time.get_ticks_usec() - a)

func mmkvRead():
	var a = Time.get_ticks_usec()
	mmkv.getString("asd")
	$Control/Label5.text += "%s /us"%str(Time.get_ticks_usec() - a)

func fileWrite():
	var a = Time.get_ticks_usec()
	saveFile(str(randf()))
	$Control/Label4.text += "%s /us"%str(Time.get_ticks_usec() - a)

func fileRead():
	var a = Time.get_ticks_usec()
	loadFile()
	$Control/Label6.text += "%s /us"%str(Time.get_ticks_usec() - a)

func mmkvTest():
	var a = Time.get_ticks_msec()
	for i in 10000:
		mmkv.setString("asd",str(randf() +i))
		$Control/RichTextLabel.call_deferred("append_bbcode",mmkv.getString("asd") +"\n")
	$Control/Label.text += "\n 耗时：%s" %str(Time.get_ticks_msec() - a)

func fileTest():
	var a = Time.get_ticks_msec()
	for i in 10000:
		saveFile(str(randf()+i))
		$Control/RichTextLabel2.call_deferred("append_bbcode",loadFile())
	$Control/Label2.text += "\n 耗时：%s" %str(Time.get_ticks_msec() - a)

func saveFile(content):
	var file = File.new()
	file.open("user://save_game.dat", File.WRITE)
	file.store_line(content)
	file.close()

func loadFile():
	var file = File.new()
	file.open("user://save_game.dat", File.READ)
	var content = file.get_as_text()
	file.close()
	return content
	
func _on_Button_pressed():
	yield(test(),"completed")

func test():
	mmkvTest()
	
	fileTest()
	yield(get_tree(),"idle_frame")

func _on_Button2_pressed():
	PlayerData.player_name = "咲夜" + str(randf())
	PlayerData.hp = randi()% 100
	PlayerData.attr = {
		"exp":randi()%100,
		"atk":randi()%500
	}
	PlayerData.lv += 1
	loadData()


func _on_Timer_timeout():
	PlayerData.lv += 1
	loadData()

func _on_Button3_pressed():
	$Timer.stop()
