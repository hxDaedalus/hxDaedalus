package ddls.data.graph;

import ddls.data.graph.GraphEdge;
import ddls.data.graph.GraphNode;

class Graph
{
    public var id(get, never) : Int;
    public var edge(get, never) : GraphEdge;
    public var node(get, never) : GraphNode;

    
    private static var INC : Int = 0;
    private var _id : Int;
    
    private var _node : GraphNode;
    private var _edge : GraphEdge;
    
    public function new()
    {
        _id = INC;
        INC++;
    }
    
    private function get_id(): Int {
        return _id;
    }
    
    public function dispose(): Void {
        while (_node!=null)deleteNode(_node);
    }
    
    private function get_edge(): GraphEdge {
        return _edge;
    }
    
    private function get_node(): GraphNode {
        return _node;
    }
    
    public function insertNode(): GraphNode {
        var node = new GraphNode();
        if( _node != null ){
            node.next = _node;
            _node.prev = node;
        }
        _node = node;
        return node;
    }
    
    public function deleteNode( node: GraphNode ): Void {
        while( node.outgoingEdge != null ){
            if( node.outgoingEdge.oppositeEdge != null ) deleteEdge( node.outgoingEdge.oppositeEdge );
            deleteEdge(node.outgoingEdge);
        }
        
        var otherNode = _node;
        var incomingEdge : GraphEdge;
        while ( otherNode != null ){
            incomingEdge = otherNode.successorNodes[ node ];
            if( incomingEdge != null ) deleteEdge( incomingEdge );
            otherNode = otherNode.next;
        }
        
        if( _node == node ){
            if( node.next != null ){
                node.next.prev = null;
                _node = node.next;
            } else {
                _node = null;
            }
        } else {
            if( node.next != null ) {
                node.prev.next = node.next;
                node.next.prev = node.prev;
            } else {
                node.prev.next = null;
            }
        }
        
        node.dispose();
    }
    
    public function insertEdge( fromNode: GraphNode, toNode: GraphNode ): GraphEdge {
        if( fromNode.successorNodes[ toNode ] != null ) return null;
        
        var edge = new GraphEdge();
        if( _edge != null ){
            _edge.prev = edge;
            edge.next = _edge;
        }
        _edge = edge;
        
        edge.sourceNode = fromNode;
        edge.destinationNode = toNode;
        fromNode.successorNodes[ toNode ] = edge;
        if( fromNode.outgoingEdge != null ) {
            fromNode.outgoingEdge.rotPrevEdge = edge;
            edge.rotNextEdge = fromNode.outgoingEdge;
            fromNode.outgoingEdge = edge;
        } else {
            fromNode.outgoingEdge = edge;
        }
        
        var oppositeEdge = toNode.successorNodes[ fromNode ];
        if( oppositeEdge != null ){
            edge.oppositeEdge = oppositeEdge;
            oppositeEdge.oppositeEdge = edge;
        }
        
        return edge;
    }
    
    public function deleteEdge( edge: GraphEdge ): Void {
        if( _edge == edge ){
            if( edge.next != null ){
                edge.next.prev = null;
                _edge = edge.next;
            } else {
                _edge = null;
            }
        } else {
            if( edge.next != null ){
                edge.prev.next = edge.next;
                edge.next.prev = edge.prev;
            } else {
                edge.prev.next = null;
            }
        }
        
        if( edge.sourceNode.outgoingEdge == edge ) {
            if( edge.rotNextEdge != null ){
                edge.rotNextEdge.rotPrevEdge = null;
                edge.sourceNode.outgoingEdge = edge.rotNextEdge;
            } else {
                edge.sourceNode.outgoingEdge = null;
            }
        } else {
            if( edge.rotNextEdge != null ){
                edge.rotPrevEdge.rotNextEdge = edge.rotNextEdge;
                edge.rotNextEdge.rotPrevEdge = edge.rotPrevEdge;
            } else {
                edge.rotPrevEdge.rotNextEdge = null;
            }
        }
        edge.dispose();
    }
}
