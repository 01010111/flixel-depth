package objects;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import openfl.display.BitmapData;
import zero.flixel.depth.StackSprite;

class StackCube extends StackSprite {
	public function new(x:Float = 0, y:Float = 0) {
		super(x, y);
		loadGraphic(make_graphic(), true, 16, 16);
		auto_stack();
		offset.set(8, 8);
		lod = 16;
		FlxTween.tween(this, { gap: Math.PI * 2 }, 1, { type: PINGPONG, ease: FlxEase.sineInOut });
	}

	function make_graphic() {
		var graphic = new BitmapData(64, 64, true, 0x00FFFFFF);

		for (i in 0...16) {
			graphic.setPixel32(i, 0, 0xFFFFFFFF);
			graphic.setPixel32(i, 15, 0xFFFFFFFF);
			graphic.setPixel32(0, i, 0xFFFFFFFF);
			graphic.setPixel32(15, i, 0xFFFFFFFF);

			graphic.setPixel32(i + 48, 48, 0xFFFFFFFF);
			graphic.setPixel32(i + 48, 15 + 48, 0xFFFFFFFF);
			graphic.setPixel32(48, i + 48, 0xFFFFFFFF);
			graphic.setPixel32(15 + 48, i + 48, 0xFFFFFFFF);

			var ox = i % 4 * 16;
			var oy = Math.floor(i / 4) * 16;
			graphic.setPixel32(ox, oy, 0xFFFFFFFF);
			graphic.setPixel32(ox + 15, oy, 0xFFFFFFFF);
			graphic.setPixel32(ox, oy + 15, 0xFFFFFFFF);
			graphic.setPixel32(ox + 15, oy + 15, 0xFFFFFFFF);
		}

		return graphic;
	}

	var time = 0.0;
	override function update(elapsed:Float) {
		time += elapsed;
		super.update(elapsed);
		for (i in 0...16) angle_offsets[i] = Math.sin(time) * 4;
	}
}