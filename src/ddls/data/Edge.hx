package ddls.data;

class Edge
{
	
	private static var INC:Int = 0;
	private var _id:Int;
	
	// root datas
	private var _isReal:Bool;
	private var _isConstrained:Bool;
	private var _originVertex:Vertex;
	private var _oppositeEdge:Edge;
	private var _nextLeftEdge:Edge;
	private var _leftFace:Face;
	
	private var _fromConstraintSegments:Array<ConstraintSegment>;
	
	public var colorDebug:Int = -1;
	
	public function new()
	{
		_id = INC;
		INC++;
		
		_fromConstraintSegments = new Array<ConstraintSegment>();
	}
	
	public var id(get, never):Int;
	private function get_id():Int { return _id; }
	
	public var isReal(get, never):Bool;
	private function get_isReal():Bool { return _isReal; }
	
	public function setDatas(originVertex:Vertex
							, oppositeEdge:Edge
							, nextLeftEdge:Edge
							, leftFace:Face
							, isReal:Bool=true
							, isConstrained:Bool=false):Void
	{
		_isConstrained = isConstrained;
		_isReal = isReal;
		_originVertex = originVertex;
		_oppositeEdge = oppositeEdge;
		_nextLeftEdge = nextLeftEdge;
		_leftFace = leftFace;
	}
	
	public function addFromConstraintSegment(segment:ConstraintSegment):Void
	{
		if (_fromConstraintSegments.indexOf(segment) == -1)
			_fromConstraintSegments.push(segment);
	}
	
	public function removeFromConstraintSegment(segment:ConstraintSegment):Void
	{
		var index:Int = _fromConstraintSegments.indexOf(segment);
		if (index != -1)
			_fromConstraintSegments.splice(index, 1);
	}
	
	public var isConstrained(get, set):Bool;
	private function get_isConstrained():Bool { return _isConstrained; }
	private function set_isConstrained(value:Bool):Bool { return _isConstrained = value; }
	
	public var fromConstraintSegments(get, set):Array<ConstraintSegment>;
	private function get_fromConstraintSegments():Array<ConstraintSegment> { return _fromConstraintSegments; }
	private function set_fromConstraintSegments(value:Array<ConstraintSegment>) { return _fromConstraintSegments = value; }
	
	public var originVertex(get, set):Vertex;
	private function get_originVertex():Vertex { return _originVertex; }
	private function set_originVertex(value:Vertex):Vertex { return _originVertex = value; }
	
	public var nextLeftEdge(get, set):Edge;
	private function get_nextLeftEdge():Edge { return _nextLeftEdge; }
	private function set_nextLeftEdge(value:Edge):Edge { return _nextLeftEdge = value; }
	
	
	public var destinationVertex(get, never):Vertex;
	private function get_destinationVertex():Vertex		{	return _oppositeEdge.originVertex;								}
	
	public var oppositeEdge(get, never)		:Edge;
	private function get_oppositeEdge()		:Edge		{	return _oppositeEdge;											}
	
	public var prevLeftEdge(get, never)		:Edge;
	private function get_prevLeftEdge()		:Edge		{	return _nextLeftEdge.nextLeftEdge;								}
	
	public var nextRightEdge(get, never)	:Edge;
	private function get_nextRightEdge()	:Edge		{	return _oppositeEdge.nextLeftEdge.nextLeftEdge.oppositeEdge;	}
	
	public var prevRightEdge(get, never)	:Edge;
	private function get_prevRightEdge()	:Edge		{	return _oppositeEdge.nextLeftEdge.oppositeEdge;					}

	public var rotLeftEdge(get, never)		:Edge;
	private function get_rotLeftEdge()		:Edge		{	return _nextLeftEdge.nextLeftEdge.oppositeEdge;					}

	public var rotRightEdge(get, never)		:Edge;
	private function get_rotRightEdge()		:Edge		{	return _oppositeEdge.nextLeftEdge;								}
	
	public var leftFace(get, set):Face;
	private function get_leftFace():Face { return _leftFace; }
	private function set_leftFace(value:Face):Face { return _leftFace = value;	}

	public var rightFace(get, never)		:Face;
	private function get_rightFace()		:Face		{	return _oppositeEdge.leftFace;									}
	
	
	public function dispose():Void
	{
		_originVertex = null;
		_oppositeEdge = null;
		_nextLeftEdge = null;
		_leftFace = null;
		_fromConstraintSegments = null;
	}
	
	public function toString():String
	{
		return "edge " + originVertex.id + " - " + destinationVertex.id;
	}
	
	
}