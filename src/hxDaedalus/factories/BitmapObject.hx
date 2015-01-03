package hxDaedalus.factories;


import hxDaedalus.data.math.ShapeSimplifier;
import hxDaedalus.data.Object;
import hxDaedalus.data.graph.Graph;
import hxDaedalus.data.math.Potrace;
import hxDaedalus.debug.Debug;
import hxDaedalus.graphics.SimpleDrawingContext;
#if ( !openfl && !nme && !html5 && js ) 
	import hxDaedalus.graphics.js.CanvasPixelMatrix;
#else
	import hxDaedalus.graphics.Pixels;
#end
#if ( !openfl && !nme && !html5 && js )
	typedef Pixels = hxDaedalus.graphics.js.CanvasPixelMatrix;
#end

class BitmapObject
{
    public function new(){}
    public static function buildFromBmpData(    bmpData: Pixels
											,	simplificationEpsilon:Float = 1
                                            ,   debugBmp: Pixels = null
                                            ,   debugShape : SimpleDrawingContext = null
                                            ) : Object
    {
        var i : Int;
        var j : Int;
        
		Debug.assertTrue(bmpData.width > 0 && bmpData.height > 0, 'Invalid `bmpData` size (${bmpData.width}, ${bmpData.height})');
		
        // OUTLINES STEP-LIKE SHAPES GENERATION
        var shapes : Array<Array<Float>> = Potrace.buildShapes(bmpData, debugBmp, debugShape);
        
		// SIMPLIFY SHAPES (REDUCE NUMBER OF POINTS)
		if (simplificationEpsilon >= 1) {
			for (i in 0...shapes.length) {
				shapes[i] = ShapeSimplifier.simplify(shapes[i], simplificationEpsilon);
			}
		}
		
        // GRAPHS OF POTENTIAL SEGMENTS GENERATION
        var graphs = new Array<Graph>();
        for (i in 0...shapes.length){
            graphs.push( Potrace.buildGraph(shapes[i]) );
        }  
		
        // OPTIMIZED POLYGONS GENERATION  
        var polygons : Array<Array<Float>> = new Array<Array<Float>>();
        for (i in 0...graphs.length){
            polygons.push(Potrace.buildPolygon(graphs[i], debugShape));
        }   
        
        // OBJECT GENERATION  
        var obj : Object = new Object();
        for (i in 0...polygons.length){
            j = 0;
            while (j < polygons[i].length - 2)
            {   
                obj.coordinates.push(polygons[i][j]);
                obj.coordinates.push(polygons[i][j + 1]);
                obj.coordinates.push(polygons[i][j + 2]);
                obj.coordinates.push(polygons[i][j + 3]);
                j += 2;
            }
            obj.coordinates.push(polygons[i][0]);
            obj.coordinates.push(polygons[i][1]);
            obj.coordinates.push(polygons[i][j]);
            obj.coordinates.push(polygons[i][j + 1]);        
        }
        return obj;
    }
    
}
