@tool
extends "res://scene.gd"

@export var month : String:
	set(v):
		if v == month:
			return
		month = v
		material_list = []
		for m : String in material_descriptions.keys():
			if m.begins_with(month+"/"):
				material_list.append(m)


func _ready():
	super()
