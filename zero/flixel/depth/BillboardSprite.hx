package zero.flixel.depth;

import zero.flixel.depth.DepthCamera;

using zero.extensions.FloatExt;

/**
	A Billboard Sprite that always faces the camera.
	Appears to exist on the Z axis
**/
class BillboardSprite extends DepthSprite {

	// Whether or not to scale with the camera or appear the same size regardless of the vertical orbit of the DepthCamera
	public var scale_with_cam = true;

	override function draw() {
		var _angle = angle;
		var _scaleY = scale.y;
		var _x = x;
		var _y = y;

		angle = _angle - camera.angle;
		scale.y = scale_with_cam ? _scaleY * cam_orbit_y.map(0, 1, Math.PI, 0) : _scaleY * 1/cam_orbit_y;

		super.draw();

		angle = _angle;
		scale.y = _scaleY;
		x = _x;
		y = _y;
	}
}