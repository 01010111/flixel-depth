package objects;

import openfl.geom.Matrix;
import states.PlayState;
import zero.flixel.depth.DepthCamera;
import flixel.math.FlxPoint;
import flixel.FlxG;
import openfl.display.BitmapData;
import flixel.FlxSprite;

using zero.extensions.FloatExt;
using flixel.util.FlxSpriteUtil;

class MouseFollower extends FlxSprite {

	var cam:DepthCamera;
	var size:Int = 32;

	public function new(depth_camera:DepthCamera) {
		var graphic = new BitmapData(size, size, true, 0x00FFFFFF);
		for (i in 0...size) {
			graphic.setPixel32(i		, 0			, 0xFFFFFFFF);
			graphic.setPixel32(0		, i			, 0xFFFFFFFF);
			graphic.setPixel32(i		, size - 1	, 0xFFFFFFFF);
			graphic.setPixel32(size - 1	, i			, 0xFFFFFFFF);
		}
		super(0, 0, graphic);
		offset.set(size/2, size/2);
		cam = depth_camera;
		visible = false;
	}

	override function update(elapsed:Float) {
		move();
		click();
		super.update(elapsed);
	}

	function move() {
		var p = cam.screen_to_world(FlxPoint.get(FlxG.mouse.x, FlxG.mouse.y));
		setPosition(p.x.snap_to_grid(32), p.y.snap_to_grid(32));
		p.put();
	}

	function click() {
		if (!FlxG.mouse.justPressed) return;
		this.flicker(0.16, 0.04, false);
	}

}