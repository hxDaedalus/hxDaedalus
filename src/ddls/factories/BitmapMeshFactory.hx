package ddls.factories;


import ddls.data.Mesh;
import ddls.data.graph.Graph;
import ddls.data.graph.GraphEdge;
import ddls.data.graph.GraphNode;
import ddls.data.math.Geom2D;
import ddls.data.math.Potrace;

import flash.display.BitmapData;
import flash.display.Shape;
import flash.geom.Point;

class BitmapMeshFactory
{
    
    public static function buildFromBmpData(    bmpData:    BitmapData
                                            ,   debugBmp:   BitmapData = null
                                            ,   debugShape: Shape = null
                                            ) : Mesh
    {
        var i : Int;
        var j : Int;
        
        // OUTLINES STEP-LIKE SHAPES GENERATION
        var shapes : Array<Array<Float>> = Potrace.buildShapes(bmpData, debugBmp, debugShape);
        
        // GRAPHS OF POTENTIAL SEGMENTS GENERATION
        var graphs : Array<Graph> = new Array<Graph>();
        for (i in 0...shapes.length){
            graphs.push(Potrace.buildGraph(shapes[i]));
        }  // OPTIMIZED POLYGONS GENERATION  
        
        
        
        var polygons : Array<Array<Float>> = new Array<Array<Float>>();
        for (i in 0...graphs.length){
            polygons.push(Potrace.buildPolygon(graphs[i], debugShape));
        }  // MESH GENERATION  
        
        
        
        var mesh : Mesh = RectMeshFactory.buildRectangle(bmpData.width, bmpData.height);
        for (i in 0...polygons.length){
            j = 0;
            while (j < polygons[i].length - 2){mesh.insertConstraintSegment(polygons[i][j], polygons[i][j + 1], polygons[i][j + 2], polygons[i][j + 3]);
                j += 2;
            }
            mesh.insertConstraintSegment(polygons[i][0], polygons[i][1], polygons[i][j], polygons[i][j + 1]);
        }
        
        return mesh;
    }

    public function new()
    {
    }
}
