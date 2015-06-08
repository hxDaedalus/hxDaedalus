package hxDaedalus.factories;


import hxDaedalus.data.Mesh;
import hxDaedalus.data.graph.Graph;
import hxDaedalus.data.graph.GraphEdge;
import hxDaedalus.data.graph.GraphNode;
import hxDaedalus.data.math.Geom2D;
import hxDaedalus.data.math.Potrace;
import hxDaedalus.graphics.SimpleDrawingContext;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.geom.Point;

class BitmapMesh
{
    
    public static function buildFromBmpData(    bmpData:    BitmapData
                                            ,   debugBmp:   BitmapData = null
                                            ,   debugShape: SimpleDrawingContext = null
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
        
        
        
        var mesh : Mesh = RectMesh.buildRectangle(bmpData.width, bmpData.height);
        for (i in 0...polygons.length){
            j = 0;
            while (j < polygons[i].length - 2){
                mesh.insertConstraintSegment(polygons[i][j], polygons[i][j + 1], polygons[i][j + 2], polygons[i][j + 3]);
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
