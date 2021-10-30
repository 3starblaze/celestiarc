extends Control

onready var m_forecast = $HBoxContainer/MForecast
onready var p_forecast = $HBoxContainer/PForecast

func forecast_mformater(data: Array):
	var m_table = []
	for meteor in data:
		var v = Helpers.f_round_fmt(meteor.velocity)
		var pos = Helpers.v2_round_fmt(
			CoordUtil.px_to_canon_coord(meteor.global_position)
		)
		m_table.append("Position: %s; Velocity: %s" % [pos, v])
	return m_table


func forecast_pformater(data: Array):
	var p_table = []
	for platform in data:
		var pos = Helpers.v2_round_fmt(
			CoordUtil.px_to_canon_coord(platform.global_position)
		)
		p_table.append(
			"Original Position: %s; Radius: %s" % [pos, platform.radius]
		)
	return p_table


func refresh_data(m_data: Array, p_data: Array) -> void:
	var m = forecast_mformater(m_data)
	var p = forecast_pformater(p_data)
	
	"""data: N sized array with arrays of 3 strings as children."""
	Helpers.kill_children(m_forecast)
	Helpers.kill_children(p_forecast)
	
	Helpers.create_row(m_forecast, ["Meteors: "])
	Helpers.create_row(p_forecast, ["Platforms: "])
	
	for obj in m:
		Helpers.create_row(m_forecast, [obj])
	for obj in p:
		Helpers.create_row(p_forecast, [obj])
	
