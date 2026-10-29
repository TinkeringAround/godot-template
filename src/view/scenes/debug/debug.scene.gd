extends Control

@onready var fps_label: Label = $FpsLabel as Label
@onready var version_label: Label = $VersionLabel as Label

func _ready() -> void:
	self.visible = Settings.DEBUG
	
	if Settings.DEBUG:
		version_label.text += Settings.VERSION
	
func _process(_delta: float) -> void:
	fps_label.text = "FPS: " + str(Engine.get_frames_per_second())
