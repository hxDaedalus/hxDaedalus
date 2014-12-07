package hxDaedalus.data.math;


import hxDaedalus.data.Constants;
import hxDaedalus.data.graph.Graph;
import hxDaedalus.data.graph.GraphEdge;
import hxDaedalus.data.graph.GraphNode;
import hxDaedalus.data.math.Point2D;
import hxDaedalus.data.Pixels;

class Potrace
{
	inline  static var MAX_INT:Int = 0x7FFFFFFF;
    
    public static var maxDistance : Float = 1;
    
    public static function buildShapes( bmpData: Pixels, debugBmp: Pixels = null ) : Array<Array<Float>>
    {
        // OUTLINES STEP-LIKE SHAPES GENERATION
        var shapes = new Array<Array<Float>>();
        var dictPixelsDone = new Map<String,Bool>();
        for (row in 1...bmpData.height - 1){
            for (col in 0...bmpData.width - 1){
                if (bmpData.getPixel(col, row) == 0xFFFFFF && bmpData.getPixel(col + 1, row) < 0xFFFFFF) 
                {
                    if (!dictPixelsDone[(col + 1) + "_" + row]) 
                        shapes.push(buildShape(bmpData, row, col + 1, dictPixelsDone, debugBmp));
                }
            }
        }
        
        return shapes;
    }
    
    public static function buildShape(bmpData : Pixels, fromPixelRow : Int, fromPixelCol : Int, dictPixelsDone : Map<String,Bool>, debugBmp : Pixels = null) : Array<Float>
    {
        var newX : Float = fromPixelCol;
        var newY : Float = fromPixelRow;
        var path = [ newX, newY ];
        dictPixelsDone[newX + "_" + newY] = true;
        
        var curDir = new Point2D(0, 1);
        var newDir = new Point2D();
        var newPixelRow : Int;
        var newPixelCol : Int;
        var count = -1;
        while (true)
        {
            if (debugBmp != null) 
            {
                debugBmp.setPixel32(fromPixelCol, fromPixelRow, 0xFFFF0000);
            }  // take the pixel at right  
            
            
            
            newPixelRow = Std.int( fromPixelRow + curDir.x + curDir.y );
            newPixelCol = Std.int( fromPixelCol + curDir.x - curDir.y );
            // if the pixel is not white
            if (bmpData.getPixel(newPixelCol, newPixelRow) < 0xFFFFFF) 
            {
                // turn the direction right
                newDir.x = -curDir.y;
                newDir.y = curDir.x;
            }
            // if the pixel is white
            else 
            {
                // take the pixel straight
                newPixelRow = Std.int( fromPixelRow + curDir.y );
                newPixelCol = Std.int( fromPixelCol + curDir.x );
                // if the pixel is not white
                if (bmpData.getPixel(newPixelCol, newPixelRow) < 0xFFFFFF) 
                {
                    // the direction stays the same
                    newDir.x = curDir.x;
                    newDir.y = curDir.y;
                }
                // if the pixel is white
                else 
                {
                    // pixel stays the same
                    newPixelRow = fromPixelRow;
                    newPixelCol = fromPixelCol;
                    // turn the direction left
                    newDir.x = curDir.y;
                    newDir.y = -curDir.x;
                }
            }
            newX = newX + curDir.x;
            newY = newY + curDir.y;
            
            if (newX == path[0] && newY == path[1]) 
            {
                break;
            }
            else 
            {
                path.push(newX);
                path.push(newY);
                dictPixelsDone[newX + "_" + newY] = true;
                fromPixelRow = newPixelRow;
                fromPixelCol = newPixelCol;
                curDir.x = newDir.x;
                curDir.y = newDir.y;
            }
            
            count--;
            if (count == 0) 
            {
                break;
            }
        }
        
        return path;
    }
    
    public static function buildGraph(shape : Array<Float>) : Graph
    {
        var i : Int;
        var graph : Graph = new Graph();
        var node : GraphNode;
        i = 0;
        while (i < shape.length){
            node = graph.insertNode();
            node.data = new NodeData();
            (node.data).index = i;
            (node.data).point = new Point2D(shape[i], shape[i + 1]);
            i += 2;
        }
        
        var node1 : GraphNode;
        var node2 : GraphNode;
        var subNode : GraphNode;
        var distSqrd : Float;
        var sumDistSqrd : Float;
        var count : Int;
        var isValid : Bool;
        var edge : GraphEdge;
        var edgeData : EdgeData;
        node1 = graph.node;
        while (node1 != null )
        {
            node2 = ( node1.next != null ) ? node1.next : graph.node;
            while (node2 != node1)
            {
                isValid = true;
                subNode = ( node1.next != null ) ? node1.next : graph.node;
                count = 2;
                sumDistSqrd = 0;
                while (subNode != node2)
                {
                    distSqrd = Geom2D.distanceSquaredPointToSegment((subNode.data).point.x, (subNode.data).point.y, (node1.data).point.x, (node1.data).point.y, (node2.data).point.x, (node2.data).point.y);
                    if (distSqrd < 0) 
                        distSqrd = 0;
                    if (distSqrd >= maxDistance) 
                    {
                        //subNode not valid
                        isValid = false;
                        break;
                    }
                    
                    count++;
                    sumDistSqrd += distSqrd;
                    subNode = ( subNode.next != null ) ? subNode.next : graph.node;
                }
                
                if (!isValid) 
                {
                    //segment not valid
                    break;
                }
                
                edge = graph.insertEdge(node1, node2);
                edgeData = new EdgeData();
                edgeData.sumDistancesSquared = sumDistSqrd;
                edgeData.length = (node1.data).point.distanceTo((node2.data).point);
                edgeData.nodesCount = count;
                edge.data = edgeData;
                
                node2 = ( node2.next != null ) ? node2.next : graph.node;
            }
            
            node1 = node1.next;
        }
        
        return graph;
    }
    
    public static function buildPolygon(graph : Graph, debugShape : Dynamic = null) : Array<Float>
    {
        var polygon : Array<Float> = new Array<Float>();
        
        var currNode : GraphNode;
        // TODO: check if Int.MAX_VALUE below is suitable.
        var minNodeIndex : Int = MAX_INT;
        var edge : GraphEdge;
        var score : Float;
        var higherScore : Float;
        var lowerScoreEdge : GraphEdge = null;
        currNode = graph.node;
        while( (currNode.data).index < minNodeIndex ){
            
            minNodeIndex = (currNode.data).index;
            
            polygon.push((currNode.data).point.x);
            polygon.push((currNode.data).point.y);
            
            higherScore = 0;
            
            edge = currNode.outgoingEdge;
            while( edge!= null )
            {
                score = (edge.data).nodesCount - (edge.data).length * Math.sqrt((edge.data).sumDistancesSquared / (edge.data).nodesCount);
                if (score > higherScore) 
                {
                    higherScore = score;
                    lowerScoreEdge = edge;
                }
                
                edge = edge.rotNextEdge;
            }
            
            currNode = lowerScoreEdge.destinationNode;
        }
        
        if (Geom2D.getDirection(polygon[polygon.length - 2], polygon[polygon.length - 1], polygon[0], polygon[1], polygon[2], polygon[3]) == 0) 
        {
            polygon.shift();
            polygon.shift();
        }
        
        return polygon;
    }

    public function new()
    {
    }
}
