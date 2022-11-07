# Godot-MMKV
Godot MMKV is an efficient, small, easy-to-use key-value storage framework,its build from https://github.com/Tencent/MMKV.

# Features
---
>Efficient. MMKV uses mmap to keep memory synced with files, and protobuf to encode/decode values.

>Reading and writing data in a loop is about 40 times faster than Godot File System

>Multi-Process concurrency: MMKV supports concurrent read-read and read-write access between processes.
>Easy-to-use. You can use MMKV as you go. All changes are saved immediately, no sync, no apply calls needed.

## Supported operating systems:
- Windows(x64)
- Android(arm64-v8a x86_64)

# Quick Tutorial
---
Download the file to your addons folder

```gdsript
var _mmkv = load("res://addons/godot-mmkv/mmkv.gd").new()

  func _ready():  
    _mmkv.initMMKV("file_path","file_name") 
    _mmkv.setString("key","value")  
    var result = _mmkv.getString("key") 
    print(result) 
```
>Supported data types:
>>1.String

>>2.float

>>3.Dictionary
---
# Autosave class
It can automatically cache variables in the current script
```gdsript
extends NodeMMKV

#var hp = 0 
#The variable will be automatically saved, and it will be automatically assigned the next time it is opened.

func _init():
	isBinding = true #open auto save
	save_tikc = 0.05 #save wait time
 ```
