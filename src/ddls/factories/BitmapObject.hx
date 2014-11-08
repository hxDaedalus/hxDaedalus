package ddls.factories;


import ddls.data.Object;
import ddls.data.graph.Graph;
import ddls.data.math.Potrace;

import flash.display.BitmapData;
import flash.display.Shape;

class BitmapObject
{
    public function new(){}
    public static function buildFromBmpData(    bmpData: BitmapData
                                            ,   debugBmp: BitmapData = null
                                            ,   debugShape : Shape = null
                                            ) : Object
    {
        var i : Int;
        var j : Int;
        
        // OUTLINES STEP-LIKE SHAPES GENERATION
        var shapes : Array<Array<Float>> = Potrace.buildShapes(bmpData, debugBmp, debugShape);
        
        // GRAPHS OF POTENTIAL SEGMENTS GENERATION
        var graphs = new Array<Graph>();
        for (i in 0...shapes.length){
            graphs.push( Potrace.buildGraph(shapes[i]) );
        }  // OPTIMIZED POLYGONS GENERATION  
        
        
        
        var polygons : Array<Array<Float>> = new Array<Array<Float>>();
        for (i in 0...graphs.length){
            polygons.push(Potrace.buildPolygon(graphs[i], debugShape));
        }  // OBJECT GENERATION  
        
        
        
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
