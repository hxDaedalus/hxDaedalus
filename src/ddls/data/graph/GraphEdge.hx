package ddls.data.graph;

import ddls.data.graph.GraphNode;
import ddls.data.math.Potrace.EdgeData;

class GraphEdge
{
    public var id(get, never) : Int;
    public var prev(get, set) : GraphEdge;
    public var next(get, set) : GraphEdge;
    public var rotPrevEdge(get, set) : GraphEdge;
    public var rotNextEdge(get, set) : GraphEdge;
    public var oppositeEdge(get, set) : GraphEdge;
    public var sourceNode(get, set) : GraphNode;
    public var destinationNode(get, set) : GraphNode;
    public var data(get, set) : EdgeData;

    
    private static var INC : Int = 0;
    private var _id : Int;
    
    private var _prev : GraphEdge;
    private var _next : GraphEdge;
    
    private var _rotPrevEdge : GraphEdge;
    private var _rotNextEdge : GraphEdge;
    private var _oppositeEdge : GraphEdge;
    private var _sourceNode : GraphNode;
    private var _destinationNode : GraphNode;
    
    private var _data : EdgeData;
    
    public function new(){
        _id = INC;
        INC++;
    }
    
    private function get_id(): Int {
        return _id;
    }
    
    public function dispose(): Void {}
    
    private function get_prev(): GraphEdge {
        return _prev;
    }
    
    private function set_prev( value: GraphEdge ): GraphEdge {
        _prev = value;
        return value;
    }
    
    private function get_next() : GraphEdge
    {
        return _next;
    }
    
    private function set_next( value: GraphEdge ): GraphEdge {
        _next = value;
        return value;
    }
    
    private function get_rotPrevEdge() : GraphEdge {
        return _rotPrevEdge;
    }
    
    private function set_rotPrevEdge( value: GraphEdge ) : GraphEdge
    {
        _rotPrevEdge = value;
        return value;
    }
    
    private function get_rotNextEdge(): GraphEdge {
        return _rotNextEdge;
    }
    
    private function set_rotNextEdge( value: GraphEdge ): GraphEdge {
        _rotNextEdge = value;
        return value;
    }
    
    private function get_oppositeEdge(): GraphEdge {
        return _oppositeEdge;
    }
    
    private function set_oppositeEdge( value: GraphEdge ): GraphEdge
    {
        _oppositeEdge = value;
        return value;
    }
    
    private function get_sourceNode(): GraphNode
    {
        return _sourceNode;
    }
    
    private function set_sourceNode( value: GraphNode): GraphNode
    {
        _sourceNode = value;
        return value;
    }
    
    private function get_destinationNode(): GraphNode
    {
        return _destinationNode;
    }
    
    private function set_destinationNode( value: GraphNode ): GraphNode {
        _destinationNode = value;
        return value;
    }
    
    //TODO: Dynamic == Dynamite :(  must look at this
    
    private function get_data() : EdgeData
    {
        return _data;
    }
    
    private function set_data( value: EdgeData ) : EdgeData
    {
        _data = value;
        return value;
    }
}
