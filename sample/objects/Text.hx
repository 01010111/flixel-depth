package objects;

import zero.flixel.depth.BillboardText;

class Text extends BillboardText {

	public function new(x:Float, y:Float, text:String) {
		super(x, y, 320, text);
		setFormat(null, 32, 0xFFFFFFFF, CENTER);
		origin.set(width/2, height);
		offset.set(width/2, height);
		scale.set(0.1, 0.1);
		z = -16;
		alpha = 0.5;
		visible = false;
	}

}