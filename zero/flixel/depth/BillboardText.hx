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
		if (DepthCamera.container == null) {
			FlxG.log.warn('No Depth Camera in use!');
			return 1;
		}
		return DepthCamera.container.scaleY;
	}

	override function draw() {
		var _angle = angle;
		var _scaleY = scale.y;
		var _x = x;
		var _y = y;

		angle = _angle - camera.angle;
		scale.y = _scaleY * 1/cam_orbit_y;

		var offset = FlxPoint.get(z * cam_orbit_y.map(0, 1, Math.PI, 0));
		offset.degrees = z >= 0 ? -camera.angle - 90 : -camera.angle + 90;

		setPosition(x + offset.x, y + offset.y);
		super.draw();

		offset.put();
		angle = _angle;
		scale.y = _scaleY;
		x = _x;
		y = _y;
	}

}