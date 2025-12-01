extends Node

@export var vertical : bool = false

@export var randomize_order : bool = false

@export var material_dir : String
@export var material_descriptions : Dictionary[String, String]
@export var material_list : Array[String]
@export var hide_material_names : bool = false

@export var background_color : Color = Color(1.0, 1.0, 1.0)
@export var text_color : Color = Color(0.0, 0.0, 0.0, 1.0)


@onready var circle = $MeshPivot1/MeshPivot2/CirclePivot/Circle

@onready var meshes = [ $MeshPivot1/MeshPivot2/Mesh1, $MeshPivot1/MeshPivot2/Mesh2 ]
var material_names : Array[String]
var material_count : int
var materials : Dictionary
var current_material = 1

@export var bpm : float = 128.0
@export var beats_per_material : float = 3.0
@export var explosiveness : int = 5
@export var damp : float = 0.5
@export var angle : float = 0.0:
	set(v):
		angle = v
		if is_inside_tree():
			var angle_offset = floor(v)
			v -= angle_offset
			$MeshPivot1/MeshPivot2.rotation.z = PI*(angle_offset+lerp(my_smoothstep(v), v, damp))

func my_smoothstep(x : float) -> float:
	var rv : float = x
	for i in explosiveness:
		rv = smoothstep(0.0, 1.0, rv)
	return rv

var shader_time : float = 0.0

var MATERIAL_LIST_SHORT : Array[String] = [ 
	"cliff_rock", "cliff_rock", "cliff_rock", "cliff_rock", "rainy_window", "rosette", "manhole_cover", "gear_box", "ornamental_ceiling" ]


func _ready():
	set_physics_process(false)
	
	material_names = []
	
	materials = {}
	var tinymesh : BoxMesh = BoxMesh.new()
	tinymesh.size = Vector3(0.01, 0.01, 0.01)
	
	for m in material_list:
		if m in material_names:
			print("Found duplicate ", m)
		if m in material_descriptions:
			var material = load(material_dir+"/"+m+".tres")
			if material != null:
				materials[m] = material
				var mesh_instance : MeshInstance3D = MeshInstance3D.new()
				mesh_instance.position.x = 0.1
				mesh_instance.mesh = tinymesh
				mesh_instance.material_override = material
				add_child(mesh_instance)
				material_names.append(m)
			else:
				print("Failed to load "+m+".tres")
		else:
			print("No description for material ", m)
			get_tree().quit()
			return	
	
	if randomize_order:
		material_names.shuffle()
	material_names.push_front(material_names.front())
	material_names.push_front(material_names.front())
	material_names.push_front(material_names.front())
	if hide_material_names:
		$Label.position.y = -1000
		$LabelVertical.position.x = -1000
	elif vertical:
		$Label.position.y = -1000
	else:
		$LabelVertical.position.x = -1000
	material_count = material_names.size()
	
	$Background.material_override.albedo_color = background_color
	$Label.self_modulate = text_color
	$LabelVertical.self_modulate = text_color
	$LabelVertical/Author.self_modulate = text_color
	
	$AnimationPlayer2.speed_scale = bpm/120.0/beats_per_material
	print($AnimationPlayer2.speed_scale)
	
	$MeshPivot1/MeshPivot2/Mesh1.visible = true
	$MeshPivot1/MeshPivot2/Mesh2.visible = true
	$MeshPivot1/MeshPivot2/CirclePivot/Circle.visible = false
	change_material()
	change_material()

var next_material : String = ""
var offset : float = 0.0
var factor : float = 1.0
func change_material():
	if meshes == null:
		return
	if current_material >= material_count or current_material < 0:
		$MeshPivot1/MeshPivot2/CirclePivot/Circle.visible = true
		print(current_material)
		if current_material & 1 == 0:
			$AnimationPlayer2.play("Rotate final 1", 0.2)
			$MeshPivot1/MeshPivot2/Mesh2.visible = false
			offset = 0.5*PI if vertical else 0.0
		else:
			$AnimationPlayer2.play("Rotate final 2", 0.2)
			$MeshPivot1/MeshPivot2/CirclePivot/Circle.rotation.z = PI
			$MeshPivot1/MeshPivot2/Mesh1.visible = false
			offset = 0.5*PI if vertical else PI
			factor = -1.0
		circle.material_override.set_shader_parameter("shader_time", -10.0)
		var tween : Tween = get_tree().create_tween()
		tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		tween.tween_property(circle.material_override, "shader_parameter/shader_time", 50.0, 5.0)
		var end_tween : Tween = get_tree().create_tween()
		end_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		end_tween.tween_interval(2.1)
		end_tween.tween_callback(self.show_material_maker)
		end_tween.tween_interval(10)
		end_tween.tween_callback(self.end)
		set_physics_process(true)
	else:
		meshes[1-(current_material & 1)].material_override = materials[material_names[current_material]]
		next_material = material_names[current_material]
	current_material += 1

func _physics_process(_delta):
	$MeshPivot1/MeshPivot2/CirclePivot.rotation.x = offset+factor*$MeshPivot1.rotation.x

func update_label():
	var material_id : String = next_material.get_basename()
	if material_descriptions.has(material_id):
		var material_desc : PackedStringArray = material_descriptions[material_id].split(",")
		var material_name : String = material_desc[0]
		var material_author : String = material_desc[1]
		$Label.text = material_name + " - " + material_author
		$LabelVertical.text = material_name
		$LabelVertical/Author.text = material_author
	else:
		$Label.text = material_id
		$LabelVertical.text = material_id
		#print(material_name)

func show_material_maker():
	$ShowTitle.play("show_title_vertical" if vertical else "show_title_shrink")

func end():
	get_tree().quit()
