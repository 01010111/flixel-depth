package objects;

import openfl.display.Sprite;
import flixel.FlxObject;
import flixel.FlxCamera;

class DepthCamera extends FlxObject {

	public static var instance:DepthCamera;
	public static var container:Sprite;
	static var initialized:Bool = false;
	static function init() {
		if (initialized) return;

		var game = FlxG.game;
		var root = game.parent;

		root.removeChild(game);
		root.addChild(container = new Sprite());
		var subcontainer = new Sprite();
		container.addChild(subcontainer);
		container.x = FlxG.width;
		container.y = FlxG.height;
		subcontainer.x = -FlxG.width;
		subcontainer.y = -FlxG.height;
		subcontainer.addChild(game);

		initialized = true;
	}

	var orbit_x(default, set):Float = 45;
	var orbit_y(default, set):Float = 0.25;
	var zoom(default, set):Float = 1;
	var snappiness(default, set):Float = 5;

	function set_orbit_x(v) return orbit_x = v.translate_to_nearest_angle(camera.angle);
	function set_orbit_y(v) return orbit_y = v.clamp(0, 1);
	function set_zoom(v) return zoom = v.clamp(0.1, 10);
	public function set_snappiness(v) return snappiness = v.clamp(0, 1).map(0, 1, 1, 60);

	public function new(orbit_x:Float = 0, orbit_y:Float = 1, zoom:Float = 1) {
		super();
		init();
		init_cam();
		screenCenter();
		set(orbit_x, orbit_y, zoom);
	}

	function init_cam() {
		instance = this;
		var size = (FlxG.width.pow(2) + FlxG.height.pow(2)).sqrt().ceil() + 256;
		camera.setSize(size, size);
		camera.setPosition(-(size - FlxG.width)/2, -(size - FlxG.height)/2);
		camera.follow(this);
	}

	override function update(dt) {
		apply(dt);
		super.update(dt);
	}

	function apply(dt:Float) {
		camera.angle += (orbit_x - camera.angle) * dt * snappiness;
		camera.zoom += (zoom - camera.zoom) * dt * snappiness;

		container.scaleY += (orbit_y.map(0, 1, 0.5, 1) - container.scaleY) * dt * snappiness;
		container.y += (orbit_y.map(0, 1, FlxG.height * 0.75, FlxG.height) - container.y) * dt * snappiness;
	}

	public function set(orbit_x, orbit_y, zoom) {
		this.orbit_x = orbit_x;
		this.orbit_y = orbit_y;
		this.zoom = zoom;

		camera.angle = orbit_x;
		camera.zoom = zoom;
		container.scaleY = orbit_y.map(0, 1, 0.5, 1);
		container.y = orbit_y.map(0, 1, FlxG.height * 0.75, FlxG.height);
	}

	public function set_delta(orbit_x_delta:Float = 0, orbit_y_delta:Float = 0, zoom_delta:Float = 0) {
		orbit_x += orbit_x_delta.map(0, 1, 0, 6);
		orbit_y += orbit_y_delta.map(0, 1, 0, 0.1);
		zoom_delta > 0 ? zoom *= zoom_delta.map(0, 1, 1, 1.1) : zoom /= zoom_delta.map(-1, 0, 1.1, 1);
	}

}