extends 'res://addons/gut/test.gd'


func test_assert_coord_1():
		assert_eq(CoordUtil.canon_to_px_coord(Vector2(0, 0)),
				  Vector2(0, CoordUtil.window_h))


func test_assert_coord_2():
		assert_eq(CoordUtil.canon_to_px_coord(Vector2(100, 100)),
				  Vector2(CoordUtil.window_h - CoordUtil.hud_h,
									CoordUtil.hud_h))
