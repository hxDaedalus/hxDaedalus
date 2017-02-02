package hxDaedalus.data;
import hxDaedalus.data.math.Point2D;

@:expose
class Vertex
{
    public var id(get, never) : Int;
    public var isReal(get, never) : Bool;
    public var pos(get, never) : Point2D;
    public var fromConstraintSegments(get, set) : Array<ConstraintSegment>;
    public var edge(get, set) : Edge;

    
     static var INC : Int = 0;
     var _id : Int;
    
     var _pos : Point2D;
    
     var _isReal : Bool;
     var _edge : Edge;
    
     var _fromConstraintSegments : Array<ConstraintSegment>;
    
    public var colorDebug : Int = -1;
    
    public function new()
    {
        _id = INC;
        INC++;
        
        _pos = new Point2D();
        
        _fromConstraintSegments = new Array<ConstraintSegment>();
    }
    
     function get_id() : Int
    {
        return _id;
    }
    
     function get_isReal() : Bool
    {
        return _isReal;
    }
    
     function get_pos() : Point2D
    {
        return _pos;
    }
    
     function get_fromConstraintSegments():Array<ConstraintSegment>{
        return _fromConstraintSegments;
    }
    
     function set_fromConstraintSegments(value:Array<ConstraintSegment>):Array<ConstraintSegment> {
        return _fromConstraintSegments = value;
    }
    
    public function setDatas(edge : Edge, isReal : Bool = true) : Void
    {
        _isReal = isReal;
        _edge = edge;
    }
    
    public function addFromConstraintSegment(segment : ConstraintSegment): Void {
        if (_fromConstraintSegments.indexOf(segment) == -1) _fromConstraintSegments.push(segment);
    }
    
    public function removeFromConstraintSegment(segment : ConstraintSegment) : Void
    {
        var index : Int = _fromConstraintSegments.indexOf(segment);
        if (index != -1) 
            _fromConstraintSegments.splice(index, 1);
    }
    
    public function dispose() : Void
    {
        _pos = null;
        _edge = null;
        _fromConstraintSegments = null;
    }
    
     function get_edge():Edge {
        return _edge;
    }
    
     function set_edge(value:Edge):Edge {
        return _edge = value;
    }

    public function toString(): String {
        return "ver_id " + _id;
    }
}
