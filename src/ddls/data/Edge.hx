package ddls.data;
import ddls.data.Face;
import ddls.data.Vertex;

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
    public var oppositeEdge: Edge;
    public var prevLeftEdge(get, never) : Edge;
    public var nextRightEdge(get, never) : Edge;
    public var prevRightEdge(get, never) : Edge;
    public var rotLeftEdge(get, never) : Edge;
    public var rotRightEdge(get, never) : Edge;
    public var rightFace(get, never) : Face;

    
    private static var INC : Int = 0;
    private var _id : Int;
    
    // root datas
    private var _isReal : Bool;
    private var _isConstrained : Bool;
    private var _originVertex : Vertex;
    private var _nextLeftEdge : Edge;
    private var _leftFace : Face;
    
    public var colorDebug : Int = -1;
    
    public function new(){
        _id = INC;
        INC++;
        fromConstraintSegments = new Array<ConstraintSegment>();
    }
    
    private function get_id(): Int {
        return _id;
    }
    
    private function get_isReal(): Bool {
        return _isReal;
    }
    
    private function get_isConstrained(): Bool {
        return _isConstrained;
    }
    
    public function setDatas( originVertex :    Vertex
                            , oppositeEdge_ :    Edge
                            , nextLeftEdge :    Edge
                            , leftFace :        Face
                            , isReal :          Bool = true
                            , isConstrained :   Bool = false
                            ): Void
    {
        _isConstrained = isConstrained;
        _isReal = isReal;
        _originVertex = originVertex;
        oppositeEdge = oppositeEdge_;
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
    
    private function set_originVertex( value: Vertex ): Vertex {
        _originVertex = value;
        return value;
    }
    
    private function set_nextLeftEdge( value: Edge ): Edge {
        _nextLeftEdge = value;
        return value;
    }
    
    private function set_leftFace( value: Face ): Face {
        _leftFace = value;
        return value;
    }
    
    private function set_isConstrained( value: Bool ) : Bool {
        _isConstrained = value;
        return value;
    }
    
    public function dispose() : Void
    {
        _originVertex = null;
        oppositeEdge = null;
        _nextLeftEdge = null;
        _leftFace = null;
        fromConstraintSegments = null;
    }
    
    private function get_originVertex() : Vertex{return _originVertex;
    }
    private function get_destinationVertex() : Vertex{return oppositeEdge.originVertex;
    }

    private function get_nextLeftEdge() : Edge{return _nextLeftEdge;
    }
    private function get_prevLeftEdge() : Edge{return _nextLeftEdge.nextLeftEdge;
    }
    private function get_nextRightEdge() : Edge{return oppositeEdge.nextLeftEdge.nextLeftEdge.oppositeEdge;
    }
    private function get_prevRightEdge() : Edge{return oppositeEdge.nextLeftEdge.oppositeEdge;
    }
    private function get_rotLeftEdge() : Edge{return _nextLeftEdge.nextLeftEdge.oppositeEdge;
    }
    private function get_rotRightEdge() : Edge{return oppositeEdge.nextLeftEdge;
    }
    private function get_leftFace() : Face{return _leftFace;
    }
    private function get_rightFace() : Face{return oppositeEdge.leftFace;
    }
    
    
    public function toString() : String
    {
        return "edge " + originVertex.id + " - " + destinationVertex.id;
    }
}

