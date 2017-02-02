package hxDaedalus.data.math;
import hxDaedalus.data.ConstraintSegment;
import hxDaedalus.data.Edge;
import hxDaedalus.data.Face;
import hxDaedalus.data.Mesh;
import hxDaedalus.data.Vertex;
import hxDaedalus.data.graph.Graph;
import hxDaedalus.factories.RectMesh;
import hxPixels.Pixels;
import hxDaedalus.data.math.Point2D;
import hxDaedalus.data.Object;

@:expose
class Tools {

    static public function extractMeshFromBitmap( pixels:Pixels, vertices:Array<Point2D>, triangles:Array<Int>): Mesh {

		// OUTLINES STEP-LIKE SHAPES GENERATION
		var shapes = Potrace.buildShapes( pixels );

		return extractMeshFromShapes( shapes, pixels.width, pixels.height, vertices, triangles );
    }

    /**
     * Extracts a triangulated mesh from `shapes`.
	 *
     * @param	shapes			coords of polys to triangulate (in CCW winding for non-holes, and CW winding for holes)
     * @param	width			right boundary for x coords
     * @param	height			bottom boundary for y coords
     * @param	vertices		triangulated vertices will be added to this array
     * @param	triangles		computed triangles (indexing into `vertices`) will be added to this array
	 * @param	invertWinding	if `true` the winding of the passed polygons will be interpreted as inverted (so CW for outer polys, and CCW for holes)
	 *
	 * @return the triangulated mesh,
     */
	static public function extractMeshFromShapes( shapes:Array<Array<Float>>, width:Int, height:Int, vertices:Array<Point2D>, triangles:Array<Int>, invertWinding: Bool = false ): Mesh {

		// GRAPHS OF POTENTIAL SEGMENTS GENERATION
		var graphs:Array<Graph> = new Array<Graph>();
		for( i in 0...shapes.length ) graphs.push( Potrace.buildGraph(shapes[i]) );

		// OPTIMIZED POLYGONS GENERATION
		var polygons = new Array<Array<Float>>();
		for( i in  0...graphs.length ) polygons.push( Potrace.buildPolygon(graphs[i]));

		// MESH GENERATION
		var mesh = RectMesh.buildRectangle( width, height);
		var edges = new Array<Edge>(); // WE KEEP TRACK OF 1 EDGE BY SHAPE
		var segment: ConstraintSegment;

		for( i in 0...polygons.length )
		{
			var j = 0;
			while (j < polygons[i].length - 2) {
				segment = mesh.insertConstraintSegment(polygons[i][j], polygons[i][j+1], polygons[i][j+2], polygons[i][j+3]);
				if( j == 0 ){
					if( segment.edges[0].originVertex.pos.x == polygons[i][j] && segment.edges[0].originVertex.pos.y == polygons[i][j+1] ){
						if(! invertWinding ){
							edges.push(segment.edges[0]);
						} else {
							edges.push(segment.edges[0].oppositeEdge);
						}
					} else {
						if(! invertWinding ){
							edges.push(segment.edges[0].oppositeEdge);
						}else {
							edges.push(segment.edges[0]);
						}
					}
				}
				j += 2;
			}
			mesh.insertConstraintSegment(polygons[i][0], polygons[i][1], polygons[i][j], polygons[i][j+1]);
		}

		// FINAL EXTRACTION
		var indicesDict = new Map<Vertex, Int>();

		var vertex:Vertex;
		var point:Point2D;
		for( i in 0...mesh._vertices.length ){
			vertex = mesh._vertices[i];
			if( vertex.isReal
				&& vertex.pos.x > 0 && vertex.pos.x < width
				&& vertex.pos.y > 0 && vertex.pos.y < height
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

			if (! currFace.edge.isConstrained) openFacesList.push(currFace.edge.rightFace);
			if (! currFace.edge.nextLeftEdge.isConstrained) openFacesList.push(currFace.edge.nextLeftEdge.rightFace);
			if (! currFace.edge.prevLeftEdge.isConstrained) openFacesList.push(currFace.edge.prevLeftEdge.rightFace);

			facesDone[ currFace ] = true;
		}

		return mesh;
    }
}
