extends 'res://addons/gut/test.gd'

const Helpers = preload("res://scripts/helpers.gd")
const window_height = 750
const hud_height = 50


func to_px_coord(coord: Vector2) -> Vector2:
		return Helpers.canon_to_px_coord(coord, window_height, hud_height)


func to_canon_coord(coord: Vector2) -> Vector2:
		return Helpers.px_to_canon_coord(coord, window_height, hud_height)


func test_assert_coord_1():
		assert_eq(to_px_coord(Vector2(0, 0)),
							Vector2(0, window_height))


func test_assert_coord_2():
		assert_eq(to_px_coord(Vector2(100, 100)),
							Vector2(window_height - hud_height, hud_height))


func assert_offsets(actual: Array, expected: Array) -> void:
		assert_almost_eq(actual[0], expected[0], 0.001)
		assert_almost_eq(actual[1], expected[1], 0.001)


func test_calculate_rotational_offset_1() -> void:
		assert_offsets(Helpers.calculate_rotational_offset(
				Vector2(18.182, 72.727),
				Vector2(125.307, 61.005),
				36.364,
				1.123,
				36.364
		), [-4.0431, 0.5665])
