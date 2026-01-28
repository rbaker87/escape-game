extends AudioStreamPlayer

## Volume in percentage (0-100). Converts to dB internally.
@export_range(0, 100, 1) var volume_percent: int = 50:
	set(value):
		volume_percent = value
		# Convert percentage to dB: 100% = 0dB, 50% ≈ -6dB, 0% = -80dB
		if value <= 0:
			volume_db = -80
		else:
			volume_db = linear_to_db(value / 100.0)


func _ready():
	# Apply initial volume
	volume_db = linear_to_db(volume_percent / 100.0)
	# Music will be started by the start screen
