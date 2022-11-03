extends Control

#提供一个可访问
var mmkv = load("res://addons/godot-mmkv/mmkv.gd").new()

func _ready():
	mmkv.initMMKV()
	loadData()

func loadData():
	$Control2/HP.text = "HP:%s"%str(PlayerData.hp)
	$Control2/NAME.text ="昵称：" +PlayerData.player_name
	$Control2/dict.text = to_json(PlayerData.attr)

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
	mmkvTest()
	
	fileTest()

func _on_Button2_pressed():
	PlayerData.player_name = "昵称：咲夜" + str(randf())
	PlayerData.hp = randi()% 100
	PlayerData.attr = {
		"exp":randi()%100,
		"atk":randi()%500
	}
	loadData()
