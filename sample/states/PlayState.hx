package states;

import objects.*;
import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;
import zero.flixel.depth.DepthGroup;
import zero.flixel.depth.DepthCamera;

class PlayState extends FlxState {

	var depth_camera:DepthCamera;
	var depth_group:DepthGroup;
	var last_mouse_x:Float;
	var last_mouse_y:Float;

	override function create() {
		FlxG.mouse.useSystemCursor = true;
		bgColor = 0xff32343C;
		depth_group = new DepthGroup();

		add(depth_camera = new DepthCamera(0, 0, 3));
		add(new DotGrid());
		add(new MouseFollower(depth_camera));
		add(depth_group);

		depth_group.add(new Billboard(FlxG.width/2 - 32, FlxG.height/2 - 32));
		depth_group.add(new Plane(FlxG.width/2 + 32, FlxG.height/2 + 32));
		depth_group.add(new StackSphere(FlxG.width/2 + 32, FlxG.height/2 - 32));
		depth_group.add(new StackCube(FlxG.width/2, FlxG.height/2));
		new PlaneCube(FlxG.width/2 - 32, FlxG.height/2 + 32, depth_group);

		var a:Array<Text> = [];

		add(a[a.push(new Text(FlxG.width/2, FlxG.height/2, 'StackSprite')) - 1]);
		add(a[a.push(new Text(FlxG.width/2 - 32, FlxG.height/2 - 32, 'BillboardSprite')) - 1]);
		add(a[a.push(new Text(FlxG.width/2 - 32, FlxG.height/2 + 32, 'PlaneSprite')) - 1]);
		add(a[a.push(new Text(FlxG.width/2 + 32, FlxG.height/2 - 32, 'StackSprite')) - 1]);
		add(a[a.push(new Text(FlxG.width/2 + 32, FlxG.height/2 + 32, 'PlaneSprite')) - 1]);

		var i = 0;
		new FlxTimer().start(3, _ -> {
			i++;
			for (t in a) t.visible = false;
			FlxSpriteUtil.flicker(a[i % a.length], 0.25);
		}, 0);
	}

	override function update(dt:Float) {
		super.update(dt);
		depth_group.depth_sort();

		if (FlxG.mouse.justPressed) {
			last_mouse_x = FlxG.mouse.screenX;
			last_mouse_y = FlxG.mouse.screenY;
		}

		depth_camera.set_delta(0.025);
		depth_camera.set_delta(FlxG.mouse.pressed ? (last_mouse_x - FlxG.mouse.screenX) / 8 : 0, FlxG.mouse.pressed ? (FlxG.mouse.screenY - last_mouse_y) / 16 : 0);

		last_mouse_x = FlxG.mouse.screenX;
		last_mouse_y = FlxG.mouse.screenY;
	}

}