extends Sprite2D

@onready var parent = $".."
var pressing = false

@export var maxLength = 50
@export var deadZone = 5

func _ready():
	maxLength *= parent.scale.x

func _process(delta):
	if pressing:
		var mouse_pos = get_global_mouse_position()
		var distance = mouse_pos.distance_to(parent.global_position)

		if distance <= maxLength:
			global_position = mouse_pos
		else:
			var angle = (mouse_pos - parent.global_position).angle()
			global_position.x = parent.global_position.x + cos(angle) * maxLength
			global_position.y = parent.global_position.y + sin(angle) * maxLength
			calculateVector()
	else:
		global_position = lerp(global_position, parent.global_position, delta * 100)
		parent.posVector = Vector2.ZERO  # Fixing the function issue

func calculateVector():
	var newVector = Vector2.ZERO
	if abs(global_position.x - parent.global_position.x) >= deadZone:
		newVector.x = (global_position.x - parent.global_position.x) / maxLength
	if abs(global_position.y - parent.global_position.y) >= deadZone:
		newVector.y = (global_position.y - parent.global_position.y) / maxLength
	
	parent.posVector = newVector  # Updating as a property, not a function

func _on_button_button_down() -> void:
	pressing = true

func _on_button_button_up() -> void:
	pressing = false
