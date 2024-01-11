package zero.flixel.depth;

import flixel.math.FlxPoint;

using Math;
using zero.extensions.FloatExt;

/**
	A Stack Sprite stacks frames up along the Z axis to appear as a 3D voxel object.
	Change `gap` to scale along the Z axis.
	Use a higher `lod` (level of detail) to fill in the gaps between slices
	To change the angle of a specific slice (and those above it) set the corresponding angle offset with `angle_offsets[]`
**/
class StackSprite extends DepthSprite {

	// array of frames to use per slice
	public var slices:Array<Int> = [];
	// visual gap between slices
	public var gap:Float = Math.PI;
	// amount of extra slices between main slices
	public var lod:Int = 1;
	// array of angle offsets - higher slices inherit lower offsets
	public var angle_offsets:Array<Float> = [];

	// automatically creates slices from current frames
	public function auto_stack() {
		slices = [];
		for (i in 0...frames.numFrames) slices.push(i);
	}

	override function draw() {
		// store previous transform values
		var _angle = angle;
		var _position = FlxPoint.get(x, y);
		//get offset vector
		var offset = FlxPoint.get(cam_orbit_y.map(0, 1, gap / lod.max(1), 0));
		offset.degrees = -camera.angle - 90;
		// loop - set frame and transform per slice
		for (i in 0...slices.length * lod.max(1).floor()) {
			var idx = (i/lod.max(1)).floor();
			animation.frameIndex = slices[idx];
			if (angle_offsets[idx] != 0) angle += angle_offsets[idx]/lod.max(1);
			setPosition(_position.x + offset.x * i, _position.y + offset.y * i);
			super.draw();
		}
		// restore previous transform values
		angle = _angle;
		setPosition(_position.x, _position.y);
		// recycle vectors
		_position.put();
		offset.put();
	}

}