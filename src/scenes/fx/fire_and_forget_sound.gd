class_name FireAndForgetSound extends Node2D

enum SoundClips {
	Woosh,
	Uuuh,
	Suuck,
	Cut,
	CutRope
}

var _sound_dictionary: Dictionary = {
	SoundClips.Woosh: preload("res://audio/fx/build_sound.wav"),
	SoundClips.Uuuh: preload("res://audio/fx/no_build.wav"),
	SoundClips.Suuck: preload("res://audio/fx/suuuck.wav"),
	SoundClips.Cut: preload("res://audio/fx/sax.wav"),
	SoundClips.CutRope: preload("res://audio/fx/cut_rope.wav")
}

var _audio_stream: AudioStream

func set_and_play(sound_clip: SoundClips) -> void:
	_audio_stream = _sound_dictionary[sound_clip]
	
func _ready() -> void:
	$AudioStreamPlayer2D.stream = _audio_stream
	$AudioStreamPlayer2D.play()

func _on_audio_stream_player_2d_finished() -> void:
	self.queue_free()
