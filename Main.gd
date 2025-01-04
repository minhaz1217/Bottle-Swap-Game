extends Node


var bottleImages = [
	preload("res://assets/potions/bottle2_01.png"),
	preload("res://assets/potions/bottle2_02.png"),
	preload("res://assets/potions/bottle2_03.png"),
	preload("res://assets/potions/bottle2_04.png"),
	preload("res://assets/potions/bottle2_05.png"),
	preload("res://assets/potions/bottle2_06.png"),
	preload("res://assets/potions/bottle2_07.png"),
];

var correctOrder = [];
var currentOrder = [];
var firstPressNumber:int = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#placeImages()
	#checkMatches()
	pass # Replace with function body.

func placeImages():	
	generateCurrentAndCorrectOrder(4)
	placeCurrentOrderImages()
	
	print(correctOrder)

func generateCurrentAndCorrectOrder(totalSize: int):
	if(totalSize < 0 || totalSize >= 7):
		print("Enter valid value")
		return
	correctOrder.clear()
	currentOrder.clear()
	while(correctOrder.size() != totalSize):
		var number:int = randi() % 7
		if(!correctOrder.has(number)):
			correctOrder.append(number)
			currentOrder.append(number)
	currentOrder.shuffle()
	
func placeCurrentOrderImages():
	print(currentOrder)
	get_node("bottle1").texture = bottleImages[ currentOrder[0] ]
	get_node("bottle2").texture = bottleImages[ currentOrder[1] ]
	get_node("bottle3").texture = bottleImages[ currentOrder[2] ]
	get_node("bottle4").texture = bottleImages[ currentOrder[3] ]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func pressed(number):
	if(firstPressNumber == -1):
		firstPressNumber = number
	else:
		if(firstPressNumber != number):
			swapImages(firstPressNumber, number)
			firstPressNumber = -1

func swapImages(pos1:int, pos2:int):
	var temp = currentOrder[pos1-1]
	currentOrder[pos1-1] = currentOrder[pos2-1]
	currentOrder[pos2-1] = temp
	placeCurrentOrderImages()
	checkMatches()
	
func checkMatches():
	var matces : int = 0
	for i in range(4):
		if(correctOrder[i] == currentOrder[i]):
			matces = matces + 1
	
	var messageLabel : Label = get_node("Label")
	messageLabel.text = String.num_int64(matces) + " bottles are in place"
