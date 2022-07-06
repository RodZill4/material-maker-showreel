extends Node

onready var meshes = [ $MeshPivot1/MeshPivot2/Mesh1, $MeshPivot1/MeshPivot2/Mesh2 ]
var materials : Array
var current_material = 0

func _ready():
	materials = []
	var dir : Directory = Directory.new()
	if dir.open("res://materials") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if ! dir.current_is_dir() and file_name.get_extension() == "tres":
				materials.push_back(load("res://materials/"+file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	change_material(1)
	change_material(0)
	print(str(materials.size())+" materials")

func change_material(m : int):
	if current_material >= materials.size() or current_material < 0:
		current_material = 0
	meshes[m].set_surface_material(0, materials[current_material])
	current_material += 1
