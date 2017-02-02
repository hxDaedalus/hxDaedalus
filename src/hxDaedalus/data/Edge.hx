package hxDaedalus.data;
import hxDaedalus.data.Face;
import hxDaedalus.data.Vertex;

@:expose
class Edge
{
    public var id(get, never) : Int;
    public var isReal(get, never) : Bool;
    public var isConstrained(get, set) : Bool;
    public var originVertex(get, set) : Vertex;
    public var nextLeftEdge(get, set) : Edge;
    public var leftFace(get, set) : Face;
    public var fromConstraintSegments: Array<ConstraintSegment>;
    public var destinationVertex(get, never) : Vertex;
    public var oppositeEdge(get, never) : Edge;
    public var prevLeftEdge(get, never) : Edge;
    public var nextRightEdge(get, never) : Edge;
    public var prevRightEdge(get, never) : Edge;
    public var rotLeftEdge(get, never) : Edge;
    public var rotRightEdge(get, never) : Edge;
    public var rightFace(get, never) : Face;

    
     static var INC : Int = 0;
     var _id : Int;
    
    // root datas
     var _isReal : Bool;
     var _isConstrained : Bool;
     var _originVertex : Vertex;
     var _oppositeEdge : Edge;
     var _nextLeftEdge : Edge;
     var _leftFace : Face;
    
    public var colorDebug : Int = -1;
    
    public function new(){
        _id = INC;
        INC++;
        fromConstraintSegments = new Array<ConstraintSegment>();
    }
    
     function get_id(): Int {
        return _id;
    }
    
     function get_isReal(): Bool {
        return _isReal;
    }
    
     function get_isConstrained(): Bool {
        return _isConstrained;
    }
    
    public function setDatas( originVertex :    Vertex
                            , oppositeEdge :    Edge
                            , nextLeftEdge :    Edge
                            , leftFace :        Face
                            , isReal :          Bool = true
                            , isConstrained :   Bool = false
                            ): Void
    {
        _isConstrained = isConstrained;
        _isReal = isReal;
        _originVertex = originVertex;
        _oppositeEdge = oppositeEdge;
        _nextLeftEdge = nextLeftEdge;
        _leftFace = leftFace;
    }
    
    public function addFromConstraintSegment( segment: ConstraintSegment ): Void {
        if( fromConstraintSegments.indexOf( segment ) == -1 ) fromConstraintSegments.push( segment );
    }
    
    public function removeFromConstraintSegment( segment: ConstraintSegment ): Void {
        var index : Int = fromConstraintSegments.indexOf( segment );
        if( index != -1 ) fromConstraintSegments.splice(index, 1);
    }
    
     function set_originVertex( value: Vertex ): Vertex {
        _originVertex = value;
        return value;
    }
    
     function set_nextLeftEdge( value: Edge ): Edge {
        _nextLeftEdge = value;
        return value;
    }
    
     function set_leftFace( value: Face ): Face {
        _leftFace = value;
        return value;
    }
    
     function set_isConstrained( value: Bool ) : Bool {
        _isConstrained = value;
        return value;
    }
    
    public function dispose() : Void
    {
        _originVertex = null;
        _oppositeEdge = null;
        _nextLeftEdge = null;
        _leftFace = null;
        fromConstraintSegments = null;
    }
    
     function get_originVertex() : Vertex{return _originVertex;
    }
     function get_destinationVertex() : Vertex{return oppositeEdge.originVertex;
    }

     function get_oppositeEdge() : Edge{return _oppositeEdge;
    }
     function get_nextLeftEdge() : Edge{return _nextLeftEdge;
    }
     function get_prevLeftEdge() : Edge{return _nextLeftEdge.nextLeftEdge;
    }
     function get_nextRightEdge() : Edge{return _oppositeEdge.nextLeftEdge.nextLeftEdge.oppositeEdge;
    }
     function get_prevRightEdge() : Edge{return _oppositeEdge.nextLeftEdge.oppositeEdge;
    }
     function get_rotLeftEdge() : Edge{return _nextLeftEdge.nextLeftEdge.oppositeEdge;
    }
     function get_rotRightEdge() : Edge{return _oppositeEdge.nextLeftEdge;
    }
     function get_leftFace() : Face{return _leftFace;
    }
     function get_rightFace() : Face{return _oppositeEdge.leftFace;
    }
    
    
    public function toString() : String
    {
        return "edge " + originVertex.id + " - " + destinationVertex.id;
    }
}

