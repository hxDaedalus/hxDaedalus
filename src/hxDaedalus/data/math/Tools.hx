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

}