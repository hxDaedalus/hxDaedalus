package ddls.data.graph;

import ddls.data.Edge;

class GraphNode
{
    public var id(get, never) : Int;
    public var prev(get, set) : GraphNode;
    public var next(get, set) : GraphNode;
    public var outgoingEdge(get, set) : GraphEdge;
    public var successorNodes(get, set) : Map<GraphNode,GraphEdge>;
    public var data(get, set) : Dynamic;

    
    private static var INC : Int = 0;
    private var _id : Int;
    
    private var _prev : GraphNode;
    private var _next : GraphNode;
    
    private var _outgoingEdge : GraphEdge;
    private var _successorNodes : Map<GraphNode,GraphEdge>;
    
    private var _data : Dynamic;
    
    public function new()
    {
        _id = INC;
        INC++;
        
        _successorNodes = new Map<GraphNode,GraphEdge>();
    }
    
    private function get_id(): Int {
        return _id;
    }
    
    public function dispose(): Void
    {
        _prev = null;
        _next = null;
        _outgoingEdge = null;
        _successorNodes = null;
        _data = null;
    }
    
    private function get_prev() : GraphNode
    {
        return _prev;
    }
    
    private function set_prev(value : GraphNode) : GraphNode
    {
        _prev = value;
        return value;
    }
    
    private function get_next() : GraphNode
    {
        return _next;
    }
    
    private function set_next(value : GraphNode) : GraphNode
    {
        _next = value;
        return value;
    }
    
    private function get_outgoingEdge(): GraphEdge
    {
        return _outgoingEdge;
    }
    
    private function set_outgoingEdge( value: GraphEdge ): GraphEdge
    {
        _outgoingEdge = value;
        return value;
    }
    
    private function get_successorNodes(): Map<GraphNode,GraphEdge>
    {
        return _successorNodes;
    }
    
    private function set_successorNodes( value: Map<GraphNode,GraphEdge> ): Map<GraphNode,GraphEdge>
    {
        _successorNodes = value;
        return value;
    }
    
    //TODO: Dynamic oh dear :( must try to change!
    
    private function get_data(): Dynamic
    {
        return _data;
    }
    
    private function set_data( value: Dynamic ) : Dynamic
    {
        _data = value;
        return value;
    }
}
