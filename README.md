# Godot-MMKV
Godot MMKV is an efficient, small, easy-to-use key-value storage framework,its build from https://github.com/Tencent/MMKV.

# Features
---
>Efficient. MMKV uses mmap to keep memory synced with files, and protobuf to encode/decode values.

>Reading and writing data in a loop is about 40 times faster than Godot File System

>Multi-Process concurrency: MMKV supports concurrent read-read and read-write access between processes.
>Easy-to-use. You can use MMKV as you go. All changes are saved immediately, no sync, no apply calls needed.

# Quick Tutorial
---
>1.Download the file to your addons folder
`
  var _mmkv = load("res://addons/godot-mmkv/mmkv.gd").new()
  
  func _ready():
    _mmkv.initMMKV("file_path","file_name")
    _mmkv.setString("key","value")
    var result = _mmkv.getString("key")
    print(result)
  
`
