package ddls.ai;


import ddls.data.Edge;
import ddls.data.Face;
import ddls.data.Mesh;
import ddls.data.Vertex;
import ddls.data.math.Geom2D;
import ddls.data.math.Point2D;
import ddls.iterators.FromFaceToInnerEdges;

import haxe.ds.StringMap;


class AStar {
    
    public var radius(get, set) : Float;
    var _radius : Float;
    public var mesh(never, set) : Mesh;
    var _mesh : Mesh;
    
    var closedFaces:  Map<Face,Bool>;
    var sortedOpenedFaces : Array<Face>;
    var openedFaces : Map<Face,Null<Bool>>;
    var entryEdges : Map<Face,Edge>;
    var entryX : Map<Face,Float>;
    var entryY : Map<Face,Float>;
    var scoreF : Map<Face,Float>;
    var scoreG : Map<Face,Float>;
    var scoreH : Map<Face,Float>;
    var predecessor : Map<Face,Face>;
    
    var iterEdge : FromFaceToInnerEdges;
    
    var radiusSquared : Float;
    var diameter : Float;
    var diameterSquared : Float;
    var fromFace : Face;
    var toFace : Face;
    var curFace : Face;
    
    public function new() {
        iterEdge = new FromFaceToInnerEdges();
    }
    
    public function dispose() : Void {
        _mesh = null;
        closedFaces = null;
        sortedOpenedFaces = null;
        openedFaces = null;
        entryEdges = null;
        entryX = null;
        entryY = null;
        scoreF = null;
        scoreG = null;
        scoreH = null;
        predecessor = null;
    }
    
    function get_radius() : Float {
        return _radius;
    }
    
    function set_radius(value : Float) : Float {
        _radius = value;
        radiusSquared = _radius * _radius;
        diameter = _radius * 2;
        diameterSquared = diameter * diameter;
        return value;
    }
    
    function set_mesh(value : Mesh) : Mesh {
        _mesh = value;
        return value;
    }
    
    public function findPath(   fromX : Float,  fromY : Float
                            ,   toX : Float,    toY : Float
                            ,   resultListFaces : Array<Face>
                            ,   resultListEdges : Array<Edge>) : Void {
        //trace("findPath");
        closedFaces = new Map<Face,Bool>();
        sortedOpenedFaces = new Array<Face>();
        openedFaces = new Map<Face,Bool>();
        entryEdges = new Map<Face,Edge>();
        entryX = new Map<Face,Float>();
        entryY = new Map<Face,Float>();
        scoreF = new Map<Face,Float>();
        scoreG = new Map<Face,Float>();
        scoreH = new Map<Face,Float>();
        predecessor = new Map<Face,Face>();
        
        var loc : Intersection;
        var locEdge : Edge;
        var locVertex : Vertex;
        var distance : Float;
        var p1 : Point2D;
        var p2 : Point2D;
        var p3 : Point2D;
        //
        loc = Geom2D.locatePosition(fromX, fromY, _mesh);
        switch( loc ){
            case EVertex( vertex ):
                locVertex = vertex;
                return;
            case EEdge( edge ):
                locEdge = edge;
                if (locEdge.isConstrained) return;
                fromFace = locEdge.leftFace;
            case EFace( face ):
                fromFace = face;
            case ENull:
                //
        }

        
        loc = Geom2D.locatePosition(toX, toY, _mesh);
        switch( loc ){
            case EVertex( vertex ):
                locVertex = vertex;
                toFace = locVertex.edge.leftFace;
            case EEdge( edge ):
                locEdge = edge;
                toFace = locVertex.edge.leftFace;
            case EFace( face ):
                toFace = face;
            case ENull:
        }
        /*fromFace.colorDebug = 0xFF0000;
        toFace.colorDebug = 0xFF0000;
        trace( "from face:", fromFace );
        trace( "to face:", toFace );*/
        
        sortedOpenedFaces.push( fromFace );
        entryEdges[ fromFace ] = null;
        entryX[ fromFace ] = fromX;
        entryY[ fromFace ] = fromY;
        scoreG[ fromFace ] = 0;
        var dist: Float = Math.sqrt((toX - fromX) * (toX - fromX) + (toY - fromY) * (toY - fromY));
        scoreH[ fromFace ] = dist;
        scoreF[ fromFace ] = dist;
        
        var innerEdge : Edge;
        var neighbourFace : Face;
        var f : Float;
        var g : Float;
        var h : Float;
        var fromPoint = new Point2D();
        var entryPoint = new Point2D();
        var distancePoint = new Point2D();
        var fillDatas : Bool;
        while( true ){
            // no path found
            if( sortedOpenedFaces.length == 0 ){
                trace("AStar no path found");
                curFace = null;
                break;
            }  // we reached the target face  
            
            curFace = sortedOpenedFaces.pop();
            if( curFace == toFace ) break;
            // we continue the search  
            iterEdge.fromFace = curFace;
            while( ( innerEdge = iterEdge.next() )!= null ) {
                if( innerEdge.isConstrained ) continue;
                neighbourFace = innerEdge.rightFace;
                if( closedFaces[ neighbourFace ] == null ) {
                    if (curFace != fromFace && _radius > 0 && !isWalkableByRadius( entryEdges[ curFace ], curFace, innerEdge) ) {
                        //                            trace("- NOT WALKABLE -");
                        //                            trace( "from", ddlsEdge(__entryEdges[__curFace]).originVertex.id, ddlsEdge(__entryEdges[__curFace]).destinationVertex.id );
                        //                            trace( "to", innerEdge.originVertex.id, innerEdge.destinationVertex.id );
                        //                            trace("----------------");
                        continue;
                    }
                    
                    fromPoint.x = entryX[ curFace ];
                    fromPoint.y = entryY[ curFace ];
                    entryPoint.x = fromPoint.x;
                    entryPoint.y = fromPoint.y;
                    entryPoint.x = ( innerEdge.originVertex.pos.x + innerEdge.destinationVertex.pos.x ) / 2;
                    entryPoint.x = ( innerEdge.originVertex.pos.y + innerEdge.destinationVertex.pos.y ) / 2;
                    distancePoint.x = entryPoint.x - toX;
                    distancePoint.y = entryPoint.y - toY;
                    h = distancePoint.length;
                    distancePoint.x = fromPoint.x - entryPoint.x;
                    distancePoint.y = fromPoint.y - entryPoint.y;
                    g = scoreG[ curFace ] + distancePoint.length;
                    f = h + g;
                    fillDatas = false;
                    if (!openedFaces[ neighbourFace ] ) 
                    {
                        sortedOpenedFaces.push( neighbourFace );
                        openedFaces[ neighbourFace ] = true;
                        fillDatas = true;
                    }
                    else if( scoreF[ neighbourFace ] > f ) 
                    {
                        fillDatas = true;
                    }
                    if (fillDatas) 
                    {
                        entryEdges[ neighbourFace ] = innerEdge;
                        entryX[ neighbourFace ] = entryPoint.x;
                        entryY[ neighbourFace ] = entryPoint.y;
                        scoreF[ neighbourFace ] = f;
                        scoreG[ neighbourFace ] = g;
                        scoreH[ neighbourFace ] = h;
                        predecessor[ neighbourFace ] = curFace;
                    }
                }
            }  //  
            
            openedFaces[ curFace ] = null;
            closedFaces[ curFace ] = true;
            sortedOpenedFaces.sort( sortingFaces );
        }  // if we didn't find a path  
        
        
        
        if (curFace == null) 
            return;  // else we build the path  ;
        
        
        
        resultListFaces.push( curFace );
        //curFace.colorDebug = 0x0000FF;
        while( curFace != fromFace ){
            resultListEdges.unshift( entryEdges[ curFace ] );
            //entryEdges[__curFace].colorDebug = 0xFFFF00;
            //entryEdges[__curFace].oppositeEdge.colorDebug = 0xFFFF00;
            curFace = predecessor[ curFace ];
            //curFace.colorDebug = 0x0000FF;
            resultListFaces.unshift( curFace );
        }
    }
    
    // faces with low distance value are at the end of the array
    private function sortingFaces( a: Face, b: Face ): Int {
        if ( scoreF[ a ] == scoreF[ b ] ) {
            return 0;
        } else if ( scoreF[ a ] < scoreF[ b ] ) {
            return 1;
        } else { 
            return -1;
        }
    }
    
    private function isWalkableByRadius( fromEdge : Edge, throughFace : Face, toEdge : Edge ) : Bool {
        var vA : Vertex = null;  // the vertex on fromEdge not on toEdge  
        var vB : Vertex = null;  // the vertex on toEdge not on fromEdge  
        var vC : Vertex = null;  // the common vertex of the 2 edges (pivot)  
        
        // we identify the points
        var aOriginVertex = fromEdge.originVertex;
        if( aOriginVertex == toEdge.originVertex ) {
                vA = fromEdge.destinationVertex;
                vB = toEdge.destinationVertex;
                vC = fromEdge.originVertex;
        } else if( aOriginVertex == toEdge.destinationVertex ){
                vA = fromEdge.originVertex;
                vB = toEdge.originVertex;
                vC = fromEdge.destinationVertex;
        } else if( aOriginVertex == toEdge.destinationVertex ){
                vA = fromEdge.destinationVertex;
                vB = toEdge.originVertex;
                vC = fromEdge.originVertex;
        } else if( aOriginVertex == toEdge.originVertex) {
                vA = fromEdge.originVertex;
                vB = toEdge.destinationVertex;
                vC = fromEdge.destinationVertex;

        }
        
        var dot : Float;
        var result : Bool;
        var distSquared : Float;
        
        // if we have a right or obtuse angle on CAB
        dot = (vC.pos.x - vA.pos.x) * (vB.pos.x - vA.pos.x) + (vC.pos.y - vA.pos.y) * (vB.pos.y - vA.pos.y);
        if( dot <= 0 ){
            // we compare length of AC with radius
            distSquared = (vC.pos.x - vA.pos.x) * (vC.pos.x - vA.pos.x) + (vC.pos.y - vA.pos.y) * (vC.pos.y - vA.pos.y);
            if (distSquared >= diameterSquared) {
                return true;
            } else { 
                return false;
            }
        }  // if we have a right or obtuse angle on CBA  
        
        
        
        dot = (vC.pos.x - vB.pos.x) * (vA.pos.x - vB.pos.x) + (vC.pos.y - vB.pos.y) * (vA.pos.y - vB.pos.y);
        if( dot <= 0 ) {
            // we compare length of BC with radius
            distSquared = (vC.pos.x - vB.pos.x) * (vC.pos.x - vB.pos.x) + (vC.pos.y - vB.pos.y) * (vC.pos.y - vB.pos.y);
            if (distSquared >= diameterSquared) {
                return true;
            } else { 
                return false;
            }
        }  // we identify the adjacent edge (facing pivot vertex)  
        
        
        
        var adjEdge : Edge;
        if( throughFace.edge != fromEdge && throughFace.edge.oppositeEdge != fromEdge && throughFace.edge != toEdge && throughFace.edge.oppositeEdge != toEdge) {
            adjEdge = throughFace.edge;
        } else if( throughFace.edge.nextLeftEdge != fromEdge && throughFace.edge.nextLeftEdge.oppositeEdge != fromEdge && throughFace.edge.nextLeftEdge != toEdge && throughFace.edge.nextLeftEdge.oppositeEdge != toEdge ){
            adjEdge = throughFace.edge.nextLeftEdge;
        } else { 
            adjEdge = throughFace.edge.prevLeftEdge;
        }
        // if the adjacent edge is constrained, we check the distance of orthognaly projected
        if( adjEdge.isConstrained ){
            var proj = new Point2D( vC.pos.x, vC.pos.y );
            Geom2D.projectOrthogonaly( proj, adjEdge );
            distSquared = (proj.x - vC.pos.x) * (proj.x - vC.pos.x) + (proj.y - vC.pos.y) * (proj.y - vC.pos.y);
            if( distSquared >= diameterSquared ) {
                return true;
            } else { 
                return false;
            }
        }
        // if the adjacent is not constrained
        else 
        {
            var distSquaredA : Float = (vC.pos.x - vA.pos.x) * (vC.pos.x - vA.pos.x) + (vC.pos.y - vA.pos.y) * (vC.pos.y - vA.pos.y);
            var distSquaredB : Float = (vC.pos.x - vB.pos.x) * (vC.pos.x - vB.pos.x) + (vC.pos.y - vB.pos.y) * (vC.pos.y - vB.pos.y);
            if( distSquaredA < diameterSquared || distSquaredB < diameterSquared ){
                return false;
            } else {
                var vFaceToCheck = new Array<Face>();
                var vFaceIsFromEdge = new Array<Edge>();
                var facesDone = new Map<Face,Bool>();
                vFaceIsFromEdge.push(adjEdge);
                if( adjEdge.leftFace == throughFace ){
                    vFaceToCheck.push(adjEdge.rightFace);
                    facesDone[adjEdge.rightFace] = true;
                } else {
                    vFaceToCheck.push(adjEdge.leftFace);
                    facesDone[ adjEdge.leftFace ] = true;
                }
                
                var currFace : Face;
                var faceFromEdge : Edge;
                var currEdgeA : Edge;
                var nextFaceA : Face;
                var currEdgeB : Edge;
                var nextFaceB : Face;
                while( vFaceToCheck.length > 0 ){
                    currFace = vFaceToCheck.shift();
                    faceFromEdge = vFaceIsFromEdge.shift();
                    
                    
                    if( currFace.edge == faceFromEdge || currFace.edge == faceFromEdge.oppositeEdge ){
                        // we identify the 2 edges to evaluate
                        currEdgeA = currFace.edge.nextLeftEdge;
                        currEdgeB = currFace.edge.nextLeftEdge.nextLeftEdge;
                    } else if( currFace.edge.nextLeftEdge == faceFromEdge || currFace.edge.nextLeftEdge == faceFromEdge.oppositeEdge ){   
                        // we identify the faces related to the 2 edges
                        currEdgeA = currFace.edge;
                        currEdgeB = currFace.edge.nextLeftEdge.nextLeftEdge;
                    } else {
                        currEdgeA = currFace.edge;
                        currEdgeB = currFace.edge.nextLeftEdge;
                    }
                    
                    if( currEdgeA.leftFace == currFace ){ 
                        nextFaceA = currEdgeA.rightFace;
                    } else { 
                        nextFaceA = currEdgeA.leftFace;
                    }
                    if( currEdgeB.leftFace == currFace ){
                        nextFaceB = currEdgeB.rightFace;
                    } else { 
                        nextFaceB = currEdgeB.leftFace;
                    }
                    // we check if the next face is not already in pipe
                    // and if the edge A is close to pivot vertex
                    if( !facesDone[ nextFaceA ] && Geom2D.distanceSquaredVertexToEdge( vC, currEdgeA ) < diameterSquared ){
                        // if the edge is constrained
                        if( currEdgeA.isConstrained ){
                            // so it is not walkable
                            return false;
                        } else {
                            // if the edge is not constrained, we continue the search
                            vFaceToCheck.push(nextFaceA);
                            vFaceIsFromEdge.push(currEdgeA);
                            facesDone[ nextFaceA ] = true;
                        }
                    }  // and if the edge B is close to pivot vertex    // we check if the next face is not already in pipe  
                    
                    if( !facesDone[ nextFaceB ] && Geom2D.distanceSquaredVertexToEdge(vC, currEdgeB) < diameterSquared ){
                        // if the edge is constrained
                        if( currEdgeB.isConstrained ){
                            // so it is not walkable
                            return false;
                        } else {
                            // if the edge is not constrained, we continue the search
                            vFaceToCheck.push( nextFaceB );
                            vFaceIsFromEdge.push( currEdgeB );
                            facesDone[ nextFaceB ] = true;
                        }
                    }
                }  // if we didn't previously meet a constrained edge  
                
                return true;
            }
        }
        
        return true;
    }
}
