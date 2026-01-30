@abstract
class_name BehaviourTreeNode
extends Object

var inimigo
var children = []

@abstract
func process() -> bool

func _init(inimigo_pai: CharacterBody3D) -> void:
	inimigo = inimigo_pai

func add_child(node: BehaviourTreeNode) -> void:
	children.append(node)
