package ddls.data;

class ConstraintShape
{
	
	private static var INC:Int = 0;
	private var _id:Int;
	
	private var _segments:Array<ConstraintSegment>;
	
	public function new()
	{
		_id = INC;
		INC++;
		
		_segments = new Array<ConstraintSegment>();
	}
	
	public var id(get, never):Int;
	private function get_id():Int { return _id; }
	
	public var segments(get, never):Array<ConstraintSegment>;
	private function get_segments():Array<ConstraintSegment> { return _segments; }
	
	public function dispose():Void
	{
		while (_segments.length > 0)
			_segments.pop().dispose();
		_segments = null;
	}

}