extends 'res://addons/gut/test.gd'

const window_height = 750
const hud_height = 50
var coord_util = load("res://scripts/coord_util.gd").new(
	window_height, hud_height
)


func test_assert_coord_1():
		assert_eq(coord_util.canon_to_px_coord(Vector2(0, 0)),
				  Vector2(0, window_height))


func test_assert_coord_2():
		assert_eq(coord_util.canon_to_px_coord(Vector2(100, 100)),
				  Vector2(window_height - hud_height, hud_height))
