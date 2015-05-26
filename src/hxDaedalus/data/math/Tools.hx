package hxDaedalus.data.math;
import hxDaedalus.data.ConstraintSegment;
import hxDaedalus.data.Edge;
import hxDaedalus.data.Face;
import hxDaedalus.data.Mesh;
import hxDaedalus.data.Vertex;
import hxDaedalus.data.graph.Graph;
import hxDaedalus.factories.RectMesh;
import hxDaedalus.graphics.Pixels;
import hxDaedalus.data.math.Point2D;
import hxDaedalus.data.Object;
import hxDaedalus.ai.EntityAI;
import hxDaedalus.ai.PathFinder;
import hxDaedalus.ai.trajectory.LinearPathSampler;

class Tools {

    static public function extractMeshFromBitmap( pixels:Pixels, vertices:Array<Point2D>, triangles:Array<Int>): Void {
           
            // OUTLINES STEP-LIKE SHAPES GENERATION
            var shapes = Potrace.buildShapes( pixels );
           
            // GRAPHS OF POTENTIAL SEGMENTS GENERATION
            var graphs:Array<Graph> = new Array<Graph>();
            for( i in 0...shapes.length ) graphs.push( Potrace.buildGraph(shapes[i]) );
           
            // OPTIMIZED POLYGONS GENERATION
            var polygons = new Array<Array<Float>>();
            for( i in  0...graphs.length ) polygons.push( Potrace.buildPolygon(graphs[i]));
           
            // MESH GENERATION
            var mesh = RectMesh.buildRectangle( pixels.width, pixels.height);
            var edges = new Array<Edge>(); // WE KEEP TRACK OF 1 EDGE BY SHAPE
            var segment: ConstraintSegment;
			var j2: Int = 0;
            for( i in 0...polygons.length )
            {
            	for( j in 0...polygons[i].length-2 )// j+=2)
               	{
					if( (j-1)%2 == 0 ) continue;
                    segment = mesh.insertConstraintSegment(polygons[i][j], polygons[i][j+1], polygons[i][j+2], polygons[i][j+3]);
                   	if( j == 0 ){
                    	if( segment.edges[0].originVertex.pos.x == polygons[i][j] && segment.edges[0].originVertex.pos.y == polygons[i][j+1] ){
                        	edges.push(segment.edges[0]);
                        } else {
                            edges.push(segment.edges[0].oppositeEdge);
						}
                    }
						j2 = j;
            	}
                mesh.insertConstraintSegment(polygons[i][0], polygons[i][1], polygons[i][j2], polygons[i][j2+1]);
            }
           
            // FINAL EXTRACTION
            var indicesDict = new Map<Vertex	,Int>();
            
			var vertex:Vertex;
            var point:Point2D;
            for( i in 0...mesh._vertices.length ){
            	vertex = mesh._vertices[i];
                if( vertex.isReal
                	&& vertex.pos.x > 0 && vertex.pos.x < pixels.width
                    && vertex.pos.y > 0 && vertex.pos.y < pixels.height
					){
                    	point = new Point2D( vertex.pos.x, vertex.pos.y );
                        vertices.push( point );
                        indicesDict[ vertex ] = vertices.length - 1;
                    }
            }
           
            var facesDone = new Map<Face,Bool>();
            var openFacesList = new Array<Face>();
            for( i in 0...edges.length ) openFacesList.push( edges[ i ].rightFace );
            var currFace:Face;
            while( openFacesList.length > 0 )
            {
                    currFace = openFacesList.pop();
                    if( facesDone[ currFace ] ) continue;
                   
                    triangles.push(indicesDict[currFace.edge.originVertex]);
                    triangles.push(indicesDict[currFace.edge.nextLeftEdge.originVertex]);
                    triangles.push(indicesDict[currFace.edge.nextLeftEdge.destinationVertex]);
                   
                    if (! currFace.edge.isConstrained)
                            openFacesList.push(currFace.edge.rightFace);
                    if (! currFace.edge.nextLeftEdge.isConstrained)
                            openFacesList.push(currFace.edge.nextLeftEdge.rightFace);
                    if (! currFace.edge.prevLeftEdge.isConstrained)
                            openFacesList.push(currFace.edge.prevLeftEdge.rightFace);
                   
                    facesDone[ currFace ] = true;
            }
    }
    
    static public function extractFillTrianglesFromObjects( arrObject: Array<Object>, w: Int, h: Int, vertices: Array<Point2D>, triangles: Array<Int> ): Void {
        var mesh = RectMesh.buildRectangle( w, h );
        for( i in 0...arrObject.length ) mesh.insertObject( arrObject[ i ] );
        var entityAI = new EntityAI();
        entityAI.radius = 0;
        entityAI.x = 10;
        entityAI.y = 10;
        var pathfinder = new PathFinder();
        pathfinder.entity = entityAI;
        pathfinder.mesh = mesh;
        var routePath = new Array<Float>();
        var pathSampler = new LinearPathSampler();
        pathSampler.entity = entityAI;
        pathSampler.samplingDistance = 10;
        pathSampler.path = routePath;
        var validEdges = new Array<Int>();
        var outerEdges = new Array<Int>();
        mesh.traverse( function( vertex: Vertex ){}, function( edge : Edge ) : Void {
       		var p0x = edge.originVertex.pos.x;
        	var p0y = edge.originVertex.pos.y;
        	var p1x = edge.destinationVertex.pos.x;
        	var p1y = edge.destinationVertex.pos.y;
        	var px = ( p0x + p1x )/2;
        	var py = ( p0y + p1y )/2;
            if ( edge.isConstrained ){
                validEdges.push( edge.id );
               	outerEdges.push( edge.id );
            } else if( edge.destinationVertex.pos.x != 0
                && edge.destinationVertex.pos.y != 0
                && edge.destinationVertex.pos.x != 600
                && edge.destinationVertex.pos.y != 400 ){
                	routePath = new Array<Float>();
                    pathfinder.findPath( px, py, routePath );
                    if( routePath.length == 0 ){
                        validEdges.push( edge.id );
                    }
            }
        } );
        var indicesDict = new Map<Vertex,Int>();
		var vertex:Vertex;
        var point:Point2D;
        for( i in 0...mesh._vertices.length ){
        	vertex = mesh._vertices[i];
            if( vertex.isReal
                && vertex.pos.x > 0 && vertex.pos.x < w
                && vertex.pos.y > 0 && vertex.pos.y < h
				&& vertex.edge.isReal ){
                    point = new Point2D( vertex.pos.x, vertex.pos.y );
                    vertices.push( point );
                    indicesDict[ vertex ] = vertices.length - 1;
            }
        }
        var facesDone = new Map<Face,Bool>();
        var openFacesList = new Array<Face>();
        for( i in 0...mesh._edges.length ) openFacesList.push( mesh._edges[ i ].rightFace );
        var currFace:Face;
        var currEdge: Edge;
        var leftEdge: Edge;
        var left2Edge: Edge;
        while( openFacesList.length > 0 )
        {
            currFace = openFacesList.pop();
            if( facesDone[ currFace ] ) continue;
            currEdge = currFace.edge;
            leftEdge = currEdge.nextLeftEdge;
            left2Edge = currEdge.nextLeftEdge.nextLeftEdge;
            var a = validEdges.indexOf( currEdge.id );
            var b = validEdges.indexOf( leftEdge.id );
            var c = validEdges.indexOf( left2Edge.id );
            if( !(a == -1 && b == -1 || a == -1 && c == -1 || b == -1 && c == -1 )  ){
                triangles.push(indicesDict[currEdge.originVertex]);
                triangles.push(indicesDict[currEdge.nextLeftEdge.originVertex]);
                triangles.push(indicesDict[currEdge.nextLeftEdge.destinationVertex]);
            }
            if (! currFace.edge.isConstrained) openFacesList.push(currFace.edge.rightFace);
            if (! currFace.edge.nextLeftEdge.isConstrained) openFacesList.push(currFace.edge.nextLeftEdge.rightFace);
            if (! currFace.edge.prevLeftEdge.isConstrained) openFacesList.push(currFace.edge.prevLeftEdge.rightFace);
			facesDone[ currFace ] = true;
       	}
    }
}
