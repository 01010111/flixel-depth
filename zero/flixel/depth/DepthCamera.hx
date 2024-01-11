package zero.flixel.depth;

import openfl.display.Sprite;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.FlxG;

using Math;
using zero.extensions.FloatExt;

/**
	DepthCamera is an object that manipulates your FlxCamera and FlxGame to make it appear 3D.
	Use set() or set_delta() to change the current orbit and zoom of the camera, move this object to move the camera.
	Don't forget to add this object to your FlxState!
**/
class DepthCamera extends FlxObject {

	@:noCompletion
	public static var container:Sprite;
	static var initialized:Bool = false;

	// creates an openfl Sprite container for scaling the game
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

	var limits = {
		orbit_y_min: 0.5,
		zoom_min: 1.0,
		zoom_max: 10.0
	};

	function set_orbit_x(v) return orbit_x = v.translate_to_nearest_angle(camera.angle);
	function set_orbit_y(v) return orbit_y = v.clamp(0, 1);
	function set_zoom(v) return zoom = v.clamp(limits.zoom_min, limits.zoom_max);
	public function set_snappiness(v) return snappiness = v.clamp(0, 1).map(0, 1, 1, 60);

	// creates and initializes a new DepthCamera instance
	public function new(orbit_x:Float = 0, orbit_y:Float = 1, zoom:Float = 1, ?camera:FlxCamera) {
		super();
		this.camera = camera ?? FlxG.camera;
		init();
		init_cam();
		screenCenter();
		set(orbit_x, orbit_y, zoom);
	}

	// we need to change the camera size so it can rotate without clipping!
	function init_cam() {
		var size = (FlxG.width.pow(2) + FlxG.height.pow(2)).sqrt().ceil() + Math.max(FlxG.width, FlxG.height).floor();
		camera.setSize(size, size);
		camera.setPosition(-(size - FlxG.width)/2, -(size - FlxG.height)/2);
		camera.follow(this);
	}

	override function update(dt) {
		apply(dt);
		super.update(dt);
	}

	// interpolates values for a more cinematic camera
	function apply(dt:Float) {
		camera.angle += (orbit_x - camera.angle) * dt * snappiness;
		camera.zoom += (zoom - camera.zoom) * dt * snappiness;

		container.scaleY += (orbit_y.map(0, 1, limits.orbit_y_min, 1) - container.scaleY) * dt * snappiness;
		container.y += (orbit_y.map(0, 1, FlxG.height * 0.75, FlxG.height) - container.y) * dt * snappiness;
	}

	// Set camera state
	public function set(orbit_x, orbit_y, zoom) {
		this.orbit_x = orbit_x;
		this.orbit_y = orbit_y;
		this.zoom = zoom;

		camera.angle = orbit_x;
		camera.zoom = zoom;
		container.scaleY = orbit_y.map(0, 1, 0.5, 1);
		container.y = orbit_y.map(0, 1, FlxG.height * 0.75, FlxG.height);
	}

	// Useful for translating user input to change in camera state
	public function set_delta(orbit_x_delta:Float = 0, orbit_y_delta:Float = 0, zoom_delta:Float = 0) {
		orbit_x += orbit_x_delta.map(0, 1, 0, 6);
		orbit_y += orbit_y_delta.map(0, 1, 0, 0.1);
		zoom_delta > 0 ? zoom *= zoom_delta.map(0, 1, 1, 1.1) : zoom /= zoom_delta.map(-1, 0, 1.1, 1);
	}

	public function set_limits(orbit_y_min:Float = 0.5, zoom_min:Float = 1, zoom_max:Float = 10) {
		limits.orbit_y_min = orbit_y_min;
		limits.zoom_min = zoom_min;
		limits.zoom_max = zoom_max;
	}

	// Move relative to screen
	public function screen_move(dx:Float, dy:Float) {
		var delta = FlxPoint.get(dx, dy);
		delta.degrees -= camera.angle;
		x += delta.x;
		y += delta.y;
		delta.put();
	}

}