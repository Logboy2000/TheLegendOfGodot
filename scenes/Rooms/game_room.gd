extends Node
@onready var entities: Node2D = %Entities
@onready var triggers: Node = %Triggers

func add_node(node: Node):
	entities.add_child(node)
