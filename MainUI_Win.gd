extends Control

var edit_index = 0

onready var Name = $VBoxContainer/HBoxContainer/VBoxContainer/Name
onready var Score1 = $VBoxContainer/HBoxContainer/VBoxContainer/Score1
onready var Score2 = $VBoxContainer/HBoxContainer/VBoxContainer/Score2
onready var Score3 = $VBoxContainer/HBoxContainer/VBoxContainer/Score3
onready var Score4 = $VBoxContainer/HBoxContainer/VBoxContainer/Score4

onready var ConfirmButton = $ConfirmButton
onready var ClearButton = $ClearButton

onready var Data = $VBoxContainer/MarginContainer/VBoxContainer3/Data
onready var DebugData = $VBoxContainer/HBoxContainer/DebugData

var data := {}

# Called when the node enters the scene tree for the first time.
func _ready():
	DebugData.text += "--依次输入姓名和四个得分，点击“确认”或按【回车键】以计算最终得分并添加数据--\n"
	DebugData.text += "--排名会自动更新--\n"
	DebugData.text += "--姓名若已经添加，将修改ta的分数--\n"
	DebugData.text += "--点击“清空”或按【esc键】以清除所有数据（是下方的数据，不是上面的五个输入框）--\n"
	DebugData.text += "--祝您使用愉快，欢迎联系QQ920780950，取得联系--\n"

func _input(event):
	if event.is_action_pressed("key_enter"):
		_on_ConfirmButton_pressed()
	if event.is_action_pressed("key_esc"):
		_on_ClearButton_pressed()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_ClearButton_pressed():
	clear_data()
	pass # Replace with function body.


func _on_ConfirmButton_pressed():
	if Name.text == "" or Score1.text == "" or Score2.text == "" or Score3.text == "" or Score4.text == "":
		DebugData.text += "--数据遗漏，请检查是否已全部输入--\n"
		return
	
	var _name = Name.text
	var _score1 = Score1.text.to_float()
	var _score2 = Score2.text.to_float()
	var _score3 = Score3.text.to_float()
	var _score4 = Score4.text.to_float()
	
	var _result_score = _score1 * 0.6 + _score2 * 0.2 + _score3 * 0.2 + _score4
	
	data[_name] = _result_score
	
	data = sort_list(data)
	
	update_data()

func sort_list(list : Dictionary, list_size := 0):
	DebugData.text += "--排名表已更新--\n"
	var _list = {}
	var _values = list.values()
	_values.sort()
	_values.invert()
	if list_size > 0:
		_values.resize(list_size)
	for value in _values:
		for i in list:
			if list.get(i) == value and !_list.has(i):
				_list[i] = value
	return _list

func update_data():
	DebugData.text += "--数据已更新--\n"
	Data.text = ""
	var _count = 0
	for i in data:
		_count += 1
		Data.text += "第" + str(_count) + "名 " + i + " 分数：" + str(data[i]) + "\n"

func clear_data():
	DebugData.text += "--数据已清空--\n"
	data.clear()
	update_data()
