package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;

class DotGrid extends FlxGroup {

	public function new() {
		super();
		for (j in 0...Math.floor(FlxG.height/32) * 2) for (i in 0...Math.floor(FlxG.width/32) * 2) {
			var s = new FlxSprite(i * 32 - FlxG.width/2, j * 32 - FlxG.height/2);
			s.makeGraphic(1,1);
			add(s);
		}
	}

}