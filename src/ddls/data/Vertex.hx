package ddls.data;

import ddls.data.math.Point2D;

class Vertex
{
	
	private static var INC:Int = 0;
	private var _id:Int;
	
	private var _pos:Point2D;
	
	private var _isReal:Bool;
	private var _edge:Edge;
	
	private var _fromConstraintSegments:Array<ConstraintSegment>;
	
	public var colorDebug:Int = - 1;
	
	public function new()
	{
		_id = INC;
		INC++;
		
		_pos = new Point2D();
		
		_fromConstraintSegments = new Array<ConstraintSegment>();
	}
	
	public var id(get, never):Int;
	private function get_id():Int { return _id; }
	
	public var isReal(get, never):Bool;
	private function get_isReal():Bool { return _isReal; }
	
	public var pos(get, never):Point2D;
	private function get_pos():Point2D { return _pos; }
	
	public var fromConstraintSegments(get, set):Array<ConstraintSegment>;
	private function get_fromConstraintSegments():Array<ConstraintSegment> { return _fromConstraintSegments; }
	private function set_fromConstraintSegments(value:Array<ConstraintSegment>) { return _fromConstraintSegments = value; }
	
	public function setDatas(edge:Edge, isReal:Bool=true):Void
	{
		_isReal = isReal;
		_edge = edge;
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
	
	public function dispose():Void
	{
		_pos = null;
		_edge = null;
		_fromConstraintSegments = null;
	}
	
	public var edge(get, set):Edge;
	private function get_edge():Edge { return _edge; }
	private function set_edge(value:Edge):Edge { return _edge = value; }
	
	public function toString():String
	{
		return "ver_id " + _id;
	}
	
}