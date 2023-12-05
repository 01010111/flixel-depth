package objects;

import openfl.geom.Rectangle;
import openfl.display.BitmapData;
import zero.flixel.depth.BillboardSprite;

class Billboard extends BillboardSprite {

	public function new(x:Float = 0, y:Float = 0) {
		super(x, y, make_graphic());
		trace(this);
		offset.set(8, 16);
		origin.set(8, 16);
	}

	function make_graphic() {
		var graphic = new BitmapData(16, 16);
		graphic.fillRect(new Rectangle(0, 0, 8, 8), 0xFF6F7585);
		graphic.fillRect(new Rectangle(8, 8, 8, 8), 0xFF6F7585);
		return graphic;
	}

}