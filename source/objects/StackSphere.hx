package objects;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxTileFrames;
import flixel.util.FlxSpriteUtil;
import flixel.math.FlxPoint;
import openfl.display.BitmapData;
import zero.flixel.depth.StackSprite;

class StackSphere extends StackSprite {

	public function new(x:Float = 0, y:Float = 0) {
		super(x, y);
		make_graphic();
		auto_stack();
		offset.set(8, 8);
	}

	function make_graphic() {
		var as = new FlxSprite();
		as.makeGraphic(64, 64, 0x00FFFFFF);
		var shades = [0xFF606060, 0xFF707070, 0xFF808080, 0xFF909090, 0xFFA0A0A0, 0xFFB0B0B0, 0xFFC0C0C0, 0xFFD0D0D0, 0xFFE0E0E0, 0xFFF0F0F0, 0xFFFFFFFF];
		for (s in 0...16) {
			var r = Math.sin(s/16 * Math.PI) * 8;
			var x = s % 4 * 16;
			var y = Math.floor(s / 4) * 16;
			trace(r);
			FlxSpriteUtil.drawCircle(as, x + 8, y + 8, Math.max(r, 1), shades[Math.floor(Math.min(s, shades.length - 1))]);
		}
		loadGraphic(as.graphic, true, 16, 16);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
	}

}