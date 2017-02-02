package hxDaedalus.data.graph;

import hxDaedalus.data.Edge;
import hxDaedalus.data.math.NodeData;

@:expose
class GraphNode
{
    public var id(get, never) : Int;
    public var prev(get, set) : GraphNode;
    public var next(get, set) : GraphNode;
    public var outgoingEdge(get, set) : GraphEdge;
    public var successorNodes(get, set) : Map<GraphNode,GraphEdge>;
    public var data(get, set) : NodeData;

    
     static var INC : Int = 0;
     var _id : Int;
    
     var _prev : GraphNode;
     var _next : GraphNode;
    
     var _outgoingEdge : GraphEdge;
     var _successorNodes : Map<GraphNode,GraphEdge>;
    
     var _data : NodeData;
    
    public function new()
    {
        _id = INC;
        INC++;
        
        _successorNodes = new Map<GraphNode,GraphEdge>();
    }
    
     function get_id(): Int {
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
    
     function get_prev() : GraphNode
    {
        return _prev;
    }
    
     function set_prev(value : GraphNode) : GraphNode
    {
        _prev = value;
        return value;
    }
    
     function get_next() : GraphNode
    {
        return _next;
    }
    
     function set_next(value : GraphNode) : GraphNode
    {
        _next = value;
        return value;
    }
    
     function get_outgoingEdge(): GraphEdge
    {
        return _outgoingEdge;
    }
    
     function set_outgoingEdge( value: GraphEdge ): GraphEdge
    {
        _outgoingEdge = value;
        return value;
    }
    
     function get_successorNodes(): Map<GraphNode,GraphEdge>
    {
        return _successorNodes;
    }
    
     function set_successorNodes( value: Map<GraphNode,GraphEdge> ): Map<GraphNode,GraphEdge>
    {
        _successorNodes = value;
        return value;
    }
    
    //TODO: Dynamic oh dear :( must try to change!
    
     function get_data(): NodeData
    {
        return _data;
    }
    
     function set_data( value: NodeData ) : NodeData
    {
        _data = value;
        return value;
    }
}
