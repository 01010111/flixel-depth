package zero.flixel.depth;

import flixel.group.FlxGroup.FlxTypedGroup;

/**
	A group used for dynamically sorting depth sprites
**/
class DepthGroup extends FlxTypedGroup<DepthSprite> {

	// quick helper class to sort by dy
	public function depth_sort() {
		sort((i, s1, s2) -> {
			return s1.dy < s2.dy ? -1 : 1;
		});
	}

}