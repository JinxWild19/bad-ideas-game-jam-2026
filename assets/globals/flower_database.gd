extends Node

enum Flower {Frostine, Red_Dragon, Birds, Cyrus, Tapestries, Warning}

var FlowerArray: Array[String] = [
	"Frostine",
	"Red Dragon",
	"Birds",
	"Cyrus",
	"Tapestries",
	"Warning"
	
]

const FLOWER_ENUM_TO_STRING: Dictionary = {
	Flower.Frostine: "Frostine",
	Flower.Red_Dragon: "Red Dragon",
	Flower.Birds: "Birds",
	Flower.Cyrus: "Cyrus",
	Flower.Tapestries: "Tapestries",
	Flower.Warning: "Warning"
}

const FLOWER_SCENE_PATHS: Dictionary = {
	Flower.Frostine: "uid://bdx5p2lrpaeej",
	Flower.Red_Dragon: "uid://dddxgwrvg7r1r",
	Flower.Birds: "uid://dxhv7x78tiubx",
	Flower.Cyrus: "uid://b7ka364r0r24h",
	Flower.Tapestries: "uid://cjvuissietel6",
	Flower.Warning: "uid://c1o0s7o04ligi"
}

const FLOWER_NAMES: Dictionary = {
	Flower.Frostine: "Frost Flower",
	Flower.Red_Dragon: "Holly Red Flower",
	Flower.Birds: "Jet Flower",
	Flower.Cyrus: "Yellow Bird Flower",
	Flower.Tapestries: "Burgundy Flower",
	Flower.Warning: "Golden Flower"
}

func flower_excluding(source_array: Array[int], exluded_flower: int) -> Array[String]:
	var results: Array[String] = []
	
	for flower_id in source_array:
		if flower_id != exluded_flower:
			results.append(FlowerArray[flower_id])
	return results
