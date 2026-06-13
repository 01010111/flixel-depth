package zero.flixel.depth;

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
		var _angle = angle;
		var base_x = x;
		var base_y = y;
		var lod_value = lod.max(1).floor();
		var slice_count = slices.length;
		var offset = cam_orbit_y.map(0, 1, gap / lod_value, 0);
		var offset_angle = (-camera.angle - 90) * Math.PI / 180;
		var step_x = Math.cos(offset_angle) * offset;
		var step_y = Math.sin(offset_angle) * offset;
		var cumulative_angle = _angle;

		for (slice in 0...slice_count) {
			var frameIndex = slices[slice];
			var angleDelta:Float = 0;

			#if html5
			if (angle_offsets[slice] != null) angleDelta = angle_offsets[slice] / lod_value;
			#else
			if (angle_offsets[slice] != 0) angleDelta = angle_offsets[slice] / lod_value;
			#end
			
			animation.frameIndex = frameIndex;

			for (j in 0...lod_value) {
				cumulative_angle += angleDelta;
				angle = cumulative_angle;
				setPosition(base_x + step_x * (slice * lod_value + j), base_y + step_y * (slice * lod_value + j));
				super.draw();
			}
		}

		angle = _angle;
		setPosition(base_x, base_y);
	}

}