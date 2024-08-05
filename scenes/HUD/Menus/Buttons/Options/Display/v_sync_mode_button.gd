extends Control

@onready var option_button = $HBoxContainer/OptionButton as OptionButton

const V_SYNC_MODE_ARRAY : Array[String] = [
	"Disabled",
	"Enabeled",
	"Adaptive",
	"Mailbox",
]

func _ready():
	option_button.clear()
	for v_sync_mode in V_SYNC_MODE_ARRAY:
		option_button.add_item(v_sync_mode)
	
	var v_sync_mode = SettingsManager.config.get_value("display", "vsync", 0)
	option_button.selected = v_sync_mode
	


func _on_option_button_item_selected(index):
	SettingsManager.set_setting("display","vsync",index)
	
