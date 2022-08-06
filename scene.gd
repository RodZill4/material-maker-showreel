extends Node

@onready var meshes = [ $MeshPivot1/MeshPivot2/Mesh1, $MeshPivot1/MeshPivot2/Mesh2 ]
var material_names : Array
var materials : Dictionary
var current_material = 0

func _ready():
	material_names = []
	materials = {}
	var dir : Directory = Directory.new()
	var tinymesh : BoxMesh = BoxMesh.new()
	tinymesh.size = Vector3(0.01, 0.01, 0.01)
	if dir.open("res://materials") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if ! dir.current_is_dir() and file_name.get_extension() == "tres":
				var material = load("res://materials/"+file_name)
				if material != null:
					material_names.push_back(file_name)
					materials[file_name] = material
					var mesh_instance : MeshInstance3D = MeshInstance3D.new()
					mesh_instance.mesh = tinymesh
					mesh_instance.set_surface_override_material(0, material)
					add_child(mesh_instance)
					if materials.keys().size() > 4:
						break
				else:
					print("Failed to load "+file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

var next_material : String = ""
func change_material():
	if current_material >= material_names.size() or current_material < 0:
		current_material = 0
	meshes[0].set_surface_override_material(0, meshes[1].get_surface_override_material(0))
	meshes[1].set_surface_override_material(0, materials[material_names[current_material]])
	next_material = material_names[current_material]
	current_material += 1

func update_label():
	$Label.text = next_material
