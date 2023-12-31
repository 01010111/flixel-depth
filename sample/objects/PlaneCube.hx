package objects;

import openfl.geom.Rectangle;
import zero.flixel.depth.PlaneSprite;
import zero.flixel.depth.DepthSprite;
import openfl.display.BitmapData;
import zero.flixel.depth.DepthGroup;

class PlaneCube {
	public function new(x:Float = 0, y:Float= 0, group:DepthGroup) {
		var graphic = new BitmapData(16, 16, true, 0x00FFFFFF);
		for (i in 0...16) {
			graphic.setPixel32(i, 0, 0xFFFFFFFF);
			graphic.setPixel32(0, i, 0xFFFFFFFF);
			graphic.setPixel32(i, 15, 0xFFFFFFFF);
			graphic.setPixel32(15, i, 0xFFFFFFFF);
		}

		var graphic = make_graphic();

		var top = new DepthSprite(x - 8, y - 8, graphic);

		top.z = 16;

		var side_n = new PlaneSprite(x, y - 8, graphic);
		var side_s = new PlaneSprite(x, y + 8, graphic);
		var side_e = new PlaneSprite(x - 8, y, graphic);
		var side_w = new PlaneSprite(x + 8, y, graphic);

		side_n.offset.set(8, 8);
		side_s.offset.set(8, 8);
		side_e.offset.set(8, 8);
		side_w.offset.set(8, 8);

		side_n.angle = 180;
		side_s.angle = 0;
		side_e.angle = 270;
		side_w.angle = 90;

		group.add(top);
		group.add(side_n);
		group.add(side_s);
		group.add(side_e);
		group.add(side_w);
	}

	function make_graphic() {
		var graphic = new BitmapData(16, 16);
		graphic.fillRect(new Rectangle(0, 0, 8, 8), 0xFF6F7585);
		graphic.fillRect(new Rectangle(8, 8, 8, 8), 0xFF6F7585);
		return graphic;
	}
}