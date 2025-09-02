extends Node

@onready var circle = $MeshPivot1/MeshPivot2/CirclePivot/Circle

@onready var meshes = [ $MeshPivot1/MeshPivot2/Mesh1, $MeshPivot1/MeshPivot2/Mesh2 ]
var material_names : Array
var material_count : int
var materials : Dictionary
var current_material = 1

var shader_time : float = 0.0

var MATERIALS = {
	ancient_bricks = { name="Ancient bricks", author="DroppedBeat" },
	ancient_pedestal = { name="Ancient pedestal", author="Tarox" },
	animated_fire = { name="Animated fire", author="unfa" },
	animated_radar = { name="Animated radar", author="PixelMuncher" },
	arcane_compass = { name="Arcane compass", author="wojtekpil" },
	beach = { name="Beach", author="Tarox" },
	bookcase = { name="Cozy bookcase", author="Arnklit" },
	burger = { name="Burger", author="Arnklit" },
	chained = { name="Chained down", author="Tarox" },
	chesterfield = { name="Chesterfield", author="TheoDGM" },
	cliff_rock = { name="Cliff rock", author="Skywolf" },
	containers = { name="Containers", author="DroppedBeat" },
	damaged_plaster = { name="Damaged plaster wall", author="Arnklit" },
	floppy_disks = { name="Floppy disks", author="PixelMuncher" },
	gears_panel = { name="Gears panel", author="RodZilla" },
	gingerbread = { name="Gingerbread", author="Tarox" },
	ground_foliage = { name="Ground foliage", author="Arnklit" },
	hardwood_floor = { name="Decrepit Hardwood floor", author="BurritoLord69" },
	leather = { name="Stitched leather", author="Tarox" },
	manhole_cover = { name="Manhole cover", author="PixelMuncher" },
	matrix_code_rain = { name="Matrix rain code", author="DroppedBeat" },
	ornamental = { name="Ornamental", author="DroppedBeat" },
	ornamental_ceiling = { name="Ornamental ceiling", author="Tarox" },
	polished_turquoise = { name="Polished turquoise", author="LitmusZest" },
	rainy_window = { name="Rainy window", author="unfa" },
	remnant = { name="Remnant", author="Tarox" },
	roof_tiles = { name="Old roof tiles", author="Tarox" },
	rosette = { name="Rosette", author="Tarox" },
	scarabs_on_hieroglyphs = { name="Scarab Beetles Crawling on Hieroglyphs", author="Arnklit" },
	sewn_flesh = { name="Sewn flesh", author="Gin" },
	smaugs_treasure = { name="Smaug's Treasure", author="Arnklit" },
	snowman = { name="Snowman", author="Arnklit" },
	stylized_flowing_lava = { name="Stylized flowing lava", author="Tarox" },
	stylized_lava = { name="Stylized lava", author="Tarox" },
	temporal_displacement = { name="Temporal displacement", author="DroppedBeat" },
	train_tracks = { name="Train tracks", author="PixelMuncher" },
	wires = { name="Wires", author="DroppedBeat" },
}

func _ready():
	set_physics_process(false)
	material_names = []
	materials = {}
	var dir = DirAccess.open("res://materials")
	var tinymesh : BoxMesh = BoxMesh.new()
	tinymesh.size = Vector3(0.01, 0.01, 0.01)
	if dir != null:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if ! dir.current_is_dir() and file_name.get_extension() == "tres":
				var material = load("res://materials/"+file_name)
				if material != null:
					material_names.push_back(file_name)
					materials[file_name] = material
					var mesh_instance : MeshInstance3D = MeshInstance3D.new()
					mesh_instance.position.x = 0.1
					mesh_instance.mesh = tinymesh
					mesh_instance.material_override = material
					add_child(mesh_instance)
					if materials.keys().size() > 6:
						break
				else:
					print("Failed to load "+file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
	material_count = material_names.size()
	
	change_material()
	change_material()

var next_material : String = ""
func change_material():
	if meshes == null:
		return
	meshes[0].material_override = meshes[1].material_override
	if current_material >= material_count or current_material < 0:
		$AnimationPlayer1.speed_scale = 0.0
		$AnimationPlayer2.play("Rotate final")
		$MeshPivot1/MeshPivot2/CirclePivot.rotation.x = $MeshPivot1.rotation.x
		circle.material_override.set_shader_parameter("shader_time", -10.0)
		var tween : Tween = get_tree().create_tween()
		tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		tween.tween_property(circle.material_override, "shader_parameter/shader_time", 50.0, 5.0)
	else:
		meshes[1].material_override = materials[material_names[current_material]]
		next_material = material_names[current_material]
		current_material += 1

func update_label():
	var material_name : String = next_material.get_basename()
	if MATERIALS.has(material_name):
		var material_desc = MATERIALS[material_name]
		$Label.text = material_desc.name + " - " + material_desc.author
	else:
		$Label.text = material_name
		#print(material_name)

func end():
	get_tree().quit()
