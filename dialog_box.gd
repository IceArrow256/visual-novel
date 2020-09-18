extends Control

var dialog = [
	"Привет путник. Ты устал? Если да, то тебе стоит поситить таверну 'U baby Gali'.",
	"Изысканые напитки, прекрасные собеседники, и невероятные истории! Вот, что тебя ожидает в таверне 'U baby Gali'.",
	"Удачи тебе путник, ня!"
]

var dialog_index = 0
var finished = false

func _ready():
	load_dialog()
	
func _process(delta):
	$next.visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()
	
func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		$RichTextLabel.bbcode_text = dialog[dialog_index]
		$RichTextLabel.percent_visible = 0
		var max_length = 0
		for string in dialog:
			max_length = max(string.length(), max_length)
		var text_speed = $RichTextLabel.bbcode_text.length()*1.0 / max_length * 5
		$Tween.interpolate_property($RichTextLabel, "percent_visible", 0, 1, text_speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
	else:
		queue_free()
	dialog_index += 1


func _on_Tween_tween_completed(object, key):
	finished = true
