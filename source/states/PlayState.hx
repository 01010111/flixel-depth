package states;

import objects.*;
import flixel.FlxState;
import flixel.FlxG;
import zero.flixel.depth.DepthGroup;
import zero.flixel.depth.DepthCamera;

class PlayState extends FlxState {

	var depth_camera:DepthCamera;
	var depth_group:DepthGroup;
	var last_mouse_x:Float;
	var last_mouse_y:Float;

	override function create() {
		bgColor = 0xff32343C;

		add(new DotGrid());

		add(depth_camera = new DepthCamera(0, 0, 3));

		depth_group = new DepthGroup();
		add(depth_group);

		var billboard = new Billboard(FlxG.width/2 - 32, FlxG.height/2 - 32);
		depth_group.add(billboard);

		var plane = new Plane(FlxG.width/2 + 32, FlxG.height/2 + 32);
		depth_group.add(plane);

		var stack_sphere = new StackSphere(FlxG.width/2 + 32, FlxG.height/2 - 32);
		depth_group.add(stack_sphere);

		var stack_cube = new StackCube(FlxG.width/2, FlxG.height/2);
		depth_group.add(stack_cube);

		var plane_cube = new PlaneCube(FlxG.width/2 - 32, FlxG.height/2 + 32, depth_group);
	}

	override function update(dt:Float) {
		super.update(dt);
		depth_group.depth_sort();

		depth_camera.set_delta(0.025);
		depth_camera.set_delta(FlxG.mouse.pressed ? (last_mouse_x - FlxG.mouse.screenX) / 8 : 0, FlxG.mouse.pressed ? (last_mouse_y - FlxG.mouse.screenY) / 32 : 0, FlxG.mouse.wheel * 0.025);

		last_mouse_x = FlxG.mouse.screenX;
		last_mouse_y = FlxG.mouse.screenY;
	}

}