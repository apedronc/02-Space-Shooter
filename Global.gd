extends Node

var VP = Vector2.ZERO
var score = 0
var lives = 5
var level = -1

var levels = [
	{
		"title":"Level 1",
		"subtitle":"Destroy The Asteroids!",
		"asteroids":[Vector2(100,100),Vector2(900,500)],
		"enemies":[],
		"asteroids_spawned":false,
		"enemies_spawned":false
	},
	{
		"title":"Level 2",
		"subtitle":"The Enemy Arrives!",
		"asteroids":[Vector2(100,100),Vector2(900,500),Vector2(800,300)],
		"enemies":[Vector2(150,500)],
		"asteroids_spawned":false,
		"enemies_spawned":false
	},
	{
		"title":"Level 3",
		"subtitle":"Reinforcements!",
		"asteroids":[Vector2(100,100),Vector2(900,500),Vector2(200,200)],
		"enemies":[Vector2(150,500),Vector2(500,300)],
		"asteroids_spawned":false,
		"enemies_spawned":false
	},
	{
		"title":"Level 4",
		"subtitle":"Just A Few More!",
		"asteroids":[Vector2(100,100),Vector2(900,500)],
		"enemies":[Vector2(150,500),Vector2(500,350),Vector2(800,300),Vector2(300,100)],
		"asteroids_spawned":false,
		"enemies_spawned":false
	},	
	{
		"title":"Level 5",
		"subtitle":"Destroy The Remaining Enemies!",
		"asteroids":[Vector2(100,100),Vector2(900,500),Vector2(200,200)],
		"enemies":[Vector2(150,500),Vector2(500,400),Vector2(500,350),Vector2(260,290)],
		"asteroids_spawned":false,
		"enemies_spawned":false
	},	
]

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	randomize()
	VP = get_viewport().size
	var _signal = get_tree().get_root().connect("size_changed", self, "_resize")
	reset()

func _physics_process(_delta):
	var A = get_node_or_null("/root/Game/Asteroid_Container")
	var E = get_node_or_null("/root/Game/Enemy_Container")
	if A != null and E != null:
		var L = levels[level]
		if L["asteroids_spawned"] and A.get_child_count() == 0 and L["enemies_spawned"] and E.get_child_count() == 0:
			next_level()

func reset():
	score = 0
	lives = 3
	level = -1
	for l in levels:
		l["asteroids_spawned"] = false
		l["enemies_spawned"] = false


func _unhandled_input(_event):
	if Input.is_action_pressed("quit"):
		get_tree().quit()


func _resize():
	VP = get_viewport().size

func update_score(s):
	score = score + s
	var Score = get_node_or_null("/root/Game/UI/HUD/Score")
	if Score != null:
		Score.text = "Score: " + str(score)

func update_lives(l):
	lives = lives + l
	if lives <= 0:
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	var Lives = get_node_or_null("/root/Game/UI/HUD/Lives")
	if Lives != null:
		Lives.text = "Lives: " + str(lives)

func next_level():
	level += 1
	if level > levels.size():
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	var Level_Label = get_node_or_null("/root/Game/UI/Level")
	if Level_Label != null:
		Level_Label.show_labels()
