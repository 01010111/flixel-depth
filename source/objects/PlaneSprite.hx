package objects;

import flixel.FlxCamera;
import flixel.graphics.frames.FlxFrame.FlxFrameAngle;

class PlaneSprite extends DepthSprite {

	public var facing_camera(get, never):Bool;
	function get_facing_camera() {
		return Math.cos(camera.angle * Math.PI/180 + angle * Math.PI/180) > 0;
	}

	override function drawComplex(camera:FlxCamera) {
		_frame.prepareMatrix(_matrix, FlxFrameAngle.ANGLE_0, checkFlipX(), checkFlipY());

		var cam_scale_y = DepthCamera.container.scaleY.map(0, 1, Math.PI, 0);
		var cam_radians = (camera.angle) * Math.PI / 180;
		var radians = angle * Math.PI / 180;

		_matrix.a = Math.cos(-radians) * scale.x;
		_matrix.b = -Math.sin(-radians) * scale.x;
		_matrix.c = -cam_scale_y * Math.sin(-cam_radians) * scale.y;
		_matrix.d = -cam_scale_y * -Math.cos(-cam_radians) * scale.y;
		_matrix.tx += -Math.cos(-radians) * width/2 * scale.x + _point.x + width/2 + height * scale.y * Math.cos(-cam_radians - Math.PI/2) * cam_scale_y;
		_matrix.ty += Math.sin(-radians) * width/2 * scale.x + _point.y + height/2 + height * scale.y * Math.sin(-cam_radians - Math.PI/2) * cam_scale_y;

		if (isPixelPerfectRender(camera)) {
			_matrix.tx = Math.floor(_matrix.tx);
			_matrix.ty = Math.floor(_matrix.ty);
		}

		camera.drawPixels(_frame, framePixels, _matrix, colorTransform, blend, antialiasing, shader);
	}

}