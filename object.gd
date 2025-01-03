extends Node2D

var dragable = false
var is_inside_dropable = false
var body_ref
var offset: Vector2
var initial_pos : Vector2

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if(dragable):
		if(Input.is_action_just_pressed("click")):
			initial_pos = global_position
			offset = get_global_mouse_position() - global_position
			global.is_dragging = true

		if(Input.is_action_pressed("click")):
			global_position = get_global_mouse_position() - offset
		elif(Input.is_action_just_released("click")):
			global.is_dragging = false
			var tween = get_tree().create_tween()
			if(is_inside_dropable):
				tween.tween_property(self, "position", body_ref.position, .2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self, "global_position", initial_pos, .2).set_ease(Tween.EASE_OUT)
			



func _on_area_2d_mouse_entered() -> void:
	if not global.is_dragging:
		dragable = true
		scale = Vector2(1.05,1.05)


func _on_area_2d_mouse_exited() -> void:
	if not global.is_dragging:
		dragable = false
		scale = Vector2(1,1)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("dropable")):
		is_inside_dropable = true
		body.modulate = Color(Color.BLUE, 1)
		body_ref = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.is_in_group("dropable")):
		is_inside_dropable = false
		body.modulate = Color(Color.BLUE, .7)
		body_ref = body
