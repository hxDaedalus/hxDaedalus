package hxDaedalus.data;

import hxDaedalus.data.Object;
import hxDaedalus.data.Vertex;
import hxDaedalus.data.math.Geom2D;
import hxDaedalus.data.math.Matrix2D;
import hxDaedalus.data.math.Point2D;
import hxDaedalus.iterators.FromMeshToVertices;
import hxDaedalus.iterators.FromVertexToIncomingEdges;
import hxDaedalus.iterators.FromVertexToOutgoingEdges;
import hxDaedalus.debug.Debug;


@:expose
class Mesh
{
    public var height(get, never) : Float;
    public var width(get, never) : Float;
    public var clipping(get, set) : Bool;
    public var id(get, never) : Int;
    public var __constraintShapes(get, never) : Array<ConstraintShape>;

    
     static var INC : Int = 0;
     var _id : Int;
    
     var _width : Float = 0;
     var _height : Float = 0;
     var _clipping : Bool = false;
    
    public var _vertices : Array<Vertex>= null;
    public var _edges : Array<Edge>= null;
    public var _faces : Array<Face>= null;
     var _constraintShapes : Array<ConstraintShape>= null;
     var _objects : Array<Object>= null;
    
    // keep references of center vertex and bounding edges when split, useful to restore edges as Delaunay
     var __centerVertex : Vertex= null;
     var __edgesToCheck : Array<Edge>= null;
    
    public function new( width: Float, height: Float )
    {
        _id = INC;
        INC++;
        
        _width = width;
        _height = height;
        _clipping = true;
        
        _vertices = new Array<Vertex>();
        _edges = new Array<Edge>();
        _faces = new Array<Face>();
        _constraintShapes = new Array<ConstraintShape>();
        _objects = new Array<Object>();
        
        __edgesToCheck = new Array<Edge>();
    }
    
     function get_height() : Float
    {
        return _height;
    }
    
     function get_width() : Float
    {
        return _width;
    }
    
     function get_clipping() : Bool
    {
        return _clipping;
    }
    
     function set_clipping(value : Bool) : Bool
    {
        _clipping = value;
        return value;
    }
    
     function get_id() : Int
    {
        return _id;
    }
    
    public function dispose() : Void
    {
        while (_vertices.length > 0) _vertices.pop().dispose();
        _vertices = null;
        while (_edges.length > 0) _edges.pop().dispose();
        _edges = null;
        while (_faces.length > 0) _faces.pop().dispose();
        _faces = null;
        while (_constraintShapes.length > 0) _constraintShapes.pop().dispose();
        _constraintShapes = null;
        while (_objects.length > 0) _objects.pop().dispose();
        _objects = null;
        
        __edgesToCheck = null;
        __centerVertex = null;
    }
    
     function get___constraintShapes() : Array<ConstraintShape>
    {
        return _constraintShapes;
    }
    
    public function buildFromRecord(rec : String) : Void
    {
        var positions = rec.split(";");
        var i : Int = 0;
        while (i < positions.length){
            insertConstraintSegment(Std.parseFloat(positions[i]), Std.parseFloat(positions[i + 1]), Std.parseFloat(positions[i + 2]), Std.parseFloat(positions[i + 3]));
            i += 4;
        }
    }
    
    public function insertObject(object : Object) : Void
    {
        if (object.constraintShape!=null) deleteObject(object);
        
        var shape : ConstraintShape = new ConstraintShape();
        var segment : ConstraintSegment;
        var coordinates : Array<Float> = object.coordinates;
        var m : Matrix2D = object.matrix;
        
        object.updateMatrixFromValues();
        var x1 : Float;
        var y1 : Float;
        var x2 : Float;
        var y2 : Float;
        var transfx1 : Float;
        var transfy1 : Float;
        var transfx2 : Float;
        var transfy2 : Float;
        
        var i : Int = 0;
        while (i < coordinates.length){
            x1 = coordinates[i];
            y1 = coordinates[i + 1];
            x2 = coordinates[i + 2];
            y2 = coordinates[i + 3];
            transfx1 = m.transformX(x1, y1);
            transfy1 = m.transformY(x1, y1);
            transfx2 = m.transformX(x2, y2);
            transfy2 = m.transformY(x2, y2);
            
            segment = insertConstraintSegment(transfx1, transfy1, transfx2, transfy2);
            if( segment != null ) 
            {
                segment.fromShape = shape;
                shape.segments.push(segment);
            }
            i += 4;
        }
        
        _constraintShapes.push( shape );
        object.constraintShape = shape;
        
        if (!__objectsUpdateInProgress) {
            _objects.push(object);
        }
    }
    
    public function deleteObject(object : Object) : Void
    {
        if (object.constraintShape == null ) return;
            
        
        deleteConstraintShape(object.constraintShape);
        object.constraintShape = null;
        
        if (!__objectsUpdateInProgress) 
        {
            var index : Int = _objects.indexOf(object);
            _objects.splice(index, 1);
        }
    }
    
     var __objectsUpdateInProgress : Bool = false;
    public function updateObjects() : Void
    {
        __objectsUpdateInProgress = true;
        for (i in 0..._objects.length){
            if (_objects[i].hasChanged) 
            {
                deleteObject(_objects[i]);
                insertObject(_objects[i]);
                _objects[i].hasChanged = false;
            }
        }
        __objectsUpdateInProgress = false;
    }
    
    // insert a new collection of constrained edges.
    // Coordinates parameter is a list with form [x0, y0, x1, y1, x2, y2, x3, y3, x4, y4, ....]
    // where each 4-uple sequence (xi, yi, xi+1, yi+1) is a constraint segment (with i % 4 == 0)
    // and where each couple sequence (xi, yi) is a point.
    // Segments are not necessary connected.
    // Segments can overlap (then they will be automaticaly subdivided).
    public function insertConstraintShape(coordinates : Array<Float>) : ConstraintShape
    {
        var shape : ConstraintShape = new ConstraintShape();
        var segment : ConstraintSegment = null;
        
        var i : Int = 0;
        while (i < coordinates.length){
            segment = insertConstraintSegment(coordinates[i], coordinates[i + 1], coordinates[i + 2], coordinates[i + 3]);
            if (segment != null) 
            {
                segment.fromShape = shape;
                shape.segments.push(segment);
            }
            i += 4;
        }
        
        _constraintShapes.push(shape);
        
        return shape;
    }
    
    public function deleteConstraintShape(shape : ConstraintShape) : Void
    {
        for( i in 0...shape.segments.length ) deleteConstraintSegment(shape.segments[i]);
        shape.dispose();
        _constraintShapes.splice( _constraintShapes.indexOf( shape ), 1);
    }
    
    public function insertConstraintSegment(x1 : Float, y1 : Float, x2 : Float, y2 : Float) : ConstraintSegment
    {
        //Debug.trace("insertConstraintSegment");
        
        /* point positions relative to bounds
        1 | 2 | 3
        ------------
        8 | 0 | 4
        ------------
        7 | 6 | 5
        */
        var p1pos : Int = findPositionFromBounds(x1, y1);
        var p2pos : Int = findPositionFromBounds(x2, y2);
        
        var newX1 : Float = x1;
        var newY1 : Float = y1;
        var newX2 : Float = x2;
        var newY2 : Float = y2;
        // need clipping if activated and if one end point is outside bounds
        if (_clipping && (p1pos != 0 || p2pos != 0)) 
        {
            var intersectPoint : Point2D = new Point2D();
            
            // if both end points are outside bounds
            if (p1pos != 0 && p2pos != 0) 
            {
                // if both end points are on same side
                if ((x1 <= 0 && x2 <= 0) || (x1 >= _width && x2 >= _width) || (y1 <= 0 && y2 <= 0) || (y1 >= _height && y2 >= _height)) 
                    return null;  // if end points are in separated left and right areas  ;
                
                
                
                if ((p1pos == 8 && p2pos == 4) || (p1pos == 4 && p2pos == 8)) 
                {
                    // intersection with left bound
                    Geom2D.intersections2segments(x1, y1, x2, y2, 0, 0, 0, _height, intersectPoint);
                    newX1 = intersectPoint.x;
                    newY1 = intersectPoint.y;
                    // intersection with right bound
                    Geom2D.intersections2segments(x1, y1, x2, y2, _width, 0, _width, _height, intersectPoint);
                    newX2 = intersectPoint.x;
                    newY2 = intersectPoint.y;
                }
                // if end points are in separated top and bottom areas
                else if ((p1pos == 2 && p2pos == 6) || (p1pos == 6 && p2pos == 2)) 
                {
                    // intersection with top bound
                    Geom2D.intersections2segments(x1, y1, x2, y2, 0, 0, _width, 0, intersectPoint);
                    newX1 = intersectPoint.x;
                    newY1 = intersectPoint.y;
                    // intersection with bottom bound
                    Geom2D.intersections2segments(x1, y1, x2, y2, 0, _height, _width, _height, intersectPoint);
                    newX2 = intersectPoint.x;
                    newY2 = intersectPoint.y;
                }
                // if ends points are apart of the top-left corner
                else if ((p1pos == 2 && p2pos == 8) || (p1pos == 8 && p2pos == 2)) 
                {
                    // check if intersection with top bound
                    if (Geom2D.intersections2segments(x1, y1, x2, y2, 0, 0, _width, 0, intersectPoint)) 
                    {
                        newX1 = intersectPoint.x;
                        newY1 = intersectPoint.y;
                        
                        // must have intersection with left bound
                        Geom2D.intersections2segments(x1, y1, x2, y2, 0, 0, 0, _height, intersectPoint);
                        newX2 = intersectPoint.x;
                        newY2 = intersectPoint.y;
                    }
                    else return null;
                }
                // if ends points are apart of the top-right corner
                else if ((p1pos == 2 && p2pos == 4) || (p1pos == 4 && p2pos == 2)) 
                {
                    // check if intersection with top bound
                    if (Geom2D.intersections2segments(x1, y1, x2, y2, 0, 0, _width, 0, intersectPoint)) 
                    {
                        newX1 = intersectPoint.x;
                        newY1 = intersectPoint.y;
                        
                        // must have intersection with right bound
                        Geom2D.intersections2segments(x1, y1, x2, y2, _width, 0, _width, _height, intersectPoint);
                        newX2 = intersectPoint.x;
                        newY2 = intersectPoint.y;
                    }
                    else return null;
                }
                // if ends points are apart of the bottom-right corner
                else if ((p1pos == 6 && p2pos == 4) || (p1pos == 4 && p2pos == 6)) 
                {
                    // check if intersection with bottom bound
                    if (Geom2D.intersections2segments(x1, y1, x2, y2, 0, _height, _width, _height, intersectPoint)) 
                    {
                        newX1 = intersectPoint.x;
                        newY1 = intersectPoint.y;
                        
                        // must have intersection with right bound
                        Geom2D.intersections2segments(x1, y1, x2, y2, _width, 0, _width, _height, intersectPoint);
                        newX2 = intersectPoint.x;
                        newY2 = intersectPoint.y;
                    }
                    else return null;
                }
                // if ends points are apart of the bottom-left corner
                else if ((p1pos == 8 && p2pos == 6) || (p1pos == 6 && p2pos == 8)) 
                {
                    // check if intersection with bottom bound
                    if (Geom2D.intersections2segments(x1, y1, x2, y2, 0, _height, _width, _height, intersectPoint)) 
                    {
                        newX1 = intersectPoint.x;
                        newY1 = intersectPoint.y;
                        
                        // must have intersection with left bound
                        Geom2D.intersections2segments(x1, y1, x2, y2, 0, 0, 0, _height, intersectPoint);
                        newX2 = intersectPoint.x;
                        newY2 = intersectPoint.y;
                    }
                    else return null;
                }
                // other cases (could be optimized)
                else 
                {
                    var firstDone : Bool = false;
                    var secondDone : Bool = false;
                    // check top bound
                    if (Geom2D.intersections2segments(x1, y1, x2, y2, 0, 0, _width, 0, intersectPoint)) 
                    {
                        newX1 = intersectPoint.x;
                        newY1 = intersectPoint.y;
                        firstDone = true;
                    }  // check right bound  
                    
                    if (Geom2D.intersections2segments(x1, y1, x2, y2, _width, 0, _width, _height, intersectPoint)) 
                    {
                        if (!firstDone) 
                        {
                            newX1 = intersectPoint.x;
                            newY1 = intersectPoint.y;
                            firstDone = true;
                        }
                        else 
                        {
                            newX2 = intersectPoint.x;
                            newY2 = intersectPoint.y;
                            secondDone = true;
                        }
                    }  // check bottom bound  
                    
                    if (!secondDone && Geom2D.intersections2segments(x1, y1, x2, y2, 0, _height, _width, _height, intersectPoint)) 
                    {
                        if (!firstDone) 
                        {
                            newX1 = intersectPoint.x;
                            newY1 = intersectPoint.y;
                            firstDone = true;
                        }
                        else 
                        {
                            newX2 = intersectPoint.x;
                            newY2 = intersectPoint.y;
                            secondDone = true;
                        }
                    }  // check left bound  
                    
                    if (!secondDone && Geom2D.intersections2segments(x1, y1, x2, y2, 0, 0, 0, _height, intersectPoint)) {
                        newX2 = intersectPoint.x;
                        newY2 = intersectPoint.y;
                    }
                    
                    if (!firstDone) return null;
                }
            }
            // one end point of segment is outside bounds and one is inside
            else 
            {
                // if one point is outside top
                if (p1pos == 2 || p2pos == 2){
                    // intersection with top bound
                    Geom2D.intersections2segments(x1, y1, x2, y2, 0, 0, _width, 0, intersectPoint);
                }
                // if one point is outside right
                else if (p1pos == 4 || p2pos == 4){
                    // intersection with right bound
                    Geom2D.intersections2segments(x1, y1, x2, y2, _width, 0, _width, _height, intersectPoint);
                }
                // if one point is outside bottom
                else if (p1pos == 6 || p2pos == 6){
                    // intersection with bottom bound
                    Geom2D.intersections2segments(x1, y1, x2, y2, 0, _height, _width, _height, intersectPoint);
                }
                // if one point is outside left
                else if (p1pos == 8 || p2pos == 8){
                    // intersection with left bound
                    Geom2D.intersections2segments(x1, y1, x2, y2, 0, 0, 0, _height, intersectPoint);
                }
                // other cases (could be optimized)
                else 
                {
                    // check top bound
                    if (!Geom2D.intersections2segments(x1, y1, x2, y2, 0, 0, _width, 0, intersectPoint)) 
                    {
                        // check right bound
                        if (!Geom2D.intersections2segments(x1, y1, x2, y2, _width, 0, _width, _height, intersectPoint)) 
                        {
                            // check bottom bound
                            if (!Geom2D.intersections2segments(x1, y1, x2, y2, 0, _height, _width, _height, intersectPoint)) 
                            {
                                // check left bound
                                Geom2D.intersections2segments(x1, y1, x2, y2, 0, 0, 0, _height, intersectPoint);
                            }
                        }
                    }
                }
                
                if( p1pos == 0 ) {
                    newX1 = x1;
                    newY1 = y1;
                } else {
                    newX1 = x2;
                    newY1 = y2;
                }
                newX2 = intersectPoint.x;
                newY2 = intersectPoint.y;
            }
        }  // we check the vertices insertions  
        
        
        
        var vertexDown = insertVertex( newX1, newY1 );
        if( vertexDown == null ) return null;
        var vertexUp = insertVertex( newX2, newY2 );
        if( vertexUp == null ) return null;
        if( vertexDown == vertexUp ) return null; 
        // useful    //Debug.trace("vertices " + vertexDown.id + " " + vertexUp.id)  
        var iterVertexToOutEdges : FromVertexToOutgoingEdges = new FromVertexToOutgoingEdges();
        var currVertex : Vertex;
        var currEdge : Edge;
        var i : Int;
        
        // the new constraint segment
        var segment = new ConstraintSegment();
        
        var tempEdgeDownUp : Edge = new Edge();
        var tempSdgeUpDown : Edge = new Edge();
        tempEdgeDownUp.setDatas(vertexDown, tempSdgeUpDown, null, null, true, true);
        tempSdgeUpDown.setDatas(vertexUp, tempEdgeDownUp, null, null, true, true);
        
        var intersectedEdges = new Array<Edge>();
        var leftBoundingEdges = new Array<Edge>();
        var rightBoundingEdges = new Array<Edge>();
        
        var currObjet : Intersection;
        var pIntersect : Point2D = new Point2D();
        var edgeLeft : Edge;
        var newEdgeDownUp : Edge;
        var newEdgeUpDown : Edge;
        var done : Bool;
        currVertex = vertexDown;
        currObjet = EVertex(currVertex);
        while (true)
        {
            done = false;
            
            switch( currObjet ){
                case EVertex( vertex ):
///////////////////////////
                        //Debug.trace("case vertex");
                        currVertex = vertex;
                        iterVertexToOutEdges.fromVertex = currVertex;
                        while ((currEdge = iterVertexToOutEdges.next())!=null)
                        {
                            // if we meet directly the end vertex
                            if (currEdge.destinationVertex == vertexUp) 
                            {
                                //Debug.trace("we met the end vertex");
                                if (!currEdge.isConstrained) 
                                {
                                    currEdge.isConstrained = true;
                                    currEdge.oppositeEdge.isConstrained = true;
                                }
                                currEdge.addFromConstraintSegment(segment);
                                currEdge.oppositeEdge.fromConstraintSegments = currEdge.fromConstraintSegments;
                                vertexDown.addFromConstraintSegment(segment);
                                vertexUp.addFromConstraintSegment(segment);
                                segment.addEdge(currEdge);
                                return segment;
                            }  // if we meet a vertex  

                            if (Geom2D.distanceSquaredVertexToEdge(currEdge.destinationVertex, tempEdgeDownUp) <= Constants.EPSILON_SQUARED) 
                            {
                                //Debug.trace("we met a vertex");
                                if (!currEdge.isConstrained) 
                                {
                                    //Debug.trace("edge is not constrained");
                                    currEdge.isConstrained = true;
                                    currEdge.oppositeEdge.isConstrained = true;
                                }
                                currEdge.addFromConstraintSegment(segment);
                                currEdge.oppositeEdge.fromConstraintSegments = currEdge.fromConstraintSegments;
                                vertexDown.addFromConstraintSegment(segment);
                                segment.addEdge(currEdge);
                                vertexDown = currEdge.destinationVertex;
                                tempEdgeDownUp.originVertex = vertexDown;
                                currObjet = EVertex(vertexDown);
                                done = true;
                                break;
                            }
                        }

                        if (done) 
                            continue;

                        iterVertexToOutEdges.fromVertex = currVertex;
                        while ((currEdge = iterVertexToOutEdges.next())!=null)
                        {
                            currEdge = currEdge.nextLeftEdge;
                            if (Geom2D.intersections2edges(currEdge, tempEdgeDownUp, pIntersect)) 
                            {
                                //Debug.trace("edge intersection");
                                if (currEdge.isConstrained) 
                                {
                                    //Debug.trace("edge is constrained");
                                    vertexDown = splitEdge(currEdge, pIntersect.x, pIntersect.y);
                                    iterVertexToOutEdges.fromVertex = currVertex;
                                    while ((currEdge = iterVertexToOutEdges.next())!=null )
                                    {
                                        if (currEdge.destinationVertex == vertexDown) 
                                        {
                                            currEdge.isConstrained = true;
                                            currEdge.oppositeEdge.isConstrained = true;
                                            currEdge.addFromConstraintSegment(segment);
                                            currEdge.oppositeEdge.fromConstraintSegments = currEdge.fromConstraintSegments;
                                            segment.addEdge(currEdge);
                                            break;
                                        }
                                    }
                                    currVertex.addFromConstraintSegment(segment);
                                    tempEdgeDownUp.originVertex = vertexDown;
                                    currObjet = EVertex(vertexDown);
                                }
                                else 
                                {
                                    //Debug.trace("edge is not constrained");
                                    intersectedEdges.push(currEdge);
                                    leftBoundingEdges.unshift(currEdge.nextLeftEdge);
                                    rightBoundingEdges.push(currEdge.prevLeftEdge);
                                    currEdge = currEdge.oppositeEdge;  // we keep the edge from left to right  
                                    currObjet = EEdge(currEdge);
                                }
                                break;
                            }
                        }
                    
////////////////////////////////////////////
                case EEdge( edge ):
                    currEdge = edge;
                        //Debug.trace("case edge");
                        edgeLeft = currEdge.nextLeftEdge;
                        if (edgeLeft.destinationVertex == vertexUp) 
                        {
                            //Debug.trace("end point reached");
                            leftBoundingEdges.unshift(edgeLeft.nextLeftEdge);
                            rightBoundingEdges.push(edgeLeft);

                            newEdgeDownUp = new Edge();
                            newEdgeUpDown = new Edge();
                            newEdgeDownUp.setDatas(vertexDown, newEdgeUpDown, null, null, true, true);
                            newEdgeUpDown.setDatas(vertexUp, newEdgeDownUp, null, null, true, true);
                            leftBoundingEdges.push(newEdgeDownUp);
                            rightBoundingEdges.push(newEdgeUpDown);
                            insertNewConstrainedEdge(segment, newEdgeDownUp, intersectedEdges, leftBoundingEdges, rightBoundingEdges);

                            return segment;
                        }
                        else if (Geom2D.distanceSquaredVertexToEdge(edgeLeft.destinationVertex, tempEdgeDownUp) <= Constants.EPSILON_SQUARED) 
                        {
                            //Debug.trace("we met a vertex");
                            leftBoundingEdges.unshift(edgeLeft.nextLeftEdge);
                            rightBoundingEdges.push(edgeLeft);

                            newEdgeDownUp = new Edge();
                            newEdgeUpDown = new Edge();
                            newEdgeDownUp.setDatas(vertexDown, newEdgeUpDown, null, null, true, true);
                            newEdgeUpDown.setDatas(edgeLeft.destinationVertex, newEdgeDownUp, null, null, true, true);
                            leftBoundingEdges.push(newEdgeDownUp);
                            rightBoundingEdges.push(newEdgeUpDown);
                            insertNewConstrainedEdge(segment, newEdgeDownUp, intersectedEdges, leftBoundingEdges, rightBoundingEdges);

                            intersectedEdges.splice(0, intersectedEdges.length);
                            leftBoundingEdges.splice(0, leftBoundingEdges.length);
                            rightBoundingEdges.splice(0, rightBoundingEdges.length);

                            vertexDown = edgeLeft.destinationVertex;
                            tempEdgeDownUp.originVertex = vertexDown;
                            currObjet = EVertex(vertexDown);
                        }
                        else 
                        {
                            if (Geom2D.intersections2edges(edgeLeft, tempEdgeDownUp, pIntersect)) 
                            {
                                //Debug.trace("1st left edge intersected");
                                if (edgeLeft.isConstrained) 
                                {
                                    //Debug.trace("edge is constrained");
                                    currVertex = splitEdge(edgeLeft, pIntersect.x, pIntersect.y);

                                    iterVertexToOutEdges.fromVertex = currVertex;
                                    while ((currEdge = iterVertexToOutEdges.next())!=null)
                                    {
                                        if (currEdge.destinationVertex == leftBoundingEdges[0].originVertex) 
                                        {
                                            leftBoundingEdges.unshift(currEdge);
                                        }
                                        if (currEdge.destinationVertex == rightBoundingEdges[rightBoundingEdges.length - 1].destinationVertex) 
                                        {
                                            rightBoundingEdges.push(currEdge.oppositeEdge);
                                        }
                                    }

                                    newEdgeDownUp = new Edge();
                                    newEdgeUpDown = new Edge();
                                    newEdgeDownUp.setDatas(vertexDown, newEdgeUpDown, null, null, true, true);
                                    newEdgeUpDown.setDatas(currVertex, newEdgeDownUp, null, null, true, true);
                                    leftBoundingEdges.push(newEdgeDownUp);
                                    rightBoundingEdges.push(newEdgeUpDown);
                                    insertNewConstrainedEdge(segment, newEdgeDownUp, intersectedEdges, leftBoundingEdges, rightBoundingEdges);

                                    intersectedEdges.splice(0, intersectedEdges.length);
                                    leftBoundingEdges.splice(0, leftBoundingEdges.length);
                                    rightBoundingEdges.splice(0, rightBoundingEdges.length);
                                    vertexDown = currVertex;
                                    tempEdgeDownUp.originVertex = vertexDown;
                                    currObjet = EVertex(vertexDown);
                                }
                                else 
                                {
                                    //Debug.trace("edge is not constrained");
                                    intersectedEdges.push(edgeLeft);
                                    leftBoundingEdges.unshift(edgeLeft.nextLeftEdge);
                                    currEdge = edgeLeft.oppositeEdge;  // we keep the edge from left to right  
                                    currObjet = EEdge(currEdge);
                                }
                            }
                            else 
                            {
                                //Debug.trace("2nd left edge intersected");
                                edgeLeft = edgeLeft.nextLeftEdge;
                                Geom2D.intersections2edges(edgeLeft, tempEdgeDownUp, pIntersect);
                                if (edgeLeft.isConstrained) 
                                {
                                    //Debug.trace("edge is constrained");
                                    currVertex = splitEdge(edgeLeft, pIntersect.x, pIntersect.y);

                                    iterVertexToOutEdges.fromVertex = currVertex;
                                    while ((currEdge = iterVertexToOutEdges.next())!=null )
                                    {
                                        if (currEdge.destinationVertex == leftBoundingEdges[0].originVertex) 
                                        {
                                            leftBoundingEdges.unshift(currEdge);
                                        }
                                        if (currEdge.destinationVertex == rightBoundingEdges[rightBoundingEdges.length - 1].destinationVertex) 
                                        {
                                            rightBoundingEdges.push(currEdge.oppositeEdge);
                                        }
                                    }

                                    newEdgeDownUp = new Edge();
                                    newEdgeUpDown = new Edge();
                                    newEdgeDownUp.setDatas(vertexDown, newEdgeUpDown, null, null, true, true);
                                    newEdgeUpDown.setDatas(currVertex, newEdgeDownUp, null, null, true, true);
                                    leftBoundingEdges.push(newEdgeDownUp);
                                    rightBoundingEdges.push(newEdgeUpDown);
                                    insertNewConstrainedEdge(segment, newEdgeDownUp, intersectedEdges, leftBoundingEdges, rightBoundingEdges);

                                    intersectedEdges.splice(0, intersectedEdges.length);
                                    leftBoundingEdges.splice(0, leftBoundingEdges.length);
                                    rightBoundingEdges.splice(0, rightBoundingEdges.length);
                                    vertexDown = currVertex;
                                    tempEdgeDownUp.originVertex = vertexDown;
                                    currObjet = EVertex(vertexDown);
                                }
                                else 
                                {
                                    //Debug.trace("edge is not constrained");
                                    intersectedEdges.push(edgeLeft);
                                    rightBoundingEdges.push(edgeLeft.prevLeftEdge);
                                    currEdge = edgeLeft.oppositeEdge;  // we keep the edge from left to right  
                                    currObjet = EEdge(currEdge);
                                }
                            }
                        }
                    
                case EFace( face ):
                    //
                case ENull:
                    //
            }
     
        }
        
        return segment;
    }
    
     function insertNewConstrainedEdge(fromSegment : ConstraintSegment, edgeDownUp : Edge, intersectedEdges : Array<Edge>, leftBoundingEdges : Array<Edge>, rightBoundingEdges : Array<Edge>) : Void
    {
        //Debug.trace("insertNewConstrainedEdge");
        _edges.push(edgeDownUp);
        _edges.push(edgeDownUp.oppositeEdge);
        
        edgeDownUp.addFromConstraintSegment(fromSegment);
        edgeDownUp.oppositeEdge.fromConstraintSegments = edgeDownUp.fromConstraintSegments;
        
        fromSegment.addEdge(edgeDownUp);
        
        edgeDownUp.originVertex.addFromConstraintSegment(fromSegment);
        edgeDownUp.destinationVertex.addFromConstraintSegment(fromSegment);
        
        untriangulate(intersectedEdges);
        
        triangulate(leftBoundingEdges, true);
        triangulate(rightBoundingEdges, true);
    }
    
    public function deleteConstraintSegment(segment : ConstraintSegment) : Void
    {
        //Debug.trace("deleteConstraintSegment id " + segment.id);
        var i : Int;
        var vertexToDelete : Array<Vertex> = new Array<Vertex>();
        var edge : Edge = null;
        var vertex : Vertex;
        var fromConstraintSegment : Array<ConstraintSegment>;
        for (i in 0...segment.edges.length){
            edge = segment.edges[i];
            //Debug.trace("unconstrain edge " + edge);
            edge.removeFromConstraintSegment(segment);
            if (edge.fromConstraintSegments.length == 0) 
            {
                edge.isConstrained = false;
                edge.oppositeEdge.isConstrained = false;
            }
            
            vertex = edge.originVertex;
            vertex.removeFromConstraintSegment(segment);
            vertexToDelete.push(vertex);
        }
		
		//if (edge != null) {
			vertex = edge.destinationVertex;
			vertex.removeFromConstraintSegment(segment);
			vertexToDelete.push(vertex);
        //}
		
        //Debug.trace("clean the useless vertices");
        for (i in 0...vertexToDelete.length){
            deleteVertex(vertexToDelete[i]);
        }  //Debug.trace("clean done");  
        
        
        
        segment.dispose();
    }
    
     function check() : Void
    {
        for (i in 0..._edges.length){
            if( _edges[i].nextLeftEdge == null ) 
            {
                Debug.trace("!!! missing nextLeftEdge");
                return;
            }
        }
        Debug.trace("check OK");
    }
    
    public function insertVertex(x : Float, y : Float) : Vertex
    {
        //Debug.trace("insertVertex " + x + "," + y);
        if (x < 0 || y < 0 || x > _width || y > _height) return null;
        
        __edgesToCheck.splice(0, __edgesToCheck.length);
        
        var inObject = Geom2D.locatePosition(x, y, this);
        var newVertex : Vertex = null;
        
        switch( inObject ){
            case EVertex( vertex ):
                //Debug.trace("inVertex " + vertex.id);
                newVertex = vertex;
            case EEdge( edge ):
                //Debug.trace("inEdge " + edge);
                newVertex = splitEdge(edge, x, y);
            case EFace( face ):
                //Debug.trace("inFace " + face );
                newVertex = splitFace(face, x, y);
            case ENull:
                //Debug.trace('nothing!');
        }
        
        restoreAsDelaunay();
        
        return newVertex;
    }
    
    public function flipEdge(edge : Edge) : Edge
    {
        // retrieve and create useful objets
        var eBot_Top = edge;
        var eTop_Bot  = edge.oppositeEdge;
        var eLeft_Right = new Edge();
        var eRight_Left = new Edge();
        var eTop_Left = eBot_Top.nextLeftEdge;
        var eLeft_Bot= eTop_Left.nextLeftEdge;
        var eBot_Right = eTop_Bot.nextLeftEdge;
        var eRight_Top = eBot_Right.nextLeftEdge;
        
        var vBot  = eBot_Top.originVertex;
        var vTop  = eTop_Bot.originVertex;
        var vLeft  = eLeft_Bot.originVertex;
        var vRight = eRight_Top.originVertex;
        
        var fLeft = eBot_Top.leftFace;
        var fRight  = eTop_Bot.leftFace;
        var fBot  = new Face();
        var fTop = new Face();
        
        // add the new edges
        _edges.push(eLeft_Right);
        _edges.push(eRight_Left);
        
        // add the new faces
        _faces.push(fTop);
        _faces.push(fBot);
        
        // set vertex, edge and face references for the new LEFT_RIGHT and RIGHT-LEFT edges
        eLeft_Right.setDatas(vLeft, eRight_Left, eRight_Top, fTop, edge.isReal, edge.isConstrained);
        eRight_Left.setDatas(vRight, eLeft_Right, eLeft_Bot, fBot, edge.isReal, edge.isConstrained);
        
        // set edge references for the new TOP and BOTTOM faces
        fTop.setDatas(eLeft_Right);
        fBot.setDatas(eRight_Left);
        
        // check the edge references of TOP and BOTTOM vertices
        if (vTop.edge == eTop_Bot) {
            vTop.setDatas(eTop_Left);
        }
        if (vBot.edge == eBot_Top) {
            vBot.setDatas(eBot_Right) ; // set the new edge and face references for the 4 bouding edges  ;
        }
        
        
        eTop_Left.nextLeftEdge = eLeft_Right;
        eTop_Left.leftFace = fTop;
        eLeft_Bot.nextLeftEdge = eBot_Right;
        eLeft_Bot.leftFace = fBot;
        eBot_Right.nextLeftEdge = eRight_Left;
        eBot_Right.leftFace = fBot;
        eRight_Top.nextLeftEdge = eTop_Left;
        eRight_Top.leftFace = fTop;
        
        // remove the old TOP-BOTTOM and BOTTOM-TOP edges
        eBot_Top.dispose();
        eTop_Bot.dispose();
        _edges.splice(_edges.indexOf(eBot_Top), 1);
        _edges.splice(_edges.indexOf(eTop_Bot), 1);
        
        // remove the old LEFT and RIGHT faces
        fLeft.dispose();
        fRight.dispose();
        _faces.splice(_faces.indexOf(fLeft), 1);
        _faces.splice(_faces.indexOf(fRight), 1);
        
        return eRight_Left;
    }
    
    public function splitEdge(edge : Edge, x : Float, y : Float) : Vertex
    {
        // empty old references
        __edgesToCheck.splice(0, __edgesToCheck.length);
        
        // retrieve useful objets
        var eLeft_Right = edge;
        var eRight_Left= eLeft_Right.oppositeEdge;
        var eRight_Top  = eLeft_Right.nextLeftEdge;
        var eTop_Left  = eRight_Top.nextLeftEdge;
        var eLeft_Bot  = eRight_Left.nextLeftEdge;
        var eBot_Right = eLeft_Bot.nextLeftEdge;
        
        var vTop  = eTop_Left.originVertex;
        var vLeft  = eLeft_Right.originVertex;
        var vBot  = eBot_Right.originVertex;
        var vRight = eRight_Left.originVertex;
        
        var fTop = eLeft_Right.leftFace;
        var fBot = eRight_Left.leftFace;
        
        // check distance from the position to edge end points
        if ((vLeft.pos.x - x) * (vLeft.pos.x - x) + (vLeft.pos.y - y) * (vLeft.pos.y - y) <= Constants.EPSILON_SQUARED) 
            return vLeft;
        if ((vRight.pos.x - x) * (vRight.pos.x - x) + (vRight.pos.y - y) * (vRight.pos.y - y) <= Constants.EPSILON_SQUARED) 
            return vRight; // create new objects  ;
        
        
        
        var vCenter = new Vertex();
        
        var eTop_Center  = new Edge();
        var eCenter_Top  = new Edge();
        var eBot_Center = new Edge();
        var eCenter_Bot = new Edge();
        
        var eLeft_Center  = new Edge();
        var eCenter_Left  = new Edge();
        var eRight_Center  = new Edge();
        var eCenter_Right = new Edge();
        
        var fTopLeft  = new Face();
        var fBotLeft  = new Face();
        var fBotRight  = new Face();
        var fTopRight  = new Face();
        
        // add the new vertex
        _vertices.push(vCenter);
        
        // add the new edges
        _edges.push(eCenter_Top);
        _edges.push(eTop_Center);
        _edges.push(eCenter_Left);
        _edges.push(eLeft_Center);
        _edges.push(eCenter_Bot);
        _edges.push(eBot_Center);
        _edges.push(eCenter_Right);
        _edges.push(eRight_Center);
        
        // add the new faces
        _faces.push(fTopRight);
        _faces.push(fBotRight);
        _faces.push(fBotLeft);
        _faces.push(fTopLeft);
        
        // set pos and edge reference for the new CENTER vertex
        vCenter.setDatas((fTop.isReal) ? eCenter_Top : eCenter_Bot);
        vCenter.pos.x = x;
        vCenter.pos.y = y;
        Geom2D.projectOrthogonaly(vCenter.pos, eLeft_Right);
        
        // set the new vertex, edge and face references for the new 8 center crossing edges
        eCenter_Top.setDatas(vCenter, eTop_Center, eTop_Left, fTopLeft, fTop.isReal);
        eTop_Center.setDatas(vTop, eCenter_Top, eCenter_Right, fTopRight, fTop.isReal);
        eCenter_Left.setDatas(vCenter, eLeft_Center, eLeft_Bot, fBotLeft, edge.isReal, edge.isConstrained);
        eLeft_Center.setDatas(vLeft, eCenter_Left, eCenter_Top, fTopLeft, edge.isReal, edge.isConstrained);
        eCenter_Bot.setDatas(vCenter, eBot_Center, eBot_Right, fBotRight, fBot.isReal);
        eBot_Center.setDatas(vBot, eCenter_Bot, eCenter_Left, fBotLeft, fBot.isReal);
        eCenter_Right.setDatas(vCenter, eRight_Center, eRight_Top, fTopRight, edge.isReal, edge.isConstrained);
        eRight_Center.setDatas(vRight, eCenter_Right, eCenter_Bot, fBotRight, edge.isReal, edge.isConstrained);
        
        // set the new edge references for the new 4 faces
        fTopLeft.setDatas(eCenter_Top, fTop.isReal);
        fBotLeft.setDatas(eCenter_Left, fBot.isReal);
        fBotRight.setDatas(eCenter_Bot, fBot.isReal);
        fTopRight.setDatas(eCenter_Right, fTop.isReal);
        
        // check the edge references of LEFT and RIGHT vertices
        if( vLeft.edge == eLeft_Right ) vLeft.setDatas(eLeft_Center);
        if( vRight.edge == eRight_Left ) vRight.setDatas(eRight_Center);  // set the new edge and face references for the 4 bounding edges  ;
        
        
        
        eTop_Left.nextLeftEdge = eLeft_Center;
        eTop_Left.leftFace = fTopLeft;
        eLeft_Bot.nextLeftEdge = eBot_Center;
        eLeft_Bot.leftFace = fBotLeft;
        eBot_Right.nextLeftEdge = eRight_Center;
        eBot_Right.leftFace = fBotRight;
        eRight_Top.nextLeftEdge = eTop_Center;
        eRight_Top.leftFace = fTopRight;
        
        // if the edge was constrained, we must:
        // - add the segments the edge is from to the 2 new
        // - update the segments the edge is from by deleting the old edge and inserting the 2 new
        // - add the segments the edge is from to the new vertex
        if (eLeft_Right.isConstrained) 
        {
            var fromSegments  = eLeft_Right.fromConstraintSegments;
            eLeft_Center.fromConstraintSegments = fromSegments.slice(0);
            eCenter_Left.fromConstraintSegments = eLeft_Center.fromConstraintSegments;
            eCenter_Right.fromConstraintSegments = fromSegments.slice(0);
            eRight_Center.fromConstraintSegments = eCenter_Right.fromConstraintSegments;
            
            var edges : Array<Edge>;
            var index : Int;
            for (i in 0...eLeft_Right.fromConstraintSegments.length){
                edges = eLeft_Right.fromConstraintSegments[i].edges;
                index = edges.indexOf(eLeft_Right);
                if (index != -1) {
                    edges.splice( index, 1 );
                    edges.insert( index, eLeft_Center );
                    edges.insert( index+1, eCenter_Right );
                } else { 
                    index = edges.indexOf(eRight_Left );
                    edges.splice( index, 1);
                    edges.insert( index, eRight_Center );
                    edges.insert( index+1, eCenter_Left );
                }
            }
            
            vCenter.fromConstraintSegments = fromSegments.slice(0);
        }  // remove the old LEFT-RIGHT and RIGHT-LEFT edges  
        
        
        
        eLeft_Right.dispose();
        eRight_Left.dispose();
        _edges.splice(_edges.indexOf(eLeft_Right), 1);
        _edges.splice(_edges.indexOf(eRight_Left), 1);
        
        // remove the old TOP and BOTTOM faces
        fTop.dispose();
        fBot.dispose();
        _faces.splice(_faces.indexOf(fTop), 1);
        _faces.splice(_faces.indexOf(fBot), 1);
        
        // add new bounds references for Delaunay restoring
        __centerVertex = vCenter;
        __edgesToCheck.push(eTop_Left);
        __edgesToCheck.push(eLeft_Bot);
        __edgesToCheck.push(eBot_Right);
        __edgesToCheck.push(eRight_Top);
        
        return vCenter;
    }
    
    public function splitFace(face : Face, x : Float, y : Float) : Vertex
    {
        // empty old references
        __edgesToCheck.splice(0, __edgesToCheck.length);
        
        // retrieve useful objects
        var eTop_Left  = face.edge;
        var eLeft_Right  = eTop_Left.nextLeftEdge;
        var eRight_Top = eLeft_Right.nextLeftEdge;
        
        var vTop = eTop_Left.originVertex;
        var vLeft  = eLeft_Right.originVertex;
        var vRight = eRight_Top.originVertex;
        
        // create new objects
        var vCenter = new Vertex();
        
        var eTop_Center = new Edge();
        var eCenter_Top = new Edge();
        var eLeft_Center  = new Edge();
        var eCenter_Left  = new Edge();
        var eRight_Center  = new Edge();
        var eCenter_Right  = new Edge();
        
        var fTopLeft = new Face();
        var fBot = new Face();
        var fTopRight = new Face();
        
        // add the new vertex
        _vertices.push(vCenter);
        
        // add the new edges
        _edges.push(eTop_Center);
        _edges.push(eCenter_Top);
        _edges.push(eLeft_Center);
        _edges.push(eCenter_Left);
        _edges.push(eRight_Center);
        _edges.push(eCenter_Right);
        
        // add the new faces
        _faces.push(fTopLeft);
        _faces.push(fBot);
        _faces.push(fTopRight);
        
        // set pos and edge reference for the new CENTER vertex
        vCenter.setDatas(eCenter_Top);
        vCenter.pos.x = x;
        vCenter.pos.y = y;
        
        // set the new vertex, edge and face references for the new 6 center crossing edges
        eTop_Center.setDatas(vTop, eCenter_Top, eCenter_Right, fTopRight);
        eCenter_Top.setDatas(vCenter, eTop_Center, eTop_Left, fTopLeft);
        eLeft_Center.setDatas(vLeft, eCenter_Left, eCenter_Top, fTopLeft);
        eCenter_Left.setDatas(vCenter, eLeft_Center, eLeft_Right, fBot);
        eRight_Center.setDatas(vRight, eCenter_Right, eCenter_Left, fBot);
        eCenter_Right.setDatas(vCenter, eRight_Center, eRight_Top, fTopRight);
        
        // set the new edge references for the new 3 faces
        fTopLeft.setDatas(eCenter_Top);
        fBot.setDatas(eCenter_Left);
        fTopRight.setDatas(eCenter_Right);
        
        // set the new edge and face references for the 3 bounding edges
        eTop_Left.nextLeftEdge = eLeft_Center;
        eTop_Left.leftFace = fTopLeft;
        eLeft_Right.nextLeftEdge = eRight_Center;
        eLeft_Right.leftFace = fBot;
        eRight_Top.nextLeftEdge = eTop_Center;
        eRight_Top.leftFace = fTopRight;
        
        // we remove the old face
        face.dispose();
        _faces.splice(_faces.indexOf(face), 1);
        
        // add new bounds references for Delaunay restoring
        __centerVertex = vCenter;
        __edgesToCheck.push(eTop_Left);
        __edgesToCheck.push(eLeft_Right);
        __edgesToCheck.push(eRight_Top);
        
        return vCenter;
    }
    
    public function restoreAsDelaunay() : Void
    {
        var edge : Edge;
        while( __edgesToCheck.length > 0 )
        {
            edge = __edgesToCheck.shift();
            if (edge.isReal && !edge.isConstrained && !Geom2D.isDelaunay(edge)) 
            {
                if (edge.nextLeftEdge.destinationVertex == __centerVertex) 
                {
                    __edgesToCheck.push(edge.nextRightEdge);
                    __edgesToCheck.push(edge.prevRightEdge);
                }
                else 
                {
                    __edgesToCheck.push(edge.nextLeftEdge);
                    __edgesToCheck.push(edge.prevLeftEdge);
                }
                flipEdge(edge);
            }
        }
    }
    
    // Delete a vertex IF POSSIBLE and then fill the hole with a new triangulation.
    // A vertex can be deleted if:
    // - it is free of constraint segment (no adjacency to any constrained edge)
    // - it is adjacent to exactly 2 contrained edges and is not an end point of any constraint segment
    public function deleteVertex(vertex : Vertex) : Bool
    {
        //Debug.trace("tryToDeleteVertex id " + vertex.id);
        var i : Int;
        var freeOfConstraint : Bool;
        var iterEdges : FromVertexToOutgoingEdges = new FromVertexToOutgoingEdges();
        iterEdges.fromVertex = vertex;
        iterEdges.realEdgesOnly = false;
        var edge : Edge;
        var outgoingEdges = new Array<Edge>();
        
        freeOfConstraint = vertex.fromConstraintSegments.length == 0;
        
        //Debug.trace("  -> freeOfConstraint " + freeOfConstraint);
        
        var bound  = new Array<Edge>();
        
        // declares moved out of if loop so haxe compiler knows they exist?
        var realA : Bool = false;
        var realB : Bool = false;
        var boundA: Array<Edge> = [];
        var boundB: Array<Edge> = [];
        
        if (freeOfConstraint) 
        {
            while ((edge = iterEdges.next())!=null)
            {
                outgoingEdges.push(edge);
                bound.push(edge.nextLeftEdge);
            }
        }
        else 
        {
            // we check if the vertex is an end point of a constraint segment
            var edges : Array<Edge>;
            for (i in 0...vertex.fromConstraintSegments.length){
                edges = vertex.fromConstraintSegments[i].edges;
                if (edges[0].originVertex == vertex || edges[edges.length - 1].destinationVertex == vertex) 
                {
                    //Debug.trace("  -> is end point of a constraint segment");
                    return false;
                }
            }  // we check the count of adjacent constrained edges  
            
            
            
            var count : Int = 0;
            while ((edge = iterEdges.next())!=null)
            {
                outgoingEdges.push(edge);
                
                if (edge.isConstrained) 
                {
                    count++;
                    if (count > 2) 
                    {
                        //Debug.trace("  -> count of adjacent constrained edges " + count);
                        return false;
                    }
                }
            }  //Debug.trace("process vertex deletion");    // if not disqualified, then we can process  
            
            
            
            
            /// TODO: Moved out of if loop so can be referenced later, not sure of full consequence
            boundA = new Array<Edge>();
            boundB = new Array<Edge>();
            var constrainedEdgeA : Edge = null;
            var constrainedEdgeB : Edge = null;
            var edgeA = new Edge();
            var edgeB = new Edge();
            /// TODO: Moved out of if loop so can be referenced later, not sure of full consequence
            ///var realA : Bool;
            ///var realB : Bool;
            _edges.push(edgeA);
            _edges.push(edgeB);
            for (i in 0...outgoingEdges.length){
                edge = outgoingEdges[i];
                if (edge.isConstrained) 
                {
                    if (constrainedEdgeA == null) 
                    {
                        edgeB.setDatas(edge.destinationVertex, edgeA, null, null, true, true);
                        boundA.push(edgeA);
                        boundA.push(edge.nextLeftEdge);
                        boundB.push(edgeB);
                        constrainedEdgeA = edge;
                    }
                    else if (constrainedEdgeB == null) 
                    {
                        edgeA.setDatas(edge.destinationVertex, edgeB, null, null, true, true);
                        boundB.push(edge.nextLeftEdge);
                        constrainedEdgeB = edge;
                    }
                }
                else 
                {
                    if (constrainedEdgeA == null) 
                        boundB.push(edge.nextLeftEdge)
                    else if (constrainedEdgeB == null) 
                        boundA.push(edge.nextLeftEdge)
                    else 
                    boundB.push(edge.nextLeftEdge);
                }
            }  // keep infos about reality  
            
            
            
            realA = constrainedEdgeA.leftFace.isReal;
            realB = constrainedEdgeB.leftFace.isReal;
            
            // we update the segments infos
            edgeA.fromConstraintSegments = constrainedEdgeA.fromConstraintSegments.slice(0);
            edgeB.fromConstraintSegments = edgeA.fromConstraintSegments;
            var index : Int;
            for (i in 0...vertex.fromConstraintSegments.length){
                edges = vertex.fromConstraintSegments[i].edges;
                index = edges.indexOf(constrainedEdgeA);
                if (index != -1) 
                {
                    edges.splice(index - 1, 2);
                    //TODO: check logic of insert
                    edges.insert(index - 1, edgeA);
                }
                else 
                {
                    var index2 = edges.indexOf(constrainedEdgeB) - 1;
                    edges.splice(index2, 2);
                    edges.insert(index2, edgeB);
                }
            }
        }  // Deletion of old faces and edges  
        
        
        
        var faceToDelete : Face;
        for (i in 0...outgoingEdges.length){
            edge = outgoingEdges[i];
            
            faceToDelete = edge.leftFace;
            _faces.splice(_faces.indexOf(faceToDelete), 1);
            faceToDelete.dispose();
            
            edge.destinationVertex.edge = edge.nextLeftEdge;
            
            _edges.splice(_edges.indexOf(edge.oppositeEdge), 1);
            edge.oppositeEdge.dispose();
            _edges.splice(_edges.indexOf(edge), 1);
            edge.dispose();
        }
        
        _vertices.splice(_vertices.indexOf(vertex), 1);
        vertex.dispose();
        
        // finally we triangulate
        if (freeOfConstraint) 
        {
            //Debug.trace("trigger single hole triangulation");
            triangulate(bound, true);
        }
        else 
        {
            //Debug.trace("trigger dual holes triangulation");
            triangulate(boundA, realA);
            triangulate(boundB, realB);
        }  //check();  
        
        
        
        return true;
    }
    
    ///// PRIVATE
    
    
    
    // untriangulate is usually used while a new edge insertion in order to delete the intersected edges
    // edgesList is a list of chained edges oriented from right to left
     function untriangulate(edgesList : Array<Edge>) : Void
    {
        // we clean useless faces and adjacent vertices
        var i : Int;
        var verticesCleaned = new Map<Vertex,Bool>();
        var currEdge : Edge;
        var outEdge : Edge;
        for (i in 0...edgesList.length){
            currEdge = edgesList[i];
            //
            if (verticesCleaned[currEdge.originVertex]== null) 
            {
                currEdge.originVertex.edge = currEdge.prevLeftEdge.oppositeEdge;
                verticesCleaned[currEdge.originVertex] = true;
            }
            if (verticesCleaned[currEdge.destinationVertex]==null) 
            {
                currEdge.destinationVertex.edge = currEdge.nextLeftEdge;
                verticesCleaned[currEdge.destinationVertex] = true;
            }  //  
            
            _faces.splice(_faces.indexOf(currEdge.leftFace), 1);
            currEdge.leftFace.dispose();
            if (i == edgesList.length - 1) 
            {
                _faces.splice(_faces.indexOf(currEdge.rightFace), 1);
                currEdge.rightFace.dispose();
            }  //  
        }  // finally we delete the intersected edges  
        
        
        
        for (i in 0...edgesList.length){
            currEdge = edgesList[i];
            _edges.splice(_edges.indexOf(currEdge.oppositeEdge), 1);
            _edges.splice(_edges.indexOf(currEdge), 1);
            currEdge.oppositeEdge.dispose();
            currEdge.dispose();
        }
    }
    
    // triangulate is usually used to fill the hole after deletion of a vertex from mesh or after untriangulation
    // - bounds is the list of edges in CCW bounding the surface to retriangulate,
     function triangulate(bound : Array<Edge>, isReal : Bool) : Void
    {
        if (bound.length < 2) 
        {
            Debug.trace("BREAK ! the hole has less than 2 edges");
            return;
        }
        // if the hole is a 2 edges polygon, we have a big problem
        else if (bound.length == 2) 
        {
            //throw new Error("BREAK ! the hole has only 2 edges! " + "  - edge0: " + bound[0].originVertex.id + " -> " + bound[0].destinationVertex.id + "  - edge1: " +  bound[1].originVertex.id + " -> " + bound[1].destinationVertex.id);
            Debug.trace("BREAK ! the hole has only 2 edges");
            Debug.trace("  - edge0: " + bound[0].originVertex.id + " -> " + bound[0].destinationVertex.id);
            Debug.trace("  - edge1: " +  bound[1].originVertex.id + " -> " + bound[1].destinationVertex.id);
            return;
        }
        // if the hole is a 3 edges polygon:
        else if (bound.length == 3) 
        {
            /*Debug.trace("the hole is a 3 edges polygon");
            Debug.trace("  - edge0: " + bound[0].originVertex.id + " -> " + bound[0].destinationVertex.id);
            Debug.trace("  - edge1: " + bound[1].originVertex.id + " -> " + bound[1].destinationVertex.id);
            Debug.trace("  - edge2: " + bound[2].originVertex.id + " -> " + bound[2].destinationVertex.id);*/
            var f = new Face();
            f.setDatas(bound[0], isReal);
            _faces.push(f);
            bound[0].leftFace = f;
            bound[1].leftFace = f;
            bound[2].leftFace = f;
            bound[0].nextLeftEdge = bound[1];
            bound[1].nextLeftEdge = bound[2];
            bound[2].nextLeftEdge = bound[0];
        }
        // if more than 3 edges, we process recursively:
        else 
        {
            //Debug.trace("the hole has " + bound.length + " edges");
            /*for (i in 0...bound.length){
                //Debug.trace("  - edge " + i + ": " + bound[i].originVertex.id + " -> " + bound[i].destinationVertex.id);
                
            }*/
            
            var baseEdge = bound[0];
            var vertexA = baseEdge.originVertex;
            var vertexB = baseEdge.destinationVertex;
            var vertexC : Vertex;
            var vertexCheck : Vertex;
            var circumcenter  = new Point2D();
            var radiusSquared : Float;
            var distanceSquared : Float;
            var isDelaunay : Bool = false;
            var index : Int = 0;
            var i : Int;
            for (i in 2...bound.length){
                vertexC = bound[i].originVertex;
                if (Geom2D.getRelativePosition2(vertexC.pos.x, vertexC.pos.y, baseEdge) == 1) 
                {
                    index = i;
                    isDelaunay = true;
                    Geom2D.getCircumcenter(vertexA.pos.x, vertexA.pos.y, vertexB.pos.x, vertexB.pos.y, vertexC.pos.x, vertexC.pos.y, circumcenter);
                    radiusSquared = (vertexA.pos.x - circumcenter.x) * (vertexA.pos.x - circumcenter.x) + (vertexA.pos.y - circumcenter.y) * (vertexA.pos.y - circumcenter.y);
                    // for perfect regular n-sides polygons, checking strict delaunay circumcircle condition is not possible, so we substract EPSILON to circumcircle radius:
                    radiusSquared -= Constants.EPSILON_SQUARED;
                    for (j in 2...bound.length){
                        if (j != i) 
                        {
                            vertexCheck = bound[j].originVertex;
                            distanceSquared = (vertexCheck.pos.x - circumcenter.x) * (vertexCheck.pos.x - circumcenter.x) + (vertexCheck.pos.y - circumcenter.y) * (vertexCheck.pos.y - circumcenter.y);
                            if (distanceSquared < radiusSquared) 
                            {
                                isDelaunay = false;
                                break;
                            }
                        }
                    }
                    
                    if (isDelaunay) 
                        break;
                }
            }
            
            if (!isDelaunay) 
            {
                // for perfect regular n-sides polygons, checking delaunay circumcircle condition is not possible
                Debug.trace("NO DELAUNAY FOUND");
                var s : String = "";
                for (i in 0...bound.length){
                    s += bound[i].originVertex.pos.x + " , ";
                    s += bound[i].originVertex.pos.y + " , ";
                    s += bound[i].destinationVertex.pos.x + " , ";
                    s += bound[i].destinationVertex.pos.y + " , ";
                }  //Debug.trace(s);  
                
                
                index = 2;
            }  //Debug.trace("index " + index + " on " + bound.length);  
            
            
            var edgeA : Edge = null;
            var edgeAopp : Edge = null;
            var edgeB : Edge = null;
            var edgeBopp : Edge;
            var boundA : Array<Edge>;
            var boundM : Array<Edge>;
            
            //TODO: is this correct??? should it be at **
            var boundB : Array<Edge>;
            
            if (index < (bound.length - 1)) 
            {
                edgeA = new Edge();
                edgeAopp = new Edge();
                _edges.push(edgeA);
                _edges.push(edgeAopp);
                edgeA.setDatas(vertexA, edgeAopp, null, null, isReal, false);
                edgeAopp.setDatas(bound[index].originVertex, edgeA, null, null, isReal, false);
                boundA = bound.slice(index);
                boundA.push(edgeA);
                triangulate(boundA, isReal);
            }
            
            if (index > 2) 
            {
                edgeB = new Edge();
                edgeBopp = new Edge();
                _edges.push(edgeB);
                _edges.push(edgeBopp);
                edgeB.setDatas(bound[1].originVertex, edgeBopp, null, null, isReal, false);
                edgeBopp.setDatas(bound[index].originVertex, edgeB, null, null, isReal, false);
                boundB = bound.slice(1, index);
                boundB.push(edgeBopp);
                triangulate(boundB, isReal);
            }
            // **
            if( index == 2 ) {
                boundM = [ baseEdge, bound[1], edgeAopp ];
            } else if ( index == (bound.length - 1) ){ 
                boundM = [ baseEdge, edgeB, bound[index] ];
            } else {  
                boundM = [ baseEdge, edgeB, edgeAopp ];
            }
            
            triangulate(boundM, isReal);
        }
    }
    
    
     function findPositionFromBounds(x : Float, y : Float) : Int
    {
        /* point positions relative to bounds
        1 | 2 | 3
        ------------
        8 | 0 | 4
        ------------
        7 | 6 | 5
        */
        
        if( x <= 0 ) {
            if( y <= 0 )             return 1
            else if( y >= _height )  return 7
            else                     return 8;
        } else if( x >= _width ) {
            if( y <= 0 )             return 3
            else if( y >= _height )  return 5
            else                     return 4;
        } else {
            if( y <= 0 )             return 2
            else if( y >= _height )  return 6
            else                     return 0;
        }
    }
    
    public function debug() : Void
    {
        var i : Int;
        for (i in 0..._vertices.length){
            Debug.trace("-- vertex " + _vertices[i].id);
            Debug.trace("  edge " + _vertices[i].edge.id + " - " + _vertices[i].edge);
            Debug.trace("  edge isReal: " + _vertices[i].edge.isReal);
        }
        for (i in 0..._edges.length){
            Debug.trace("-- edge " + _edges[i]);
            Debug.trace("  isReal " + _edges[i].id + " - " + _edges[i].isReal);
            Debug.trace("  nextLeftEdge " + _edges[i].nextLeftEdge);
            Debug.trace("  oppositeEdge " + _edges[i].oppositeEdge);
        }
    }
	
	public function getVerticesAndEdges() : { vertices:Array<Vertex>, edges:Array<Edge> }
	{
		var res = { vertices:[], edges:[] };
        var vertex : Vertex;
        var incomingEdge : Edge;
        var holdingFace : Face;
        
        var iterVertices : FromMeshToVertices;
        iterVertices = new FromMeshToVertices();
        iterVertices.fromMesh = this;
        
        var iterEdges : FromVertexToIncomingEdges;
        iterEdges = new FromVertexToIncomingEdges();
        var dictVerticesDone = new Map<Vertex,Bool>();
        
        while ((vertex = iterVertices.next()) != null)
        {
            dictVerticesDone[vertex] = true;
            if (!vertexIsInsideAABB(vertex, this)) 
                continue;  
            
			res.vertices.push(vertex);
            
            iterEdges.fromVertex = vertex;
            while ((incomingEdge = iterEdges.next()) != null)
            {
                if (!dictVerticesDone[incomingEdge.originVertex]) 
                {
					res.edges.push(incomingEdge);
                }
            }
        }
		return res;
	}
    
    inline public function vertexIsInsideAABB(vertex : Vertex, mesh : Mesh) : Bool 
	{
        return !(vertex.pos.x < 0 || vertex.pos.x > mesh.width || vertex.pos.y < 0 || vertex.pos.y > mesh.height); 
    }
}

