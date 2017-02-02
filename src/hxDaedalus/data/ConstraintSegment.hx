package hxDaedalus.data;

import hxDaedalus.data.ConstraintShape;
import hxDaedalus.data.Edge;

@:expose
class ConstraintSegment
{
    public var id(get, never) : Int;
    public var fromShape: ConstraintShape;
    public var edges(get, never) : Array<Edge>;
    static var INC : Int = 0;
    var _id : Int;
    var _edges : Array<Edge>;
    
    public function new(){
        _id = INC;
        INC++;
        _edges = new Array<Edge>();
    }
    
    function get_id() : Int {
        return _id;
    }
    
    
    public function addEdge( edge :Edge ) : Void {
        if( _edges.indexOf(edge) == -1 && _edges.indexOf( edge.oppositeEdge ) == -1 ) _edges.push( edge );
    }
    
    public function removeEdge( edge :Edge ) : Void {
        var index : Int;
        index = _edges.indexOf(edge);
        if (index == -1) index = _edges.indexOf( edge.oppositeEdge );
        if (index != -1) _edges.splice( index, 1 );
    }
    
    function get_edges() : Array<Edge> {
        return _edges;
    }
    
    public function dispose() : Void {
        _edges = null;
        fromShape = null;
    }
    
    public function toString() : String {
        return "seg_id " + _id;
    }
}
