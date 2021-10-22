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
	"""Check scenario when meteor is above origin and can collide."""
	assert_offsets(Helpers.calculate_rotational_offset(
				Vector2(18.182, 72.727),
				Vector2(125.307, 61.005),
				36.364,
				1.123,
				36.364
		), [-4.0431, 0.5665])


func test_calculate_rotational_offset_2() -> void:
	"""Check scenario when meteor is above origin and cannot collide."""
	assert_eq(Helpers.calculate_rotational_offset(
		Vector2(0.123, 61.389),
		Vector2(82.391, 2.320),
		10.0,
		4.321,
		34.921
	), [])


func test_calculate_rotational_offset_3() -> void:
	"""Check scenario when meteor is below origin and cannot collide."""
	assert_eq(Helpers.calculate_rotational_offset(
		Vector2(2.020, 5.102),
		Vector2(123.200, 83.001),
		20.0,
		4.321,
		34.921
	), [])


func test_calculate_rotational_offset_4() -> void:
	"""Check scenario when meteor is below origin and can collide."""
	assert_eq(
	    len(Helpers.calculate_rotational_offset(
		Vector2(2.020, 68.102),
		Vector2(123.200, 83.001),
		20.0,
		4.321,
		34.921
		)),
	    2)
