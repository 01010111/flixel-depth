package states;

import objects.DepthSprite;
import objects.PlaneSprite;
import objects.DepthGroup;
import objects.BillboardSprite;
import flixel.math.FlxRandom;
import objects.StackSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import objects.DepthCamera;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState {

	var car:StackSprite;
	var cam:DepthCamera;
	var grp:DepthGroup;

	var plane:PlaneSprite;
	var planes:Array<PlaneSprite> = [];

	override function create() {
		FlxG.mouse.visible = false;
		bgColor = 0xff32343C;

		add(cam = new DepthCamera(0, 0, 3));
		cam.set_snappiness(0.1);

		for (j in 0...(FlxG.height/32).floor()) for (i in 0...(FlxG.width/32).floor()) {
			var s = new FlxSprite(i * 32, j * 32);
			s.makeGraphic(1,1);
			add(s);
		}

		grp = new DepthGroup();
		add(grp);

		// plane = new PlaneSprite();
		// plane.loadGraphic(Images.grass__png);
		// plane.screenCenter();
		// grp.add(plane);

		var cube = new StackSprite();
		cube.loadGraphic(Images.cube__png, true, 32, 32);
		cube.auto_stack();
		cube.screenCenter();
		grp.add(cube);

		for (i in 0...4) {
			var cube = new StackSprite();
			cube.loadGraphic(Images.cube__png, true, 32, 32);
			cube.auto_stack();
			cube.screenCenter();
			cube.color = new FlxRandom().color();
			cube.z += i * 32;
			cube.x -= 32;
			grp.add(cube);
		}

		var walker = new BillboardSprite();
		walker.loadGraphic(Images.fadeline__png, true, 32, 32);
		walker.animation.add('play', [0,0,1,2,3,3,4,5], 15);
		walker.animation.play('play');
		walker.z = 32;
		walker.scale.set(2, 2);
		walker.origin.set(16, 32);
		walker.offset.set(16, 32);
		walker.setSize(0, 0);
		walker.screenCenter();
		grp.add(walker);

		car = new objects.StackSprite();
		car.loadGraphic(Images.car__png, true, 32, 32);
		car.auto_stack();
		car.lod = 4;
		car.screenCenter();
		car.x += 32;
		car.y += 32;
		grp.add(car);

		var box_size = 4;
		var wall_size = 32;

		for (i in 0...box_size) {
			var plane = new PlaneSprite(FlxG.width/2 - box_size * wall_size/2 + i * wall_size, FlxG.height/2 - box_size * wall_size/2 - wall_size/2);
			plane.makeGraphic(wall_size, wall_size);
			plane.drawRect(0, 0, wall_size/2, wall_size/2, 0xFF806090);
			plane.drawRect(wall_size/2, wall_size/2, wall_size/2, wall_size/2, 0xFF806090);
			grp.add(plane);
			planes.push(plane);
			var plane = new PlaneSprite(FlxG.width/2 - box_size * wall_size/2 + i * wall_size, FlxG.height/2 + box_size * wall_size/2 - wall_size/2);
			plane.makeGraphic(wall_size, wall_size);
			plane.drawRect(0, 0, wall_size/2, wall_size/2, 0xFF806090);
			plane.drawRect(wall_size/2, wall_size/2, wall_size/2, wall_size/2, 0xFF806090);
			plane.angle = 180;
			grp.add(plane);
			planes.push(plane);
		}
		for (i in 0...box_size) {
			var plane = new PlaneSprite(FlxG.width/2 + box_size * wall_size/2 - wall_size/2, FlxG.height/2 - box_size * wall_size/2 + i * wall_size);
			plane.makeGraphic(wall_size, wall_size);
			plane.drawRect(0, 0, wall_size/2, wall_size/2, 0xFF806090);
			plane.drawRect(wall_size/2, wall_size/2, wall_size/2, wall_size/2, 0xFF806090);
			plane.angle = 90;
			grp.add(plane);
			planes.push(plane);
			var plane = new PlaneSprite(FlxG.width/2 - box_size * wall_size/2 - wall_size/2, FlxG.height/2 - box_size * wall_size/2 + i * wall_size);
			plane.makeGraphic(wall_size, wall_size);
			plane.drawRect(0, 0, wall_size/2, wall_size/2, 0xFF806090);
			plane.drawRect(wall_size/2, wall_size/2, wall_size/2, wall_size/2, 0xFF806090);
			plane.angle = 270;
			grp.add(plane);
			planes.push(plane);
		}
	}

	var lmx:Float;
	var lmy:Float;
	override function update(dt:Float) {
		for (plane in planes) {
			plane.color = plane.facing_camera ? 0xFFFFFFFF: 0xFF808080;
			plane.alpha = plane.facing_camera ? 1: 0.75;
		}
		super.update(dt);
		grp.depth_sort();

		// plane.angle--;
		// plane.animation.frameIndex = plane.facing_camera ? 0 : 1;

		if (FlxG.keys.pressed.A) car.lod--;
		if (FlxG.keys.pressed.D) car.lod++;

		cam.set_delta(0.025);

		cam.set_delta(FlxG.mouse.pressed ? (lmx - FlxG.mouse.screenX) / 8 : 0, FlxG.mouse.pressed ? (lmy - FlxG.mouse.screenY) / 32 : 0, FlxG.mouse.wheel * 0.025);
		// var scroll = FlxPoint.get();
		// if (FlxG.keys.pressed.W) scroll.y -= 1;
		// if (FlxG.keys.pressed.S) scroll.y += 1;
		// if (FlxG.keys.pressed.A) scroll.x -= 1;
		// if (FlxG.keys.pressed.D) scroll.x += 1;
		// scroll.degrees -= camera.angle;
		// scroll.length *= 4 / camera.zoom;
		// cam.x += scroll.x;
		// cam.y += scroll.y;

		lmx = FlxG.mouse.screenX;
		lmy = FlxG.mouse.screenY;
	}

}