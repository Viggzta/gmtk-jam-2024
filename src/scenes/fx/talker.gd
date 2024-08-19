class_name Talker extends Node2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var _sound_dictionary: Dictionary = {
	'a': preload("res://audio/alphabet/victor/a.wav"),
	'b': preload("res://audio/alphabet/victor/b.wav"),
	'c': preload("res://audio/alphabet/victor/c.wav"),
	'd': preload("res://audio/alphabet/victor/d.wav"),
	'e': preload("res://audio/alphabet/victor/e.wav"),
	'f': preload("res://audio/alphabet/victor/f.wav"),
	'g': preload("res://audio/alphabet/victor/g.wav"),
	'h': preload("res://audio/alphabet/victor/h.wav"),
	'i': preload("res://audio/alphabet/victor/i.wav"),
	'j': preload("res://audio/alphabet/victor/j.wav"),
	'k': preload("res://audio/alphabet/victor/k.wav"),
	'l': preload("res://audio/alphabet/victor/l.wav"),
	'm': preload("res://audio/alphabet/victor/m.wav"),
	'n': preload("res://audio/alphabet/victor/n.wav"),
	'o': preload("res://audio/alphabet/victor/o.wav"),
	'p': preload("res://audio/alphabet/victor/p.wav"),
	'q': preload("res://audio/alphabet/victor/q.wav"),
	'r': preload("res://audio/alphabet/victor/r.wav"),
	's': preload("res://audio/alphabet/victor/s.wav"),
	't': preload("res://audio/alphabet/victor/t.wav"),
	'u': preload("res://audio/alphabet/victor/u.wav"),
	'v': preload("res://audio/alphabet/victor/v.wav"),
	'w': preload("res://audio/alphabet/victor/w.wav"),
	'x': preload("res://audio/alphabet/victor/x.wav"),
	'y': preload("res://audio/alphabet/victor/y.wav"),
	'z': preload("res://audio/alphabet/victor/z.wav"),
	'å': preload("res://audio/alphabet/victor/å.wav"),
	'ä': preload("res://audio/alphabet/victor/ä.wav"),
	'ö': preload("res://audio/alphabet/victor/ö.wav"),
}

### Returns the length of the sound in seconds
func play_and_get_length(letter: String) -> float:
	var small_letter: String = letter.to_lower()
	if _sound_dictionary.has(small_letter):
		var playback: AudioStreamPlaybackPolyphonic = audio_stream_player_2d.get_stream_playback()
		var stream: AudioStream = _sound_dictionary[small_letter]
		playback.play_stream(stream, 0, 0, randf_range(0.9, 1.1))
		return stream.get_length()
	else:
		return 0.0
