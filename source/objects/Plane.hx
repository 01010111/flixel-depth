package objects;

import flixel.tweens.FlxTween;
import openfl.geom.Rectangle;
import openfl.display.BitmapData;
import zero.flixel.depth.PlaneSprite;

class Plane extends PlaneSprite {

	public function new(x:Float = 0, y:Float = 0) {
		super(x, y, make_graphic());
		offset.set(8, 8);
		FlxTween.tween(this, { angle: 360 }, 10, { type: LOOPING });
	}

	function make_graphic() {
		var graphic = new BitmapData(16, 16);
		graphic.fillRect(new Rectangle(0, 0, 8, 8), 0xFF6F7585);
		graphic.fillRect(new Rectangle(8, 8, 8, 8), 0xFF6F7585);
		return graphic;
	}

	override function update(elapsed:Float) {
		color = facing_camera ? 0xFFFFFFFF : 0xFF6F7585;
		super.update(elapsed);
	}

}