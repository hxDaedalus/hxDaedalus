package DDLS.factories
{
	import DDLS.data.DDLSMesh;
	import DDLS.data.graph.DDLSGraph;
	import DDLS.data.graph.DDLSGraphEdge;
	import DDLS.data.graph.DDLSGraphNode;
	import DDLS.data.math.DDLSGeom2D;
	import DDLS.data.math.DDLSPotrace;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	public class DDLSBitmapMeshFactory
	{
		
		public static function buildFromBmpData(bmpData:BitmapData
											, debugBmp:BitmapData=null
											, debugShape:Shape=null):DDLSMesh
		{
			var i:int;
			var j:int;
			
			// OUTLINES STEP-LIKE SHAPES GENERATION
			var shapes:Vector.<Vector.<Number>> = DDLSPotrace.buildShapes(bmpData, debugBmp, debugShape);
			
			// GRAPHS OF POTENTIAL SEGMENTS GENERATION
			var graphs:Vector.<DDLSGraph> = new Vector.<DDLSGraph>();
			for (i=0 ; i<shapes.length ; i++)
			{
				graphs.push( DDLSPotrace.buildGraph(shapes[i]) );
			}
			
			// OPTIMIZED POLYGONS GENERATION
			var polygons:Vector.<Vector.<Number>> = new Vector.<Vector.<Number>>();
			for (i=0 ; i<graphs.length ; i++)
			{
				polygons.push( DDLSPotrace.buildPolygon(graphs[i], debugShape) );
			}
			
			// MESH GENERATION
			var mesh:DDLSMesh = DDLSRectMeshFactory.buildRectangle(bmpData.width, bmpData.height);
			for (i=0 ; i<polygons.length ; i++)
			{
				for (j=0 ; j<polygons[i].length-2 ; j+=2)
					mesh.insertConstraintSegment(polygons[i][j], polygons[i][j+1], polygons[i][j+2], polygons[i][j+3]);
				mesh.insertConstraintSegment(polygons[i][0], polygons[i][1], polygons[i][j], polygons[i][j+1]);
			}
			
			return mesh;
		}
		
	}
}