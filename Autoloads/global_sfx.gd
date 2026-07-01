extends Node


@export var blip_positive: AudioStreamPlayer
@export var blip_negative: AudioStreamPlayer
@export var misc_blip: AudioStreamPlayer


func button_down()-> void:
	blip_positive.play();
	blip_negative.stop();

func button_up() -> void:
	blip_negative.play();
	blip_positive.stop();

func focused() -> void:
	misc_blip.volume_linear = 0.5;
	misc_blip.play();
