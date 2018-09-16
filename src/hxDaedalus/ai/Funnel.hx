package hxDaedalus.ai;


import hxDaedalus.data.Constants;
import hxDaedalus.data.Edge;
import hxDaedalus.data.Face;
import hxDaedalus.data.math.Geom2D;
import hxDaedalus.data.Vertex;
import hxDaedalus.data.math.Point2D;
import hxDaedalus.debug.Debug;

@:expose
class Funnel
{
    public var radius(get, set) : Float;

    
     var _radius : Float = 0;
     var _radiusSquared : Float = 0;
     var _numSamplesCircle : Int = 16;
     var _sampleCircle : Array<Point2D>;
     var _sampleCircleDistanceSquared : Float;
    #if js
    
    #else
     //public var debugSurface : Sprite;
    #end
    
    public function new()
    {
        _poolPoints = new Array<Point2D>();
        for (i in 0..._poolPointsSize){
            _poolPoints.push(new Point2D());
        }
    }
    
    public function dispose() : Void
    {
        _sampleCircle = null;
    }
    
    
     var _poolPointsSize : Int = 3000;
     var _poolPoints : Array<Point2D>;
     var _currPoolPointsIndex : Int = 0;
     var __point : Point2D;
    public function getPoint(x : Float = 0, y : Float = 0) : Point2D
    {
        __point = _poolPoints[_currPoolPointsIndex];
        __point.setXY(x, y);
        
        _currPoolPointsIndex++;
        if (_currPoolPointsIndex == _poolPointsSize) 
        {
            _poolPoints.push(new Point2D());
            _poolPointsSize++;
        }
        
        return __point;
    }
    public function getCopyPoint(pointToCopy : Point2D) : Point2D
    {
        return getPoint(pointToCopy.x, pointToCopy.y);
    }
    
     function get_radius() : Float
    {
        return _radius;
    }
    
     function set_radius(value : Float) : Float
    {
        _radius = Math.max( 0, value );
        _radiusSquared = _radius * _radius;
        _sampleCircle = new Array<Point2D>();
        if( radius == 0 ) return 0;
        for( i in 0..._numSamplesCircle ){
            _sampleCircle.push( new Point2D(    _radius * Math.cos( -2 * Math.PI * i / _numSamplesCircle )
                                            ,   _radius * Math.sin( -2 * Math.PI * i / _numSamplesCircle )
                                            )
                            );
        }
        _sampleCircleDistanceSquared = (_sampleCircle[0].x - _sampleCircle[1].x) * (_sampleCircle[0].x - _sampleCircle[1].x) + (_sampleCircle[0].y - _sampleCircle[1].y) * (_sampleCircle[0].y - _sampleCircle[1].y);
        return _radius;
    }
    
    public function findPath( fromX: Float, fromY: Float
                            , toX : Float, toY : Float
                            , listFaces : Array<Face>
                            , listEdges : Array<Edge>
                            , resultPath : Array<Float>) : Void {
        _currPoolPointsIndex = 0;
        
        // we check the start and goal
        if (_radius > 0) 
        {
            var checkFace = listFaces[0];
            var distanceSquared : Float;
            var distance : Float;
            var p1 : Point2D;
            var p2 : Point2D;
            var p3 : Point2D;
            p1 = checkFace.edge.originVertex.pos;
            p2 = checkFace.edge.destinationVertex.pos;
            p3 = checkFace.edge.nextLeftEdge.destinationVertex.pos;
            distanceSquared = (p1.x - fromX) * (p1.x - fromX) + (p1.y - fromY) * (p1.y - fromY);
            if (distanceSquared <= _radiusSquared) 
            {
                distance = Math.sqrt(distanceSquared);
                fromX = _radius * 1.01 * ((fromX - p1.x) / distance) + p1.x;
                fromY = _radius * 1.01 * ((fromY - p1.y) / distance) + p1.y;
            }
            else 
            {
                distanceSquared = (p2.x - fromX) * (p2.x - fromX) + (p2.y - fromY) * (p2.y - fromY);
                if (distanceSquared <= _radiusSquared) 
                {
                    distance = Math.sqrt(distanceSquared);
                    fromX = _radius * 1.01 * ((fromX - p2.x) / distance) + p2.x;
                    fromY = _radius * 1.01 * ((fromY - p2.y) / distance) + p2.y;
                }
                else 
                {
                    distanceSquared = (p3.x - fromX) * (p3.x - fromX) + (p3.y - fromY) * (p3.y - fromY);
                    if (distanceSquared <= _radiusSquared) 
                    {
                        distance = Math.sqrt(distanceSquared);
                        fromX = _radius * 1.01 * ((fromX - p3.x) / distance) + p3.x;
                        fromY = _radius * 1.01 * ((fromY - p3.y) / distance) + p3.y;
                    }
                }
            }  //  
            
            checkFace = listFaces[listFaces.length - 1];
            p1 = checkFace.edge.originVertex.pos;
            p2 = checkFace.edge.destinationVertex.pos;
            p3 = checkFace.edge.nextLeftEdge.destinationVertex.pos;
            distanceSquared = (p1.x - toX) * (p1.x - toX) + (p1.y - toY) * (p1.y - toY);
            if (distanceSquared <= _radiusSquared) 
            {
                distance = Math.sqrt(distanceSquared);
                toX = _radius * 1.01 * ((toX - p1.x) / distance) + p1.x;
                toY = _radius * 1.01 * ((toY - p1.y) / distance) + p1.y;
            }
            else 
            {
                distanceSquared = (p2.x - toX) * (p2.x - toX) + (p2.y - toY) * (p2.y - toY);
                if (distanceSquared <= _radiusSquared) 
                {
                    distance = Math.sqrt(distanceSquared);
                    toX = _radius * 1.01 * ((toX - p2.x) / distance) + p2.x;
                    toY = _radius * 1.01 * ((toY - p2.y) / distance) + p2.y;
                }
                else 
                {
                    distanceSquared = (p3.x - toX) * (p3.x - toX) + (p3.y - toY) * (p3.y - toY);
                    if (distanceSquared <= _radiusSquared) 
                    {
                        distance = Math.sqrt(distanceSquared);
                        toX = _radius * 1.01 * ((toX - p3.x) / distance) + p3.x;
                        toY = _radius * 1.01 * ((toY - p3.y) / distance) + p3.y;
                    }
                }
            }
        }  // we build starting and ending points  
        
        
        
        
        
        var startPoint : Point2D;
        var endPoint :Point2D;
        startPoint = new Point2D(fromX, fromY);
        endPoint = new Point2D(toX, toY);

        // useful
        var i : Int;
        var j : Int;
        var k : Int;
        var currEdge : Edge = null;
        var currVertex : Vertex = null;
        var direction : Int;

        // fix for issue76
        if (listFaces.length > 1) {
            // first we skip the first face and first edge if the starting point lies on the first interior edge:
            switch( Geom2D.isInFace(fromX, fromY, listFaces[0]) )
            {
                case EEdge( edge ):
                    if( listEdges[0] == edge )
                    {
                        listEdges.shift();
                        listFaces.shift();
                    }
                case _:
                    // 
            }
        }
        if (listFaces.length == 1)
        {
            resultPath.push(startPoint.x);
            resultPath.push(startPoint.y);
            resultPath.push(endPoint.x);
            resultPath.push(endPoint.y);
            return;
        }

        // our funnels, inited with starting point  
        var funnelLeft = new Array<Point2D>();
        var funnelRight = new Array<Point2D>();
        funnelLeft.push(startPoint);
        funnelRight.push(startPoint);
        
        // useful to keep track of done vertices and compare the sides
        var verticesDoneSide = new Map<Vertex,Int>();
        
        // we extract the vertices positions and sides from the edges list
        var pointsList = new Array<Point2D>();
        var pointSides = new Map<Point2D,Int>();
        // we keep the successor relation in a dictionnary
        var pointSuccessor = new Map<Point2D,Point2D>();
        //
        pointSides[ startPoint ] = 0;
        // we begin with the vertices in first edge
        currEdge = listEdges[0];
        var relativPos : Int = Geom2D.getRelativePosition2(fromX, fromY, currEdge);
        var prevPoint : Point2D;
        var newPointA : Point2D;
        var newPointB : Point2D;
        newPointA = getCopyPoint( currEdge.destinationVertex.pos );
        newPointB = getCopyPoint( currEdge.originVertex.pos );
        
        pointsList.push(newPointA);
        pointsList.push(newPointB);
        pointSuccessor[ startPoint ] = newPointA;
        pointSuccessor[ newPointA ] = newPointB;
        prevPoint = newPointB;
        if( relativPos == 1 ){
            pointSides[ newPointA ] = 1;
            pointSides[ newPointB ] = -1;
            verticesDoneSide[ currEdge.destinationVertex ] = 1;
            verticesDoneSide[ currEdge.originVertex ] = -1;
        }else if (relativPos == -1) {// then we iterate through the edges
            pointSides[ newPointA ] = -1;
            pointSides[ newPointB ] = 1;
            verticesDoneSide[ currEdge.destinationVertex ] = -1;
            verticesDoneSide[ currEdge.originVertex ] = 1;
        }
        
        
        
        var fromVertex = listEdges[ 0 ].originVertex;
        var fromFromVertex = listEdges[ 0 ].destinationVertex;
        for (i in 1...listEdges.length ){
            // we identify the current vertex and his origin vertex
            currEdge = listEdges[ i ];
            if (currEdge.originVertex == fromVertex) 
            {
                currVertex = currEdge.destinationVertex;
            }
            else if (currEdge.destinationVertex == fromVertex) 
            {
                currVertex = currEdge.originVertex;
            }
            else if (currEdge.originVertex == fromFromVertex) 
            {
                currVertex = currEdge.destinationVertex;
                fromVertex = fromFromVertex;
            }
            else if (currEdge.destinationVertex == fromFromVertex) 
            {
                currVertex = currEdge.originVertex;
                fromVertex = fromFromVertex;
            }
            else 
            {
                Debug.trace("IMPOSSIBLE TO IDENTIFY THE VERTEX !!!");
            }
            
            newPointA = getCopyPoint(currVertex.pos);
            pointsList.push(newPointA);
            direction = - verticesDoneSide[ fromVertex ];
            pointSides[ newPointA ] = direction;
            pointSuccessor[ prevPoint ] = newPointA;
            verticesDoneSide[ currVertex ] = direction;
            prevPoint = newPointA;
            fromFromVertex = fromVertex;
            fromVertex = currVertex;
        }  // we then we add the end point  
        
        pointSuccessor[ prevPoint ] = endPoint;
        pointSides[ endPoint ] = 0;
        
        /*
        debugSurface.graphics.clear();
        debugSurface.graphics.lineStyle(1, 0x0000FF);
        var ppp1:Point = startPoint;
        var ppp2:Point = pointSuccessor[ppp1];
        while (ppp2)
        {
        debugSurface.graphics.moveTo(ppp1.x, ppp1.y+2);
        debugSurface.graphics.lineTo(ppp2.x, ppp2.y+2);
        debugSurface.graphics.drawCircle(ppp2.x, ppp2.y, 3);
        ppp1 = ppp2;
        ppp2 = pointSuccessor[ppp2];
        }
        
        debugSurface.graphics.lineStyle(1, 0x00FF00);
        for (i=1 ; i<pointsList.length ; i++)
        {
        debugSurface.graphics.moveTo(pointsList[i-1].x+2, pointsList[i-1].y);
        debugSurface.graphics.lineTo(pointsList[i].x+2, pointsList[i].y);
        }
        */
        
        // we will keep the points and funnel sides of the optimized path
        var pathPoints = new Array<Point2D>();
        var pathSides = new Map<Point2D,Int>();
        pathPoints.push( startPoint );
        pathSides[ startPoint ] = 0;
        
        // now we process the points by order
        var currPos : Point2D;
        for (i in 0...pointsList.length){
            currPos = pointsList[i];
            
            // we identify the current vertex funnel's position by the position of his origin vertex
            if ( pointSides[ currPos ] == -1 ) {
                // current vertex is at right
                //Debug.trace("current vertex is at right");
                j = funnelLeft.length - 2;
                while (j >= 0){
                    direction = Geom2D.getDirection(funnelLeft[j].x, funnelLeft[j].y, funnelLeft[j + 1].x, funnelLeft[j + 1].y, currPos.x, currPos.y);
                    if (direction != -1) 
                    {
                        //Debug.trace("funnels are crossing");
                        
                        funnelLeft.shift();
                        for (k in 0...j){
                            pathPoints.push(funnelLeft[0]);
                            pathSides[ funnelLeft[0] ] = 1;
                            funnelLeft.shift();
                        }
                        pathPoints.push(funnelLeft[0]);
                        pathSides[ funnelLeft[0]] = 1;
                        funnelRight.splice(0, funnelRight.length);
                        funnelRight.push(funnelLeft[0] );
                        funnelRight.push( currPos );
                        break;
                    }
                    j--;
                }
                
                funnelRight.push(currPos);
                j = funnelRight.length - 3;
                while (j >= 0){
                    direction = Geom2D.getDirection(funnelRight[j].x, funnelRight[j].y, funnelRight[j + 1].x, funnelRight[j + 1].y, currPos.x, currPos.y);
                    if (direction == -1) 
                        break
                    else 
                    {
                        funnelRight.splice(j + 1, 1);
                    }
                    j--;
                }
            }
            else 
            {
                // current vertex is at left
                j = funnelRight.length - 2;
                while (j >= 0){
                    direction = Geom2D.getDirection(funnelRight[j].x, funnelRight[j].y, funnelRight[j + 1].x, funnelRight[j + 1].y, currPos.x, currPos.y);
                    if (direction != 1) 
                    {
                        funnelRight.shift();
                        for (k in 0...j){
                            pathPoints.push(funnelRight[0]);
                            pathSides[funnelRight[0] ] = -1;
                            funnelRight.shift();
                        }
                        pathPoints.push(funnelRight[0]);
                        pathSides[funnelRight[0] ]= -1;
                        funnelLeft.splice(0, funnelLeft.length);
                        funnelLeft.push(funnelRight[0] );
                        funnelLeft.push( currPos );
                        break;
                    }
                    j--;
                }
                
                funnelLeft.push(currPos);
                j = funnelLeft.length - 3;
                while (j >= 0){
                    direction = Geom2D.getDirection(funnelLeft[j].x, funnelLeft[j].y, funnelLeft[j + 1].x, funnelLeft[j + 1].y, currPos.x, currPos.y);
                    if (direction == 1) 
                        break
                    else 
                    {
                        funnelLeft.splice(j + 1, 1);
                    }
                    j--;
                }
            }
        }  // check if the goal is blocked by one funnel's right vertex  
        
        
        
        var blocked = false;
        //Debug.trace("check if the goal is blocked by one funnel right vertex");
        j = funnelRight.length - 2;
        while (j >= 0){
            direction = Geom2D.getDirection(funnelRight[j].x, funnelRight[j].y, funnelRight[j + 1].x, funnelRight[j + 1].y, toX, toY);
            //Debug.trace("dir" + funnelRight[j].x + "," + funnelRight[j].y + " " + funnelRight[j+1].x + "," + funnelRight[j+1].y + " " + toX + "," + toY);
            if (direction != 1) 
            {
                //Debug.trace("goal access right blocked");
                // access blocked
                funnelRight.shift();
                for (k in 0...j + 1){
                    pathPoints.push(funnelRight[0]);
                    pathSides[ funnelRight[0] ] = -1;
                    funnelRight.shift();
                }
                pathPoints.push(endPoint);
                pathSides[ endPoint ] = 0;
                blocked = true;
                break;
            }
            j--;
        }
        
        if (!blocked) 
        {
            // check if the goal is blocked by one funnel's left vertex
            //Debug.trace("check if the goal is blocked by one funnel left vertex");
            j = funnelLeft.length - 2;
            while (j >= 0){
                direction = Geom2D.getDirection(funnelLeft[j].x, funnelLeft[j].y, funnelLeft[j + 1].x, funnelLeft[j + 1].y, toX, toY);
                //Debug.trace("dir " + funnelLeft[j].x + "," + funnelLeft[j].y + " " + funnelLeft[j+1].x + "," + funnelLeft[j+1].y + " " + toX + "," + toY);
                if (direction != -1) 
                {
                    //Debug.trace("goal access left blocked");
                    // access blocked
                    funnelLeft.shift();
                    for (k in 0...j + 1){
                        pathPoints.push(funnelLeft[0]);
                        pathSides[ funnelLeft[0] ] = 1;
                        funnelLeft.shift();
                    }
                    
                    pathPoints.push(endPoint);
                    pathSides[ endPoint ] = 0;
                    blocked = true;
                    break;
                }
                j--;
            }
        }  // if not blocked, we consider the direct path  
        
        
        
        if (!blocked) 
        {
            pathPoints.push(endPoint);
            pathSides[ endPoint ] = 0;
            blocked = true;
        }  // if radius is non zero  
        
        
        var adjustedPoints= new Array<Point2D>();
        if (radius > 0) 
        {
            
            var newPath : Array<Point2D> = new Array<Point2D>();
            
            if (pathPoints.length == 2) 
            {
                adjustWithTangents(pathPoints[0], false, pathPoints[1], false, pointSides, pointSuccessor, newPath, adjustedPoints);
            }
            else if (pathPoints.length > 2) 
            {
                // tangent from start point to 2nd point
                adjustWithTangents(pathPoints[0], false, pathPoints[1], true, pointSides, pointSuccessor, newPath, adjustedPoints);
                
                // tangents for intermediate points
                if (pathPoints.length > 3) 
                {
                    for (i in 1...pathPoints.length - 3 + 1){
                        adjustWithTangents(pathPoints[i], true, pathPoints[i + 1], true, pointSides, pointSuccessor, newPath, adjustedPoints);
                    }
                }  // tangent from last-1 point to end point  
                
                
                
                var pathLength : Int = pathPoints.length;
                adjustWithTangents(pathPoints[pathLength - 2], true, pathPoints[pathLength - 1], false, pointSides, pointSuccessor, newPath, adjustedPoints);
            }
            
            newPath.push(endPoint);
            
            // adjusted path can have useless tangents, we check it
            checkAdjustedPath(newPath, adjustedPoints, pointSides);
            
            var smoothPoints = new Array<Point2D>();
            i = newPath.length - 2;
            while (i >= 1){
                smoothAngle(adjustedPoints[i * 2 - 1], newPath[i], adjustedPoints[i * 2], pointSides[ newPath[i] ], smoothPoints);
                while (smoothPoints.length != 0 )
                {
                    var temp = i * 2;
                    adjustedPoints.splice(temp, 0 );
                    adjustedPoints.insert( temp, smoothPoints.pop());
                }
                i--;
            }
        }
        else 
        {
            adjustedPoints = pathPoints;
        }  // extract coordinates  
        
        
        
        for (i in 0...adjustedPoints.length){
            resultPath.push(adjustedPoints[i].x);
            resultPath.push(adjustedPoints[i].y);
        }
    }
    
     function adjustWithTangents(p1 : Point2D, applyRadiusToP1 : Bool, p2 : Point2D, applyRadiusToP2 : Bool, pointSides : Map<Point2D,Int>, pointSuccessor : Map<Point2D,Point2D>, newPath : Array<Point2D>, adjustedPoints : Array<Point2D>) : Void
    {
        // we find the tangent T between the points pathPoints[i] - pathPoints[i+1]
        // then we check the unused intermediate points between pathPoints[i] and pathPoints[i+1]
        // if a point P is too close from the segment, we replace T by 2 tangents T1, T2, between the points pathPoints[i] P and P - pathPoints[i+1]
        
        //Debug.trace("adjustWithTangents");
        
        var tangentsResult : Array<Float> = new Array<Float>();
        
        var side1 : Int = pointSides[ p1 ];
        var side2 : Int = pointSides[ p2 ];
        
        var pTangent1 : Point2D = null;
        var pTangent2 : Point2D = null;
        
        // if no radius application
        if (!applyRadiusToP1 && !applyRadiusToP2) 
        {
            //Debug.trace("no radius applied");
            pTangent1 = p1;
            pTangent2 = p2;
        }
        // we apply radius to p2 only
        else if (!applyRadiusToP1) 
        {
            //Debug.trace("! applyRadiusToP1");
            if (Geom2D.tangentsPointToCircle(p1.x, p1.y, p2.x, p2.y, _radius, tangentsResult)) {
				// p2 lies on the left funnel
				if (side2 == 1) 
				{
					pTangent1 = p1;
					pTangent2 = getPoint(tangentsResult[2], tangentsResult[3]);
				}
				// p2 lies on the right funnel
				else 
				{
					pTangent1 = p1;
					pTangent2 = getPoint(tangentsResult[0], tangentsResult[1]);
				}
			} else {
				Debug.trace("NO TANGENT");
				return;
			}
        }
        // we apply radius to p1 only
        else if (!applyRadiusToP2) 
        {
            //Debug.trace("! applyRadiusToP2");
            if (Geom2D.tangentsPointToCircle(p2.x, p2.y, p1.x, p1.y, _radius, tangentsResult)) {
				if (tangentsResult.length > 0)
				{
					// p1 lies on the left funnel
					if (side1 == 1) 
					{
						pTangent1 = getPoint(tangentsResult[0], tangentsResult[1]);
						pTangent2 = p2;
					}
					// p1 lies on the right funnel
					else 
					{
						pTangent1 = getPoint(tangentsResult[2], tangentsResult[3]);
						pTangent2 = p2;
					}
				}
			} else {
				Debug.trace("NO TANGENT");
				return;
			}
        }
        // we apply radius to both points
        else 
        {
            //Debug.trace("we apply radius to both points");
            // both points lie on left funnel
            if (side1 == 1 && side2 == 1) 
            {
                Geom2D.tangentsParalCircleToCircle(_radius, p1.x, p1.y, p2.x, p2.y, tangentsResult);
                // we keep the points of the right tangent
                pTangent1 = getPoint(tangentsResult[2], tangentsResult[3]);
                pTangent2 = getPoint(tangentsResult[4], tangentsResult[5]);
            }
            // both points lie on right funnel
            else if (side1 == -1 && side2 == -1) 
            {
                Geom2D.tangentsParalCircleToCircle(_radius, p1.x, p1.y, p2.x, p2.y, tangentsResult);
                // we keep the points of the left tangent
                pTangent1 = getPoint(tangentsResult[0], tangentsResult[1]);
                pTangent2 = getPoint(tangentsResult[6], tangentsResult[7]);
            }
            // 1st point lies on left funnel, 2nd on right funnel
            else if (side1 == 1 && side2 == -1) 
            {
                if (Geom2D.tangentsCrossCircleToCircle(_radius, p1.x, p1.y, p2.x, p2.y, tangentsResult)) 
                {
                    // we keep the points of the right-left tangent
                    pTangent1 = getPoint(tangentsResult[2], tangentsResult[3]);
                    pTangent2 = getPoint(tangentsResult[6], tangentsResult[7]);
                }
                else 
                {
                    // NO TANGENT BECAUSE POINTS TOO CLOSE
                    // A* MUST CHECK THAT !
                    Debug.trace("NO TANGENT, points are too close for radius");
                    return;
                }
            }
            // 1st point lies on right funnel, 2nd on left funnel
            else 
            {
                if (Geom2D.tangentsCrossCircleToCircle(_radius, p1.x, p1.y, p2.x, p2.y, tangentsResult)) 
                {
                    // we keep the points of the left-right tangent
                    pTangent1 = getPoint(tangentsResult[0], tangentsResult[1]);
                    pTangent2 = getPoint(tangentsResult[4], tangentsResult[5]);
                }
                else 
                {
                    // NO TANGENT BECAUSE POINTS TOO CLOSE
                    // A* MUST CHECK THAT !
                    Debug.trace("NO TANGENT, points are too close for radius");
                    return;
                }
            }
        }
        
        var successor = pointSuccessor[ p1 ];
        var distance : Float;
        while (successor != p2)
        {
            distance = Geom2D.distanceSquaredPointToSegment(successor.x, successor.y, pTangent1.x, pTangent1.y, pTangent2.x, pTangent2.y);
            if (distance < _radiusSquared) 
            {
                adjustWithTangents(p1, applyRadiusToP1, successor, true, pointSides, pointSuccessor, newPath, adjustedPoints);
                adjustWithTangents(successor, true, p2, applyRadiusToP2, pointSides, pointSuccessor, newPath, adjustedPoints);
                return;
            }
            else 
            {
                successor = pointSuccessor[successor];
            }
        }  /*if ( adjustedPoints.length > 0 )
        {
        var distanceSquared:Number;
        var lastPoint:Point = adjustedPoints[adjustedPoints.length-1];
        distanceSquared = (lastPoint.x - pTangent1.x)*(lastPoint.x - pTangent1.x) + (lastPoint.y - pTangent1.y)*(lastPoint.y - pTangent1.y);
        if (distanceSquared <= QEConstants.EPSILON_SQUARED)
        {
        adjustedPoints.pop();
        adjustedPoints.push(pTangent2);
        return;
        }
        }*/    // we check distance in order to remove useless close points due to straight line subdivision  
        
        
        
        
        
        adjustedPoints.push( pTangent1 );
        adjustedPoints.push( pTangent2 );
        newPath.push( p1 );
    }
    
     function checkAdjustedPath( newPath : Array<Point2D>, adjustedPoints : Array<Point2D>, pointSides : Map<Point2D,Int> ) : Void
    {
        
        var needCheck = true;
        
        var point0 : Point2D;
        var point0Side : Int;
        var point1 : Point2D;
        var point1Side : Int;
        var point2 : Point2D;
        var point2Side : Int;
        
        var pt1 : Point2D;
        var pt2 : Point2D;
        var pt3 : Point2D;
        var dot : Float;
        
        var tangentsResult = new Array<Float>();
        var pTangent1 : Point2D = null;
        var pTangent2 : Point2D = null;
        
        while (needCheck)
        {
            needCheck = false;
            var i = 2;
            while(i < newPath.length ){
                point2 = newPath[i];
                point2Side = pointSides[ point2 ];
                point1 = newPath[i - 1];
                point1Side = pointSides[ point1 ];
                point0 = newPath[i - 2];
                point0Side = pointSides[ point0 ];
                
                if( point1Side == point2Side ) 
                {
                    pt1 = adjustedPoints[(i - 2) * 2];
                    pt2 = adjustedPoints[(i - 1) * 2 - 1];
                    pt3 = adjustedPoints[(i - 1) * 2];
                    dot = (pt1.x - pt2.x) * (pt3.x - pt2.x) + (pt1.y - pt2.y) * (pt3.y - pt2.y);
                    if (dot > 0) 
                    {
                        //needCheck = true;
                        //Debug.trace("dot > 0");
                        // rework the tangent
                        if (i == 2) 
                        {
                            // tangent from start point
                            Geom2D.tangentsPointToCircle(point0.x, point0.y, point2.x, point2.y, _radius, tangentsResult);
                            // p2 lies on the left funnel
                            if (point2Side == 1) 
                            {
                                pTangent1 = point0;
                                pTangent2 = getPoint(tangentsResult[2], tangentsResult[3]);
                            }
                            else 
                            {
                                pTangent1 = point0;
                                pTangent2 = getPoint(tangentsResult[0], tangentsResult[1]);
                            }
                        }
                        else if (i == newPath.length - 1) 
                        {
                            // tangent to end point
                            Geom2D.tangentsPointToCircle(point2.x, point2.y, point0.x, point0.y, _radius, tangentsResult);
                            // p1 lies on the left funnel
                            if (point0Side == 1) 
                            {
                                pTangent1 = getPoint(tangentsResult[0], tangentsResult[1]);
                                pTangent2 = point2;
                            }
                            // p1 lies on the right funnel
                            else 
                            {
                                pTangent1 = getPoint(tangentsResult[2], tangentsResult[3]);
                                pTangent2 = point2;
                            }
                        }
                        else 
                        {
                            // 1st point lies on left funnel, 2nd on right funnel
                            if (point0Side == 1 && point2Side == -1) 
                            {
                                //Debug.trace("point0Side == 1 && point2Side == -1");
                                Geom2D.tangentsCrossCircleToCircle(_radius, point0.x, point0.y, point2.x, point2.y, tangentsResult);  // we keep the points of the right-left tangent  ;
                                
                                pTangent1 = getPoint(tangentsResult[2], tangentsResult[3]);
                                pTangent2 = getPoint(tangentsResult[6], tangentsResult[7]);
                            }
                            // 1st point lies on right funnel, 2nd on left funnel
                            else if (point0Side == -1 && point2Side == 1) 
                            {
                                //Debug.trace("point0Side == -1 && point2Side == 1");
                                Geom2D.tangentsCrossCircleToCircle(_radius, point0.x, point0.y, point2.x, point2.y, tangentsResult);  // we keep the points of the right-left tangent  ;
                                
                                pTangent1 = getPoint(tangentsResult[0], tangentsResult[1]);
                                pTangent2 = getPoint(tangentsResult[4], tangentsResult[5]);
                            }
                            // both points lie on left funnel
                            else if (point0Side == 1 && point2Side == 1) 
                            {
                                //Debug.trace("point0Side == 1 && point2Side == 1");
                                Geom2D.tangentsParalCircleToCircle(_radius, point0.x, point0.y, point2.x, point2.y, tangentsResult);
                                // we keep the points of the right tangent
                                pTangent1 = getPoint(tangentsResult[2], tangentsResult[3]);
                                pTangent2 = getPoint(tangentsResult[4], tangentsResult[5]);
                            }
                            // both points lie on right funnel
                            else if (point0Side == -1 && point2Side == -1) 
                            {
                                //Debug.trace("point0Side == -1 && point2Side == -1");
                                Geom2D.tangentsParalCircleToCircle(_radius, point0.x, point0.y, point2.x, point2.y, tangentsResult);
                                // we keep the points of the right tangent
                                pTangent1 = getPoint(tangentsResult[0], tangentsResult[1]);
                                pTangent2 = getPoint(tangentsResult[6], tangentsResult[7]);
                            }
                        }
                        var temp = ( i - 2) * 2;
                        adjustedPoints.splice( temp, 1 );
                        adjustedPoints.insert( temp, pTangent1 );
                        temp = i * 2 - 1;
                        adjustedPoints.splice( temp, 1 );
                        adjustedPoints.insert( temp, pTangent2);
                        
                        // delete useless point
                        newPath.splice(i - 1, 1);
                        adjustedPoints.splice((i - 1) * 2 - 1, 2);
                        
                        tangentsResult.splice(0, tangentsResult.length);
                        i--;
                    }
                }
				i++;
            }
        }
    }
    
     function smoothAngle(prevPoint : Point2D, pointToSmooth : Point2D, nextPoint : Point2D, side : Int, encirclePoints : Array<Point2D>) : Void
    {
        var angleType = Geom2D.getDirection(prevPoint.x, prevPoint.y, pointToSmooth.x, pointToSmooth.y, nextPoint.x, nextPoint.y);
        
        /*
        Debug.trace("smoothAngle");
        Debug.trace("angleType " + angleType);
        Debug.trace("prevPoint " + prevPoint);
        Debug.trace("pointToSmooth " + pointToSmooth);
        Debug.trace("nextPoint " + nextPoint);
        */
        
        var distanceSquared = (prevPoint.x - nextPoint.x) * (prevPoint.x - nextPoint.x) + (prevPoint.y - nextPoint.y) * (prevPoint.y - nextPoint.y);
        if (distanceSquared <= _sampleCircleDistanceSquared) 
            return;
        
        var index : Int = 0;
        var side1 : Int;
        var side2 : Int;
        var pointInArea : Bool;
        var xToCheck : Float;
        var yToCheck : Float;
        for (i in 0..._numSamplesCircle){
            pointInArea = false;
            xToCheck = pointToSmooth.x + _sampleCircle[i].x;
            yToCheck = pointToSmooth.y + _sampleCircle[i].y;
            side1 = Geom2D.getDirection(prevPoint.x, prevPoint.y, pointToSmooth.x, pointToSmooth.y, xToCheck, yToCheck);
            side2 = Geom2D.getDirection(pointToSmooth.x, pointToSmooth.y, nextPoint.x, nextPoint.y, xToCheck, yToCheck);
            
            // if funnel left
            if (side == 1) 
            {
                //Debug.trace("funnel side is 1");
                // if angle is < 180
                if (angleType == -1) 
                {
                    //Debug.trace("angle type is -1");
                    if (side1 == -1 && side2 == -1) 
                        pointInArea = true;
                }
                // if angle is >= 180
                else 
                {
                    //Debug.trace("angle type is 1")
                    if (side1 == -1 || side2 == -1) 
                        pointInArea = true;
                }
            }
            // if funnel right
            else 
            {
                // if angle is < 180
                if (angleType == 1) 
                {
                    if (side1 == 1 && side2 == 1) 
                        pointInArea = true;
                }
                // if angle is >= 180
                else 
                {
                    if (side1 == 1 || side2 == 1) 
                        pointInArea = true;
                }
            }
            if (pointInArea) 
            {
                encirclePoints.splice(index, 0);
                encirclePoints.insert(index, new Point2D(xToCheck, yToCheck));
                index++;
            }
            else 
            index = 0;
        }
        if (side == -1) 
            encirclePoints.reverse();
    }
}
