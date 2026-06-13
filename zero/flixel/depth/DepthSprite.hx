package zero.flixel.depth;

import flixel.FlxG;
import flixel.FlxSprite;

using zero.extensions.FloatExt;
using Math;

/**
	A Depth Sprite, gives a typical FlxSprite the ability to appear to travel along the Z axis
**/
class DepthSprite extends FlxSprite {

	// Give a depth sprite a positive z value to raise it off of the ground plane
	public var z:Float = 0;

	// depth-y - y value relative to camera rotation, used for depth group sorting
	public var dy(get, never):Float;
	function get_dy() {
		var radians = camera.angle * Math.PI / 180;
		return x * radians.cos() + y * radians.cos() + z * cam_orbit_y * Math.PI;
	}

	var cam_orbit_y(get, never):Float;
	function get_cam_orbit_y() {
		if (DepthCamera._container == null) {
			FlxG.log.warn('No Depth Camera in use!');
			return 1;
		}
		return DepthCamera._container.scaleY;
	}

	override function draw() {
		if (z == 0) return super.draw();

		var baseX = x;
		var baseY = y;
		var offset_length = z * cam_orbit_y.map(0, 1, Math.PI, 0);
		var offset_angle = (z >= 0 ? -camera.angle - 90 : -camera.angle + 90) * Math.PI / 180;
		var offset_x = offset_angle.cos() * offset_length;
		var offset_y = offset_angle.sin() * offset_length;

		setPosition(baseX + offset_x, baseY + offset_y);
		super.draw();
		setPosition(baseX, baseY);
	}
}