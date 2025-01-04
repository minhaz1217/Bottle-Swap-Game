extends Node2D;


@export var bottle_texture: Texture

var dragable = false	
var is_inside_dropable = false
var body_ref
var offset: Vector2
var initial_pos : Vector2
var starting_position: Vector2
var tween : Tween

func _ready():
	var sprite : Sprite2D  = get_node("Sprite2D")
	sprite.texture = bottle_texture
	global.is_dragging = false
	pass

func _process(delta):
	if(dragable && (tween == null || !tween.is_running())):
		if(Input.is_action_just_pressed("click")):
			initial_pos = global_position
			offset = get_global_mouse_position() - self.position
			global.is_dragging = true

		if(Input.is_action_pressed("click")):
			position = get_global_mouse_position() - offset
		elif(Input.is_action_just_released("click")):
			global.is_dragging = false
			
			tween = get_tree().create_tween()
			if(is_inside_dropable):
				print(self.name, body_ref.name, initial_pos, body_ref.global_position)
				tween.tween_property(self, "global_position", body_ref.global_position, .2).set_ease(Tween.EASE_OUT)
				tween.tween_property(body_ref.get_parent(), "global_position", initial_pos, .2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self, "global_position", initial_pos, .2).set_ease(Tween.EASE_OUT)

func _on_area_2d_body_entered(body: Node2D) -> void:
	var staticBody = get_node("BottleStaticBody");
	if(body.is_in_group("bottle") && body != staticBody):
		is_inside_dropable = true
		body_ref = body
		print("Entered ", body.get_parent().name)


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
