package objects;

import objects.DepthCamera;
import flixel.FlxSprite;

/**
	A Depth Sprite, gives a typical FlxSprite the ability to appear to travel along the Z axis
**/
class DepthSprite extends FlxSprite {

	// Give a depth sprite a positive z value to raise it off of the ground plane
	public var z:Float = 0;

	// depth-y - y value relative to camera rotation, used for depth group sorting
	public var dy(get, never):Float;
	function get_dy() {
		var p = FlxPoint.get(x, y);
		var d = FlxPoint.get(p.length);
		d.degrees = p.degrees + camera.angle;
		var out = d.y;
		p.put();
		d.put();
		return out + z * DepthCamera.container.scaleY * Math.PI;
	}

	override function draw() {
		if (z == 0) return super.draw();

		var _position = FlxPoint.get(x, y);
		var offset = FlxPoint.get(z * DepthCamera.container.scaleY.map(0, 1, Math.PI, 0));
		offset.degrees = -camera.angle - 90;

		setPosition(_position.x + offset.x, _position.y + offset.y);
		super.draw();
		setPosition(_position.x, _position.y);

		_position.put();
		offset.put();
	}
}