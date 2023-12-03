package;

import openfl.display.Sprite;
import flixel.FlxGame;

class Main extends Sprite {
	static var WIDTH:Int = 800;
	static var HEIGHT:Int = 800;

	public static var container:Sprite;

	public function new() {
		super();
		addChild(new FlxGame(WIDTH, HEIGHT, states.PlayState, 60, 60, true));
	}
}