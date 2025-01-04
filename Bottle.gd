extends Node2D;


@export var bottle_texture: Texture

var dragable = false	
var is_inside_dropable = false
var body_ref
var offset: Vector2
var initial_pos : Vector2

func _ready():
	var sprite : Sprite2D  = get_node("Sprite2D")
	sprite.texture = bottle_texture
	global.is_dragging = false
	pass

func _process(delta):
	if(dragable):
		if(Input.is_action_just_pressed("click")):
			initial_pos = global_position
			offset = get_global_mouse_position() - self.position
			global.is_dragging = true

		if(Input.is_action_pressed("click")):
			position = get_global_mouse_position() - offset
		elif(Input.is_action_just_released("click")):
			global.is_dragging = false
			var tween = get_tree().create_tween()
			if(is_inside_dropable):
				print("Moving to body ",body_ref.global_position, body_ref.position)
				tween.tween_property(self, "global_position", body_ref.global_position, .2).set_ease(Tween.EASE_OUT)
			else:
				print("Moving to ", initial_pos)
				tween.tween_property(self, "global_position", initial_pos, .2).set_ease(Tween.EASE_OUT)

func _on_area_2d_body_entered(body: Node2D) -> void:
	var staticBody = get_node("BottleStaticBody");
	if(body.is_in_group("bottle") && body != staticBody):
		is_inside_dropable = true
		body_ref = body
		#print("Entered", body.name,body.global_position, body.position, global_position)


func _on_area_2d_body_exited(body: Node2D) -> void:
	var staticBody = get_node("BottleStaticBody");
	if(body.is_in_group("bottle") && body != staticBody):
		is_inside_dropable = false
		body_ref = body
		#print("Exited ", body.position, global_position)

func _on_mouse_entered() -> void:
	if not global.is_dragging:
		dragable = true
		scale = Vector2(1.05,1.05)
		print(global_position, position)


func _on_mouse_exited() -> void:
	if not global.is_dragging:
		dragable = false
		scale = Vector2(1,1)
		print(global_position, position)
