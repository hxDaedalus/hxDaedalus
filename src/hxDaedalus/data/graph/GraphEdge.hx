package hxDaedalus.data.graph;

import hxDaedalus.data.graph.GraphNode;
import hxDaedalus.data.math.EdgeData;

class GraphEdge
{
    public var id( get, never ): Int;
    function get_id(): Int { return _id; }
    public var prev( get, set ): GraphEdge;
    public var next( get, set ): GraphEdge;
    public var rotPrevEdge( get, set ): GraphEdge;
    public var rotNextEdge( get, set ): GraphEdge;
    public var oppositeEdge( get, set ): GraphEdge;
    public var sourceNode( get, set ): GraphNode;
    public var destinationNode( get, set ): GraphNode;
    public var data( get, set ): EdgeData;
    static var INC: Int = 0;
    var _id: Int;
    var _prev: GraphEdge;
    var _next: GraphEdge;
    var _rotPrevEdge: GraphEdge;
    var _rotNextEdge: GraphEdge;
    var _oppositeEdge: GraphEdge;
    var _sourceNode: GraphNode;
    var _destinationNode: GraphNode;
    var _data: EdgeData;
    
    public function new(){
        _id = INC;
        INC++;
    }
    
    public function dispose(): Void {}
    
    function get_prev(): GraphEdge {
        return _prev;
    }
    
    function set_prev( value: GraphEdge ): GraphEdge {
        _prev = value;
        return value;
    }
    
     function get_next(): GraphEdge {
        return _next;
    }
    
    function set_next( value: GraphEdge ): GraphEdge {
        _next = value;
        return value;
    }
    
    function get_rotPrevEdge(): GraphEdge {
        return _rotPrevEdge;
    }
    
     function set_rotPrevEdge( value: GraphEdge ) : GraphEdge
    {
        _rotPrevEdge = value;
        return value;
    }
    
     function get_rotNextEdge(): GraphEdge {
        return _rotNextEdge;
    }
    
     function set_rotNextEdge( value: GraphEdge ): GraphEdge {
        _rotNextEdge = value;
        return value;
    }
    
     function get_oppositeEdge(): GraphEdge {
        return _oppositeEdge;
    }
    
     function set_oppositeEdge( value: GraphEdge ): GraphEdge
    {
        _oppositeEdge = value;
        return value;
    }
    
     function get_sourceNode(): GraphNode
    {
        return _sourceNode;
    }
    
     function set_sourceNode( value: GraphNode): GraphNode
    {
        _sourceNode = value;
        return value;
    }
    
     function get_destinationNode(): GraphNode
    {
        return _destinationNode;
    }
    
     function set_destinationNode( value: GraphNode ): GraphNode {
        _destinationNode = value;
        return value;
    }
    
    //TODO: Dynamic == Dynamite :(  must look at this
    
     function get_data() : EdgeData
    {
        return _data;
    }
    
     function set_data( value: EdgeData ) : EdgeData
    {
        _data = value;
        return value;
    }
}
