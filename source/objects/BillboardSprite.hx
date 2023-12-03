package objects;

import objects.DepthCamera;

class BillboardSprite extends DepthSprite {

	public var scale_with_cam = true;

	override function draw() {
		var _angle = angle;
		var _scaleY = scale.y;
		var _x = x;
		var _y = y;

		angle = _angle - camera.angle;
		scale.y = scale_with_cam ? _scaleY * DepthCamera.container.scaleY.map(0, 1, Math.PI, 0) : _scaleY * 1/DepthCamera.container.scaleY;

		super.draw();

		angle = _angle;
		scale.y = _scaleY;
		x = _x;
		y = _y;
	}
}