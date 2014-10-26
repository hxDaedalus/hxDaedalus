package ddls.factories;


import ddls.data.DObject;
import ddls.data.graph.Graph;
import ddls.data.math.Potrace;

import flash.display.BitmapData;
import flash.display.Shape;

class BitmapObjectFactory
{
    
    public static function buildFromBmpData(    bmpData: BitmapData
                                            ,   debugBmp: BitmapData = null
                                            ,   debugShape : Shape = null
                                            ) : DObject
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
        
        
        
        var obj : DObject = new DObject();
        for (i in 0...polygons.length){
            j = 0;
            while (j < polygons[i].length - 2)
            {   
                obj.coordinates = obj.coordinates.concat([ polygons[i][j], polygons[i][j + 1], polygons[i][j + 2], polygons[i][j + 3] ]);
                j += 2;
            }
            obj.coordinates = obj.coordinates.concat([polygons[i][0], polygons[i][1], polygons[i][j], polygons[i][j + 1] ]);
        }
        
        return obj;
    }

    public function new()
    {
    }
}
