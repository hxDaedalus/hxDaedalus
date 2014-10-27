package ddls.ai;

import ddls.data.Edge;
import ddls.data.Face;
import ddls.data.Mesh;
import ddls.data.Vertex;
import ddls.data.math.Geom2D;
import ddls.data.math.Point2D;
import ddls.iterators.FromFaceToInnerEdges;


class AStar
{
	
	private var _mesh:Mesh;
	
	
	private var __closedFaces:Map<Face, Bool>;
	private var __sortedOpenedFaces:Array<Face>;
	private var __openedFaces:Map<Face, Bool>;
	private var __entryEdges:Map<Face, Edge>;
	private var __entryX:Map<Face, Float>;
	private var __entryY:Map<Face, Float>;
	private var __scoreF:Map<Face, Float>;
	private var __scoreG:Map<Face, Float>;
	private var __scoreH:Map<Face, Float>;
	private var __predecessor:Map<Face, Face>;
	
	private var __iterEdge:FromFaceToInnerEdges;
	
	private var _radius:Float;
	private var _radiusSquared:Float;
	private var _diameter:Float;
	private var _diameterSquared:Float;
	
	public function new()
	{
		__iterEdge = new FromFaceToInnerEdges();
	}
	
	public function dispose():Void
	{
		_mesh = null;
		
		 __closedFaces = null;
		__sortedOpenedFaces = null;
		__openedFaces = null;
		__entryEdges = null;
		__entryX = null;
		__entryY = null;
		__scoreF = null;
		__scoreG = null;
		__scoreH = null;
		__predecessor = null;
	}
	
	public var radius(get, set):Float;
	private function get_radius():Float { return _radius; }
	private function set_radius(value:Float):Float
	{
		_radius = value;
		_radiusSquared = _radius*_radius;
		_diameter = _radius*2;
		_diameterSquared = _diameter * _diameter;
		return _radius;
	}

	public var mesh(never, set):Mesh;
	private function set_mesh(value:Mesh):Mesh { return _mesh = value; }
	
	private var __fromFace:Face;
	private var __toFace:Face;
	private var __curFace:Face;
	public function findPath(fromX:Float, fromY:Float, toX:Float, toY:Float
							, resultListFaces:Array<Face>
							, resultListEdges:Array<Edge>):Void
	{
		//trace("findPath");
		__closedFaces = new Map();
		__sortedOpenedFaces = new Array<Face>();
		__openedFaces = new Map();
		__entryEdges = new Map();
		__entryX = new Map();
		__entryY = new Map();
		__scoreF = new Map();
		__scoreG = new Map();
		__scoreH = new Map();
		__predecessor = new Map();
		
		var loc:Dynamic;
		var locEdge:Edge;
		var locVertex:Vertex;
		var distance:Float;
		var p1:Point2D;
		var p2:Point2D;
		var p3:Point2D;
		//
		loc = Geom2D.locatePosition(fromX, fromY, _mesh);
		//TODO: check if must also check for null
		if (Std.is(loc, Vertex))
		{
			// vertex are always in constraint, so we abort
			locVertex = cast loc;
			return;
		}
		else if (Std.is(loc, Edge))
		{
			// if the vertex lies on a constrained edge, we abort
			locEdge = cast loc;
			if (locEdge.isConstrained)
				return;
			
			__fromFace = locEdge.leftFace;
		}
		else
		{
			__fromFace = cast loc;
		}
		//
		loc = Geom2D.locatePosition(toX, toY, _mesh);
		if (Std.is(loc, Vertex)) {
			locVertex = cast loc;
			__toFace = locVertex.edge.leftFace;
		} else if (Std.is(loc, Edge)) {
			locEdge = cast loc;
			__toFace = locEdge.leftFace;
		} else {
			__toFace = cast loc;
		}
		
		/*__fromFace.colorDebug = 0xFF0000;
		__toFace.colorDebug = 0xFF0000;
		trace("from face:", __fromFace);
		trace("to face:", __toFace);*/
		
		__sortedOpenedFaces.push(__fromFace);
		__entryEdges[__fromFace] = null;
		__entryX[__fromFace] = fromX;
		__entryY[__fromFace] = fromY;
		__scoreG[__fromFace] = 0;
		__scoreH[__fromFace] = Math.sqrt((toX - fromX)*(toX - fromX) + (toY - fromY)*(toY - fromY));
		__scoreF[__fromFace] = __scoreH[__fromFace] + __scoreG[__fromFace];
		
		var innerEdge:Edge;
		var neighbourFace:Face;
		var f:Float;
		var g:Float;
		var h:Float;
		var fromPoint:Point2D = new Point2D();
		var entryPoint:Point2D = new Point2D();
		var distancePoint:Point2D = new Point2D();
		var fillDatas:Bool;
		while (true)
		{
			// no path found
			if (__sortedOpenedFaces.length == 0)
			{
				trace("AStar no path found");
				__curFace = null;
				break;
			}
			
			// we reached the target face
			__curFace = __sortedOpenedFaces.pop();
			if (__curFace == __toFace)
			{
				break;
			}
			
			// we continue the search
			__iterEdge.fromFace = __curFace;
			while ((innerEdge = __iterEdge.next()) != null)
			{
				if (innerEdge.isConstrained)
					continue;
				
				neighbourFace = innerEdge.rightFace;
				if (!__closedFaces[neighbourFace])
				{
					if (__curFace != __fromFace && _radius > 0 && !isWalkableByRadius(__entryEdges[__curFace], __curFace, innerEdge))
					{
//							trace("- NOT WALKABLE -");
//							trace("from", Edge(__entryEdges[__curFace]).originVertex.id, Edge(__entryEdges[__curFace]).destinationVertex.id);
//							trace("to", innerEdge.originVertex.id, innerEdge.destinationVertex.id);
//							trace("----------------");
						continue;
					}
					
					fromPoint.x = __entryX[__curFace];
					fromPoint.y = __entryY[__curFace];
					entryPoint.x = fromPoint.x;
					entryPoint.y = fromPoint.y;
					entryPoint.x = (innerEdge.originVertex.pos.x + innerEdge.destinationVertex.pos.x) /2;
					entryPoint.x = (innerEdge.originVertex.pos.y + innerEdge.destinationVertex.pos.y) /2;
					distancePoint.x = entryPoint.x - toX;
					distancePoint.y = entryPoint.y - toY;
					h = distancePoint.length;
					distancePoint.x = fromPoint.x - entryPoint.x;
					distancePoint.y = fromPoint.y - entryPoint.y;
					g = __scoreG[__curFace] + distancePoint.length;
					f = h + g;
					fillDatas = false;
					if (__openedFaces[neighbourFace] == null || !__openedFaces[neighbourFace])
					{
						__sortedOpenedFaces.push(neighbourFace);
						__openedFaces[neighbourFace] = true;
						fillDatas = true;
					}
					else if (__scoreF[neighbourFace] > f)
					{
						fillDatas = true;
					}
					if (fillDatas)
					{
						__entryEdges[neighbourFace] = innerEdge;
						__entryX[neighbourFace] = entryPoint.x;
						__entryY[neighbourFace] = entryPoint.y;
						__scoreF[neighbourFace] = f;
						__scoreG[neighbourFace] = g;
						__scoreH[neighbourFace] = h;
						__predecessor[neighbourFace] = __curFace;
					}
				}
			}
			//
			__openedFaces[__curFace] = false;
			__closedFaces[__curFace] = true;
			__sortedOpenedFaces.sort(sortingFaces);
		}
		
		// if we didn't find a path
		if (__curFace == null)
			return;
		
		// else we build the path
		resultListFaces.push(__curFace);
		//__curFace.colorDebug = 0x0000FF;
		while (__curFace != __fromFace)
		{
			resultListEdges.unshift(__entryEdges[__curFace]);
			//__entryEdges[__curFace].colorDebug = 0xFFFF00;
			//__entryEdges[__curFace].oppositeEdge.colorDebug = 0xFFFF00;
			__curFace = __predecessor[__curFace];
			//__curFace.colorDebug = 0x0000FF;
			resultListFaces.unshift(__curFace);
		}
	}
	
	// faces with low distance value are at the end of the array
	private function sortingFaces(a:Face, b:Face):Int
	{
		if (__scoreF[a] == __scoreF[b])
			return 0;
		else if (__scoreF[a] < __scoreF[b])
			return 1;
		else
			return -1;
	}
	
	private function isWalkableByRadius(fromEdge:Edge, throughFace:Face, toEdge:Edge):Bool
	{
		var vA:Vertex = null; // the vertex on fromEdge not on toEdge
		var vB:Vertex = null; // the vertex on toEdge not on fromEdge
		var vC:Vertex = null; // the common vertex of the 2 edges (pivot)
		
		// we identify the points
		if (fromEdge.originVertex == toEdge.originVertex)
		{
			vA = fromEdge.destinationVertex;
			vB = toEdge.destinationVertex;
			vC = fromEdge.originVertex;
		}
		else if (fromEdge.destinationVertex == toEdge.destinationVertex)
		{
			vA = fromEdge.originVertex;
			vB = toEdge.originVertex;
			vC = fromEdge.destinationVertex;
		}
		else if (fromEdge.originVertex == toEdge.destinationVertex)
		{
			vA = fromEdge.destinationVertex;
			vB = toEdge.originVertex;
			vC = fromEdge.originVertex;
		}
		else if (fromEdge.destinationVertex == toEdge.originVertex)
		{
			vA = fromEdge.originVertex;
			vB = toEdge.destinationVertex;
			vC = fromEdge.destinationVertex;
		}
		
		var dot:Float;
		var result:Bool;
		var distSquared:Float;
		
		// if we have a right or obtuse angle on CAB
		dot = (vC.pos.x - vA.pos.x)*(vB.pos.x - vA.pos.x) + (vC.pos.y - vA.pos.y)*(vB.pos.y - vA.pos.y);
		if (dot <= 0)
		{
			// we compare length of AC with radius
			distSquared = (vC.pos.x - vA.pos.x)*(vC.pos.x - vA.pos.x) + (vC.pos.y - vA.pos.y)*(vC.pos.y - vA.pos.y);
			if (distSquared >= _diameterSquared)
				return true;
			else
				return false;
		}
		
		// if we have a right or obtuse angle on CBA
		dot = (vC.pos.x - vB.pos.x)*(vA.pos.x - vB.pos.x) + (vC.pos.y - vB.pos.y)*(vA.pos.y - vB.pos.y);
		if (dot <= 0)
		{
			// we compare length of BC with radius
			distSquared = (vC.pos.x - vB.pos.x)*(vC.pos.x - vB.pos.x) + (vC.pos.y - vB.pos.y)*(vC.pos.y - vB.pos.y);
			if (distSquared >= _diameterSquared)
				return true;
			else
				return false;
		}
		
		// we identify the adjacent edge (facing pivot vertex)
		var adjEdge:Edge;
		if (throughFace.edge != fromEdge && throughFace.edge.oppositeEdge != fromEdge
			&& throughFace.edge != toEdge && throughFace.edge.oppositeEdge != toEdge)
			adjEdge = throughFace.edge;
		else if (throughFace.edge.nextLeftEdge != fromEdge && throughFace.edge.nextLeftEdge.oppositeEdge != fromEdge
				&& throughFace.edge.nextLeftEdge != toEdge && throughFace.edge.nextLeftEdge.oppositeEdge != toEdge)
			adjEdge = throughFace.edge.nextLeftEdge;
		else
			adjEdge = throughFace.edge.prevLeftEdge;
		
		// if the adjacent edge is constrained, we check the distance of orthognaly projected
		if (adjEdge.isConstrained)
		{
			var proj:Point2D = new Point2D(vC.pos.x, vC.pos.y);
			Geom2D.projectOrthogonaly(proj, adjEdge);
			distSquared = (proj.x - vC.pos.x)*(proj.x - vC.pos.x) + (proj.y - vC.pos.y)*(proj.y - vC.pos.y);
			if (distSquared >= _diameterSquared)
				return true;
			else
				return false;
		}
		else // if the adjacent is not constrained
		{
			var distSquaredA:Float = (vC.pos.x - vA.pos.x)*(vC.pos.x - vA.pos.x) + (vC.pos.y - vA.pos.y)*(vC.pos.y - vA.pos.y);
			var distSquaredB:Float = (vC.pos.x - vB.pos.x)*(vC.pos.x - vB.pos.x) + (vC.pos.y - vB.pos.y)*(vC.pos.y - vB.pos.y);
			if (distSquaredA < _diameterSquared || distSquaredB < _diameterSquared)
			{
				return false;
			}
			else
			{
				var vFaceToCheck:Array<Face> = new Array<Face>();
				var vFaceIsFromEdge:Array<Edge> = new Array<Edge>();
				var facesDone:Map<Face, Bool> = new Map();
				vFaceIsFromEdge.push(adjEdge);
				if (adjEdge.leftFace == throughFace)
				{
					vFaceToCheck.push(adjEdge.rightFace);
					facesDone[adjEdge.rightFace] = true;
				}
				else
				{
					vFaceToCheck.push(adjEdge.leftFace);
					facesDone[adjEdge.leftFace] = true;
				}
				
				var currFace:Face;
				var faceFromEdge:Edge;
				var currEdgeA:Edge;
				var nextFaceA:Face;
				var currEdgeB:Edge;
				var nextFaceB:Face;
				while (vFaceToCheck.length > 0)
				{
					currFace = vFaceToCheck.shift();
					faceFromEdge = vFaceIsFromEdge.shift();
					
					// we identify the 2 edges to evaluate
					if (currFace.edge == faceFromEdge || currFace.edge == faceFromEdge.oppositeEdge)
					{
						currEdgeA = currFace.edge.nextLeftEdge;
						currEdgeB = currFace.edge.nextLeftEdge.nextLeftEdge;
					}
					else if (currFace.edge.nextLeftEdge == faceFromEdge || currFace.edge.nextLeftEdge == faceFromEdge.oppositeEdge)
					{
						currEdgeA = currFace.edge;
						currEdgeB = currFace.edge.nextLeftEdge.nextLeftEdge;
					}
					else
					{
						currEdgeA = currFace.edge;
						currEdgeB = currFace.edge.nextLeftEdge;
					}
					
					// we identify the faces related to the 2 edges
					if (currEdgeA.leftFace == currFace)
						nextFaceA = currEdgeA.rightFace;
					else
						nextFaceA = currEdgeA.leftFace;
					if (currEdgeB.leftFace == currFace)
						nextFaceB = currEdgeB.rightFace;
					else
						nextFaceB = currEdgeB.leftFace;
						
					// we check if the next face is not already in pipe
					// and if the edge A is close to pivot vertex
					if (!facesDone[nextFaceA] && Geom2D.distanceSquaredVertexToEdge(vC, currEdgeA) < _diameterSquared)
					{
						// if the edge is constrained
						if (currEdgeA.isConstrained)
						{
							// so it is not walkable
							return false;
						}
						else
						{
							// if the edge is not constrained, we continue the search
							vFaceToCheck.push(nextFaceA);
							vFaceIsFromEdge.push(currEdgeA);
							facesDone[nextFaceA] = true;
						}
					}
					
					// we check if the next face is not already in pipe
					// and if the edge B is close to pivot vertex
					if (!facesDone[nextFaceB] && Geom2D.distanceSquaredVertexToEdge(vC, currEdgeB) < _diameterSquared)
					{
						// if the edge is constrained
						if (currEdgeB.isConstrained)
						{
							// so it is not walkable
							return false;
						}
						else
						{
							// if the edge is not constrained, we continue the search
							vFaceToCheck.push(nextFaceB);
							vFaceIsFromEdge.push(currEdgeB);
							facesDone[nextFaceB] = true;
						}
					}
				}
				
				// if we didn't previously meet a constrained edge
				return true;
			}
		}
		
		return true;
	}
	
	
}