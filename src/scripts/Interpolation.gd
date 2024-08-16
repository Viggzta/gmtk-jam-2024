extends Node
## Fast and funky 1 demensional nonlinear transformations based on https://www.youtube.com/watch?v=mr5xkf6zSzk
##
## Contains convenience functions for interpolating values that ranges from 0.0 to 1.0

static func smooth_start(t: float) -> float:
	return t * t

static func smooth_start2(t: float) -> float:
	return t * t * t

static func smooth_start3(t: float) -> float:
	return t * t * t * t

static func smooth_start4(t: float) -> float:
	return t * t * t * t * t

static func smooth_stop(t: float) -> float:
	return flip(smooth_start(flip(t)))

static func smooth_stop2(t: float) -> float:
	return flip(smooth_start2(flip(t)))
	
static func smooth_stop3(t: float) -> float:
	return flip(smooth_start3(flip(t)))
	
static func smooth_stop4(t: float) -> float:
	return flip(smooth_start4(flip(t)))
	
static func smooth_step(t: float) -> float:
	return mix(smooth_start(t), smooth_stop(t), t)

static func smooth_step2(t: float) -> float:
	return mix(smooth_start2(t), smooth_stop2(t), t)

static func smooth_step3(t: float) -> float:
	return mix(smooth_start3(t), smooth_stop3(t), t)

static func smooth_step4(t: float) -> float:
	return mix(smooth_start4(t), smooth_stop4(t), t)

static func bell_curve(t: float) -> float:
	return smooth_start(t) * smooth_stop(t)

static func normalized_bezier3(b: float, c: float, t: float) -> float:
	var s: float = flip(t)
	var t2: float = scale(t, t)
	var s2: float = scale(s, s)
	var t3: float = scale(t2, t)
	return (3.0 * b * s2 * t) + (3.0 * c * s * t2) + t3

static func flip(t: float) -> float:
	return 1.0 - t
	
static func mix(a: float, b: float, blend: float) -> float:
	return flip(blend) * a + blend * b

static func scale(t: float, s: float) -> float:
	return t * s

static func reverse_scale(t: float, s: float) -> float:
	return flip(t) * s

static func bounce_clamp_bottom(t: float) -> float:
	return absf(t)

static func bounce_clamp_top(t: float) -> float:
	return flip(bounce_clamp_bottom(flip(t)))
