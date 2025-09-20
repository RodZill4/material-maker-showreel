extends Node

@onready var circle = $MeshPivot1/MeshPivot2/CirclePivot/Circle

@onready var meshes = [ $MeshPivot1/MeshPivot2/Mesh1, $MeshPivot1/MeshPivot2/Mesh2 ]
var material_names : Array[String]
var material_count : int
var materials : Dictionary
var current_material = 1

@export var damp : float = 0.5
@export var angle : float = 0.0:
	set(v):
		angle = v
		if is_inside_tree():
			var offset = floor(v)
			v -= offset
			$MeshPivot1/MeshPivot2.rotation.z = PI*(offset+lerp(my_smoothstep(v), v, damp))

func my_smoothstep(x : float) -> float:
	var rv : float = x
	rv = smoothstep(0.0, 1.0, rv)
	rv = smoothstep(0.0, 1.0, rv)
	rv = smoothstep(0.0, 1.0, rv)
	rv = smoothstep(0.0, 1.0, rv)
	rv = smoothstep(0.0, 1.0, rv)
	return rv

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
	fish_pond = { name="Fish pond", author="DroppedBeat" },
	floppy_disks = { name="Floppy disks", author="PixelMuncher" },
	gears_panel = { name="Gears panel", author="RodZilla" },
	gear_box = { name="Gear box", author="DroppedBeat" },
	gingerbread = { name="Gingerbread", author="Tarox" },
	ground_foliage = { name="Ground foliage", author="Arnklit" },
	hardwood_floor = { name="Decrepit Hardwood floor", author="BurritoLord69" },
	kryptonite = { name="Kryptonite", author="Tarox" },
	leather = { name="Stitched leather", author="Tarox" },
	manhole_cover = { name="Manhole cover", author="PixelMuncher" },
	matrix_code_rain = { name="Matrix rain code", author="DroppedBeat" },
	ornamental = { name="Ornamental", author="DroppedBeat" },
	ornamental_ceiling = { name="Ornamental ceiling", author="Tarox" },
	polished_turquoise = { name="Polished turquoise", author="LitmusZest" },
	puddle = { name="Puddle", author="DroppedBeat" },
	rainy_window = { name="Rainy window", author="unfa" },
	remnant = { name="Remnant", author="Tarox" },
	roof_tiles = { name="Old roof tiles", author="Tarox" },
	rosette = { name="Rosette", author="Tarox" },
	scarabs_on_hieroglyphs = { name="Scarab Beetles Crawling on Hieroglyphs", author="Arnklit" },
	sealing_talismans = { name="Sealing Talismans", author="DroppedBeat" },
	sewn_flesh = { name="Sewn flesh", author="Gin" },
	smaugs_treasure = { name="Smaug's Treasure", author="Arnklit" },
	snowman = { name="Snowman", author="Arnklit" },
	stylized_flowing_lava = { name="Stylized flowing lava", author="Tarox" },
	stylized_lava = { name="Stylized lava", author="Tarox" },
	temporal_displacement = { name="Temporal displacement", author="DroppedBeat" },
	train_tracks = { name="Train tracks", author="PixelMuncher" },
	wires = { name="Wires", author="DroppedBeat" },
}

var MATERIAL_LIST_LONG : Array[String] = [
	"roof_tiles", "polished_turquoise", "beach", "gingerbread",
	"sewn_flesh", "ornamental", "gear_box", "floppy_disks",
	"smaugs_treasure", "animated_fire", "arcane_compass", "wires",
	"containers", "stylized_flowing_lava", "ancient_bricks",
	"sealing_talismans", "temporal_displacement", "bookcase",
	"gears_panel", "scarabs_on_hieroglyphs", "burger", "chained",
	"hardwood_floor", "puddle", "cliff_rock", "manhole_cover",
	"matrix_code_rain", "rosette", "kryptonite", "rainy_window",
	"remnant", "ornamental_ceiling", "stylized_lava",
	"train_tracks", "ancient_pedestal", "animated_radar",
	"damaged_plaster", "fish_pond", "leather", "chesterfield",
	"snowman", "ground_foliage"]


func _ready():
	material_names = MATERIAL_LIST_LONG
	material_count = material_names.size()
	
	set_physics_process(false)
	
	materials = {}
	var tinymesh : BoxMesh = BoxMesh.new()
	tinymesh.size = Vector3(0.01, 0.01, 0.01)
	
	for m in material_names:
		if m in MATERIALS:
			var material = load("res://materials/"+m+".tres")
			if material != null:
				materials[m] = material
				var mesh_instance : MeshInstance3D = MeshInstance3D.new()
				mesh_instance.position.x = 0.1
				mesh_instance.mesh = tinymesh
				mesh_instance.material_override = material
				add_child(mesh_instance)
				if materials.keys().size() > 1000:
					break
			else:
				print("Failed to load "+m+".tres")
				get_tree().quit()
				return
		else:
			print("No description for material ", m)
			get_tree().quit()
			return

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
			print("Rotate final 1")
			$AnimationPlayer2.play("Rotate final 1", 0.2)
			$MeshPivot1/MeshPivot2/Mesh2.visible = false
		else:
			print("Rotate final 2")
			$AnimationPlayer2.play("Rotate final 2", 0.2)
			$MeshPivot1/MeshPivot2/CirclePivot/Circle.rotation.z = PI
			$MeshPivot1/MeshPivot2/Mesh1.visible = false
			offset = PI
			factor = -1.0
		circle.material_override.set_shader_parameter("shader_time", -10.0)
		var tween : Tween = get_tree().create_tween()
		tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		tween.tween_property(circle.material_override, "shader_parameter/shader_time", 50.0, 5.0)
		set_physics_process(true)
	else:
		meshes[1-(current_material & 1)].material_override = materials[material_names[current_material]]
		next_material = material_names[current_material]
	current_material += 1

func _physics_process(delta):
	$MeshPivot1/MeshPivot2/CirclePivot.rotation.x = offset+factor*$MeshPivot1.rotation.x

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
