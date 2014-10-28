package ddls.data.math;

import ddls.data.Constants;
import ddls.data.Edge;
import ddls.data.Face;
import ddls.data.Mesh;
import ddls.data.Vertex;
import ddls.iterators.FromFaceToInnerEdges;
import ddls.iterators.FromVertexToHoldingFaces;


class Geom2D
{
	
	
	private static var _randGen:RandGenerator;
	
	// return one the following, in priority order:
	// - an existant vertex (if (x, y) lies on this vertex)
	// or 
	// - an existant edge (if (x, y) lies on this edge)
	// or
	// - an existant face (if (x, y) lies on this face)
	// or
	// - null if outside mesh
	// YOU SHOULD USE THIS FUNCTION ONLY FOR COORDINATES INSIDE SAFE AREA
	static private var __samples:Array<Vertex> = new Array<Vertex>();
	static public function locatePosition(x:Float, y:Float, mesh:Mesh):Dynamic
	{
		// jump and walk algorithm
		
		if (_randGen == null)
			_randGen = new RandGenerator();
		_randGen.seed = Std.int(x * 10 + 4 * y);
		
		var i:Int;
		
		__samples.splice(0, __samples.length);
		var numSamples:Int = Std.int(Math.pow(mesh.__vertices.length, 1 / 3));
		_randGen.rangeMin = 0;
		_randGen.rangeMax = mesh.__vertices.length - 1;
		for (i in 0...numSamples) {
			var _rnd:Int = _randGen.next();
			//TODO: Assert
			if (_rnd < 0 || _rnd > mesh.__vertices.length -1 || mesh.__vertices == null) throw "null";
			__samples.push(mesh.__vertices[_rnd]);
		}
		
			
		var currVertex:Vertex;
		var currVertexPos:Point2D;
		var distSquared:Float;
		var minDistSquared:Float = Math.POSITIVE_INFINITY;
		var closedVertex:Vertex = null;
		for (i in 0...numSamples)
		{
			currVertex = __samples[i];
			currVertexPos = currVertex.pos;
			distSquared = (currVertexPos.x - x) * (currVertexPos.x - x) + (currVertexPos.y - y) * (currVertexPos.y - y);
			if (distSquared < minDistSquared)
			{
				minDistSquared = distSquared;
				closedVertex = currVertex;
			}
		}
		
		var currFace:Face;
		var iterFace:FromVertexToHoldingFaces = new FromVertexToHoldingFaces();
		iterFace.fromVertex = closedVertex;
		currFace = iterFace.next();
		
		var faceVisited = new Map<Face, Bool>();
		var currEdge:Edge;
		var iterEdge:FromFaceToInnerEdges = new FromFaceToInnerEdges();
		var objectContainer:Dynamic = null;
		var relativPos:Int;
		var numIter:Int = 0;
		while (faceVisited[currFace] || (objectContainer = isInFace(x, y, currFace)) == null)
		{
			
			numIter++;
			if (numIter == 50)
			{
				trace("WALK TAKE MORE THAN 50 LOOP");
				//objectContainer = null;
				//break;
				//throw new Error("WALK TAKE MORE THAN 50 LOOP");
			}
			iterEdge.fromFace = currFace;
			do
			{
				currEdge = iterEdge.next();
				if (currEdge == null)
				{
					trace("KILL PATH");
					return null;
				}
				relativPos = getRelativePosition(x, y, currEdge);
			}
			while (relativPos == 1 || relativPos == 0);
			
			currFace = currEdge.rightFace;
		}
		
		return objectContainer;
	}
	
	static public function isCircleIntersectingAnyConstraint(x:Float, y:Float, radius:Float, mesh:Mesh):Bool
	{
		if (x <= 0 || x >= mesh.width || y <= 0 || y >= mesh.height)
			return true;
		
		var loc:Dynamic = Geom2D.locatePosition(x, y, mesh);
		var locVertex:Vertex;
		var locEdge:Edge;
		var face:Face;
		if (Std.is(loc, Vertex)) {
			locVertex = cast loc;
			face = locVertex.edge.leftFace;
		} else if (Std.is(loc, Edge)) {
			locEdge = cast loc;
			face = locEdge.leftFace;
		} else {
			face = cast loc;
		}
		
		// if a vertex is in the circle, a contrainst must intersect the circle
		// because a vertex always belongs to a contrained edge
		var radiusSquared:Float = radius * radius;
		var pos:Point2D;
		var distSquared:Float;
		pos = face.edge.originVertex.pos;
		distSquared = (pos.x - x) * (pos.x - x) + (pos.y - y) * (pos.y - y);
		if (distSquared <= radiusSquared)
		{
			return true;
		}
		pos = face.edge.nextLeftEdge.originVertex.pos;
		distSquared = (pos.x - x) * (pos.x - x) + (pos.y - y) * (pos.y - y);
		if (distSquared <= radiusSquared)
		{
			return true;
		}
		pos = face.edge.nextLeftEdge.nextLeftEdge.originVertex.pos;
		distSquared = (pos.x - x) * (pos.x - x) + (pos.y - y) * (pos.y - y);
		if (distSquared <= radiusSquared)
		{
			return true;
		}
		
		// check if edge intersects
		var edgesToCheck:Array<Edge> = new Array<Edge>();
		edgesToCheck.push(face.edge);
		edgesToCheck.push(face.edge.nextLeftEdge);
		edgesToCheck.push(face.edge.nextLeftEdge.nextLeftEdge);
		
		var edge:Edge;
		var pos1:Point2D;
		var pos2:Point2D;
		var checkedEdges = new Map<Edge, Bool>();
		var intersecting:Bool;
		while (edgesToCheck.length > 0)
		{
			edge = edgesToCheck.pop();
			checkedEdges[edge] = true;
			pos1 = edge.originVertex.pos;
			pos2 = edge.destinationVertex.pos;
			intersecting = intersectionsSegmentCircle(pos1.x, pos1.y, pos2.x, pos2.y,x, y, radius);
			if (intersecting)
			{
				if (edge.isConstrained)
					return true;
				else
				{
					edge = edge.oppositeEdge.nextLeftEdge;
					if (!checkedEdges[edge] && !checkedEdges[edge.oppositeEdge]
						&& edgesToCheck.indexOf(edge) == -1 && edgesToCheck.indexOf(edge.oppositeEdge) == -1)
					{
						edgesToCheck.push(edge);
					}
					edge = edge.nextLeftEdge;
					if (!checkedEdges[edge] && !checkedEdges[edge.oppositeEdge]
						&& edgesToCheck.indexOf(edge) == -1 && edgesToCheck.indexOf(edge.oppositeEdge) == -1)
					{
						edgesToCheck.push(edge);
					}
				}
			}
		}
		
		return false;
	}
	
	// return the relative direction from (x1,y1), to (x3,y3) through (x2, y2)
	// the function returns:
	// 0 if the path is a straight line
	// 1 if the path goes to the left
	// -1 if the path goes to the right
	static public function getDirection(x1:Float, y1:Float
										, x2:Float, y2:Float
										, x3:Float, y3:Float):Int
	{
		
		// dot product with the orthogonal vector pointing left vector of eUp:
		var dot:Float = (x3 - x1) * (y2 - y1) + (y3 - y1) * (- x2 + x1);
		
		// check sign
		return (dot == 0) ? 0 : ((dot > 0) ? 1 : -1);
	}
	
	// second version of getDirection. More accurate and safer version
	// return the relative direction from (x1,y1), to (x3,y3) through (x2, y2)
	// the function returns:
	// 0 if the path is a straight line
	// 1 if the path goes to the left
	// -1 if the path goes to the right
	static public function getDirection2(x1:Float, y1:Float
										, x2:Float, y2:Float
										, x3:Float, y3:Float):Int
	{
		// dot product with the orthogonal vector pointing left vector of eUp:
		var dot:Float = (x3 - x1) * (y2 - y1) + (y3 - y1) * (- x2 + x1);
		
		// check sign
		if (dot == 0)
		{
			return 0;
		}
		else if (dot > 0)
		{
			if (distanceSquaredPointToLine(x3, y3, x1, y1, x2, y2) <= Constants.EPSILON_SQUARED)
				return 0;
			else
				return 1;
		}
		else
		{
			if (distanceSquaredPointToLine(x3, y3, x1, y1, x2, y2) <= Constants.EPSILON_SQUARED)
				return 0;
			else
				return -1;
		}
	}
	
	// eUp seen as an infinite line splits the 2D space in 2 parts (left and right),
	// the function returns:
	//   0 if the (x, y) lies on the line
	//   1 if the (x, y) lies at left
	//   -1 if the (x, y) lies at right
	static public function getRelativePosition(x:Float, y:Float, eUp:Edge):Int
	{
		return getDirection(eUp.originVertex.pos.x, eUp.originVertex.pos.y
							, eUp.destinationVertex.pos.x, eUp.destinationVertex.pos.y
							, x, y);
		
		/*
		parametric expression of pointing up edge eUp
		x(t1) = vOrigin.x + t1*(vDestination.x - vOrigin.x)
		y(t1) = vOrigin.y + t1*(vDestination.y - vOrigin.y)
		
		and orthogonal edge pointing right to eUp 
		x(t2) = vOrigin.x + t2*(vDestination.y - vOrigin.y)
		y(t2) = vOrigin.y - t2*(vDestination.x - vOrigin.x)
		
		(x, y) position can be expressed as a linear combination of the 2 previous segments
		x = vOrigin.x + t2*(vDestination.y - vOrigin.y) + t1*(vDestination.x - vOrigin.x)
		y = vOrigin.y + t1*(vDestination.y - vOrigin.y) - t2*(vDestination.x - vOrigin.x)
		
		---> the sign of t2 will inform us if vToCheck lies at right or left of eUp
		*/
		
		// set alias letters
		/*
		var a:Float = x;
		var b:Float = y;
		var c:Float = vOrigin.pos.x;
		var d:Float = vOrigin.pos.y;
		var e:Float = vDestination.pos.x;
		var f:Float = vDestination.pos.y;
		*/
		
		/*
		system to solve:
		a = c + t2 (f - d) + t1 (e - c)
		b = d + t1 (f - d) - t2 (e - c)
		*/
		
		// giving to wolfram: Solve[{a = c + t2 (f - d) + t1 (e - c) , b = d + t1 (f - d) - t2 (e - c)}, {t1, t2}]
		// we get:
		/*
		var t2:Float = (-a*d + a*f + b*c - b*e - c*f + d*e) / (c*c - 2*c*e + d*d - 2*d*f + e*e + f*f);
		
		var result:Int;
		if (t2 == 0)
			result = 0;
		else if (t2 < 0)
			result = -1;
		else
			result = 1;
		
		return result;
		*/
	}
	
	static public function getRelativePosition2(x:Float, y:Float, eUp:Edge):Int
	{
		return getDirection2(eUp.originVertex.pos.x, eUp.originVertex.pos.y
							, eUp.destinationVertex.pos.x, eUp.destinationVertex.pos.y
							, x, y);
	}
	
	// the function checks by priority:
	// - if the (x, y) lies on a vertex of the polygon, it will return this vertex
	// - if the (x, y) lies on a edge of the polygon, it will return this edge
	// - if the (x, y) lies inside the polygon, it will return the polygon
	// - if the (x, y) lies outside the polygon, it will return null
	static public function isInFace(x:Float, y:Float, polygon:Face):Dynamic
	{
		// remember polygons are triangle only,
		// and we suppose we have not degenerated flat polygons !
		
		var result:Dynamic = null;
		
		var e1_2:Edge = polygon.edge;
		var e2_3:Edge = e1_2.nextLeftEdge;
		var e3_1:Edge = e2_3.nextLeftEdge;
		if (getRelativePosition(x, y, e1_2) >= 0 && getRelativePosition(x, y, e2_3) >= 0 && getRelativePosition(x, y, e3_1) >= 0)
		{
			var v1:Vertex = e1_2.originVertex;
			var v2:Vertex = e2_3.originVertex;
			var v3:Vertex = e3_1.originVertex;
			
			var x1:Float = v1.pos.x;
			var y1:Float = v1.pos.y;
			var x2:Float = v2.pos.x;
			var y2:Float = v2.pos.y;
			var x3:Float = v3.pos.x;
			var y3:Float = v3.pos.y;
			
			var v_v1squaredLength:Float = (x1 - x) * (x1 - x) + (y1 - y) * (y1 - y);
			var v_v2squaredLength:Float = (x2 - x) * (x2 - x) + (y2 - y) * (y2 - y);
			var v_v3squaredLength:Float = (x3 - x) * (x3 - x) + (y3 - y) * (y3 - y);
			var v1_v2squaredLength:Float = (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1);
			var v2_v3squaredLength:Float = (x3 - x2) * (x3 - x2) + (y3 - y2) * (y3 - y2);
			var v3_v1squaredLength:Float = (x1 - x3) * (x1 - x3) + (y1 - y3) * (y1 - y3);
			
			var dot_v_v1v2:Float = (x - x1) * (x2 - x1) + (y - y1) * (y2 - y1);
			var dot_v_v2v3:Float = (x - x2) * (x3 - x2) + (y - y2) * (y3 - y2);
			var dot_v_v3v1:Float = (x - x3) * (x1 - x3) + (y - y3) * (y1 - y3);
			
			var v_e1_2squaredLength:Float = v_v1squaredLength - dot_v_v1v2 * dot_v_v1v2 / v1_v2squaredLength;
			var v_e2_3squaredLength:Float = v_v2squaredLength - dot_v_v2v3 * dot_v_v2v3 / v2_v3squaredLength;
			var v_e3_1squaredLength:Float = v_v3squaredLength - dot_v_v3v1 * dot_v_v3v1 / v3_v1squaredLength;
			
			var closeTo_e1_2:Bool = v_e1_2squaredLength <= Constants.EPSILON_SQUARED;
			var closeTo_e2_3:Bool = v_e2_3squaredLength <= Constants.EPSILON_SQUARED;
			var closeTo_e3_1:Bool = v_e3_1squaredLength <= Constants.EPSILON_SQUARED;
			
			if (closeTo_e1_2)
			{
				if (closeTo_e3_1)
					result = v1;
				else if (closeTo_e2_3)
					result = v2;
				else
					result = e1_2;
			}
			else if (closeTo_e2_3)
			{
				if (closeTo_e3_1)
					result = v3;
				else
					result = e2_3;
			}
			else if (closeTo_e3_1)
				result = e3_1;
			else
				result = polygon;
		}
		
		return result;
		
		// we will use barycentric coordinates
		// see http://en.wikipedia.org/wiki/Barycentric_coordinate_system
		/*
		var e1_2:QEEdge = polygon.edge;
		var e2_3:QEEdge = e1_2.nextLeftEdge;
		var e3_1:QEEdge = e2_3.nextLeftEdge;
		
		var v1:QEVertex = e1_2.originVertex;
		var v2:QEVertex = e2_3.originVertex;
		var v3:QEVertex = e3_1.originVertex;
		
		var x1:Float = v1.pos.x;
		var y1:Float = v1.pos.y;
		var x2:Float = v2.pos.x;
		var y2:Float = v2.pos.y;
		var x3:Float = v3.pos.x;
		var y3:Float = v3.pos.y;
		
		var coef1:Float = ((y2 - y3)*(x - x3) + (x3 - x2)*(y - y3)) / ((y2 - y3)*(x1 - x3) + (x3 - x2)*(y1 - y3));
		var coef2:Float = ((y3 - y1)*(x - x3) + (x1 - x3)*(y - y3)) / ((y2 - y3)*(x1 - x3) + (x3 - x2)*(y1 - y3));
		var coef3:Float = 1 - coef1 - coef2;
		
		trace("isInFace:", coef1, coef2, coef3);
		
		var result:Object;
		if (0 <= coef1 && coef1 <= 1 && 0 <= coef2 && coef2 <= 1 && 0 <= coef3 && coef3 <= 1)
		{
			var v_v1squaredLength:Float = (x1 - x)*(x1 - x) + (y1 - y)*(y1 - y);
			var v_v2squaredLength:Float = (x2 - x)*(x2 - x) + (y2 - y)*(y2 - y);
			var v_v3squaredLength:Float = (x3 - x)*(x3 - x) + (y3 - y)*(y3 - y);
			var v1_v2squaredLength:Float = (x2 - x1)*(x2 - x1) + (y2 - y1)*(y2 - y1);
			var v2_v3squaredLength:Float = (x3 - x2)*(x3 - x2) + (y3 - y2)*(y3 - y2);
			var v3_v1squaredLength:Float = (x1 - x3)*(x1 - x3) + (y1 - y3)*(y1 - y3);
			
			var dot_v_v1v2:Float = (x - x1)*(x2 - x1) + (y - y1)*(y2 - y1);
			var dot_v_v2v3:Float = (x - x2)*(x3 - x2) + (y - y2)*(y3 - y2);
			var dot_v_v3v1:Float = (x - x3)*(x1 - x3) + (y - y3)*(y1 - y3);
				
			var v_e1_2squaredLength:Float = v_v1squaredLength - dot_v_v1v2 * dot_v_v1v2 / v1_v2squaredLength;
			var v_e2_3squaredLength:Float = v_v2squaredLength - dot_v_v2v3 * dot_v_v2v3 / v2_v3squaredLength;
			var v_e3_1squaredLength:Float = v_v3squaredLength - dot_v_v3v1 * dot_v_v3v1 / v3_v1squaredLength;
			
			var closeTo_e1_2:Bool = v_e1_2squaredLength <= QEConstants.EPSILON_SQUARED;
			var closeTo_e2_3:Bool = v_e2_3squaredLength <= QEConstants.EPSILON_SQUARED;
			var closeTo_e3_1:Bool = v_e3_1squaredLength <= QEConstants.EPSILON_SQUARED;
			
			if (closeTo_e1_2)
			{
				if (closeTo_e3_1)
					result = v1;
				else if (closeTo_e2_3)
					result = v2;
				else
					result = e1_2;
			}
			else if (closeTo_e2_3)
			{
				if (closeTo_e3_1)
					result = v3;
				else
					result = e2_3;
			}
			else if (closeTo_e3_1)
				result = e3_1;
			else
				result = polygon;
		}
		
		return result;
		
		*/
		
		
		/*
		parametric expression of eLeft:
		x(t1) = vCorner.x + t1*(vLeft.x - vCorner.x)
		x(t1) = vCorner.y + t1*(vLeft.y - vCorner.y)
		
		for eRight:
		x(t2) = vCorner.x + t2*(vRight.x - vCorner.x)
		x(t2) = vCorner.y + t2*(vRight.y - vCorner.y)
		
		(x, y) position can be expressed as a linear combination of the 2 previous segments
		
		x = vCorner.x + t1*(vLeft.x - vCorner.x) + t2*(vRight.x - vCorner.x)
		y = vCorner.y + t1*(vLeft.y - vCorner.y) + t2*(vRight.y - vCorner.y)
		
		values of t1, t2 and s=t1+t2 will inform us if vToCheck lies in the polygon
		*/
		/*
		// set alias letters
		var a:Float = x;
		var b:Float = y;
		var c:Float = vCorner.pos.x;
		var d:Float = vCorner.pos.y;
		var e:Float = vLeft.pos.x;
		var f:Float = vLeft.pos.y;
		var g:Float = vRight.pos.x;
		var h:Float = vRight.pos.y;
		
		/*
		system to solve:
		a = c + t1 (e - c) + t2 (g - c)
		b = d + t1 (f - d) + t2 (h - d)
		*/
		/*
		// giving to wolfram: Solve[{a = c + t1 (e - c) + t2 (g - c) , b = d + t1 (f - d) + t2 (h - d)}, {t1, t2}]
		// we get:
		var denominator:Float = (c*(f - h) + d*(g - e) + e*h - f*g);
		var t1:Float = (a*(h - d) + b*(c - g) - c*h + d*g) / denominator;
		var t2:Float = (a*(f - d) + b*(c - e) - c*f + d*e) / -denominator;
		// then we deduce:
		var s:Float = t1 + t2;
		
		var result:Object;
		// if inside triangle:
		if (0 <= t1 && t1 <=1 && 0 <= t2 && t2 <=1 && 0 <= s && s <=1)
		{
			if (t2*((g - c)*(g - c) + (h - d)*(h - d)) <= QEConstants.EPSILON_SQUARED)
			// if near vCorner:
			if (((c - a)*(c - a) + (d - b)*(d - b)) <= QEConstants.EPSILON_SQUARED)
				result = vCorner;
			// if near vLeft:
			else if (((e - a)*(e - a) + (f - b)*(f - b)) <= QEConstants.EPSILON_SQUARED)
				result = vLeft;
			// if near vRight:
			else if (((g - a)*(g - a) + (h - b)*(h - b)) <= QEConstants.EPSILON_SQUARED)
				result = vRight;
			else
				result = polygon;
		}
		else
			result = null;
		
		return result;*/
	}
	
	// return:
	// - true if the segment is totally or partially in the triangle
	// - false if the segment is totally outside the triangle
	static public function clipSegmentByTriangle(s1x:Float, s1y:Float, s2x:Float, s2y:Float
												, t1x:Float, t1y:Float, t2x:Float, t2y:Float, t3x:Float, t3y:Float
												, pResult1:Point2D=null, pResult2:Point2D=null):Bool
	{
		var side1_1:Int;
		var side1_2:Int;
		side1_1 = getDirection(t1x, t1y, t2x, t2y, s1x, s1y);
		side1_2 = getDirection(t1x, t1y, t2x, t2y, s2x, s2y);
		// if both segment points are on right side
		if (side1_1 <= 0 && side1_2 <= 0)
			return false;
		
		var side2_1:Int;
		var side2_2:Int;
		side2_1 = getDirection(t2x, t2y, t3x, t3y, s1x, s1y);
		side2_2 = getDirection(t2x, t2y, t3x, t3y, s2x, s2y);
		// if both segment points are on right side
		if (side2_1 <= 0 && side2_2 <= 0)
			return false;
		
		var side3_1:Int;
		var side3_2:Int;
		side3_1 = getDirection(t3x, t3y, t1x, t1y, s1x, s1y);
		side3_2 = getDirection(t3x, t3y, t1x, t1y, s2x, s2y);
		// if both segment points are on right side
		if (side3_1 <= 0 && side3_2 <= 0)
			return false;
		
		// both segment points are in triangle
		if ((side1_1 >= 0 && side2_1 >= 0 && side3_1 >= 0) && (side1_2 >= 0 && side2_2 >= 0 && side3_2 >= 0))
		{
			pResult1.x = s1x;
			pResult1.y = s1y;
			pResult2.x = s2x;
			pResult2.y = s2y;
			return true;
		}
		
		var n:Int = 0;
		// check intersection between segment and 1st side triangle
		if (intersections2segments(s1x, s1y, s2x, s2y, t1x, t1y, t2x, t2y, pResult1, null))
		{
			n++;
		}
		
		// if no intersection with 1st side triangle
		if (n == 0)
		{
			// check intersection between segment and 1st side triangle
			if (intersections2segments(s1x, s1y, s2x, s2y, t2x, t2y, t3x, t3y, pResult1, null))
			{
				n++;
			}
		}
		else
		{
			if (intersections2segments(s1x, s1y, s2x, s2y, t2x, t2y, t3x, t3y, pResult2, null))
			{
				// we check if the segment is not on t2 triangle point
				if (   -Constants.EPSILON > pResult1.x - pResult2.x
					|| pResult1.x - pResult2.x > Constants.EPSILON
					|| -Constants.EPSILON > pResult1.y - pResult2.y
					|| pResult1.y - pResult2.y > Constants.EPSILON)
				{
					n++;
				}
			}
		}
		
		// if intersection neither 1st nor 2nd side triangle
		if (n == 0)
		{
			if (intersections2segments(s1x, s1y, s2x, s2y, t3x, t3y, t1x, t1y, pResult1, null))
			{
				n++;
			}
		}
		else if (n == 1)
		{
			if (intersections2segments(s1x, s1y, s2x, s2y, t3x, t3y, t1x, t1y, pResult2, null))
			{
				if (   -Constants.EPSILON > pResult1.x - pResult2.x
					|| pResult1.x - pResult2.x > Constants.EPSILON
					|| -Constants.EPSILON > pResult1.y - pResult2.y
					|| pResult1.y - pResult2.y > Constants.EPSILON)
				{
					n++;
				}
			}
		}
		
		// if one intersection, we identify the segment point in the triangle
		if (n==1)
		{
			if (side1_1 >= 0 && side2_1 >= 0 && side3_1 >= 0)
			{
				pResult2.x = s1x;
				pResult2.y = s1y;
			}
			else if (side1_2 >= 0 && side2_2 >= 0 && side3_2 >= 0)
			{
				pResult2.x = s2x;
				pResult2.y = s2y;
			}
			else
			{
				// 1 intersection and none point in triangle : degenerate case
				n = 0;
			}
		}
		
		if (n > 0)
			return true;
		else
			return false;
	}
	
	// test if the segment intersects or lies inside the triangle
	static public function isSegmentIntersectingTriangle(s1x:Float, s1y:Float, s2x:Float, s2y:Float
														, t1x:Float, t1y:Float, t2x:Float, t2y:Float, t3x:Float, t3y:Float):Bool
	{
		// check sides
		
		var side1_1:Int;
		var side1_2:Int;
		side1_1 = getDirection(t1x, t1y, t2x, t2y, s1x, s1y);
		side1_2 = getDirection(t1x, t1y, t2x, t2y, s2x, s2y);
		// if both segment points are on right side
		if (side1_1 <= 0 && side1_2 <= 0)
			return false;
		
		var side2_1:Int;
		var side2_2:Int;
		side2_1 = getDirection(t2x, t2y, t3x, t3y, s1x, s1y);
		side2_2 = getDirection(t2x, t2y, t3x, t3y, s2x, s2y);
		// if both segment points are on right side
		if (side2_1 <= 0 && side2_2 <= 0)
			return false;
		
		var side3_1:Int;
		var side3_2:Int;
		side3_1 = getDirection(t3x, t3y, t1x, t1y, s1x, s1y);
		side3_2 = getDirection(t3x, t3y, t1x, t1y, s2x, s2y);
		// if both segment points are on right side
		if (side3_1 <= 0 && side3_2 <= 0)
			return false;
		
		// if 1st segment point is inside triangle
		if (side1_1 == 1 && side2_1 == 1 && side3_1 == 1)
			return true;
		
		// if 2st segment point is inside triangle
		if (side1_1 == 1 && side2_1 == 1 && side3_1 == 1)
			return true;
		
		var side1:Int;
		var side2:Int;
		// if both segment points are on different sides of the 1st triangle side
		if ((side1_1 == 1 && side1_2 <= 0) || (side1_1 <= 0 && side1_2 == 1))
		{
			side1 = getDirection(s1x, s1y, s2x, s2y, t1x, t1y);
			side2 = getDirection(s1x, s1y, s2x, s2y, t2x, t2y);
			if (side1 == 1 && side2 <= 0 || side1 <= 0 && side2 == 1)
			{
				return true;
			}
		}
		// if both segment points are on different sides of the 2nd triangle side
		if ((side2_1 == 1 && side2_2 <= 0) || (side2_1 <= 0 && side2_2 == 1))
		{
			side1 = getDirection(s1x, s1y, s2x, s2y, t2x, t2y);
			side2 = getDirection(s1x, s1y, s2x, s2y, t3x, t3y);
			if (side1 == 1 && side2 <= 0 || side1 <= 0 && side2 == 1)
			{
				return true;
			}
		}
		// if both segment points are on different sides of the 3rd triangle side
		if ((side3_1 == 1 && side3_2 <= 0) || (side3_1 <= 0 && side3_2 == 1))
		{
			side1 = getDirection(s1x, s1y, s2x, s2y, t3x, t3y);
			side2 = getDirection(s1x, s1y, s2x, s2y, t1x, t1y);
			if (side1 == 1 && side2 <= 0 || side1 <= 0 && side2 == 1)
			{
				return true;
			}
		}
		
		return false;
	}
	
	static private var __circumcenter:Point2D = new Point2D();
	static public function isDelaunay(edge:Edge):Bool
	{
		var vLeft:Vertex = edge.originVertex;
		var vRight:Vertex = edge.destinationVertex;
		var vCorner:Vertex = edge.nextLeftEdge.destinationVertex;
		var vOpposite:Vertex = edge.nextRightEdge.destinationVertex;
		/*
		// middle points
		var vMidLeft:Point = new Point();
		vMidLeft.x = (vCorner.pos.x + vLeft.pos.x) / 2;
		vMidLeft.y = (vCorner.pos.y + vLeft.pos.y) / 2;
		
		var vMidRight:Point = new Point();
		vMidRight.x = (vCorner.pos.x + vRight.pos.x) / 2;
		vMidRight.y = (vCorner.pos.y + vRight.pos.y) / 2;
		*/
		/*
		- parametric expression of orthogonal segments
		segOrthoLeftX(t1) = vMidLeft.x + t1 * (vLeft.y - vCorner.y)
		segOrthoLeftY(t1) = vMidLeft.y - t1 * (vLeft.x - vCorner.x)
		
		segOrthoRightX(t2) = vMidRight.x + t2 * (vRight.y - vCorner.y)
		segOrthoRightY(t2) = vMidRight.y - t2 * (vRight.x - vCorner.x)
		
		- the center of circle passing by vLeft, vRight, vCorner will lead to:
		segOrthoLeftX(t1) = segOrthoRightX(t2)
		segOrthoLeftY(t1) = segOrthoRightY(t2)
		*/
		/*
		// set alias letters
		var a:Float = vMidLeft.x;
		var b:Float = vLeft.pos.y;
		var c:Float = vCorner.pos.y;
		var d:Float = vMidRight.x;
		var e:Float = vRight.pos.y;
		var f:Float = vCorner.pos.y;
		var g:Float = vMidLeft.y;
		var h:Float = vLeft.pos.x;
		var i:Float = vCorner.pos.x;
		var j:Float = vMidRight.y;
		var k:Float = vRight.pos.x;
		var l:Float = vCorner.pos.x;
		*/
		/*
		system to solve:
		a + t1 (b - c) = d + t2 (e - f)
		g - t1 (h - i) = j - t2 (k - l)
		*/
		
		//giving to wolfram: Solve[{a + t1 (b - c) = d + t2 (e - f) , g - t1 (h - i) = j - t2 (k - l)}, {t1, t2}]
		//we get:
		//var t1:Float = (-(a-d)*(k-l) + e*(j-g) + f*(g-j)) / ((b-c)*(k-l) + e*(i-h) + f*(h-i));
		/*
		__barycenter.x = a + t1 * (b - c);
		__barycenter.y = g - t1 * (h - i);
		*/
		getCircumcenter(vCorner.pos.x, vCorner.pos.y, vLeft.pos.x, vLeft.pos.y, vRight.pos.x, vRight.pos.y, __circumcenter);
		
		// check if the opposite vertex lies outside the circle
		var squaredRadius:Float = (vCorner.pos.x - __circumcenter.x)*(vCorner.pos.x - __circumcenter.x) + (vCorner.pos.y - __circumcenter.y)*(vCorner.pos.y - __circumcenter.y);
		var squaredDistance:Float = (vOpposite.pos.x - __circumcenter.x)*(vOpposite.pos.x - __circumcenter.x) + (vOpposite.pos.y - __circumcenter.y)*(vOpposite.pos.y - __circumcenter.y);
		
		return squaredDistance >= squaredRadius;
	}
	
	public static function getCircumcenter(x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, result:Point2D=null):Point2D
	{
		if (result == null)
		{
			result = new Point2D();
		}
		
		// middle points
		var m1:Float = (x1 + x2) / 2;
		var m2:Float = (y1 + y2) / 2;
		var m3:Float = (x1 + x3) / 2;
		var m4:Float = (y1 + y3) / 2;
		/*
		- parametric expression of orthogonal segments
		segOrtho1X(t1) = m1 + t1 * (y2 - y1)
		segOrtho1Y(t1) = m2 - t1 * (x2 - x1)
		
		segOrtho2X(t2) = m3 + t2 * (y3 - y1)
		segOrtho2Y(t2) = m4 - t2 * (x3 - x1)
		
		- the center of circle passing by vLeft, vRight, vCorner will lead to:
		segOrtho1X(t1) = segOrtho2X(t2)
		segOrtho1Y(t1) = segOrtho2Y(t2)
		
		system to solve:
		m1 + t1 (y2 - y1) = m3 + t2 (y3 - y1)
		m2 - t1 (x2 - x1) = m4 - t2 (x3 - x1)
		
		giving to wolfram: Solve[{m1 + t1 (y2 - y1) = m3 + t2 (y3 - y1) , m2 - t1 (x2 - x1) = m4 - t2 (x3 - x1)}, {t1, t2}]
		we get:
		*/
		var t1:Float = (m1*(x1 - x3) + (m2 - m4)*(y1-y3) + m3*(x3 - x1)) / (x1*(y3 - y2) + x2*(y1 - y3) + x3*(y2 - y1));
		
		result.x = m1 + t1 * (y2 - y1);
		result.y = m2 - t1 * (x2 - x1);
		
		return result;
	}
	
	static public function intersections2segments(s1p1x:Float, s1p1y:Float, s1p2x:Float, s1p2y:Float
												, s2p1x:Float, s2p1y:Float, s2p2x:Float, s2p2y:Float
												, posIntersection:Point2D=null, paramIntersection:Array<Float>=null
												, infiniteLineMode:Bool=false):Bool
	{
		var t1:Float = 0;
		var t2:Float = 0;
		
		var result:Bool;
		var divisor:Float = (s1p1x - s1p2x) * (s2p1y - s2p2y) + (s1p2y - s1p1y) * (s2p1x - s2p2x);
		if (divisor == 0)
		{
			result = false; // parallel case, no intersection
		}
		else
		{
			result = true;
			
			if (!infiniteLineMode || posIntersection != null || paramIntersection != null)
			{
				// if we consider edges as finite segments, we must check t1 and t2 values
				t1 = (s1p1x * (s2p1y - s2p2y) + s1p1y * (s2p2x - s2p1x) + s2p1x * s2p2y - s2p1y * s2p2x) / divisor;
				t2 = (s1p1x * (s2p1y - s1p2y) + s1p1y * (s1p2x - s2p1x) - s1p2x * s2p1y + s1p2y * s2p1x) / divisor;
				if (!infiniteLineMode && !(0 <= t1 && t1 <=1 && 0 <= t2 && t2 <=1))
					result = false;
			}
		}
		
		if (result)
		{
			if (posIntersection != null)
			{
				posIntersection.x = s1p1x + t1*(s1p2x - s1p1x);
				posIntersection.y = s1p1y + t1*(s1p2y - s1p1y);
			}
			if (paramIntersection != null)
			{
				paramIntersection.push(t1);
				paramIntersection.push(t2);
			}
		}
		
		return result;
	}
	
	static public function intersections2edges(edge1:Edge, edge2:Edge
												, posIntersection:Point2D=null, paramIntersection:Array<Float>=null
												, infiniteLineMode:Bool=false):Bool
	{
		return intersections2segments(edge1.originVertex.pos.x, edge1.originVertex.pos.y
										, edge1.destinationVertex.pos.x, edge1.destinationVertex.pos.y
										, edge2.originVertex.pos.x, edge2.originVertex.pos.y
										, edge2.destinationVertex.pos.x, edge2.destinationVertex.pos.y
										, posIntersection, paramIntersection, infiniteLineMode);
	}
	
	// a edge is convex if the polygon formed by the 2 faces at left and right of this edge is convex
	static public function isConvex(edge:Edge):Bool
	{
		var result:Bool = true;
		
		var eLeft:Edge;
		var vRight:Vertex;
		
		eLeft = edge.nextLeftEdge.oppositeEdge;
		vRight = edge.nextRightEdge.destinationVertex;
		if (getRelativePosition(vRight.pos.x, vRight.pos.y, eLeft) != -1)
		{
			result = false;
		}
		else
		{
			eLeft = edge.prevRightEdge;
			vRight = edge.prevLeftEdge.originVertex;
			if (getRelativePosition(vRight.pos.x, vRight.pos.y, eLeft) != -1)
			{
				result = false;
			}
		}
			
		return result;
	}
	
	static public function projectOrthogonaly(vertexPos:Point2D, edge:Edge):Void
	{
		// parametric expression of edge
		// x(t1) = edge.originVertex.pos.x + t1*(edge.destinationVertex.pos.x - edge.originVertex.pos.x)
		// y(t1) = edge.originVertex.pos.y + t1*(edge.destinationVertex.pos.y - edge.originVertex.pos.y)
		
		// parametric expression of the segment orthogonal to edge and lying by vertex
		// x(t2) = vertexPos.x + t2*(edge.destinationVertex.pos.y - edge.originVertex.pos.y)
		// y(t2) = vertexPos.y - t2*(edge.destinationVertex.pos.x - edge.originVertex.pos.x)
		
		// the orthogonal projection of vertex on edge will lead to:
		// x(t1) = x(t2)
		// y(t1) = y(t2)
		
		// set alias letters
		var a:Float = edge.originVertex.pos.x;
		var b:Float = edge.originVertex.pos.y;
		var c:Float = edge.destinationVertex.pos.x;
		var d:Float = edge.destinationVertex.pos.y;
		var e:Float = vertexPos.x;
		var f:Float = vertexPos.y;
		
		// system to solve:
		// a + t1 (c - a) = e + t2 (d - b)
		// b + t1 (d - b) = f - t2 (c - a)
		
		// solution:
		var t1:Float = (a*a - a*c - a*e + b*b - b*d - b*f + c*e + d*f) / (a*a - 2*a*c + b*b - 2*b*d + c*c + d*d);

		// set position:
		vertexPos.x = a + t1*(c - a);
		vertexPos.y = b + t1*(d - b);
	}
	
	// fill the result vector with 4 elements, with the form:
	// [intersect0.x, intersect0.y, intersect1.x, intersect1.y]
	// empty if no intersection
	static public function intersections2Circles(cx1:Float, cy1:Float, r1:Float, cx2:Float, cy2:Float, r2:Float, result:Array<Float>=null):Bool
	{
		var distRadiusSQRD:Float =  ((cx2 - cx1)*(cx2 - cx1) + (cy2 - cy1)*(cy2 - cy1));
		
		if ((cx1 != cx2 || cy1 != cy2)
			&& distRadiusSQRD <= ((r1 + r2)*(r1 + r2))
			&& distRadiusSQRD >= ((r1 - r2)*(r1 - r2)))
		{
			var transcendPart:Float = Math.sqrt( ((r1 + r2)*(r1 + r2) - distRadiusSQRD)
				* (distRadiusSQRD - (r2 - r1)*(r2 - r1)) );
			var xFirstPart:Float = (cx1 + cx2) / 2 + (cx2 - cx1)*(r1*r1 - r2*r2) / (2*distRadiusSQRD);
			var yFirstPart:Float = (cy1 + cy2) / 2 + (cy2 - cy1)*(r1*r1 - r2*r2) / (2*distRadiusSQRD);
			var xFactor:Float = (cy2 - cy1) / (2*distRadiusSQRD);
			var yFactor:Float = (cx2 - cx1) / (2*distRadiusSQRD);
			
			if (result != null)
			{
				var values = [xFirstPart + xFactor * transcendPart
							, yFirstPart - yFactor * transcendPart
							, xFirstPart - xFactor * transcendPart
							, yFirstPart + yFactor * transcendPart];
				
				for (f in values) result.push(f);
			}
			
			return true;
		}
		else
			return false;
	}
	
	public static function intersectionsSegmentCircle(p0x:Float, p0y:Float
													, p1x:Float, p1y:Float
													, cx:Float, cy:Float, r:Float
													, result:Array<Float>=null):Bool
	{
		
		var p0xSQD:Float = p0x*p0x;
		var p0ySQD:Float = p0y*p0y;
		var a:Float = p1y*p1y - 2*p1y*p0y + p0ySQD + p1x*p1x - 2*p1x*p0x + p0xSQD;
		var b:Float = 2*p0y*cy - 2*p0xSQD + 2*p1y*p0y - 2*p0ySQD + 2*p1x*p0x - 2*p1x*cx + 2*p0x*cx - 2*p1y*cy;
		var c:Float = p0ySQD + cy*cy + cx*cx - 2*p0y*cy - 2*p0x*cx + p0xSQD - r*r;
		var delta:Float = b*b - 4*a*c;
		var deltaSQRT:Float;
		
		var t0:Float;
		var t1:Float;
		if (delta < 0)
		{
			// no solution
			return false;
		}
		else if (delta == 0)
		{
			// unique solution
			t0 = - b / (2 * a);
			if (t0 < 0 || t0 > 1)
				return false;
			// we return a 3 elements array, under the form:
			//  [intersect0.x, intersect0.y, t0]
			if (result != null) {
				for (f in [p0x + t0 * (p1x - p0x), p0y + t0 * (p1y - p0y),  t0]) 
					result.push(f);
			}
			
			return true;
		}
		else // (delta > 0)
		{
			deltaSQRT = Math.sqrt(delta);
			t0 = (- b + deltaSQRT) / (2 * a);
			t1 = (- b - deltaSQRT) / (2 * a);
			// we return a n elements array, under the form:
			//  [intersect0.x, intersect0.y, t0
			//	, intersect1.x, intersect1.y, t1]
			var intersecting:Bool = false;
			if (0 <= t0 && t0 <= 1)
			{
				if (result != null) {
					for (f in [p0x + t0 * (p1x - p0x), p0y + t0 * (p1y - p0y), t0])
						result.push(f);
				}
				intersecting = true;
			}
			if (0 <= t1 && t1 <= 1)
			{
				if (result != null) {
					for (f in [p0x + t1 * (p1x - p0x), p0y + t1 * (p1y - p0y), t1])
						result.push(f);
				}
				intersecting = true;
			}
			
			return intersecting;
		}
	}
	
	public static function intersectionsLineCircle(p0x:Float, p0y:Float
												, p1x:Float, p1y:Float
												, cx:Float, cy:Float, r:Float
												, result:Array<Float>):Bool
	{
		var p0xSQD:Float = p0x*p0x;
		var p0ySQD:Float = p0y*p0y;
		var a:Float = p1y*p1y - 2*p1y*p0y + p0ySQD + p1x*p1x - 2*p1x*p0x + p0xSQD;
		var b:Float = 2*p0y*cy - 2*p0xSQD + 2*p1y*p0y - 2*p0ySQD + 2*p1x*p0x - 2*p1x*cx + 2*p0x*cx - 2*p1y*cy;
		var c:Float = p0ySQD + cy*cy + cx*cx - 2*p0y*cy - 2*p0x*cx + p0xSQD - r*r;
		var delta:Float = b*b - 4*a*c;
		var deltaSQRT:Float;
		
		var t0:Float;
		var t1:Float;
		if (delta < 0)
		{
			// no solution
			return false;
		}
		else if (delta == 0)
		{
			// unique solution
			t0 = - b / (2 * a);
			// we return a 3 elements array, under the form:
			//  [intersect0.x, intersect0.y, t0]
			for (f in [p0x + t0 * (p1x - p0x), p0y + t0 * (p1y - p0y),  t0])
				result.push(f);
		}
		else if (delta > 0)
		{
			deltaSQRT = Math.sqrt(delta);
			t0 = (- b + deltaSQRT) / (2 * a);
			t1 = (- b - deltaSQRT) / (2 * a);
			// we return a 6 elements array, under the form:
			//  [intersect0.x, intersect0.y, t0
			//	, intersect1.x, intersect1.y, t1]
			for (f in [p0x + t0*(p1x - p0x), p0y + t0*(p1y - p0y), t0, p0x + t1*(p1x - p0x), p0y + t1*(p1y - p0y), t1])
				result.push(f);
		}
		
		return true;
	}
	
	// based on intersections2Circles method
	// fill the result vector with 4 elements, with the form:
	// [point_tangent1.x, point_tangent1.y, point_tangent2.x, point_tangent2.y]
	// empty if no tangent
	static public function tangentsPointToCircle(px:Float, py:Float, cx:Float, cy:Float, r:Float, result:Array<Float>):Void
	{
		var c2x:Float = (px + cx)/2;
		var c2y:Float = (py + cy)/2;
		var r2:Float = 0.5*Math.sqrt((px-cx)*(px-cx) + (py-cy)*(py-cy));
		
		intersections2Circles(c2x, c2y, r2, cx, cy, r, result);
	}
	
	// <!!!> CIRCLES MUST HAVE SAME RADIUS
	static public function tangentsCrossCircleToCircle(r:Float, c1x:Float, c1y:Float, c2x:Float, c2y:Float, result:Array<Float>):Bool
	{
		var distance:Float = Math.sqrt((c1x-c2x)*(c1x-c2x) + (c1y-c2y)*(c1y-c2y));
		
		// new circle
		var radius:Float = distance / 4;
		var centerX:Float = c1x + (c2x - c1x)/4;
		var centerY:Float = c1y + (c2y - c1y)/4;
		
		if (intersections2Circles(c1x, c1y, r, centerX, centerY, radius, result))
		{
			var t1x:Float = result[0];
			var t1y:Float = result[1];
			var t2x:Float = result[2];
			var t2y:Float = result[3];
			
			var midX:Float = (c1x + c2x)/2;
			var midY:Float = (c1y + c2y)/2;
			var dotProd:Float = (t1x - midX)*(c2y - c1y) + (t1y - midY)*(- c2x + c1x);
			var tproj:Float = dotProd / (distance*distance);
			var projx:Float = midX + tproj*(c2y - c1y);
			var projy:Float = midY - tproj*(c2x - c1x);
			
			
			var t4x:Float = 2*projx - t1x;
			var t4y:Float = 2*projy - t1y;
			
			var t3x:Float = t4x + t2x - t1x;
			var t3y:Float = t2y + t4y - t1y;
			
			for (f in [t3x, t3y, t4x, t4y])
				result.push(f);
			
			return true;
		}
		else
		{
			// no tangent because cicles are intersecting
			return false;
		}
	}
	
	// <!!!> CIRCLES MUST HAVE SAME RADIUS
	static public function tangentsParalCircleToCircle(r:Float, c1x:Float, c1y:Float, c2x:Float, c2y:Float, result:Array<Float>):Void
	{
		var distance:Float = Math.sqrt((c1x-c2x)*(c1x-c2x) + (c1y-c2y)*(c1y-c2y));
		var t1x:Float = c1x + r * (c2y - c1y) / distance;
		var t1y:Float = c1y + r * (- c2x + c1x) / distance;
		var t2x:Float = 2*c1x - t1x;
		var t2y:Float = 2*c1y - t1y;
		var t3x:Float = t2x + c2x - c1x;
		var t3y:Float = t2y + c2y - c1y;
		var t4x:Float = t1x + c2x - c1x;
		var t4y:Float = t1y + c2y - c1y;
		
		for (f in [t1x, t1y, t2x, t2y, t3x, t3y, t4x, t4y])
			result.push(f);
	}
	
	// squared distance from point p to infinite line (a, b)
	static public function distanceSquaredPointToLine(px:Float, py:Float, ax:Float, ay:Float, bx:Float, by:Float):Float
	{
		var a_b_squaredLength:Float = (bx - ax)*(bx - ax) + (by - ay)*(by - ay);
		var dotProduct:Float = (px - ax)*(bx - ax) + (py - ay)*(by - ay);
		var p_a_squaredLength:Float = (ax - px)*(ax - px) + (ay - py)*(ay - py);
		return p_a_squaredLength - dotProduct * dotProduct / a_b_squaredLength;
	}
	
	// squared distance from point p to finite segment [a, b]
	static public function distanceSquaredPointToSegment(px:Float, py:Float, ax:Float, ay:Float, bx:Float, by:Float):Float
	{
		var a_b_squaredLength:Float = (bx - ax)*(bx - ax) + (by - ay)*(by - ay);
		var dotProduct:Float = ((px - ax)*(bx - ax) + (py - ay)*(by - ay)) / a_b_squaredLength;
		if (dotProduct < 0)
		{
			return (px - ax)*(px - ax) + (py - ay)*(py - ay);
		}
		else if (dotProduct <= 1)
		{
			var p_a_squaredLength:Float = (ax - px)*(ax - px) + (ay - py)*(ay - py);
			return p_a_squaredLength - dotProduct * dotProduct * a_b_squaredLength;
		}
		else
		{
			return (px - bx)*(px - bx) + (py - by)*(py - by);
		}
	}
	
	static public function distanceSquaredVertexToEdge(vertex:Vertex, edge:Edge):Float
	{
		return distanceSquaredPointToSegment(vertex.pos.x, vertex.pos.y
											, edge.originVertex.pos.x, edge.originVertex.pos.y
											, edge.destinationVertex.pos.x, edge.destinationVertex.pos.y);
	}
	
	static public function pathLength(path:Array<Float>):Float
	{
		var sumDistance:Float = 0;
		var fromX:Float = path[0];
		var fromY:Float = path[1];
		var nextX:Float;
		var nextY:Float;
		var x:Float;
		var y:Float;
		var distance:Float;
		var i:Int = 2;
		while (i < path.length)
		{
			nextX = path[i];
			nextY = path[i+1];
			x = nextX - fromX;
			y = nextY - fromY;
			distance = Math.sqrt(x*x + y*y);
			sumDistance += distance;
			fromX = nextX;
			fromY = nextY;
			i += 2;
		}
		
		return sumDistance;
	}
	
}
