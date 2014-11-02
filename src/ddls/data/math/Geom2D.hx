package ddls.data.math;

import ddls.data.math.Point2D;
import ddls.data.math.RandGenerator;

import ddls.data.Constants;
import ddls.data.Edge;
import ddls.data.Face;
import ddls.data.Mesh;
import ddls.data.Vertex;
import ddls.iterators.FromFaceToInnerEdges;
import ddls.iterators.FromVertexToHoldingFaces;

import flash.geom.Point;

 
enum Intersection {
    EVertex( vertex: Vertex );
    EEdge( edge: Edge );
    EFace( face: Face );
    ENull( );
}
/*
use 
switch( loc ){
    case EVertex( vertex ):
        locVertex = vertex;
    case EEdge( edge ):
        locEdge = edge;
    case EFace( face ):
        locFace = face;
    case ENull( isnull ):
        //
}
*/
//var typedef Intersection={ ?vertex:Vertex, ?edge:Edge, ?polygon:Polygon };


class Geom2D
{
    
    
    private static var _randGen: RandGenerator;
    
    // return one the following, in priority order:
    // - an existant vertex (if (x, y) lies on this vertex)
    // or
    // - an existant edge (if (x, y) lies on this edge )
    // or
    // - an existant face (if (x, y) lies on this face )
    // or
    // - null if outside mesh
    // YOU SHOULD USE THIS FUNCTION ONLY FOR COORDINATES INSIDE SAFE AREA
    private static var __samples: Array<Vertex> = new Array<Vertex>();
    public static function locatePosition( x: Float, y: Float, mesh: Mesh ): Intersection
    {
        // jump and walk algorithm
        
        if (_randGen == null) _randGen = new RandGenerator();
        _randGen.seed = Std.int( x * 10 + 4 * y );
        
        var i : Int;
        
        __samples.splice(0, __samples.length);
        var numSamples : Int = Std.int( Math.pow(mesh._vertices.length, 1 / 3) );
        _randGen.rangeMin = 0;
        _randGen.rangeMax = mesh._vertices.length - 1;
        for (i in 0...numSamples){
            var _rnd:Int = _randGen.next();
            //TODO: Assert
            if (_rnd < 0 || _rnd > mesh._vertices.length -1 || mesh._vertices == null) throw "null";
            __samples.push(mesh._vertices[_rnd]);
        }
        
        var currVertex : Vertex;
        var currVertexPos : Point2D;
        var distSquared : Float;
        var minDistSquared : Float = Math.POSITIVE_INFINITY;
        var closedVertex : Vertex = null;
        for (i in 0...numSamples){
            currVertex = __samples[i];
            currVertexPos = currVertex.pos;
            distSquared = (currVertexPos.x - x) * (currVertexPos.x - x) + (currVertexPos.y - y) * (currVertexPos.y - y);
            if (distSquared < minDistSquared) 
            {
                minDistSquared = distSquared;
                closedVertex = currVertex;
            }
        }
        
        var currFace : Face;
        var iterFace : FromVertexToHoldingFaces = new FromVertexToHoldingFaces();
        iterFace.fromVertex = closedVertex;
        currFace = iterFace.next();
        
        var faceVisited = new Map<Face,Bool>();
        var currEdge : Edge;
        var iterEdge : FromFaceToInnerEdges = new FromFaceToInnerEdges();
        var objectContainer : Intersection = ENull;
        var relativPos : Int;
        var numIter : Int = 0;
        //while ( faceVisited[ currFace ] || !(objectContainer = isInFace(x, y, currFace)) )
        while ( faceVisited[ currFace ] || (objectContainer = isInFace(x, y, currFace)).match(ENull) )
        {
            faceVisited[ currFace ];
            
            numIter++;
            if (numIter == 50) 
            {
                trace("WALK TAKE MORE THAN 50 LOOP");
            }
            iterEdge.fromFace = currFace;
            do
            {
                currEdge = iterEdge.next();
                if (currEdge == null) 
                {
                    trace("KILL PATH");
                    return ENull;
                }
                relativPos = getRelativePosition(x, y, currEdge);
            } while ((relativPos == 1 || relativPos == 0));
            
            currFace = currEdge.rightFace;
        }
        
        return objectContainer;
    }
    
    public static function isCircleIntersectingAnyConstraint(x : Float, y : Float, radius : Float, mesh : Mesh) : Bool
    {
        if (x <= 0 || x >= mesh.width || y <= 0 || y >= mesh.height) return true;
        
        var loc = Geom2D.locatePosition(x, y, mesh);
        var face : Face;
        switch( loc ){
            case EVertex( vertex ):
                face = vertex.edge.leftFace;
            case EEdge( edge ):
                face = edge.leftFace;
            case EFace( face_ ):
                face = face_;
            case ENull:
                face = null;
        }
        
        // if a vertex is in the circle, a contrainst must intersect the circle
        // because a vertex always belongs to a contrained edge
        var radiusSquared : Float = radius * radius;
        var pos : Point2D;
        var distSquared : Float;
        pos = face.edge.originVertex.pos;
        distSquared = (pos.x - x) * (pos.x - x) + (pos.y - y) * (pos.y - y);
        if (distSquared <= radiusSquared) 
        {
            return true;
        }
        pos = face.edge.nextLeftEdge.originVertex.pos;
        distSquared = (pos.x - x) * (pos.x - x) + (pos.y - y) * (pos.y - y);
        if (distSquared <= radiusSquared) 
        {
            return true;
        }
        pos = face.edge.nextLeftEdge.nextLeftEdge.originVertex.pos;
        distSquared = (pos.x - x) * (pos.x - x) + (pos.y - y) * (pos.y - y);
        if (distSquared <= radiusSquared) 
        {
            return true;
        }  // check if edge intersects  
        
        
        
        var edgesToCheck = new Array<Edge>();
        edgesToCheck.push(face.edge);
        edgesToCheck.push(face.edge.nextLeftEdge);
        edgesToCheck.push(face.edge.nextLeftEdge.nextLeftEdge);
        
        var edge : Edge;
        var pos1 : Point2D;
        var pos2 : Point2D;
        var checkedEdges = new Map<Edge,Bool>();
        var intersecting : Bool;
        while (edgesToCheck.length > 0)
        {
            edge = edgesToCheck.pop();
            checkedEdges[ edge ] = true;
            pos1 = edge.originVertex.pos;
            pos2 = edge.destinationVertex.pos;
            intersecting = intersectionsSegmentCircle(pos1.x, pos1.y, pos2.x, pos2.y, x, y, radius);
            if (intersecting) 
            {
                if (edge.isConstrained) {
                    return true;
                }else {
                    edge = edge.oppositeEdge.nextLeftEdge;
                    if (!checkedEdges[edge] && !checkedEdges[edge.oppositeEdge] && edgesToCheck.indexOf(edge) == -1 && edgesToCheck.indexOf(edge.oppositeEdge) == -1) 
                    {
                        edgesToCheck.push(edge);
                    }
                    edge = edge.nextLeftEdge;
                    if (!checkedEdges[edge] && !checkedEdges[edge.oppositeEdge] && edgesToCheck.indexOf(edge) == -1 && edgesToCheck.indexOf(edge.oppositeEdge) == -1) 
                    {
                        edgesToCheck.push(edge);
                    }
                }
            }
        }
        
        return false;
    }
    
    // return the relative direction from (x1,y1), to (x3,y3) through (x2, y2)
    // the function returns:
    // 0 if the path is a straight line
    // 1 if the path goes to the left
    // -1 if the path goes to the right
    public static function getDirection(x1 : Float, y1 : Float, x2 : Float, y2 : Float, x3 : Float, y3 : Float) : Int
    {
        
        // dot product with the orthogonal vector pointing left vector of eUp:
        var dot : Float = (x3 - x1) * (y2 - y1) + (y3 - y1) * (-x2 + x1);
        
        // check sign
        return ((dot == 0)) ? 0 : (((dot > 0)) ? 1 : -1);
    }
    
    // second version of getDirection. More accurate and safer version
    // return the relative direction from (x1,y1), to (x3,y3) through (x2, y2)
    // the function returns:
    // 0 if the path is a straight line
    // 1 if the path goes to the left
    // -1 if the path goes to the right
    public static function getDirection2(x1 : Float, y1 : Float, x2 : Float, y2 : Float, x3 : Float, y3 : Float) : Int
    {
        // dot product with the orthogonal vector pointing left vector of eUp:
        var dot : Float = (x3 - x1) * (y2 - y1) + (y3 - y1) * (-x2 + x1);
        
        // check sign
        if (dot == 0) 
        {
            return 0;
        }
        else if (dot > 0) 
        {
            if (distanceSquaredPointToLine(x3, y3, x1, y1, x2, y2) <= Constants.EPSILON_SQUARED) {
                return 0;
            } else { 
                return 1;
            }
        }
        else 
        {
            if (distanceSquaredPointToLine(x3, y3, x1, y1, x2, y2) <= Constants.EPSILON_SQUARED) {
                return 0;
            } else { 
                return -1;
            }
        }
        return 0;
    }
    
    // eUp seen as an infinite line splits the 2D space in 2 parts (left and right),
    // the function returns:
    //   0 if the (x, y) lies on the line
    //   1 if the (x, y) lies at left
    //   -1 if the (x, y) lies at right
    public static function getRelativePosition(x : Float, y : Float, eUp : Edge) : Int
    {
        return getDirection(eUp.originVertex.pos.x, eUp.originVertex.pos.y, eUp.destinationVertex.pos.x, eUp.destinationVertex.pos.y, x, y);
    }
    
    public static function getRelativePosition2(x : Float, y : Float, eUp : Edge) : Int
    {
        return getDirection2(eUp.originVertex.pos.x, eUp.originVertex.pos.y, eUp.destinationVertex.pos.x, eUp.destinationVertex.pos.y, x, y);
    }
    
    // the function checks by priority:
    // - if the (x, y) lies on a vertex of the polygon, it will return this vertex
    // - if the (x, y) lies on a edge of the polygon, it will return this edge
    // - if the (x, y) lies inside the polygon, it will return the polygon
    // - if the (x, y) lies outside the polygon, it will return null
    public static function isInFace(x : Float, y : Float, polygon : Face) : Intersection
    {
        // remember polygons are triangle only,
        // and we suppose we have not degenerated flat polygons !
        
        var result : Intersection = ENull;
        
        var e1_2 = polygon.edge;
        var e2_3 = e1_2.nextLeftEdge;
        var e3_1 = e2_3.nextLeftEdge;
        if (getRelativePosition(x, y, e1_2) >= 0 && getRelativePosition(x, y, e2_3) >= 0 && getRelativePosition(x, y, e3_1) >= 0) 
        {
            var v1= e1_2.originVertex;
            var v2= e2_3.originVertex;
            var v3= e3_1.originVertex;
            
            var x1= v1.pos.x;
            var y1= v1.pos.y;
            var x2= v2.pos.x;
            var y2= v2.pos.y;
            var x3= v3.pos.x;
            var y3= v3.pos.y;
            
            var v_v1squaredLength= (x1 - x) * (x1 - x) + (y1 - y) * (y1 - y);
            var v_v2squaredLength= (x2 - x) * (x2 - x) + (y2 - y) * (y2 - y);
            var v_v3squaredLength= (x3 - x) * (x3 - x) + (y3 - y) * (y3 - y);
            var v1_v2squaredLength= (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1);
            var v2_v3squaredLength= (x3 - x2) * (x3 - x2) + (y3 - y2) * (y3 - y2);
            var v3_v1squaredLength= (x1 - x3) * (x1 - x3) + (y1 - y3) * (y1 - y3);
            
            var dot_v_v1v2= (x - x1) * (x2 - x1) + (y - y1) * (y2 - y1);
            var dot_v_v2v3 = (x - x2) * (x3 - x2) + (y - y2) * (y3 - y2);
            var dot_v_v3v1 = (x - x3) * (x1 - x3) + (y - y3) * (y1 - y3);
            
            var v_e1_2squaredLength = v_v1squaredLength - dot_v_v1v2 * dot_v_v1v2 / v1_v2squaredLength;
            var v_e2_3squaredLength = v_v2squaredLength - dot_v_v2v3 * dot_v_v2v3 / v2_v3squaredLength;
            var v_e3_1squaredLength = v_v3squaredLength - dot_v_v3v1 * dot_v_v3v1 / v3_v1squaredLength;
            
            var closeTo_e1_2  = v_e1_2squaredLength <= Constants.EPSILON_SQUARED;
            var closeTo_e2_3  = v_e2_3squaredLength <= Constants.EPSILON_SQUARED;
            var closeTo_e3_1  = v_e3_1squaredLength <= Constants.EPSILON_SQUARED;
            
            if( closeTo_e1_2 ){
                if( closeTo_e3_1 ){
                    result = EVertex( v1 );
                } else if( closeTo_e2_3 ){ 
                    result = EVertex( v2 );
                } else { 
                    result = EEdge( e1_2 );
                }
            } else if( closeTo_e2_3 ){
                if( closeTo_e3_1 ){
                    result = EVertex( v3 );
                } else { 
                    result = EEdge( e2_3 );
                }
            } else if( closeTo_e3_1 ){ 
                result = EEdge( e3_1 );
            } else {
                result = EFace( polygon );
            }
        }
        
        return result;
    }
    
    // return:
    // - true if the segment is totally or partially in the triangle
    // - false if the segment is totally outside the triangle
    public static function clipSegmentByTriangle( s1x : Float, s1y : Float
                                                , s2x : Float, s2y : Float
                                                , t1x : Float, t1y : Float
                                                , t2x : Float, t2y : Float
                                                , t3x : Float, t3y : Float
                                                , pResult1 : Point2D = null, pResult2 : Point2D = null
                                                ) : Bool
    {
        var side1_1 : Int;
        var side1_2 : Int;
        side1_1 = getDirection(t1x, t1y, t2x, t2y, s1x, s1y);
        side1_2 = getDirection(t1x, t1y, t2x, t2y, s2x, s2y);
        // if both segment points are on right side
        if (side1_1 <= 0 && side1_2 <= 0) 
            return false;
        
        var side2_1 : Int;
        var side2_2 : Int;
        side2_1 = getDirection(t2x, t2y, t3x, t3y, s1x, s1y);
        side2_2 = getDirection(t2x, t2y, t3x, t3y, s2x, s2y);
        // if both segment points are on right side
        if (side2_1 <= 0 && side2_2 <= 0) 
            return false;
        
        var side3_1 : Int;
        var side3_2 : Int;
        side3_1 = getDirection(t3x, t3y, t1x, t1y, s1x, s1y);
        side3_2 = getDirection(t3x, t3y, t1x, t1y, s2x, s2y);
        // if both segment points are on right side
        if (side3_1 <= 0 && side3_2 <= 0) 
            return false;  // both segment points are in triangle  ;
        
        
        
        if ((side1_1 >= 0 && side2_1 >= 0 && side3_1 >= 0) && (side1_2 >= 0 && side2_2 >= 0 && side3_2 >= 0)) 
        {
            pResult1.x = s1x;
            pResult1.y = s1y;
            pResult2.x = s2x;
            pResult2.y = s2y;
            return true;
        }
        
        var n : Int = 0;
        // check intersection between segment and 1st side triangle
        if (intersections2segments(s1x, s1y, s2x, s2y, t1x, t1y, t2x, t2y, pResult1, null)) 
        {
            n++;
        }  // if no intersection with 1st side triangle  
        
        
        
        if (n == 0) 
        {
            // check intersection between segment and 1st side triangle
            if (intersections2segments(s1x, s1y, s2x, s2y, t2x, t2y, t3x, t3y, pResult1, null)) 
            {
                n++;
            }
        }
        else 
        {
            if (intersections2segments(s1x, s1y, s2x, s2y, t2x, t2y, t3x, t3y, pResult2, null)) 
            {
                // we check if the segment is not on t2 triangle point
                if (-Constants.EPSILON > pResult1.x - pResult2.x || pResult1.x - pResult2.x > Constants.EPSILON || -Constants.EPSILON > pResult1.y - pResult2.y || pResult1.y - pResult2.y > Constants.EPSILON) 
                {
                    n++;
                }
            }
        }  // if intersection neither 1st nor 2nd side triangle  
        
        
        
        if (n == 0) 
        {
            if (intersections2segments(s1x, s1y, s2x, s2y, t3x, t3y, t1x, t1y, pResult1, null)) 
            {
                n++;
            }
        }
        // if one intersection, we identify the segment point in the triangle
        else if (n == 1) 
        {
            if (intersections2segments(s1x, s1y, s2x, s2y, t3x, t3y, t1x, t1y, pResult2, null)) 
            {
                if (-Constants.EPSILON > pResult1.x - pResult2.x || pResult1.x - pResult2.x > Constants.EPSILON || -Constants.EPSILON > pResult1.y - pResult2.y || pResult1.y - pResult2.y > Constants.EPSILON) 
                {
                    n++;
                }
            }
        }
        
        
        
        if (n == 1) 
        {
            if (side1_1 >= 0 && side2_1 >= 0 && side3_1 >= 0) 
            {
                pResult2.x = s1x;
                pResult2.y = s1y;
            }
            else if (side1_2 >= 0 && side2_2 >= 0 && side3_2 >= 0) 
            {
                pResult2.x = s2x;
                pResult2.y = s2y;
            }
            else 
            {
                // 1 intersection and none point in triangle : degenerate case
                n = 0;
            }
        }
        
        if (n > 0) 
            return true
        else 
        return false;
    }
    
    // test if the segment intersects or lies inside the triangle
    public static function isSegmentIntersectingTriangle(s1x : Float, s1y : Float, s2x : Float, s2y : Float, t1x : Float, t1y : Float, t2x : Float, t2y : Float, t3x : Float, t3y : Float) : Bool
    {
        // check sides
        
        var side1_1 : Int;
        var side1_2 : Int;
        side1_1 = getDirection(t1x, t1y, t2x, t2y, s1x, s1y);
        side1_2 = getDirection(t1x, t1y, t2x, t2y, s2x, s2y);
        // if both segment points are on right side
        if (side1_1 <= 0 && side1_2 <= 0) 
            return false;
        
        var side2_1 : Int;
        var side2_2 : Int;
        side2_1 = getDirection(t2x, t2y, t3x, t3y, s1x, s1y);
        side2_2 = getDirection(t2x, t2y, t3x, t3y, s2x, s2y);
        // if both segment points are on right side
        if (side2_1 <= 0 && side2_2 <= 0) 
            return false;
        
        var side3_1 : Int;
        var side3_2 : Int;
        side3_1 = getDirection(t3x, t3y, t1x, t1y, s1x, s1y);
        side3_2 = getDirection(t3x, t3y, t1x, t1y, s2x, s2y);
        // if both segment points are on right side
        if (side3_1 <= 0 && side3_2 <= 0) 
            return false;  // if 1st segment point is inside triangle  ;
        
        
        
        if (side1_1 == 1 && side2_1 == 1 && side3_1 == 1) 
            return true;  // if 2st segment point is inside triangle  ;
        
        
        
        if (side1_1 == 1 && side2_1 == 1 && side3_1 == 1) 
            return true;
        
        var side1 : Int;
        var side2 : Int;
        // if both segment points are on different sides of the 1st triangle side
        if ((side1_1 == 1 && side1_2 <= 0) || (side1_1 <= 0 && side1_2 == 1)) 
        {
            side1 = getDirection(s1x, s1y, s2x, s2y, t1x, t1y);
            side2 = getDirection(s1x, s1y, s2x, s2y, t2x, t2y);
            if (side1 == 1 && side2 <= 0 || side1 <= 0 && side2 == 1) 
            {
                return true;
            }
        }  // if both segment points are on different sides of the 2nd triangle side  
        
        if ((side2_1 == 1 && side2_2 <= 0) || (side2_1 <= 0 && side2_2 == 1)) 
        {
            side1 = getDirection(s1x, s1y, s2x, s2y, t2x, t2y);
            side2 = getDirection(s1x, s1y, s2x, s2y, t3x, t3y);
            if (side1 == 1 && side2 <= 0 || side1 <= 0 && side2 == 1) 
            {
                return true;
            }
        }  // if both segment points are on different sides of the 3rd triangle side  
        
        if ((side3_1 == 1 && side3_2 <= 0) || (side3_1 <= 0 && side3_2 == 1)) 
        {
            side1 = getDirection(s1x, s1y, s2x, s2y, t3x, t3y);
            side2 = getDirection(s1x, s1y, s2x, s2y, t1x, t1y);
            if (side1 == 1 && side2 <= 0 || side1 <= 0 && side2 == 1) 
            {
                return true;
            }
        }
        
        return false;
    }
    
    private static var __circumcenter : Point2D = new Point2D();
    public static function isDelaunay(edge : Edge) : Bool
    {
        var vLeft : Vertex = edge.originVertex;
        var vRight : Vertex = edge.destinationVertex;
        var vCorner : Vertex = edge.nextLeftEdge.destinationVertex;
        var vOpposite : Vertex = edge.nextRightEdge.destinationVertex;
        /*
        // middle points
        var vMidLeft:Point = new Point();
        vMidLeft.x = (vCorner.pos.x + vLeft.pos.x) / 2;
        vMidLeft.y = (vCorner.pos.y + vLeft.pos.y) / 2;
        
        var vMidRight:Point = new Point();
        vMidRight.x = (vCorner.pos.x + vRight.pos.x) / 2;
        vMidRight.y = (vCorner.pos.y + vRight.pos.y) / 2;
        */
        /*
        - parametric expression of orthogonal segments
        segOrthoLeftX(t1) = vMidLeft.x + t1 * (vLeft.y - vCorner.y)
        segOrthoLeftY(t1) = vMidLeft.y - t1 * (vLeft.x - vCorner.x)
        
        segOrthoRightX(t2) = vMidRight.x + t2 * (vRight.y - vCorner.y)
        segOrthoRightY(t2) = vMidRight.y - t2 * (vRight.x - vCorner.x)
        
        - the center of circle passing by vLeft, vRight, vCorner will lead to:
        segOrthoLeftX(t1) = segOrthoRightX(t2)
        segOrthoLeftY(t1) = segOrthoRightY(t2)
        */
        /*
        // set alias letters
        var a:Number = vMidLeft.x;
        var b:Number = vLeft.pos.y;
        var c:Number = vCorner.pos.y;
        var d:Number = vMidRight.x;
        var e:Number = vRight.pos.y;
        var f:Number = vCorner.pos.y;
        var g:Number = vMidLeft.y;
        var h:Number = vLeft.pos.x;
        var i:Number = vCorner.pos.x;
        var j:Number = vMidRight.y;
        var k:Number = vRight.pos.x;
        var l:Number = vCorner.pos.x;
        */
        /*
        system to solve:
        a + t1 (b - c) = d + t2 (e - f)
        g - t1 (h - i) = j - t2 (k - l)
        */
        
        //giving to wolfram: Solve[{a + t1 (b - c) = d + t2 (e - f) , g - t1 (h - i) = j - t2 (k - l)}, {t1, t2}]
        //we get:
        //var t1:Number = (-(a-d)*(k-l) + e*(j-g) + f*(g-j)) / ((b-c)*(k-l) + e*(i-h) + f*(h-i));
        /*
        __barycenter.x = a + t1 * (b - c);
        __barycenter.y = g - t1 * (h - i);
        */
        getCircumcenter(vCorner.pos.x, vCorner.pos.y, vLeft.pos.x, vLeft.pos.y, vRight.pos.x, vRight.pos.y, __circumcenter);
        
        // check if the opposite vertex lies outside the circle
        var squaredRadius : Float = (vCorner.pos.x - __circumcenter.x) * (vCorner.pos.x - __circumcenter.x) + (vCorner.pos.y - __circumcenter.y) * (vCorner.pos.y - __circumcenter.y);
        var squaredDistance : Float = (vOpposite.pos.x - __circumcenter.x) * (vOpposite.pos.x - __circumcenter.x) + (vOpposite.pos.y - __circumcenter.y) * (vOpposite.pos.y - __circumcenter.y);
        
        return squaredDistance >= squaredRadius;
    }
    
    public static function getCircumcenter(x1 : Float, y1 : Float, x2 : Float, y2 : Float, x3 : Float, y3 : Float, result : Point2D = null) : Point2D
    {
        if (result == null) 
        {
            result = new Point2D();
        }  // middle points  
        
        
        
        var m1 : Float = (x1 + x2) / 2;
        var m2 : Float = (y1 + y2) / 2;
        var m3 : Float = (x1 + x3) / 2;
        var m4 : Float = (y1 + y3) / 2;
        /*
        - parametric expression of orthogonal segments
        segOrtho1X(t1) = m1 + t1 * (y2 - y1)
        segOrtho1Y(t1) = m2 - t1 * (x2 - x1)
        
        segOrtho2X(t2) = m3 + t2 * (y3 - y1)
        segOrtho2Y(t2) = m4 - t2 * (x3 - x1)
        
        - the center of circle passing by vLeft, vRight, vCorner will lead to:
        segOrtho1X(t1) = segOrtho2X(t2)
        segOrtho1Y(t1) = segOrtho2Y(t2)
        
        system to solve:
        m1 + t1 (y2 - y1) = m3 + t2 (y3 - y1)
        m2 - t1 (x2 - x1) = m4 - t2 (x3 - x1)
        
        giving to wolfram: Solve[{m1 + t1 (y2 - y1) = m3 + t2 (y3 - y1) , m2 - t1 (x2 - x1) = m4 - t2 (x3 - x1)}, {t1, t2}]
        we get:
        */
        var t1 : Float = (m1 * (x1 - x3) + (m2 - m4) * (y1 - y3) + m3 * (x3 - x1)) / (x1 * (y3 - y2) + x2 * (y1 - y3) + x3 * (y2 - y1));
        
        result.x = m1 + t1 * (y2 - y1);
        result.y = m2 - t1 * (x2 - x1);
        
        return result;
    }
    
    public static function intersections2segments(s1p1x : Float, s1p1y : Float, s1p2x : Float, s1p2y : Float, s2p1x : Float, s2p1y : Float, s2p2x : Float, s2p2y : Float, posIntersection : Point2D = null, paramIntersection : Array<Float> = null, infiniteLineMode : Bool = false) : Bool
    {
        var t1 : Float = 0;
        var t2 : Float = 0;
        
        var result : Bool;
        var divisor : Float = (s1p1x - s1p2x) * (s2p1y - s2p2y) + (s1p2y - s1p1y) * (s2p1x - s2p2x);
        if (divisor == 0) 
        {
            result = false;
        }
        else 
        {
            result = true;
            
            if (!infiniteLineMode || posIntersection != null || paramIntersection != null) 
            {
                // if we consider edges as finite segments, we must check t1 and t2 values
                t1 = (s1p1x * (s2p1y - s2p2y) + s1p1y * (s2p2x - s2p1x) + s2p1x * s2p2y - s2p1y * s2p2x) / divisor;
                t2 = (s1p1x * (s2p1y - s1p2y) + s1p1y * (s1p2x - s2p1x) - s1p2x * s2p1y + s1p2y * s2p1x) / divisor;
                if (!infiniteLineMode && !(0 <= t1 && t1 <= 1 && 0 <= t2 && t2 <= 1)) 
                    result = false;
            }
        }
        
        if (result) 
        {
            if (posIntersection != null) 
            {
                posIntersection.x = s1p1x + t1 * (s1p2x - s1p1x);
                posIntersection.y = s1p1y + t1 * (s1p2y - s1p1y);
            }
            if (paramIntersection != null) 
            {
                paramIntersection.push(t1);
                paramIntersection.push(t2);
            }
        }
        
        return result;
    }
    
    public static function intersections2edges(edge1 : Edge, edge2 : Edge, posIntersection :Point2D = null, paramIntersection : Array<Float> = null, infiniteLineMode : Bool = false) : Bool
    {
        return intersections2segments(edge1.originVertex.pos.x, edge1.originVertex.pos.y, edge1.destinationVertex.pos.x, edge1.destinationVertex.pos.y, edge2.originVertex.pos.x, edge2.originVertex.pos.y, edge2.destinationVertex.pos.x, edge2.destinationVertex.pos.y, posIntersection, paramIntersection, infiniteLineMode);
    }
    
    // a edge is convex if the polygon formed by the 2 faces at left and right of this edge is convex
    public static function isConvex(edge : Edge) : Bool
    {
        var result : Bool = true;
        
        var eLeft : Edge;
        var vRight : Vertex;
        
        eLeft = edge.nextLeftEdge.oppositeEdge;
        vRight = edge.nextRightEdge.destinationVertex;
        if (getRelativePosition(vRight.pos.x, vRight.pos.y, eLeft) != -1) 
        {
            result = false;
        }
        else 
        {
            eLeft = edge.prevRightEdge;
            vRight = edge.prevLeftEdge.originVertex;
            if (getRelativePosition(vRight.pos.x, vRight.pos.y, eLeft) != -1) 
            {
                result = false;
            }
        }
        
        return result;
    }
    
    public static function projectOrthogonaly(vertexPos : Point2D, edge : Edge) : Void
    {
        // parametric expression of edge
        // x(t1) = edge.originVertex.pos.x + t1*(edge.destinationVertex.pos.x - edge.originVertex.pos.x)
        // y(t1) = edge.originVertex.pos.y + t1*(edge.destinationVertex.pos.y - edge.originVertex.pos.y)
        
        // parametric expression of the segment orthogonal to edge and lying by vertex
        // x(t2) = vertexPos.x + t2*(edge.destinationVertex.pos.y - edge.originVertex.pos.y)
        // y(t2) = vertexPos.y - t2*(edge.destinationVertex.pos.x - edge.originVertex.pos.x)
        
        // the orthogonal projection of vertex on edge will lead to:
        // x(t1) = x(t2)
        // y(t1) = y(t2)
        
        // set alias letters
        var a = edge.originVertex.pos.x;
        var b = edge.originVertex.pos.y;
        var c  = edge.destinationVertex.pos.x;
        var d  = edge.destinationVertex.pos.y;
        var e  = vertexPos.x;
        var f = vertexPos.y;
        
        // system to solve:
        // a + t1 (c - a) = e + t2 (d - b)
        // b + t1 (d - b) = f - t2 (c - a)
        
        // solution:
        var t1  = (a * a - a * c - a * e + b * b - b * d - b * f + c * e + d * f) / (a * a - 2 * a * c + b * b - 2 * b * d + c * c + d * d);
        
        // set position:
        vertexPos.x = a + t1 * (c - a);
        vertexPos.y = b + t1 * (d - b);
    }
    
    // fill the result vector with 4 elements, with the form:
    // [intersect0.x, intersect0.y, intersect1.x, intersect1.y]
    // empty if no intersection
    public static function intersections2Circles(cx1 : Float, cy1 : Float, r1 : Float, cx2 : Float, cy2 : Float, r2 : Float, result : Array<Float> = null) : Bool
    {
        var distRadiusSQRD = ((cx2 - cx1) * (cx2 - cx1) + (cy2 - cy1) * (cy2 - cy1));
        
        if ((cx1 != cx2 || cy1 != cy2)
            && distRadiusSQRD <= ((r1 + r2) * (r1 + r2))
            && distRadiusSQRD >= ((r1 - r2) * (r1 - r2))) 
        {
            var transcendPart : Float = Math.sqrt(((r1 + r2) * (r1 + r2) - distRadiusSQRD)
                    * (distRadiusSQRD - (r2 - r1) * (r2 - r1)));
            var xFirstPart : Float = (cx1 + cx2) / 2 + (cx2 - cx1) * (r1 * r1 - r2 * r2) / (2 * distRadiusSQRD);
            var yFirstPart : Float = (cy1 + cy2) / 2 + (cy2 - cy1) * (r1 * r1 - r2 * r2) / (2 * distRadiusSQRD);
            var xFactor : Float = (cy2 - cy1) / (2 * distRadiusSQRD);
            var yFactor : Float = (cx2 - cx1) / (2 * distRadiusSQRD);
            
            if (result != null) 
            {
                for (f in [ xFirstPart + xFactor * transcendPart, yFirstPart - yFactor * transcendPart, xFirstPart - xFactor * transcendPart, yFirstPart + yFactor * transcendPart])
					result.push(f);
            }
            
            return true;
        }
        else 
        return false;
    }
    
    public static function intersectionsSegmentCircle(p0x : Float, p0y : Float, p1x : Float, p1y : Float, cx : Float, cy : Float, r : Float, result : Array<Float> = null) : Bool
    {
        
        var p0xSQD  = p0x * p0x;
        var p0ySQD  = p0y * p0y;
        var a  = p1y * p1y - 2 * p1y * p0y + p0ySQD + p1x * p1x - 2 * p1x * p0x + p0xSQD;
        var b = 2 * p0y * cy - 2 * p0xSQD + 2 * p1y * p0y - 2 * p0ySQD + 2 * p1x * p0x - 2 * p1x * cx + 2 * p0x * cx - 2 * p1y * cy;
        var c = p0ySQD + cy * cy + cx * cx - 2 * p0y * cy - 2 * p0x * cx + p0xSQD - r * r;
        var delta  = b * b - 4 * a * c;
        var deltaSQRT : Float;
        
        var t0 : Float;
        var t1 : Float;
        if (delta < 0) 
        {
            // no solution
            return false;
        }
        else if (delta == 0) 
        {
            // unique solution
            t0 = -b / (2 * a);
            if (t0 < 0 || t0 > 1) 
                return false;  //  [intersect0.x, intersect0.y, t0]    // we return a 3 elements array, under the form:  ;
            
            
            
            if (result != null) 
                for (f in [ p0x + t0 * (p1x - p0x), p0y + t0 * (p1y - p0y), t0 ] )
					result.push(f);
            
            return true;
        }
        // (delta > 0)
        else 
        {
            deltaSQRT = Math.sqrt(delta);
            t0 = (-b + deltaSQRT) / (2 * a);
            t1 = (-b - deltaSQRT) / (2 * a);
            // we return a n elements array, under the form:
            //  [intersect0.x, intersect0.y, t0
            //    , intersect1.x, intersect1.y, t1]
            var intersecting : Bool = false;
            if (0 <= t0 && t0 <= 1) 
            {
                if (result != null)
					for (f in [p0x + t0 * (p1x - p0x), p0y + t0 * (p1y - p0y), t0] )
						result.push(f);
                intersecting = true;
            }
            if (0 <= t1 && t1 <= 1) 
            {
                if (result != null) 
                    for (f in [p0x + t1 * (p1x - p0x), p0y + t1 * (p1y - p0y), t1])
						result.push(f);
                intersecting = true;
            }
            
            return intersecting;
        }
    }
    
    public static function intersectionsLineCircle(p0x : Float, p0y : Float, p1x : Float, p1y : Float, cx : Float, cy : Float, r : Float, result : Array<Float>) : Bool
    {
        var p0xSQD  = p0x * p0x;
        var p0ySQD  = p0y * p0y;
        var a  = p1y * p1y - 2 * p1y * p0y + p0ySQD + p1x * p1x - 2 * p1x * p0x + p0xSQD;
        var b  = 2 * p0y * cy - 2 * p0xSQD + 2 * p1y * p0y - 2 * p0ySQD + 2 * p1x * p0x - 2 * p1x * cx + 2 * p0x * cx - 2 * p1y * cy;
        var c  = p0ySQD + cy * cy + cx * cx - 2 * p0y * cy - 2 * p0x * cx + p0xSQD - r * r;
        var delta  = b * b - 4 * a * c;
        var deltaSQRT : Float;
        
        var t0 : Float;
        var t1 : Float;
        if (delta < 0) 
        {
            // no solution
            return false;
        }
        else if (delta == 0) 
        {
            // unique solution
            t0 = -b / (2 * a);
            // we return a 3 elements array, under the form:
            //  [intersect0.x, intersect0.y, t0]
            for (f in [p0x + t0 * (p1x - p0x), p0y + t0 * (p1y - p0y), t0])
				result.push(f);
        }
        else if (delta > 0) 
        {
            deltaSQRT = Math.sqrt(delta);
            t0 = (-b + deltaSQRT) / (2 * a);
            t1 = (-b - deltaSQRT) / (2 * a);
            // we return a 6 elements array, under the form:
            //  [intersect0.x, intersect0.y, t0
            //    , intersect1.x, intersect1.y, t1]
            for (f in [p0x + t0 * (p1x - p0x), p0y + t0 * (p1y - p0y), t0, p0x + t1 * (p1x - p0x), p0y + t1 * (p1y - p0y), t1])
				result.push(f);
        }
        
        return true;
    }
    
    // based on intersections2Circles method
    // fill the result vector with 4 elements, with the form:
    // [point_tangent1.x, point_tangent1.y, point_tangent2.x, point_tangent2.y]
    // empty if no tangent
    public static function tangentsPointToCircle(px : Float, py : Float, cx : Float, cy : Float, r : Float, result : Array<Float>) : Void
    {
        var c2x  = (px + cx) / 2;
        var c2y  = (py + cy) / 2;
        var r2 = 0.5 * Math.sqrt((px - cx) * (px - cx) + (py - cy) * (py - cy));
        
        intersections2Circles(c2x, c2y, r2, cx, cy, r, result);
    }
    
    // <!!!> CIRCLES MUST HAVE SAME RADIUS
    public static function tangentsCrossCircleToCircle(r : Float, c1x : Float, c1y : Float, c2x : Float, c2y : Float, result : Array<Float>) : Bool
    {
        var distance  = Math.sqrt((c1x - c2x) * (c1x - c2x) + (c1y - c2y) * (c1y - c2y));
        
        // new circle
        var radius  = distance / 4;
        var centerX  = c1x + (c2x - c1x) / 4;
        var centerY = c1y + (c2y - c1y) / 4;
        
        if (intersections2Circles(c1x, c1y, r, centerX, centerY, radius, result)) 
        {
            var t1x  = result[0];
            var t1y  = result[1];
            var t2x  = result[2];
            var t2y  = result[3];
            
            var midX  = (c1x + c2x) / 2;
            var midY  = (c1y + c2y) / 2;
            var dotProd = (t1x - midX) * (c2y - c1y) + (t1y - midY) * (-c2x + c1x);
            var tproj = dotProd / (distance * distance);
            var projx = midX + tproj * (c2y - c1y);
            var projy  = midY - tproj * (c2x - c1x);
            
            
            var t4x  = 2 * projx - t1x;
            var t4y  = 2 * projy - t1y;
            
            var t3x  = t4x + t2x - t1x;
            var t3y = t2y + t4y - t1y;
            
            result = result.concat([ t3x, t3y, t4x, t4y ]);
            
            return true;
        }
        else 
        {
            // no tangent because cicles are intersecting
            return false;
        }
    }
    
    // <!!!> CIRCLES MUST HAVE SAME RADIUS
    public static function tangentsParalCircleToCircle(r : Float, c1x : Float, c1y : Float, c2x : Float, c2y : Float, result : Array<Float>) : Void
    {
        var distance  = Math.sqrt((c1x - c2x) * (c1x - c2x) + (c1y - c2y) * (c1y - c2y));
        var t1x  = c1x + r * (c2y - c1y) / distance;
        var t1y = c1y + r * (-c2x + c1x) / distance;
        var t2x  = 2 * c1x - t1x;
        var t2y  = 2 * c1y - t1y;
        var t3x  = t2x + c2x - c1x;
        var t3y  = t2y + c2y - c1y;
        var t4x  = t1x + c2x - c1x;
        var t4y  = t1y + c2y - c1y;
        for (f in [t1x, t1y, t2x, t2y, t3x, t3y, t4x, t4y])
			result.push(f);
    }
    
    // squared distance from point p to infinite line (a, b)
    public static function distanceSquaredPointToLine(px : Float, py : Float, ax : Float, ay : Float, bx : Float, by : Float) : Float
    {
        var a_b_squaredLength  = (bx - ax) * (bx - ax) + (by - ay) * (by - ay);
        var dotProduct  = (px - ax) * (bx - ax) + (py - ay) * (by - ay);
        var p_a_squaredLength  = (ax - px) * (ax - px) + (ay - py) * (ay - py);
        return p_a_squaredLength - dotProduct * dotProduct / a_b_squaredLength;
    }
    
    // squared distance from point p to finite segment [a, b]
    public static function distanceSquaredPointToSegment(px : Float, py : Float, ax : Float, ay : Float, bx : Float, by : Float) : Float
    {
        var a_b_squaredLength = (bx - ax) * (bx - ax) + (by - ay) * (by - ay);
        var dotProduct  = ((px - ax) * (bx - ax) + (py - ay) * (by - ay)) / a_b_squaredLength;
        if (dotProduct < 0) 
        {
            return (px - ax) * (px - ax) + (py - ay) * (py - ay);
        }
        else if (dotProduct <= 1) 
        {
            var p_a_squaredLength = (ax - px) * (ax - px) + (ay - py) * (ay - py);
            return p_a_squaredLength - dotProduct * dotProduct * a_b_squaredLength;
        }
        else 
        {
            return (px - bx) * (px - bx) + (py - by) * (py - by);
        }
    }
    
    public static function distanceSquaredVertexToEdge(vertex : Vertex, edge : Edge) : Float
    {
        return distanceSquaredPointToSegment(vertex.pos.x, vertex.pos.y, edge.originVertex.pos.x, edge.originVertex.pos.y, edge.destinationVertex.pos.x, edge.destinationVertex.pos.y);
    }
    
    public static function pathLength(path : Array<Float>) : Float
    {
        var sumDistance  = 0.;
        var fromX = path[0];
        var fromY  = path[1];
        var nextX : Float;
        var nextY : Float;
        var x : Float;
        var y : Float;
        var distance : Float;
        var i = 2;
        while (i < path.length){
            nextX = path[i];
            nextY = path[i + 1];
            x = nextX - fromX;
            y = nextY - fromY;
            distance = Math.sqrt(x * x + y * y);
            sumDistance += distance;
            fromX = nextX;
            fromY = nextY;
            i += 2;
        }
        
        return sumDistance;
    }

    public function new()
    {
    }
}
