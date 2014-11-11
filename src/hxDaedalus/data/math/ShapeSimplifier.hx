package hxDaedalus.data.math;

import hxDaedalus.debug.Debug;

class ShapeSimplifier
{

	/**
	 * Simplify polyline (Ramer-Douglas-Peucker).
	 * 
	 * @param	coords		Array of coords defining the polyline.
	 * @param	epsilon		Perpendicular distance threshold (typically in the range [1..2]).
	 * @return	An array of coords defining the simplified polyline.
	 */
	static public function simplify(coords:Array<Float>, epsilon:Float = 1):Array<Float> 
	{
		var len = coords.length;
		Debug.assertFalse((len & 1) != 0, "Wrong size");
		
		if (len <= 4) {
			return [].concat(coords);
		}
		
		var firstPointX = coords[0];
		var firstPointY = coords[1];
		var lastPointX = coords[len - 2];
		var lastPointY = coords[len - 1];
		
		var index = -1;
		var dist = 0.;
		for (i in 1...len >> 1) {
			var currDist = Geom2D.distanceSquaredPointToSegment(coords[i << 1], coords[(i << 1) + 1], firstPointX, firstPointY, lastPointX, lastPointY);
			if (currDist > dist) {
				dist = currDist;
				index = i;
			}
		}
		
		if (dist > epsilon * epsilon) {
			// recurse
			var l1 = coords.slice(0, (index << 1) + 2);
			var l2 = coords.slice(index << 1);
			var r1 = simplify(l1, epsilon);
			var r2 = simplify(l2, epsilon);
			// concat r2 to r1 minus the end/startpoint that will be the same
			var rs = r1.slice(0, r1.length - 2).concat(r2);
			return rs;
		} else {
			return [firstPointX, firstPointY, lastPointX, lastPointY];
		}
	}
}