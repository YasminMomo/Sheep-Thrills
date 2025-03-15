extends CharacterBody2D

@onready var player_sprite = $AnimatedSprite2D
const SPEED = 100.0
const JUMP_VELOCITY = -400.0
const MAX_JUMPS = 2 

@onready var all_interactions = []
@onready var interactLabel = $"Interaction Components/InteractLabel"

func _ready():
	update_interactions()

var jump_count = 0 

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jump_count = 0

	if velocity.x < 0:
		player_sprite.flip_h = true
	elif velocity.x > 0:
		player_sprite.flip_h = false
		



	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and jump_count < MAX_JUMPS:
		velocity.y = JUMP_VELOCITY
		jump_count += 1 

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if Input.is_action_just_pressed("interact"):
		execute_interaction()


func _on_interaction_area_area_entered(area: Area2D):
	all_interactions.insert(0, area)
	update_interactions()

func _on_interaction_area_area_exited(area: Area2D):
	all_interactions.erase(area)
	update_interactions()

func update_interactions():
	if all_interactions:
		interactLabel.text = all_interactions[0].interact_label
	else:
		interactLabel.text = ""

func execute_interaction():
	if all_interactions:
		var current_interaction = all_interactions[0]
		match current_interaction.interact_type:
			"print_text":
				# Optionally display a message
				interactLabel.text = current_interaction.interact_value
				await get_tree().create_timer(1.0).timeout  # Delay for 2 seconds
				get_tree().change_scene_to_file("res://Scenes/Congratulations.tscn")
