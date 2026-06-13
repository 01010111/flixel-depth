package zero.flixel.depth;

import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.text.FlxText;
import zero.flixel.depth.DepthCamera;

using zero.extensions.FloatExt;

class BillboardText extends FlxText {

	public var z:Float = 0;

	var cam_orbit_y(get, never):Float;
	function get_cam_orbit_y() {
		if (DepthCamera._container == null) {
			FlxG.log.warn('No Depth Camera in use!');
			return 1;
		}
		return DepthCamera._container.scaleY;
	}

	override function draw() {
		var _angle = angle;
		var _scaleY = scale.y;
		var _x = x;
		var _y = y;

		angle = _angle - camera.angle;
		scale.y = _scaleY * 1/cam_orbit_y;

		var offset_length = z * cam_orbit_y.map(0, 1, Math.PI, 0);
		var offset_angle = (z >= 0 ? -camera.angle - 90 : -camera.angle + 90) * Math.PI / 180;
		var offset_x = Math.cos(offset_angle) * offset_length;
		var offset_y = Math.sin(offset_angle) * offset_length;

		setPosition(x + offset_x, y + offset_y);
		angle = _angle;
		scale.y = _scaleY;
		x = _x;
		y = _y;
	}

}