package objects;

import flixel.group.FlxGroup.FlxTypedGroup;

class DepthGroup extends FlxTypedGroup<DepthSprite> {

	public function depth_sort() {
		sort((i, s1, s2) -> {
			return s1.dy < s2.dy ? -1 : 1;
		});
	}

}