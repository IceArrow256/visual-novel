extends Control

export(float) var speed = 7.0

var dialog = [
	"Привет путник. Ты устал? Если да, то тебе стоит поситить таверну 'U baby Gali'.",
	"Изысканые напитки, прекрасные собеседники, и невероятные истории! Вот, что тебя ожидает в таверне 'U baby Gali'.",
	"Удачи тебе пушистик, ня!"
]

var dialog_index = 0
var finished = false
const MAX_LENGTH = 280.0

func _ready():
	load_dialog()

func _process(delta):
	$next.visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()

func load_dialog():
	if $Tween.is_active():
		$Tween.seek($Tween.get_runtime())
	elif dialog_index < dialog.size():
		finished = false
		$RichTextLabel.bbcode_text = dialog[dialog_index]
		$RichTextLabel.percent_visible = 0.0
		var text_speed = $RichTextLabel.bbcode_text.length() / MAX_LENGTH * speed
		$Tween.interpolate_property($RichTextLabel, "percent_visible", 0.0, 1.0, text_speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		dialog_index += 1

func _on_Tween_tween_completed(object, key):
	finished = true
