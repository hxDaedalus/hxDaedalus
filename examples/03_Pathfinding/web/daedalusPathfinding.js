(function () { "use strict";
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.cca = function(s,index) {
	var x = s.charCodeAt(index);
	if(x != x) return undefined;
	return x;
};
HxOverrides.substr = function(s,pos,len) {
	if(pos != null && pos != 0 && len != null && len < 0) return "";
	if(len == null) len = s.length;
	if(pos < 0) {
		pos = s.length + pos;
		if(pos < 0) pos = 0;
	} else if(len < 0) len = s.length + len - pos;
	return s.substr(pos,len);
};
HxOverrides.indexOf = function(a,obj,i) {
	var len = a.length;
	if(i < 0) {
		i += len;
		if(i < 0) i = 0;
	}
	while(i < len) {
		if(a[i] === obj) return i;
		i++;
	}
	return -1;
};
var IMap = function() { };
IMap.__name__ = true;
Math.__name__ = true;
var PathfindingJS = function() {
	this.newPath = false;
	this.mesh = hxDaedalus.factories.RectMesh.buildRectangle(600,600);
	this.view = new hxDaedalus.view.SimpleViewJS();
	var randGen;
	randGen = new hxDaedalus.data.math.RandGenerator();
	randGen.set_seed(7259);
	var object;
	var shapeCoords;
	var _g = 0;
	while(_g < 50) {
		var i = _g++;
		haxe.Log.trace(" i " + i,{ fileName : "PathfindingJS.hx", lineNumber : 51, className : "PathfindingJS", methodName : "new"});
		object = new hxDaedalus.data.Object();
		shapeCoords = new Array();
		shapeCoords = [-1,-1,1,-1,1,-1,1,1,1,1,-1,1,-1,1,-1,-1];
		object.set_coordinates(shapeCoords);
		randGen.rangeMin = 10;
		randGen.rangeMax = 40;
		object.set_scaleX(randGen.next());
		object.set_scaleY(randGen.next());
		randGen.rangeMin = 0;
		randGen.rangeMax = 1000;
		object.set_rotation(randGen.next() / 1000 * Math.PI / 2);
		randGen.rangeMin = 50;
		randGen.rangeMax = 600;
		object.set_x(randGen.next());
		object.set_y(randGen.next());
		this.mesh.insertObject(object);
	}
	this.view.drawMesh(this.mesh);
	this.entityAI = new hxDaedalus.ai.EntityAI();
	this.entityAI.set_radius(4);
	this.entityAI.x = 20;
	this.entityAI.y = 20;
	this.view.drawEntity(this.entityAI);
	this.pathfinder = new hxDaedalus.ai.PathFinder();
	this.pathfinder.entity = this.entityAI;
	this.pathfinder.set_mesh(this.mesh);
	this.path = new Array();
	this.pathSampler = new hxDaedalus.ai.trajectory.LinearPathSampler();
	this.pathSampler.entity = this.entityAI;
	this.pathSampler.set_samplingDistance(5);
	this.pathSampler.set_path(this.path);
	window.document.body.onmousedown = $bind(this,this.onMouseDown);
	window.document.body.onmousedown = $bind(this,this.onMouseUp);
	window.document.body.onmousemove = $bind(this,this.onMouseMove);
	this.view.basicCanvas.onEnterFrame = $bind(this,this.onEnterFrame);
};
PathfindingJS.__name__ = true;
PathfindingJS.main = function() {
	new PathfindingJS();
};
PathfindingJS.prototype = {
	onMouseMove: function(e) {
		var p = e;
		this.x = p.clientX;
		this.y = p.clientY;
	}
	,onMouseUp: function(event) {
		this.newPath = false;
	}
	,onMouseDown: function(event) {
		this.newPath = true;
	}
	,onEnterFrame: function() {
		if(this.newPath) {
			this.pathfinder.findPath(this.x,this.y,this.path);
			this.view.drawPath(this.path);
			this.pathSampler.reset();
		}
		if(this.pathSampler.get_hasNext()) {
			this.pathSampler.next();
			this.view.drawEntity(this.entityAI);
		}
	}
};
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
};
Std["int"] = function(x) {
	return x | 0;
};
Std.parseInt = function(x) {
	var v = parseInt(x,10);
	if(v == 0 && (HxOverrides.cca(x,1) == 120 || HxOverrides.cca(x,1) == 88)) v = parseInt(x);
	if(isNaN(v)) return null;
	return v;
};
Std.parseFloat = function(x) {
	return parseFloat(x);
};
var StringTools = function() { };
StringTools.__name__ = true;
StringTools.hex = function(n,digits) {
	var s = "";
	var hexChars = "0123456789ABCDEF";
	do {
		s = hexChars.charAt(n & 15) + s;
		n >>>= 4;
	} while(n > 0);
	if(digits != null) while(s.length < digits) s = "0" + s;
	return s;
};
var haxe = {};
haxe.Log = function() { };
haxe.Log.__name__ = true;
haxe.Log.trace = function(v,infos) {
	js.Boot.__trace(v,infos);
};
haxe.ds = {};
haxe.ds.ObjectMap = function() {
	this.h = { };
	this.h.__keys__ = { };
};
haxe.ds.ObjectMap.__name__ = true;
haxe.ds.ObjectMap.__interfaces__ = [IMap];
haxe.ds.ObjectMap.prototype = {
	set: function(key,value) {
		var id = key.__id__ || (key.__id__ = ++haxe.ds.ObjectMap.count);
		this.h[id] = value;
		this.h.__keys__[id] = key;
	}
};
var hxDaedalus = {};
hxDaedalus.ai = {};
hxDaedalus.ai.AStar = function() {
	this.iterEdge = new hxDaedalus.iterators.FromFaceToInnerEdges();
};
hxDaedalus.ai.AStar.__name__ = true;
hxDaedalus.ai.AStar.prototype = {
	dispose: function() {
		this._mesh = null;
		this.closedFaces = null;
		this.sortedOpenedFaces = null;
		this.openedFaces = null;
		this.entryEdges = null;
		this.entryX = null;
		this.entryY = null;
		this.scoreF = null;
		this.scoreG = null;
		this.scoreH = null;
		this.predecessor = null;
	}
	,get_radius: function() {
		return this._radius;
	}
	,set_radius: function(value) {
		this._radius = value;
		this.radiusSquared = this._radius * this._radius;
		this.diameter = this._radius * 2;
		this.diameterSquared = this.diameter * this.diameter;
		return value;
	}
	,set_mesh: function(value) {
		this._mesh = value;
		return value;
	}
	,findPath: function(fromX,fromY,toX,toY,resultListFaces,resultListEdges) {
		this.closedFaces = new haxe.ds.ObjectMap();
		this.sortedOpenedFaces = new Array();
		this.openedFaces = new haxe.ds.ObjectMap();
		this.entryEdges = new haxe.ds.ObjectMap();
		this.entryX = new haxe.ds.ObjectMap();
		this.entryY = new haxe.ds.ObjectMap();
		this.scoreF = new haxe.ds.ObjectMap();
		this.scoreG = new haxe.ds.ObjectMap();
		this.scoreH = new haxe.ds.ObjectMap();
		this.predecessor = new haxe.ds.ObjectMap();
		var loc;
		var locEdge;
		var locVertex;
		var distance;
		var p1;
		var p2;
		var p3;
		loc = hxDaedalus.data.math.Geom2D.locatePosition(fromX,fromY,this._mesh);
		switch(loc[1]) {
		case 0:
			var vertex = loc[2];
			locVertex = vertex;
			return;
		case 1:
			var edge = loc[2];
			locEdge = edge;
			if(locEdge.get_isConstrained()) return;
			this.fromFace = locEdge.get_leftFace();
			break;
		case 2:
			var face = loc[2];
			this.fromFace = face;
			break;
		case 3:
			break;
		}
		loc = hxDaedalus.data.math.Geom2D.locatePosition(toX,toY,this._mesh);
		switch(loc[1]) {
		case 0:
			var vertex1 = loc[2];
			locVertex = vertex1;
			this.toFace = locVertex.get_edge().get_leftFace();
			break;
		case 1:
			var edge1 = loc[2];
			locEdge = edge1;
			this.toFace = locEdge.get_leftFace();
			break;
		case 2:
			var face1 = loc[2];
			this.toFace = face1;
			break;
		case 3:
			break;
		}
		this.sortedOpenedFaces.push(this.fromFace);
		this.entryEdges.set(this.fromFace,null);
		null;
		this.entryX.set(this.fromFace,fromX);
		fromX;
		this.entryY.set(this.fromFace,fromY);
		fromY;
		this.scoreG.set(this.fromFace,0);
		0;
		var dist = Math.sqrt((toX - fromX) * (toX - fromX) + (toY - fromY) * (toY - fromY));
		this.scoreH.set(this.fromFace,dist);
		dist;
		this.scoreF.set(this.fromFace,dist);
		dist;
		var innerEdge;
		var neighbourFace;
		var f;
		var g;
		var h;
		var fromPoint = new hxDaedalus.data.math.Point2D();
		var entryPoint = new hxDaedalus.data.math.Point2D();
		var distancePoint = new hxDaedalus.data.math.Point2D();
		var fillDatas;
		while(true) {
			if(this.sortedOpenedFaces.length == 0) {
				haxe.Log.trace("AStar no path found",{ fileName : "AStar.hx", lineNumber : 157, className : "hxDaedalus.ai.AStar", methodName : "findPath"});
				this.curFace = null;
				break;
			}
			this.curFace = this.sortedOpenedFaces.pop();
			if(this.curFace == this.toFace) break;
			this.iterEdge.set_fromFace(this.curFace);
			while((innerEdge = this.iterEdge.next()) != null) {
				if(innerEdge.get_isConstrained()) continue;
				neighbourFace = innerEdge.get_rightFace();
				if(!this.closedFaces.h[neighbourFace.__id__]) {
					if(this.curFace != this.fromFace && this._radius > 0 && !this.isWalkableByRadius(this.entryEdges.h[this.curFace.__id__],this.curFace,innerEdge)) continue;
					fromPoint.x = this.entryX.h[this.curFace.__id__];
					fromPoint.y = this.entryY.h[this.curFace.__id__];
					entryPoint.x = fromPoint.x;
					entryPoint.y = fromPoint.y;
					entryPoint.x = (innerEdge.get_originVertex().get_pos().x + innerEdge.get_destinationVertex().get_pos().x) / 2;
					entryPoint.x = (innerEdge.get_originVertex().get_pos().y + innerEdge.get_destinationVertex().get_pos().y) / 2;
					distancePoint.x = entryPoint.x - toX;
					distancePoint.y = entryPoint.y - toY;
					h = distancePoint.get_length();
					distancePoint.x = fromPoint.x - entryPoint.x;
					distancePoint.y = fromPoint.y - entryPoint.y;
					g = this.scoreG.h[this.curFace.__id__] + distancePoint.get_length();
					f = h + g;
					fillDatas = false;
					if(this.openedFaces.h[neighbourFace.__id__] == null || !this.openedFaces.h[neighbourFace.__id__]) {
						this.sortedOpenedFaces.push(neighbourFace);
						this.openedFaces.set(neighbourFace,true);
						true;
						fillDatas = true;
					} else if(this.scoreF.h[neighbourFace.__id__] > f) fillDatas = true;
					if(fillDatas) {
						this.entryEdges.set(neighbourFace,innerEdge);
						innerEdge;
						var v = entryPoint.x;
						this.entryX.set(neighbourFace,v);
						v;
						var v1 = entryPoint.y;
						this.entryY.set(neighbourFace,v1);
						v1;
						this.scoreF.set(neighbourFace,f);
						f;
						this.scoreG.set(neighbourFace,g);
						g;
						this.scoreH.set(neighbourFace,h);
						h;
						var v2 = this.curFace;
						this.predecessor.set(neighbourFace,v2);
						v2;
					}
				}
			}
			this.openedFaces.set(this.curFace,false);
			false;
			this.closedFaces.set(this.curFace,true);
			true;
			this.sortedOpenedFaces.sort($bind(this,this.sortingFaces));
		}
		if(this.curFace == null) return;
		resultListFaces.push(this.curFace);
		while(this.curFace != this.fromFace) {
			resultListEdges.unshift(this.entryEdges.h[this.curFace.__id__]);
			this.curFace = this.predecessor.h[this.curFace.__id__];
			resultListFaces.unshift(this.curFace);
		}
	}
	,sortingFaces: function(a,b) {
		if(this.scoreF.h[a.__id__] == this.scoreF.h[b.__id__]) return 0; else if(this.scoreF.h[a.__id__] < this.scoreF.h[b.__id__]) return 1; else return -1;
	}
	,isWalkableByRadius: function(fromEdge,throughFace,toEdge) {
		var vA = null;
		var vB = null;
		var vC = null;
		if(fromEdge.get_originVertex() == toEdge.get_originVertex()) {
			vA = fromEdge.get_destinationVertex();
			vB = toEdge.get_destinationVertex();
			vC = fromEdge.get_originVertex();
		} else if(fromEdge.get_destinationVertex() == toEdge.get_destinationVertex()) {
			vA = fromEdge.get_originVertex();
			vB = toEdge.get_originVertex();
			vC = fromEdge.get_destinationVertex();
		} else if(fromEdge.get_originVertex() == toEdge.get_destinationVertex()) {
			vA = fromEdge.get_destinationVertex();
			vB = toEdge.get_originVertex();
			vC = fromEdge.get_originVertex();
		} else if(fromEdge.get_destinationVertex() == toEdge.get_originVertex()) {
			vA = fromEdge.get_originVertex();
			vB = toEdge.get_destinationVertex();
			vC = fromEdge.get_destinationVertex();
		}
		var dot;
		var result;
		var distSquared;
		dot = (vC.get_pos().x - vA.get_pos().x) * (vB.get_pos().x - vA.get_pos().x) + (vC.get_pos().y - vA.get_pos().y) * (vB.get_pos().y - vA.get_pos().y);
		if(dot <= 0) {
			distSquared = (vC.get_pos().x - vA.get_pos().x) * (vC.get_pos().x - vA.get_pos().x) + (vC.get_pos().y - vA.get_pos().y) * (vC.get_pos().y - vA.get_pos().y);
			if(distSquared >= this.diameterSquared) return true; else return false;
		}
		dot = (vC.get_pos().x - vB.get_pos().x) * (vA.get_pos().x - vB.get_pos().x) + (vC.get_pos().y - vB.get_pos().y) * (vA.get_pos().y - vB.get_pos().y);
		if(dot <= 0) {
			distSquared = (vC.get_pos().x - vB.get_pos().x) * (vC.get_pos().x - vB.get_pos().x) + (vC.get_pos().y - vB.get_pos().y) * (vC.get_pos().y - vB.get_pos().y);
			if(distSquared >= this.diameterSquared) return true; else return false;
		}
		var adjEdge;
		if(throughFace.get_edge() != fromEdge && throughFace.get_edge().get_oppositeEdge() != fromEdge && throughFace.get_edge() != toEdge && throughFace.get_edge().get_oppositeEdge() != toEdge) adjEdge = throughFace.get_edge(); else if(throughFace.get_edge().get_nextLeftEdge() != fromEdge && throughFace.get_edge().get_nextLeftEdge().get_oppositeEdge() != fromEdge && throughFace.get_edge().get_nextLeftEdge() != toEdge && throughFace.get_edge().get_nextLeftEdge().get_oppositeEdge() != toEdge) adjEdge = throughFace.get_edge().get_nextLeftEdge(); else adjEdge = throughFace.get_edge().get_prevLeftEdge();
		if(adjEdge.get_isConstrained()) {
			var proj = new hxDaedalus.data.math.Point2D(vC.get_pos().x,vC.get_pos().y);
			hxDaedalus.data.math.Geom2D.projectOrthogonaly(proj,adjEdge);
			distSquared = (proj.x - vC.get_pos().x) * (proj.x - vC.get_pos().x) + (proj.y - vC.get_pos().y) * (proj.y - vC.get_pos().y);
			if(distSquared >= this.diameterSquared) return true; else return false;
		} else {
			var distSquaredA = (vC.get_pos().x - vA.get_pos().x) * (vC.get_pos().x - vA.get_pos().x) + (vC.get_pos().y - vA.get_pos().y) * (vC.get_pos().y - vA.get_pos().y);
			var distSquaredB = (vC.get_pos().x - vB.get_pos().x) * (vC.get_pos().x - vB.get_pos().x) + (vC.get_pos().y - vB.get_pos().y) * (vC.get_pos().y - vB.get_pos().y);
			if(distSquaredA < this.diameterSquared || distSquaredB < this.diameterSquared) return false; else {
				var vFaceToCheck = new Array();
				var vFaceIsFromEdge = new Array();
				var facesDone = new haxe.ds.ObjectMap();
				vFaceIsFromEdge.push(adjEdge);
				if(adjEdge.get_leftFace() == throughFace) {
					vFaceToCheck.push(adjEdge.get_rightFace());
					var k = adjEdge.get_rightFace();
					facesDone.set(k,true);
					true;
				} else {
					vFaceToCheck.push(adjEdge.get_leftFace());
					var k1 = adjEdge.get_leftFace();
					facesDone.set(k1,true);
					true;
				}
				var currFace;
				var faceFromEdge;
				var currEdgeA;
				var nextFaceA;
				var currEdgeB;
				var nextFaceB;
				while(vFaceToCheck.length > 0) {
					currFace = vFaceToCheck.shift();
					faceFromEdge = vFaceIsFromEdge.shift();
					if(currFace.get_edge() == faceFromEdge || currFace.get_edge() == faceFromEdge.get_oppositeEdge()) {
						currEdgeA = currFace.get_edge().get_nextLeftEdge();
						currEdgeB = currFace.get_edge().get_nextLeftEdge().get_nextLeftEdge();
					} else if(currFace.get_edge().get_nextLeftEdge() == faceFromEdge || currFace.get_edge().get_nextLeftEdge() == faceFromEdge.get_oppositeEdge()) {
						currEdgeA = currFace.get_edge();
						currEdgeB = currFace.get_edge().get_nextLeftEdge().get_nextLeftEdge();
					} else {
						currEdgeA = currFace.get_edge();
						currEdgeB = currFace.get_edge().get_nextLeftEdge();
					}
					if(currEdgeA.get_leftFace() == currFace) nextFaceA = currEdgeA.get_rightFace(); else nextFaceA = currEdgeA.get_leftFace();
					if(currEdgeB.get_leftFace() == currFace) nextFaceB = currEdgeB.get_rightFace(); else nextFaceB = currEdgeB.get_leftFace();
					if(!facesDone.h[nextFaceA.__id__] && hxDaedalus.data.math.Geom2D.distanceSquaredVertexToEdge(vC,currEdgeA) < this.diameterSquared) {
						if(currEdgeA.get_isConstrained()) return false; else {
							vFaceToCheck.push(nextFaceA);
							vFaceIsFromEdge.push(currEdgeA);
							facesDone.set(nextFaceA,true);
							true;
						}
					}
					if(!facesDone.h[nextFaceB.__id__] && hxDaedalus.data.math.Geom2D.distanceSquaredVertexToEdge(vC,currEdgeB) < this.diameterSquared) {
						if(currEdgeB.get_isConstrained()) return false; else {
							vFaceToCheck.push(nextFaceB);
							vFaceIsFromEdge.push(currEdgeB);
							facesDone.set(nextFaceB,true);
							true;
						}
					}
				}
				return true;
			}
		}
		return true;
	}
};
hxDaedalus.ai.EntityAI = function() {
	this._radius = 10;
	this.x = this.y = 0;
	this.dirNormX = 1;
	this.dirNormY = 0;
	this.angleFOV = 60;
};
hxDaedalus.ai.EntityAI.__name__ = true;
hxDaedalus.ai.EntityAI.prototype = {
	buildApproximation: function() {
		this._approximateObject = new hxDaedalus.data.Object();
		this._approximateObject.get_matrix().translate(this.x,this.y);
		var coordinates = new Array();
		this._approximateObject.set_coordinates(coordinates);
		if(this._radius == 0) return;
		var _g = 0;
		while(_g < 6) {
			var i = _g++;
			coordinates.push(this._radius * Math.cos(2 * Math.PI * i / 6));
			coordinates.push(this._radius * Math.sin(2 * Math.PI * i / 6));
			coordinates.push(this._radius * Math.cos(2 * Math.PI * (i + 1) / 6));
			coordinates.push(this._radius * Math.sin(2 * Math.PI * (i + 1) / 6));
		}
	}
	,get_approximateObject: function() {
		this._approximateObject.get_matrix().identity();
		this._approximateObject.get_matrix().translate(this.x,this.y);
		return this._approximateObject;
	}
	,get_radius: function() {
		return this._radius;
	}
	,get_radiusSquared: function() {
		return this._radiusSquared;
	}
	,set_radius: function(value) {
		this._radius = value;
		this._radiusSquared = this._radius * this._radius;
		return value;
	}
};
hxDaedalus.ai.Funnel = function() {
	this._currPoolPointsIndex = 0;
	this._poolPointsSize = 3000;
	this._numSamplesCircle = 16;
	this._radiusSquared = 0;
	this._radius = 0;
	this._poolPoints = new Array();
	var _g1 = 0;
	var _g = this._poolPointsSize;
	while(_g1 < _g) {
		var i = _g1++;
		this._poolPoints.push(new hxDaedalus.data.math.Point2D());
	}
};
hxDaedalus.ai.Funnel.__name__ = true;
hxDaedalus.ai.Funnel.prototype = {
	dispose: function() {
		this._sampleCircle = null;
	}
	,getPoint: function(x,y) {
		if(y == null) y = 0;
		if(x == null) x = 0;
		this.__point = this._poolPoints[this._currPoolPointsIndex];
		this.__point.setXY(x,y);
		this._currPoolPointsIndex++;
		if(this._currPoolPointsIndex == this._poolPointsSize) {
			this._poolPoints.push(new hxDaedalus.data.math.Point2D());
			this._poolPointsSize++;
		}
		return this.__point;
	}
	,getCopyPoint: function(pointToCopy) {
		return this.getPoint(pointToCopy.x,pointToCopy.y);
	}
	,get_radius: function() {
		return this._radius;
	}
	,set_radius: function(value) {
		this._radius = Math.max(0,value);
		this._radiusSquared = this._radius * this._radius;
		this._sampleCircle = new Array();
		if(this.get_radius() == 0) return 0;
		var _g1 = 0;
		var _g = this._numSamplesCircle;
		while(_g1 < _g) {
			var i = _g1++;
			this._sampleCircle.push(new hxDaedalus.data.math.Point2D(this._radius * Math.cos(-2 * Math.PI * i / this._numSamplesCircle),this._radius * Math.sin(-2 * Math.PI * i / this._numSamplesCircle)));
		}
		this._sampleCircleDistanceSquared = (this._sampleCircle[0].x - this._sampleCircle[1].x) * (this._sampleCircle[0].x - this._sampleCircle[1].x) + (this._sampleCircle[0].y - this._sampleCircle[1].y) * (this._sampleCircle[0].y - this._sampleCircle[1].y);
		return this._radius;
	}
	,findPath: function(fromX,fromY,toX,toY,listFaces,listEdges,resultPath) {
		this._currPoolPointsIndex = 0;
		if(this._radius > 0) {
			var checkFace = listFaces[0];
			var distanceSquared;
			var distance;
			var p1;
			var p2;
			var p3;
			p1 = checkFace.get_edge().get_originVertex().get_pos();
			p2 = checkFace.get_edge().get_destinationVertex().get_pos();
			p3 = checkFace.get_edge().get_nextLeftEdge().get_destinationVertex().get_pos();
			distanceSquared = (p1.x - fromX) * (p1.x - fromX) + (p1.y - fromY) * (p1.y - fromY);
			if(distanceSquared <= this._radiusSquared) {
				distance = Math.sqrt(distanceSquared);
				fromX = this._radius * 1.01 * ((fromX - p1.x) / distance) + p1.x;
				fromY = this._radius * 1.01 * ((fromY - p1.y) / distance) + p1.y;
			} else {
				distanceSquared = (p2.x - fromX) * (p2.x - fromX) + (p2.y - fromY) * (p2.y - fromY);
				if(distanceSquared <= this._radiusSquared) {
					distance = Math.sqrt(distanceSquared);
					fromX = this._radius * 1.01 * ((fromX - p2.x) / distance) + p2.x;
					fromY = this._radius * 1.01 * ((fromY - p2.y) / distance) + p2.y;
				} else {
					distanceSquared = (p3.x - fromX) * (p3.x - fromX) + (p3.y - fromY) * (p3.y - fromY);
					if(distanceSquared <= this._radiusSquared) {
						distance = Math.sqrt(distanceSquared);
						fromX = this._radius * 1.01 * ((fromX - p3.x) / distance) + p3.x;
						fromY = this._radius * 1.01 * ((fromY - p3.y) / distance) + p3.y;
					}
				}
			}
			checkFace = listFaces[listFaces.length - 1];
			p1 = checkFace.get_edge().get_originVertex().get_pos();
			p2 = checkFace.get_edge().get_destinationVertex().get_pos();
			p3 = checkFace.get_edge().get_nextLeftEdge().get_destinationVertex().get_pos();
			distanceSquared = (p1.x - toX) * (p1.x - toX) + (p1.y - toY) * (p1.y - toY);
			if(distanceSquared <= this._radiusSquared) {
				distance = Math.sqrt(distanceSquared);
				toX = this._radius * 1.01 * ((toX - p1.x) / distance) + p1.x;
				toY = this._radius * 1.01 * ((toY - p1.y) / distance) + p1.y;
			} else {
				distanceSquared = (p2.x - toX) * (p2.x - toX) + (p2.y - toY) * (p2.y - toY);
				if(distanceSquared <= this._radiusSquared) {
					distance = Math.sqrt(distanceSquared);
					toX = this._radius * 1.01 * ((toX - p2.x) / distance) + p2.x;
					toY = this._radius * 1.01 * ((toY - p2.y) / distance) + p2.y;
				} else {
					distanceSquared = (p3.x - toX) * (p3.x - toX) + (p3.y - toY) * (p3.y - toY);
					if(distanceSquared <= this._radiusSquared) {
						distance = Math.sqrt(distanceSquared);
						toX = this._radius * 1.01 * ((toX - p3.x) / distance) + p3.x;
						toY = this._radius * 1.01 * ((toY - p3.y) / distance) + p3.y;
					}
				}
			}
		}
		var startPoint;
		var endPoint;
		startPoint = new hxDaedalus.data.math.Point2D(fromX,fromY);
		endPoint = new hxDaedalus.data.math.Point2D(toX,toY);
		if(listFaces.length == 1) {
			resultPath.push(startPoint.x);
			resultPath.push(startPoint.y);
			resultPath.push(endPoint.x);
			resultPath.push(endPoint.y);
			return;
		}
		var i;
		var j;
		var k;
		var currEdge = null;
		var currVertex = null;
		var direction;
		{
			var _g = hxDaedalus.data.math.Geom2D.isInFace(fromX,fromY,listFaces[0]);
			switch(_g[1]) {
			case 1:
				var edge = _g[2];
				if(listEdges[0] == edge) {
					listEdges.shift();
					listFaces.shift();
				}
				break;
			default:
			}
		}
		var funnelLeft = new Array();
		var funnelRight = new Array();
		funnelLeft.push(startPoint);
		funnelRight.push(startPoint);
		var verticesDoneSide = new haxe.ds.ObjectMap();
		var pointsList = new Array();
		var pointSides = new haxe.ds.ObjectMap();
		var pointSuccessor = new haxe.ds.ObjectMap();
		pointSides.set(startPoint,0);
		0;
		currEdge = listEdges[0];
		var relativPos = hxDaedalus.data.math.Geom2D.getRelativePosition2(fromX,fromY,currEdge);
		var prevPoint;
		var newPointA;
		var newPointB;
		newPointA = this.getCopyPoint(currEdge.get_destinationVertex().get_pos());
		newPointB = this.getCopyPoint(currEdge.get_originVertex().get_pos());
		pointsList.push(newPointA);
		pointsList.push(newPointB);
		pointSuccessor.set(startPoint,newPointA);
		newPointA;
		pointSuccessor.set(newPointA,newPointB);
		newPointB;
		prevPoint = newPointB;
		if(relativPos == 1) {
			pointSides.set(newPointA,1);
			1;
			pointSides.set(newPointB,-1);
			-1;
			var k1 = currEdge.get_destinationVertex();
			verticesDoneSide.set(k1,1);
			1;
			var k2 = currEdge.get_originVertex();
			verticesDoneSide.set(k2,-1);
			-1;
		} else if(relativPos == -1) {
			pointSides.set(newPointA,-1);
			-1;
			pointSides.set(newPointB,1);
			1;
			var k3 = currEdge.get_destinationVertex();
			verticesDoneSide.set(k3,-1);
			-1;
			var k4 = currEdge.get_originVertex();
			verticesDoneSide.set(k4,1);
			1;
		}
		var fromVertex = listEdges[0].get_originVertex();
		var fromFromVertex = listEdges[0].get_destinationVertex();
		var _g1 = 1;
		var _g2 = listEdges.length;
		while(_g1 < _g2) {
			var i1 = _g1++;
			currEdge = listEdges[i1];
			if(currEdge.get_originVertex() == fromVertex) currVertex = currEdge.get_destinationVertex(); else if(currEdge.get_destinationVertex() == fromVertex) currVertex = currEdge.get_originVertex(); else if(currEdge.get_originVertex() == fromFromVertex) {
				currVertex = currEdge.get_destinationVertex();
				fromVertex = fromFromVertex;
			} else if(currEdge.get_destinationVertex() == fromFromVertex) {
				currVertex = currEdge.get_originVertex();
				fromVertex = fromFromVertex;
			} else haxe.Log.trace("IMPOSSIBLE TO IDENTIFY THE VERTEX !!!",{ fileName : "Funnel.hx", lineNumber : 286, className : "hxDaedalus.ai.Funnel", methodName : "findPath"});
			newPointA = this.getCopyPoint(currVertex.get_pos());
			pointsList.push(newPointA);
			direction = -verticesDoneSide.h[fromVertex.__id__];
			pointSides.set(newPointA,direction);
			direction;
			pointSuccessor.set(prevPoint,newPointA);
			newPointA;
			verticesDoneSide.set(currVertex,direction);
			direction;
			prevPoint = newPointA;
			fromFromVertex = fromVertex;
			fromVertex = currVertex;
		}
		pointSuccessor.set(prevPoint,endPoint);
		endPoint;
		pointSides.set(endPoint,0);
		0;
		var pathPoints = new Array();
		var pathSides = new haxe.ds.ObjectMap();
		pathPoints.push(startPoint);
		pathSides.set(startPoint,0);
		0;
		var currPos;
		var _g11 = 0;
		var _g3 = pointsList.length;
		while(_g11 < _g3) {
			var i2 = _g11++;
			currPos = pointsList[i2];
			if(pointSides.h[currPos.__id__] == -1) {
				j = funnelLeft.length - 2;
				while(j >= 0) {
					direction = hxDaedalus.data.math.Geom2D.getDirection(funnelLeft[j].x,funnelLeft[j].y,funnelLeft[j + 1].x,funnelLeft[j + 1].y,currPos.x,currPos.y);
					if(direction != -1) {
						funnelLeft.shift();
						var _g21 = 0;
						while(_g21 < j) {
							var k5 = _g21++;
							pathPoints.push(funnelLeft[0]);
							pathSides.set(funnelLeft[0],1);
							1;
							funnelLeft.shift();
						}
						pathPoints.push(funnelLeft[0]);
						pathSides.set(funnelLeft[0],1);
						1;
						funnelRight.splice(0,funnelRight.length);
						funnelRight.push(funnelLeft[0]);
						funnelRight.push(currPos);
						break;
					}
					j--;
				}
				funnelRight.push(currPos);
				j = funnelRight.length - 3;
				while(j >= 0) {
					direction = hxDaedalus.data.math.Geom2D.getDirection(funnelRight[j].x,funnelRight[j].y,funnelRight[j + 1].x,funnelRight[j + 1].y,currPos.x,currPos.y);
					if(direction == -1) break; else funnelRight.splice(j + 1,1);
					j--;
				}
			} else {
				j = funnelRight.length - 2;
				while(j >= 0) {
					direction = hxDaedalus.data.math.Geom2D.getDirection(funnelRight[j].x,funnelRight[j].y,funnelRight[j + 1].x,funnelRight[j + 1].y,currPos.x,currPos.y);
					if(direction != 1) {
						funnelRight.shift();
						var _g22 = 0;
						while(_g22 < j) {
							var k6 = _g22++;
							pathPoints.push(funnelRight[0]);
							pathSides.set(funnelRight[0],-1);
							-1;
							funnelRight.shift();
						}
						pathPoints.push(funnelRight[0]);
						pathSides.set(funnelRight[0],-1);
						-1;
						funnelLeft.splice(0,funnelLeft.length);
						funnelLeft.push(funnelRight[0]);
						funnelLeft.push(currPos);
						break;
					}
					j--;
				}
				funnelLeft.push(currPos);
				j = funnelLeft.length - 3;
				while(j >= 0) {
					direction = hxDaedalus.data.math.Geom2D.getDirection(funnelLeft[j].x,funnelLeft[j].y,funnelLeft[j + 1].x,funnelLeft[j + 1].y,currPos.x,currPos.y);
					if(direction == 1) break; else funnelLeft.splice(j + 1,1);
					j--;
				}
			}
		}
		var blocked = false;
		j = funnelRight.length - 2;
		while(j >= 0) {
			direction = hxDaedalus.data.math.Geom2D.getDirection(funnelRight[j].x,funnelRight[j].y,funnelRight[j + 1].x,funnelRight[j + 1].y,toX,toY);
			if(direction != 1) {
				funnelRight.shift();
				var _g12 = 0;
				var _g4 = j + 1;
				while(_g12 < _g4) {
					var k7 = _g12++;
					pathPoints.push(funnelRight[0]);
					pathSides.set(funnelRight[0],-1);
					-1;
					funnelRight.shift();
				}
				pathPoints.push(endPoint);
				pathSides.set(endPoint,0);
				0;
				blocked = true;
				break;
			}
			j--;
		}
		if(!blocked) {
			j = funnelLeft.length - 2;
			while(j >= 0) {
				direction = hxDaedalus.data.math.Geom2D.getDirection(funnelLeft[j].x,funnelLeft[j].y,funnelLeft[j + 1].x,funnelLeft[j + 1].y,toX,toY);
				if(direction != -1) {
					funnelLeft.shift();
					var _g13 = 0;
					var _g5 = j + 1;
					while(_g13 < _g5) {
						var k8 = _g13++;
						pathPoints.push(funnelLeft[0]);
						pathSides.set(funnelLeft[0],1);
						1;
						funnelLeft.shift();
					}
					pathPoints.push(endPoint);
					pathSides.set(endPoint,0);
					0;
					blocked = true;
					break;
				}
				j--;
			}
		}
		if(!blocked) {
			pathPoints.push(endPoint);
			pathSides.set(endPoint,0);
			0;
			blocked = true;
		}
		var adjustedPoints = new Array();
		if(this.get_radius() > 0) {
			var newPath = new Array();
			if(pathPoints.length == 2) this.adjustWithTangents(pathPoints[0],false,pathPoints[1],false,pointSides,pointSuccessor,newPath,adjustedPoints); else if(pathPoints.length > 2) {
				this.adjustWithTangents(pathPoints[0],false,pathPoints[1],true,pointSides,pointSuccessor,newPath,adjustedPoints);
				if(pathPoints.length > 3) {
					var _g14 = 1;
					var _g6 = pathPoints.length - 3 + 1;
					while(_g14 < _g6) {
						var i3 = _g14++;
						this.adjustWithTangents(pathPoints[i3],true,pathPoints[i3 + 1],true,pointSides,pointSuccessor,newPath,adjustedPoints);
					}
				}
				var pathLength = pathPoints.length;
				this.adjustWithTangents(pathPoints[pathLength - 2],true,pathPoints[pathLength - 1],false,pointSides,pointSuccessor,newPath,adjustedPoints);
			}
			newPath.push(endPoint);
			this.checkAdjustedPath(newPath,adjustedPoints,pointSides);
			var smoothPoints = new Array();
			i = newPath.length - 2;
			while(i >= 1) {
				this.smoothAngle(adjustedPoints[i * 2 - 1],newPath[i],adjustedPoints[i * 2],pointSides.h[newPath[i].__id__],smoothPoints);
				while(smoothPoints.length != 0) {
					var temp = i * 2;
					adjustedPoints.splice(temp,0);
					var x = smoothPoints.pop();
					adjustedPoints.splice(temp,0,x);
				}
				i--;
			}
		} else adjustedPoints = pathPoints;
		var _g15 = 0;
		var _g7 = adjustedPoints.length;
		while(_g15 < _g7) {
			var i4 = _g15++;
			resultPath.push(adjustedPoints[i4].x);
			resultPath.push(adjustedPoints[i4].y);
		}
	}
	,adjustWithTangents: function(p1,applyRadiusToP1,p2,applyRadiusToP2,pointSides,pointSuccessor,newPath,adjustedPoints) {
		var tangentsResult = new Array();
		var side1 = pointSides.h[p1.__id__];
		var side2 = pointSides.h[p2.__id__];
		var pTangent1 = null;
		var pTangent2 = null;
		if(!applyRadiusToP1 && !applyRadiusToP2) {
			pTangent1 = p1;
			pTangent2 = p2;
		} else if(!applyRadiusToP1) {
			if(hxDaedalus.data.math.Geom2D.tangentsPointToCircle(p1.x,p1.y,p2.x,p2.y,this._radius,tangentsResult)) {
				if(side2 == 1) {
					pTangent1 = p1;
					pTangent2 = this.getPoint(tangentsResult[2],tangentsResult[3]);
				} else {
					pTangent1 = p1;
					pTangent2 = this.getPoint(tangentsResult[0],tangentsResult[1]);
				}
			} else {
				haxe.Log.trace("NO TANGENT",{ fileName : "Funnel.hx", lineNumber : 580, className : "hxDaedalus.ai.Funnel", methodName : "adjustWithTangents"});
				return;
			}
		} else if(!applyRadiusToP2) {
			if(hxDaedalus.data.math.Geom2D.tangentsPointToCircle(p2.x,p2.y,p1.x,p1.y,this._radius,tangentsResult)) {
				if(tangentsResult.length > 0) {
					if(side1 == 1) {
						pTangent1 = this.getPoint(tangentsResult[0],tangentsResult[1]);
						pTangent2 = p2;
					} else {
						pTangent1 = this.getPoint(tangentsResult[2],tangentsResult[3]);
						pTangent2 = p2;
					}
				}
			} else {
				haxe.Log.trace("NO TANGENT",{ fileName : "Funnel.hx", lineNumber : 605, className : "hxDaedalus.ai.Funnel", methodName : "adjustWithTangents"});
				return;
			}
		} else if(side1 == 1 && side2 == 1) {
			hxDaedalus.data.math.Geom2D.tangentsParalCircleToCircle(this._radius,p1.x,p1.y,p2.x,p2.y,tangentsResult);
			pTangent1 = this.getPoint(tangentsResult[2],tangentsResult[3]);
			pTangent2 = this.getPoint(tangentsResult[4],tangentsResult[5]);
		} else if(side1 == -1 && side2 == -1) {
			hxDaedalus.data.math.Geom2D.tangentsParalCircleToCircle(this._radius,p1.x,p1.y,p2.x,p2.y,tangentsResult);
			pTangent1 = this.getPoint(tangentsResult[0],tangentsResult[1]);
			pTangent2 = this.getPoint(tangentsResult[6],tangentsResult[7]);
		} else if(side1 == 1 && side2 == -1) {
			if(hxDaedalus.data.math.Geom2D.tangentsCrossCircleToCircle(this._radius,p1.x,p1.y,p2.x,p2.y,tangentsResult)) {
				pTangent1 = this.getPoint(tangentsResult[2],tangentsResult[3]);
				pTangent2 = this.getPoint(tangentsResult[6],tangentsResult[7]);
			} else {
				haxe.Log.trace("NO TANGENT, points are too close for radius",{ fileName : "Funnel.hx", lineNumber : 642, className : "hxDaedalus.ai.Funnel", methodName : "adjustWithTangents"});
				return;
			}
		} else if(hxDaedalus.data.math.Geom2D.tangentsCrossCircleToCircle(this._radius,p1.x,p1.y,p2.x,p2.y,tangentsResult)) {
			pTangent1 = this.getPoint(tangentsResult[0],tangentsResult[1]);
			pTangent2 = this.getPoint(tangentsResult[4],tangentsResult[5]);
		} else {
			haxe.Log.trace("NO TANGENT, points are too close for radius",{ fileName : "Funnel.hx", lineNumber : 659, className : "hxDaedalus.ai.Funnel", methodName : "adjustWithTangents"});
			return;
		}
		var successor = pointSuccessor.h[p1.__id__];
		var distance;
		while(successor != p2) {
			distance = hxDaedalus.data.math.Geom2D.distanceSquaredPointToSegment(successor.x,successor.y,pTangent1.x,pTangent1.y,pTangent2.x,pTangent2.y);
			if(distance < this._radiusSquared) {
				this.adjustWithTangents(p1,applyRadiusToP1,successor,true,pointSides,pointSuccessor,newPath,adjustedPoints);
				this.adjustWithTangents(successor,true,p2,applyRadiusToP2,pointSides,pointSuccessor,newPath,adjustedPoints);
				return;
			} else successor = pointSuccessor.h[successor.__id__];
		}
		adjustedPoints.push(pTangent1);
		adjustedPoints.push(pTangent2);
		newPath.push(p1);
	}
	,checkAdjustedPath: function(newPath,adjustedPoints,pointSides) {
		var needCheck = true;
		var point0;
		var point0Side;
		var point1;
		var point1Side;
		var point2;
		var point2Side;
		var pt1;
		var pt2;
		var pt3;
		var dot;
		var tangentsResult = new Array();
		var pTangent1 = null;
		var pTangent2 = null;
		while(needCheck) {
			needCheck = false;
			var i = 2;
			while(i < newPath.length) {
				point2 = newPath[i];
				point2Side = pointSides.h[point2.__id__];
				point1 = newPath[i - 1];
				point1Side = pointSides.h[point1.__id__];
				point0 = newPath[i - 2];
				point0Side = pointSides.h[point0.__id__];
				if(point1Side == point2Side) {
					pt1 = adjustedPoints[(i - 2) * 2];
					pt2 = adjustedPoints[(i - 1) * 2 - 1];
					pt3 = adjustedPoints[(i - 1) * 2];
					dot = (pt1.x - pt2.x) * (pt3.x - pt2.x) + (pt1.y - pt2.y) * (pt3.y - pt2.y);
					if(dot > 0) {
						if(i == 2) {
							hxDaedalus.data.math.Geom2D.tangentsPointToCircle(point0.x,point0.y,point2.x,point2.y,this._radius,tangentsResult);
							if(point2Side == 1) {
								pTangent1 = point0;
								pTangent2 = this.getPoint(tangentsResult[2],tangentsResult[3]);
							} else {
								pTangent1 = point0;
								pTangent2 = this.getPoint(tangentsResult[0],tangentsResult[1]);
							}
						} else if(i == newPath.length - 1) {
							hxDaedalus.data.math.Geom2D.tangentsPointToCircle(point2.x,point2.y,point0.x,point0.y,this._radius,tangentsResult);
							if(point0Side == 1) {
								pTangent1 = this.getPoint(tangentsResult[0],tangentsResult[1]);
								pTangent2 = point2;
							} else {
								pTangent1 = this.getPoint(tangentsResult[2],tangentsResult[3]);
								pTangent2 = point2;
							}
						} else if(point0Side == 1 && point2Side == -1) {
							hxDaedalus.data.math.Geom2D.tangentsCrossCircleToCircle(this._radius,point0.x,point0.y,point2.x,point2.y,tangentsResult);
							pTangent1 = this.getPoint(tangentsResult[2],tangentsResult[3]);
							pTangent2 = this.getPoint(tangentsResult[6],tangentsResult[7]);
						} else if(point0Side == -1 && point2Side == 1) {
							hxDaedalus.data.math.Geom2D.tangentsCrossCircleToCircle(this._radius,point0.x,point0.y,point2.x,point2.y,tangentsResult);
							pTangent1 = this.getPoint(tangentsResult[0],tangentsResult[1]);
							pTangent2 = this.getPoint(tangentsResult[4],tangentsResult[5]);
						} else if(point0Side == 1 && point2Side == 1) {
							hxDaedalus.data.math.Geom2D.tangentsParalCircleToCircle(this._radius,point0.x,point0.y,point2.x,point2.y,tangentsResult);
							pTangent1 = this.getPoint(tangentsResult[2],tangentsResult[3]);
							pTangent2 = this.getPoint(tangentsResult[4],tangentsResult[5]);
						} else if(point0Side == -1 && point2Side == -1) {
							hxDaedalus.data.math.Geom2D.tangentsParalCircleToCircle(this._radius,point0.x,point0.y,point2.x,point2.y,tangentsResult);
							pTangent1 = this.getPoint(tangentsResult[0],tangentsResult[1]);
							pTangent2 = this.getPoint(tangentsResult[6],tangentsResult[7]);
						}
						var temp = (i - 2) * 2;
						adjustedPoints.splice(temp,1);
						adjustedPoints.splice(temp,0,pTangent1);
						temp = i * 2 - 1;
						adjustedPoints.splice(temp,1);
						adjustedPoints.splice(temp,0,pTangent2);
						newPath.splice(i - 1,1);
						adjustedPoints.splice((i - 1) * 2 - 1,2);
						tangentsResult.splice(0,tangentsResult.length);
						i--;
					}
				}
				i++;
			}
		}
	}
	,smoothAngle: function(prevPoint,pointToSmooth,nextPoint,side,encirclePoints) {
		var angleType = hxDaedalus.data.math.Geom2D.getDirection(prevPoint.x,prevPoint.y,pointToSmooth.x,pointToSmooth.y,nextPoint.x,nextPoint.y);
		var distanceSquared = (prevPoint.x - nextPoint.x) * (prevPoint.x - nextPoint.x) + (prevPoint.y - nextPoint.y) * (prevPoint.y - nextPoint.y);
		if(distanceSquared <= this._sampleCircleDistanceSquared) return;
		var index = 0;
		var side1;
		var side2;
		var pointInArea;
		var xToCheck;
		var yToCheck;
		var _g1 = 0;
		var _g = this._numSamplesCircle;
		while(_g1 < _g) {
			var i = _g1++;
			pointInArea = false;
			xToCheck = pointToSmooth.x + this._sampleCircle[i].x;
			yToCheck = pointToSmooth.y + this._sampleCircle[i].y;
			side1 = hxDaedalus.data.math.Geom2D.getDirection(prevPoint.x,prevPoint.y,pointToSmooth.x,pointToSmooth.y,xToCheck,yToCheck);
			side2 = hxDaedalus.data.math.Geom2D.getDirection(pointToSmooth.x,pointToSmooth.y,nextPoint.x,nextPoint.y,xToCheck,yToCheck);
			if(side == 1) {
				if(angleType == -1) {
					if(side1 == -1 && side2 == -1) pointInArea = true;
				} else if(side1 == -1 || side2 == -1) pointInArea = true;
			} else if(angleType == 1) {
				if(side1 == 1 && side2 == 1) pointInArea = true;
			} else if(side1 == 1 || side2 == 1) pointInArea = true;
			if(pointInArea) {
				encirclePoints.splice(index,0);
				var x = new hxDaedalus.data.math.Point2D(xToCheck,yToCheck);
				encirclePoints.splice(index,0,x);
				index++;
			} else index = 0;
		}
		if(side == -1) encirclePoints.reverse();
	}
};
hxDaedalus.ai.PathFinder = function() {
	this.astar = new hxDaedalus.ai.AStar();
	this.funnel = new hxDaedalus.ai.Funnel();
	this.listFaces = new Array();
	this.listEdges = new Array();
};
hxDaedalus.ai.PathFinder.__name__ = true;
hxDaedalus.ai.PathFinder.prototype = {
	dispose: function() {
		this._mesh = null;
		this.astar.dispose();
		this.astar = null;
		this.funnel.dispose();
		this.funnel = null;
		this.listEdges = null;
		this.listFaces = null;
	}
	,get_mesh: function() {
		return this._mesh;
	}
	,set_mesh: function(value) {
		this._mesh = value;
		this.astar.set_mesh(this._mesh);
		return value;
	}
	,findPath: function(toX,toY,resultPath) {
		resultPath.splice(0,resultPath.length);
		hxDaedalus.debug.Debug.assertFalse(this._mesh == null,"Mesh missing",{ fileName : "PathFinder.hx", lineNumber : 51, className : "hxDaedalus.ai.PathFinder", methodName : "findPath"});
		hxDaedalus.debug.Debug.assertFalse(this.entity == null,"Entity missing",{ fileName : "PathFinder.hx", lineNumber : 52, className : "hxDaedalus.ai.PathFinder", methodName : "findPath"});
		if(hxDaedalus.data.math.Geom2D.isCircleIntersectingAnyConstraint(toX,toY,this.entity.get_radius(),this._mesh)) return;
		this.astar.set_radius(this.entity.get_radius());
		this.funnel.set_radius(this.entity.get_radius());
		this.listFaces.splice(0,this.listFaces.length);
		this.listEdges.splice(0,this.listEdges.length);
		this.astar.findPath(this.entity.x,this.entity.y,toX,toY,this.listFaces,this.listEdges);
		if(this.listFaces.length == 0) {
			haxe.Log.trace("PathFinder listFaces.length == 0",{ fileName : "PathFinder.hx", lineNumber : 63, className : "hxDaedalus.ai.PathFinder", methodName : "findPath"});
			return;
		}
		this.funnel.findPath(this.entity.x,this.entity.y,toX,toY,this.listFaces,this.listEdges,resultPath);
	}
};
hxDaedalus.ai.trajectory = {};
hxDaedalus.ai.trajectory.LinearPathSampler = function() {
	this._samplingDistanceSquared = 1;
	this._samplingDistance = 1;
	this._preCompX = new Array();
	this._preCompY = new Array();
};
hxDaedalus.ai.trajectory.LinearPathSampler.__name__ = true;
hxDaedalus.ai.trajectory.LinearPathSampler.pythag = function(a,b) {
	return Math.sqrt(a * a + b * b);
};
hxDaedalus.ai.trajectory.LinearPathSampler.prototype = {
	dispose: function() {
		this.entity = null;
		this._path = null;
		this._preCompX = null;
		this._preCompY = null;
	}
	,get_x: function() {
		return this._currentX;
	}
	,get_y: function() {
		return this._currentY;
	}
	,get_hasPrev: function() {
		return this._hasPrev;
	}
	,get_hasNext: function() {
		return this._hasNext;
	}
	,get_count: function() {
		return this._count;
	}
	,set_count: function(value) {
		this._count = value;
		if(this._count < 0) this._count = 0;
		if(this._count > this.get_countMax() - 1) this._count = this.get_countMax() - 1;
		if(this._count == 0) this._hasPrev = false; else this._hasPrev = true;
		if(this._count == this.get_countMax() - 1) this._hasNext = false; else this._hasNext = true;
		this._currentX = this._preCompX[this._count];
		this._currentY = this._preCompY[this._count];
		this.updateEntity();
		return this._count;
	}
	,get_countMax: function() {
		return this._preCompX.length - 1;
	}
	,get_samplingDistance: function() {
		return this._samplingDistance;
	}
	,set_samplingDistance: function(value) {
		this._samplingDistance = value;
		this._samplingDistanceSquared = this._samplingDistance * this._samplingDistance;
		return value;
	}
	,set_path: function(value) {
		this._path = value;
		this._preComputed = false;
		this.reset();
		return value;
	}
	,reset: function() {
		if(this._path.length > 0) {
			hxDaedalus.debug.Debug.assertTrue((this._path.length & 1) == 0,"Wrong length",{ fileName : "LinearPathSampler.hx", lineNumber : 100, className : "hxDaedalus.ai.trajectory.LinearPathSampler", methodName : "reset"});
			this._currentX = this._path[0];
			this._currentY = this._path[1];
			this._iPrev = 0;
			this._iNext = 2;
			this._hasPrev = false;
			this._hasNext = true;
			this._count = 0;
			this.updateEntity();
		} else {
			this._hasPrev = false;
			this._hasNext = false;
			this._count = 0;
		}
	}
	,preCompute: function() {
		this._preCompX.splice(0,this._preCompX.length);
		this._preCompY.splice(0,this._preCompY.length);
		this._count = 0;
		this._preCompX.push(this._currentX);
		this._preCompY.push(this._currentY);
		this._preComputed = false;
		while(this.next()) {
			this._preCompX.push(this._currentX);
			this._preCompY.push(this._currentY);
		}
		this.reset();
		this._preComputed = true;
	}
	,prev: function() {
		if(!this._hasPrev) return false;
		this._hasNext = true;
		if(this._preComputed) {
			this._count--;
			if(this._count == 0) this._hasPrev = false;
			this._currentX = this._preCompX[this._count];
			this._currentY = this._preCompY[this._count];
			this.updateEntity();
			return true;
		}
		var remainingDist;
		var dist;
		remainingDist = this._samplingDistance;
		while(true) {
			var pathPrev = this._path[this._iPrev];
			var pathPrev1 = this._path[this._iPrev + 1];
			dist = hxDaedalus.ai.trajectory.LinearPathSampler.pythag(this._currentX - pathPrev,this._currentY - pathPrev1);
			if(dist < remainingDist) {
				remainingDist -= dist;
				this._iPrev -= 2;
				this._iNext -= 2;
				if(this._iNext == 0) break;
			} else break;
		}
		if(this._iNext == 0) {
			this._currentX = this._path[0];
			this._currentY = this._path[1];
			this._hasPrev = false;
			this._iNext = 2;
			this._iPrev = 0;
			this.updateEntity();
			return true;
		} else {
			this._currentX = this._currentX + (this._path[this._iPrev] - this._currentX) * remainingDist / dist;
			this._currentY = this._currentY + (this._path[this._iPrev + 1] - this._currentY) * remainingDist / dist;
			this.updateEntity();
			return true;
		}
	}
	,next: function() {
		if(!this._hasNext) return false;
		this._hasPrev = true;
		if(this._preComputed) {
			this._count++;
			if(this._count == this._preCompX.length - 1) this._hasNext = false;
			this._currentX = this._preCompX[this._count];
			this._currentY = this._preCompY[this._count];
			this.updateEntity();
			return true;
		}
		var remainingDist;
		var dist;
		remainingDist = this._samplingDistance;
		while(true) {
			var pathNext = this._path[this._iNext];
			var pathNext1 = this._path[this._iNext + 1];
			dist = hxDaedalus.ai.trajectory.LinearPathSampler.pythag(this._currentX - pathNext,this._currentY - pathNext1);
			if(dist < remainingDist) {
				remainingDist -= dist;
				this._currentX = this._path[this._iNext];
				this._currentY = this._path[this._iNext + 1];
				this._iPrev += 2;
				this._iNext += 2;
				if(this._iNext == this._path.length) break;
			} else break;
		}
		if(this._iNext == this._path.length) {
			this._currentX = this._path[this._iPrev];
			this._currentY = this._path[this._iPrev + 1];
			this._hasNext = false;
			this._iNext = this._path.length - 2;
			this._iPrev = this._iNext - 2;
			this.updateEntity();
			return true;
		} else {
			this._currentX = this._currentX + (this._path[this._iNext] - this._currentX) * remainingDist / dist;
			this._currentY = this._currentY + (this._path[this._iNext + 1] - this._currentY) * remainingDist / dist;
			this.updateEntity();
			return true;
		}
	}
	,updateEntity: function() {
		if(this.entity == null) return;
		hxDaedalus.debug.Debug.assertFalse(isNaN(this._currentX) && isNaN(this._currentY),null,{ fileName : "LinearPathSampler.hx", lineNumber : 228, className : "hxDaedalus.ai.trajectory.LinearPathSampler", methodName : "updateEntity"});
		this.entity.x = this._currentX;
		this.entity.y = this._currentY;
	}
};
hxDaedalus.canvas = {};
hxDaedalus.canvas.BasicCanvas = function() {
	var _this = window.document;
	this.canvas = _this.createElement("canvas");
	this.dom = this.canvas;
	this.body = window.document.body;
	this.surface = this.canvas.getContext("2d");
	this.style = this.dom.style;
	this.header = new hxDaedalus.canvas.CanvasHeader();
	this.canvas.width = this.header.width;
	this.canvas.height = this.header.height;
	this.style.paddingLeft = "0px";
	this.style.paddingTop = "0px";
	this.style.left = Std.string(0 + "px");
	this.style.top = Std.string(0 + "px");
	this.style.position = "absolute";
	this.image = this.dom;
	var s;
	var _this1 = window.document;
	s = _this1.createElement("style");
	s.innerHTML = "@keyframes spin { from { transform:rotate( 0deg ); } to { transform:rotate( 360deg ); } }";
	window.document.getElementsByTagName("head")[0].appendChild(s);
	s.animation = "spin 1s linear infinite";
	this.loop(this.header.frameRate);
	var body = window.document.body;
	body.appendChild(this.dom);
};
hxDaedalus.canvas.BasicCanvas.__name__ = true;
hxDaedalus.canvas.BasicCanvas.prototype = {
	loop: function(tim) {
		window.requestAnimationFrame($bind(this,this.loop));
		if(this.onEnterFrame != null) this.onEnterFrame();
		return true;
	}
	,clear: function() {
		this.surface.clearRect(0,0,this.header.width,this.header.height);
	}
	,drawCircle: function(x,y,radius) {
		this.surface.beginPath();
		this.surface.arc(x,y,radius,0,2 * Math.PI,false);
		this.surface.stroke();
		this.surface.closePath();
		this.surface.fill();
	}
	,lineStyle: function(wid,col) {
		this.surface.lineWidth = wid;
		this.surface.strokeStyle = "#" + StringTools.hex(col,6);
	}
	,beginFill: function(col) {
		this.surface.fillStyle = "#" + StringTools.hex(col,6);
		this.surface.beginPath();
	}
	,endDraw: function() {
		this.surface.stroke();
		this.surface.closePath();
		this.surface.fill();
	}
};
hxDaedalus.canvas.CanvasHeader = function() {
	var canvasHeader = "600:600:60:FFFFFF".split(":");
	this.width = Std.parseInt(canvasHeader[0]);
	this.height = Std.parseInt(canvasHeader[1]);
	this.frameRate = Std.parseInt(canvasHeader[2]);
	this.bgColor = "#" + canvasHeader[3];
};
hxDaedalus.canvas.CanvasHeader.__name__ = true;
hxDaedalus.canvas.CanvasHeader.prototype = {
	parseInt: function(e) {
		return Std.parseInt(e);
	}
	,toHashColor: function(e) {
		return "#" + e;
	}
};
hxDaedalus.data = {};
hxDaedalus.data.Constants = function() { };
hxDaedalus.data.Constants.__name__ = true;
hxDaedalus.data.ConstraintSegment = function() {
	this._id = hxDaedalus.data.ConstraintSegment.INC;
	hxDaedalus.data.ConstraintSegment.INC++;
	this._edges = new Array();
};
hxDaedalus.data.ConstraintSegment.__name__ = true;
hxDaedalus.data.ConstraintSegment.prototype = {
	get_id: function() {
		return this._id;
	}
	,addEdge: function(edge) {
		if(HxOverrides.indexOf(this._edges,edge,0) == -1 && (function($this) {
			var $r;
			var x = edge.get_oppositeEdge();
			$r = HxOverrides.indexOf($this._edges,x,0);
			return $r;
		}(this)) == -1) this._edges.push(edge);
	}
	,removeEdge: function(edge) {
		var index;
		index = HxOverrides.indexOf(this._edges,edge,0);
		if(index == -1) {
			var x = edge.get_oppositeEdge();
			index = HxOverrides.indexOf(this._edges,x,0);
		}
		if(index != -1) this._edges.splice(index,1);
	}
	,get_edges: function() {
		return this._edges;
	}
	,dispose: function() {
		this._edges = null;
		this.fromShape = null;
	}
	,toString: function() {
		return "seg_id " + this._id;
	}
};
hxDaedalus.data.ConstraintShape = function() {
	this._id = hxDaedalus.data.ConstraintShape.INC;
	hxDaedalus.data.ConstraintShape.INC++;
	this.segments = new Array();
};
hxDaedalus.data.ConstraintShape.__name__ = true;
hxDaedalus.data.ConstraintShape.prototype = {
	get_id: function() {
		return this._id;
	}
	,dispose: function() {
		while(this.segments.length > 0) this.segments.pop().dispose();
		this.segments = null;
	}
};
hxDaedalus.data.Edge = function() {
	this.colorDebug = -1;
	this._id = hxDaedalus.data.Edge.INC;
	hxDaedalus.data.Edge.INC++;
	this.fromConstraintSegments = new Array();
};
hxDaedalus.data.Edge.__name__ = true;
hxDaedalus.data.Edge.prototype = {
	get_id: function() {
		return this._id;
	}
	,get_isReal: function() {
		return this._isReal;
	}
	,get_isConstrained: function() {
		return this._isConstrained;
	}
	,setDatas: function(originVertex,oppositeEdge,nextLeftEdge,leftFace,isReal,isConstrained) {
		if(isConstrained == null) isConstrained = false;
		if(isReal == null) isReal = true;
		this._isConstrained = isConstrained;
		this._isReal = isReal;
		this._originVertex = originVertex;
		this._oppositeEdge = oppositeEdge;
		this._nextLeftEdge = nextLeftEdge;
		this._leftFace = leftFace;
	}
	,addFromConstraintSegment: function(segment) {
		if(HxOverrides.indexOf(this.fromConstraintSegments,segment,0) == -1) this.fromConstraintSegments.push(segment);
	}
	,removeFromConstraintSegment: function(segment) {
		var index = HxOverrides.indexOf(this.fromConstraintSegments,segment,0);
		if(index != -1) this.fromConstraintSegments.splice(index,1);
	}
	,set_originVertex: function(value) {
		this._originVertex = value;
		return value;
	}
	,set_nextLeftEdge: function(value) {
		this._nextLeftEdge = value;
		return value;
	}
	,set_leftFace: function(value) {
		this._leftFace = value;
		return value;
	}
	,set_isConstrained: function(value) {
		this._isConstrained = value;
		return value;
	}
	,dispose: function() {
		this._originVertex = null;
		this._oppositeEdge = null;
		this._nextLeftEdge = null;
		this._leftFace = null;
		this.fromConstraintSegments = null;
	}
	,get_originVertex: function() {
		return this._originVertex;
	}
	,get_destinationVertex: function() {
		return this.get_oppositeEdge().get_originVertex();
	}
	,get_oppositeEdge: function() {
		return this._oppositeEdge;
	}
	,get_nextLeftEdge: function() {
		return this._nextLeftEdge;
	}
	,get_prevLeftEdge: function() {
		return this._nextLeftEdge.get_nextLeftEdge();
	}
	,get_nextRightEdge: function() {
		return this._oppositeEdge.get_nextLeftEdge().get_nextLeftEdge().get_oppositeEdge();
	}
	,get_prevRightEdge: function() {
		return this._oppositeEdge.get_nextLeftEdge().get_oppositeEdge();
	}
	,get_rotLeftEdge: function() {
		return this._nextLeftEdge.get_nextLeftEdge().get_oppositeEdge();
	}
	,get_rotRightEdge: function() {
		return this._oppositeEdge.get_nextLeftEdge();
	}
	,get_leftFace: function() {
		return this._leftFace;
	}
	,get_rightFace: function() {
		return this._oppositeEdge.get_leftFace();
	}
	,toString: function() {
		return "edge " + this.get_originVertex().get_id() + " - " + this.get_destinationVertex().get_id();
	}
};
hxDaedalus.data.Face = function() {
	this.colorDebug = -1;
	this._id = hxDaedalus.data.Face.INC;
	hxDaedalus.data.Face.INC++;
};
hxDaedalus.data.Face.__name__ = true;
hxDaedalus.data.Face.prototype = {
	get_id: function() {
		return this._id;
	}
	,get_isReal: function() {
		return this._isReal;
	}
	,set_datas: function(edge) {
		this._isReal = true;
		this._edge = edge;
	}
	,setDatas: function(edge,isReal) {
		if(isReal == null) isReal = true;
		this._isReal = isReal;
		this._edge = edge;
	}
	,dispose: function() {
		this._edge = null;
	}
	,get_edge: function() {
		return this._edge;
	}
};
hxDaedalus.data.Mesh = function(width,height) {
	this.__objectsUpdateInProgress = false;
	this.__edgesToCheck = null;
	this.__centerVertex = null;
	this._objects = null;
	this._constraintShapes = null;
	this._faces = null;
	this._edges = null;
	this._vertices = null;
	this._clipping = false;
	this._height = 0;
	this._width = 0;
	this._id = hxDaedalus.data.Mesh.INC;
	hxDaedalus.data.Mesh.INC++;
	this._width = width;
	this._height = height;
	this._clipping = true;
	this._vertices = new Array();
	this._edges = new Array();
	this._faces = new Array();
	this._constraintShapes = new Array();
	this._objects = new Array();
	this.__edgesToCheck = new Array();
};
hxDaedalus.data.Mesh.__name__ = true;
hxDaedalus.data.Mesh.prototype = {
	get_height: function() {
		return this._height;
	}
	,get_width: function() {
		return this._width;
	}
	,get_clipping: function() {
		return this._clipping;
	}
	,set_clipping: function(value) {
		this._clipping = value;
		return value;
	}
	,get_id: function() {
		return this._id;
	}
	,dispose: function() {
		while(this._vertices.length > 0) this._vertices.pop().dispose();
		this._vertices = null;
		while(this._edges.length > 0) this._edges.pop().dispose();
		this._edges = null;
		while(this._faces.length > 0) this._faces.pop().dispose();
		this._faces = null;
		while(this._constraintShapes.length > 0) this._constraintShapes.pop().dispose();
		this._constraintShapes = null;
		while(this._objects.length > 0) this._objects.pop().dispose();
		this._objects = null;
		this.__edgesToCheck = null;
		this.__centerVertex = null;
	}
	,get___constraintShapes: function() {
		return this._constraintShapes;
	}
	,buildFromRecord: function(rec) {
		var positions = rec.split(";");
		var i = 0;
		while(i < positions.length) {
			this.insertConstraintSegment(Std.parseFloat(positions[i]),Std.parseFloat(positions[i + 1]),Std.parseFloat(positions[i + 2]),Std.parseFloat(positions[i + 3]));
			i += 4;
		}
	}
	,insertObject: function(object) {
		if(object.get_constraintShape() != null) this.deleteObject(object);
		var shape = new hxDaedalus.data.ConstraintShape();
		var segment;
		var coordinates = object.get_coordinates();
		var m = object.get_matrix();
		object.updateMatrixFromValues();
		var x1;
		var y1;
		var x2;
		var y2;
		var transfx1;
		var transfy1;
		var transfx2;
		var transfy2;
		var i = 0;
		while(i < coordinates.length) {
			x1 = coordinates[i];
			y1 = coordinates[i + 1];
			x2 = coordinates[i + 2];
			y2 = coordinates[i + 3];
			transfx1 = m.transformX(x1,y1);
			transfy1 = m.transformY(x1,y1);
			transfx2 = m.transformX(x2,y2);
			transfy2 = m.transformY(x2,y2);
			segment = this.insertConstraintSegment(transfx1,transfy1,transfx2,transfy2);
			if(segment != null) {
				segment.fromShape = shape;
				shape.segments.push(segment);
			}
			i += 4;
		}
		this._constraintShapes.push(shape);
		object.set_constraintShape(shape);
		if(!this.__objectsUpdateInProgress) this._objects.push(object);
	}
	,deleteObject: function(object) {
		if(object.get_constraintShape() == null) return;
		this.deleteConstraintShape(object.get_constraintShape());
		object.set_constraintShape(null);
		if(!this.__objectsUpdateInProgress) {
			var index = HxOverrides.indexOf(this._objects,object,0);
			this._objects.splice(index,1);
		}
	}
	,updateObjects: function() {
		this.__objectsUpdateInProgress = true;
		var _g1 = 0;
		var _g = this._objects.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(this._objects[i].get_hasChanged()) {
				this.deleteObject(this._objects[i]);
				this.insertObject(this._objects[i]);
				this._objects[i].set_hasChanged(false);
			}
		}
		this.__objectsUpdateInProgress = false;
	}
	,insertConstraintShape: function(coordinates) {
		var shape = new hxDaedalus.data.ConstraintShape();
		var segment = null;
		var i = 0;
		while(i < coordinates.length) {
			segment = this.insertConstraintSegment(coordinates[i],coordinates[i + 1],coordinates[i + 2],coordinates[i + 3]);
			if(segment != null) {
				segment.fromShape = shape;
				shape.segments.push(segment);
			}
			i += 4;
		}
		this._constraintShapes.push(shape);
		return shape;
	}
	,deleteConstraintShape: function(shape) {
		var _g1 = 0;
		var _g = shape.segments.length;
		while(_g1 < _g) {
			var i = _g1++;
			this.deleteConstraintSegment(shape.segments[i]);
		}
		shape.dispose();
		this._constraintShapes.splice(HxOverrides.indexOf(this._constraintShapes,shape,0),1);
	}
	,insertConstraintSegment: function(x1,y1,x2,y2) {
		var p1pos = this.findPositionFromBounds(x1,y1);
		var p2pos = this.findPositionFromBounds(x2,y2);
		var newX1 = x1;
		var newY1 = y1;
		var newX2 = x2;
		var newY2 = y2;
		if(this._clipping && (p1pos != 0 || p2pos != 0)) {
			var intersectPoint = new hxDaedalus.data.math.Point2D();
			if(p1pos != 0 && p2pos != 0) {
				if(x1 <= 0 && x2 <= 0 || x1 >= this._width && x2 >= this._width || y1 <= 0 && y2 <= 0 || y1 >= this._height && y2 >= this._height) return null;
				if(p1pos == 8 && p2pos == 4 || p1pos == 4 && p2pos == 8) {
					hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,0,this._height,intersectPoint);
					newX1 = intersectPoint.x;
					newY1 = intersectPoint.y;
					hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,this._width,0,this._width,this._height,intersectPoint);
					newX2 = intersectPoint.x;
					newY2 = intersectPoint.y;
				} else if(p1pos == 2 && p2pos == 6 || p1pos == 6 && p2pos == 2) {
					hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,this._width,0,intersectPoint);
					newX1 = intersectPoint.x;
					newY1 = intersectPoint.y;
					hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,this._height,this._width,this._height,intersectPoint);
					newX2 = intersectPoint.x;
					newY2 = intersectPoint.y;
				} else if(p1pos == 2 && p2pos == 8 || p1pos == 8 && p2pos == 2) {
					if(hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,this._width,0,intersectPoint)) {
						newX1 = intersectPoint.x;
						newY1 = intersectPoint.y;
						hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,0,this._height,intersectPoint);
						newX2 = intersectPoint.x;
						newY2 = intersectPoint.y;
					} else return null;
				} else if(p1pos == 2 && p2pos == 4 || p1pos == 4 && p2pos == 2) {
					if(hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,this._width,0,intersectPoint)) {
						newX1 = intersectPoint.x;
						newY1 = intersectPoint.y;
						hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,this._width,0,this._width,this._height,intersectPoint);
						newX2 = intersectPoint.x;
						newY2 = intersectPoint.y;
					} else return null;
				} else if(p1pos == 6 && p2pos == 4 || p1pos == 4 && p2pos == 6) {
					if(hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,this._height,this._width,this._height,intersectPoint)) {
						newX1 = intersectPoint.x;
						newY1 = intersectPoint.y;
						hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,this._width,0,this._width,this._height,intersectPoint);
						newX2 = intersectPoint.x;
						newY2 = intersectPoint.y;
					} else return null;
				} else if(p1pos == 8 && p2pos == 6 || p1pos == 6 && p2pos == 8) {
					if(hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,this._height,this._width,this._height,intersectPoint)) {
						newX1 = intersectPoint.x;
						newY1 = intersectPoint.y;
						hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,0,this._height,intersectPoint);
						newX2 = intersectPoint.x;
						newY2 = intersectPoint.y;
					} else return null;
				} else {
					var firstDone = false;
					var secondDone = false;
					if(hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,this._width,0,intersectPoint)) {
						newX1 = intersectPoint.x;
						newY1 = intersectPoint.y;
						firstDone = true;
					}
					if(hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,this._width,0,this._width,this._height,intersectPoint)) {
						if(!firstDone) {
							newX1 = intersectPoint.x;
							newY1 = intersectPoint.y;
							firstDone = true;
						} else {
							newX2 = intersectPoint.x;
							newY2 = intersectPoint.y;
							secondDone = true;
						}
					}
					if(!secondDone && hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,this._height,this._width,this._height,intersectPoint)) {
						if(!firstDone) {
							newX1 = intersectPoint.x;
							newY1 = intersectPoint.y;
							firstDone = true;
						} else {
							newX2 = intersectPoint.x;
							newY2 = intersectPoint.y;
							secondDone = true;
						}
					}
					if(!secondDone && hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,0,this._height,intersectPoint)) {
						newX2 = intersectPoint.x;
						newY2 = intersectPoint.y;
					}
					if(!firstDone) return null;
				}
			} else {
				if(p1pos == 2 || p2pos == 2) hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,this._width,0,intersectPoint); else if(p1pos == 4 || p2pos == 4) hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,this._width,0,this._width,this._height,intersectPoint); else if(p1pos == 6 || p2pos == 6) hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,this._height,this._width,this._height,intersectPoint); else if(p1pos == 8 || p2pos == 8) hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,0,this._height,intersectPoint); else if(!hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,this._width,0,intersectPoint)) {
					if(!hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,this._width,0,this._width,this._height,intersectPoint)) {
						if(!hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,this._height,this._width,this._height,intersectPoint)) hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,0,this._height,intersectPoint);
					}
				}
				if(p1pos == 0) {
					newX1 = x1;
					newY1 = y1;
				} else {
					newX1 = x2;
					newY1 = y2;
				}
				newX2 = intersectPoint.x;
				newY2 = intersectPoint.y;
			}
		}
		var vertexDown = this.insertVertex(newX1,newY1);
		if(vertexDown == null) return null;
		var vertexUp = this.insertVertex(newX2,newY2);
		if(vertexUp == null) return null;
		if(vertexDown == vertexUp) return null;
		var iterVertexToOutEdges = new hxDaedalus.iterators.FromVertexToOutgoingEdges();
		var currVertex;
		var currEdge;
		var i;
		var segment = new hxDaedalus.data.ConstraintSegment();
		var tempEdgeDownUp = new hxDaedalus.data.Edge();
		var tempSdgeUpDown = new hxDaedalus.data.Edge();
		tempEdgeDownUp.setDatas(vertexDown,tempSdgeUpDown,null,null,true,true);
		tempSdgeUpDown.setDatas(vertexUp,tempEdgeDownUp,null,null,true,true);
		var intersectedEdges = new Array();
		var leftBoundingEdges = new Array();
		var rightBoundingEdges = new Array();
		var currObjet;
		var pIntersect = new hxDaedalus.data.math.Point2D();
		var edgeLeft;
		var newEdgeDownUp;
		var newEdgeUpDown;
		var done;
		currVertex = vertexDown;
		currObjet = hxDaedalus.data.math.Intersection.EVertex(currVertex);
		while(true) {
			done = false;
			switch(currObjet[1]) {
			case 0:
				var vertex = currObjet[2];
				currVertex = vertex;
				iterVertexToOutEdges.set_fromVertex(currVertex);
				while((currEdge = iterVertexToOutEdges.next()) != null) {
					if(currEdge.get_destinationVertex() == vertexUp) {
						if(!currEdge.get_isConstrained()) {
							currEdge.set_isConstrained(true);
							currEdge.get_oppositeEdge().set_isConstrained(true);
						}
						currEdge.addFromConstraintSegment(segment);
						currEdge.get_oppositeEdge().fromConstraintSegments = currEdge.fromConstraintSegments;
						vertexDown.addFromConstraintSegment(segment);
						vertexUp.addFromConstraintSegment(segment);
						segment.addEdge(currEdge);
						return segment;
					}
					if(hxDaedalus.data.math.Geom2D.distanceSquaredVertexToEdge(currEdge.get_destinationVertex(),tempEdgeDownUp) <= 0.0001) {
						if(!currEdge.get_isConstrained()) {
							currEdge.set_isConstrained(true);
							currEdge.get_oppositeEdge().set_isConstrained(true);
						}
						currEdge.addFromConstraintSegment(segment);
						currEdge.get_oppositeEdge().fromConstraintSegments = currEdge.fromConstraintSegments;
						vertexDown.addFromConstraintSegment(segment);
						segment.addEdge(currEdge);
						vertexDown = currEdge.get_destinationVertex();
						tempEdgeDownUp.set_originVertex(vertexDown);
						currObjet = hxDaedalus.data.math.Intersection.EVertex(vertexDown);
						done = true;
						break;
					}
				}
				if(done) continue;
				iterVertexToOutEdges.set_fromVertex(currVertex);
				while((currEdge = iterVertexToOutEdges.next()) != null) {
					currEdge = currEdge.get_nextLeftEdge();
					if(hxDaedalus.data.math.Geom2D.intersections2edges(currEdge,tempEdgeDownUp,pIntersect)) {
						if(currEdge.get_isConstrained()) {
							vertexDown = this.splitEdge(currEdge,pIntersect.x,pIntersect.y);
							iterVertexToOutEdges.set_fromVertex(currVertex);
							while((currEdge = iterVertexToOutEdges.next()) != null) if(currEdge.get_destinationVertex() == vertexDown) {
								currEdge.set_isConstrained(true);
								currEdge.get_oppositeEdge().set_isConstrained(true);
								currEdge.addFromConstraintSegment(segment);
								currEdge.get_oppositeEdge().fromConstraintSegments = currEdge.fromConstraintSegments;
								segment.addEdge(currEdge);
								break;
							}
							currVertex.addFromConstraintSegment(segment);
							tempEdgeDownUp.set_originVertex(vertexDown);
							currObjet = hxDaedalus.data.math.Intersection.EVertex(vertexDown);
						} else {
							intersectedEdges.push(currEdge);
							leftBoundingEdges.unshift(currEdge.get_nextLeftEdge());
							rightBoundingEdges.push(currEdge.get_prevLeftEdge());
							currEdge = currEdge.get_oppositeEdge();
							currObjet = hxDaedalus.data.math.Intersection.EEdge(currEdge);
						}
						break;
					}
				}
				break;
			case 1:
				var edge = currObjet[2];
				currEdge = edge;
				edgeLeft = currEdge.get_nextLeftEdge();
				if(edgeLeft.get_destinationVertex() == vertexUp) {
					leftBoundingEdges.unshift(edgeLeft.get_nextLeftEdge());
					rightBoundingEdges.push(edgeLeft);
					newEdgeDownUp = new hxDaedalus.data.Edge();
					newEdgeUpDown = new hxDaedalus.data.Edge();
					newEdgeDownUp.setDatas(vertexDown,newEdgeUpDown,null,null,true,true);
					newEdgeUpDown.setDatas(vertexUp,newEdgeDownUp,null,null,true,true);
					leftBoundingEdges.push(newEdgeDownUp);
					rightBoundingEdges.push(newEdgeUpDown);
					this.insertNewConstrainedEdge(segment,newEdgeDownUp,intersectedEdges,leftBoundingEdges,rightBoundingEdges);
					return segment;
				} else if(hxDaedalus.data.math.Geom2D.distanceSquaredVertexToEdge(edgeLeft.get_destinationVertex(),tempEdgeDownUp) <= 0.0001) {
					leftBoundingEdges.unshift(edgeLeft.get_nextLeftEdge());
					rightBoundingEdges.push(edgeLeft);
					newEdgeDownUp = new hxDaedalus.data.Edge();
					newEdgeUpDown = new hxDaedalus.data.Edge();
					newEdgeDownUp.setDatas(vertexDown,newEdgeUpDown,null,null,true,true);
					newEdgeUpDown.setDatas(edgeLeft.get_destinationVertex(),newEdgeDownUp,null,null,true,true);
					leftBoundingEdges.push(newEdgeDownUp);
					rightBoundingEdges.push(newEdgeUpDown);
					this.insertNewConstrainedEdge(segment,newEdgeDownUp,intersectedEdges,leftBoundingEdges,rightBoundingEdges);
					intersectedEdges.splice(0,intersectedEdges.length);
					leftBoundingEdges.splice(0,leftBoundingEdges.length);
					rightBoundingEdges.splice(0,rightBoundingEdges.length);
					vertexDown = edgeLeft.get_destinationVertex();
					tempEdgeDownUp.set_originVertex(vertexDown);
					currObjet = hxDaedalus.data.math.Intersection.EVertex(vertexDown);
				} else if(hxDaedalus.data.math.Geom2D.intersections2edges(edgeLeft,tempEdgeDownUp,pIntersect)) {
					if(edgeLeft.get_isConstrained()) {
						currVertex = this.splitEdge(edgeLeft,pIntersect.x,pIntersect.y);
						iterVertexToOutEdges.set_fromVertex(currVertex);
						while((currEdge = iterVertexToOutEdges.next()) != null) {
							if(currEdge.get_destinationVertex() == leftBoundingEdges[0].get_originVertex()) leftBoundingEdges.unshift(currEdge);
							if(currEdge.get_destinationVertex() == rightBoundingEdges[rightBoundingEdges.length - 1].get_destinationVertex()) rightBoundingEdges.push(currEdge.get_oppositeEdge());
						}
						newEdgeDownUp = new hxDaedalus.data.Edge();
						newEdgeUpDown = new hxDaedalus.data.Edge();
						newEdgeDownUp.setDatas(vertexDown,newEdgeUpDown,null,null,true,true);
						newEdgeUpDown.setDatas(currVertex,newEdgeDownUp,null,null,true,true);
						leftBoundingEdges.push(newEdgeDownUp);
						rightBoundingEdges.push(newEdgeUpDown);
						this.insertNewConstrainedEdge(segment,newEdgeDownUp,intersectedEdges,leftBoundingEdges,rightBoundingEdges);
						intersectedEdges.splice(0,intersectedEdges.length);
						leftBoundingEdges.splice(0,leftBoundingEdges.length);
						rightBoundingEdges.splice(0,rightBoundingEdges.length);
						vertexDown = currVertex;
						tempEdgeDownUp.set_originVertex(vertexDown);
						currObjet = hxDaedalus.data.math.Intersection.EVertex(vertexDown);
					} else {
						intersectedEdges.push(edgeLeft);
						leftBoundingEdges.unshift(edgeLeft.get_nextLeftEdge());
						currEdge = edgeLeft.get_oppositeEdge();
						currObjet = hxDaedalus.data.math.Intersection.EEdge(currEdge);
					}
				} else {
					edgeLeft = edgeLeft.get_nextLeftEdge();
					hxDaedalus.data.math.Geom2D.intersections2edges(edgeLeft,tempEdgeDownUp,pIntersect);
					if(edgeLeft.get_isConstrained()) {
						currVertex = this.splitEdge(edgeLeft,pIntersect.x,pIntersect.y);
						iterVertexToOutEdges.set_fromVertex(currVertex);
						while((currEdge = iterVertexToOutEdges.next()) != null) {
							if(currEdge.get_destinationVertex() == leftBoundingEdges[0].get_originVertex()) leftBoundingEdges.unshift(currEdge);
							if(currEdge.get_destinationVertex() == rightBoundingEdges[rightBoundingEdges.length - 1].get_destinationVertex()) rightBoundingEdges.push(currEdge.get_oppositeEdge());
						}
						newEdgeDownUp = new hxDaedalus.data.Edge();
						newEdgeUpDown = new hxDaedalus.data.Edge();
						newEdgeDownUp.setDatas(vertexDown,newEdgeUpDown,null,null,true,true);
						newEdgeUpDown.setDatas(currVertex,newEdgeDownUp,null,null,true,true);
						leftBoundingEdges.push(newEdgeDownUp);
						rightBoundingEdges.push(newEdgeUpDown);
						this.insertNewConstrainedEdge(segment,newEdgeDownUp,intersectedEdges,leftBoundingEdges,rightBoundingEdges);
						intersectedEdges.splice(0,intersectedEdges.length);
						leftBoundingEdges.splice(0,leftBoundingEdges.length);
						rightBoundingEdges.splice(0,rightBoundingEdges.length);
						vertexDown = currVertex;
						tempEdgeDownUp.set_originVertex(vertexDown);
						currObjet = hxDaedalus.data.math.Intersection.EVertex(vertexDown);
					} else {
						intersectedEdges.push(edgeLeft);
						rightBoundingEdges.push(edgeLeft.get_prevLeftEdge());
						currEdge = edgeLeft.get_oppositeEdge();
						currObjet = hxDaedalus.data.math.Intersection.EEdge(currEdge);
					}
				}
				break;
			case 2:
				var face = currObjet[2];
				break;
			case 3:
				break;
			}
		}
		return segment;
	}
	,insertNewConstrainedEdge: function(fromSegment,edgeDownUp,intersectedEdges,leftBoundingEdges,rightBoundingEdges) {
		this._edges.push(edgeDownUp);
		this._edges.push(edgeDownUp.get_oppositeEdge());
		edgeDownUp.addFromConstraintSegment(fromSegment);
		edgeDownUp.get_oppositeEdge().fromConstraintSegments = edgeDownUp.fromConstraintSegments;
		fromSegment.addEdge(edgeDownUp);
		edgeDownUp.get_originVertex().addFromConstraintSegment(fromSegment);
		edgeDownUp.get_destinationVertex().addFromConstraintSegment(fromSegment);
		this.untriangulate(intersectedEdges);
		this.triangulate(leftBoundingEdges,true);
		this.triangulate(rightBoundingEdges,true);
	}
	,deleteConstraintSegment: function(segment) {
		var i;
		var vertexToDelete = new Array();
		var edge = null;
		var vertex;
		var fromConstraintSegment;
		var _g1 = 0;
		var _g = segment.get_edges().length;
		while(_g1 < _g) {
			var i1 = _g1++;
			edge = segment.get_edges()[i1];
			edge.removeFromConstraintSegment(segment);
			if(edge.fromConstraintSegments.length == 0) {
				edge.set_isConstrained(false);
				edge.get_oppositeEdge().set_isConstrained(false);
			}
			vertex = edge.get_originVertex();
			vertex.removeFromConstraintSegment(segment);
			vertexToDelete.push(vertex);
		}
		vertex = edge.get_destinationVertex();
		vertex.removeFromConstraintSegment(segment);
		vertexToDelete.push(vertex);
		var _g11 = 0;
		var _g2 = vertexToDelete.length;
		while(_g11 < _g2) {
			var i2 = _g11++;
			this.deleteVertex(vertexToDelete[i2]);
		}
		segment.dispose();
	}
	,check: function() {
		var _g1 = 0;
		var _g = this._edges.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(this._edges[i].get_nextLeftEdge() == null) {
				haxe.Log.trace("!!! missing nextLeftEdge",{ fileName : "Mesh.hx", lineNumber : 793, className : "hxDaedalus.data.Mesh", methodName : "check"});
				return;
			}
		}
		haxe.Log.trace("check OK",{ fileName : "Mesh.hx", lineNumber : 797, className : "hxDaedalus.data.Mesh", methodName : "check"});
	}
	,insertVertex: function(x,y) {
		if(x < 0 || y < 0 || x > this._width || y > this._height) return null;
		this.__edgesToCheck.splice(0,this.__edgesToCheck.length);
		var inObject = hxDaedalus.data.math.Geom2D.locatePosition(x,y,this);
		var newVertex = null;
		switch(inObject[1]) {
		case 0:
			var vertex = inObject[2];
			newVertex = vertex;
			break;
		case 1:
			var edge = inObject[2];
			newVertex = this.splitEdge(edge,x,y);
			break;
		case 2:
			var face = inObject[2];
			newVertex = this.splitFace(face,x,y);
			break;
		case 3:
			break;
		}
		this.restoreAsDelaunay();
		return newVertex;
	}
	,flipEdge: function(edge) {
		var eBot_Top = edge;
		var eTop_Bot = edge.get_oppositeEdge();
		var eLeft_Right = new hxDaedalus.data.Edge();
		var eRight_Left = new hxDaedalus.data.Edge();
		var eTop_Left = eBot_Top.get_nextLeftEdge();
		var eLeft_Bot = eTop_Left.get_nextLeftEdge();
		var eBot_Right = eTop_Bot.get_nextLeftEdge();
		var eRight_Top = eBot_Right.get_nextLeftEdge();
		var vBot = eBot_Top.get_originVertex();
		var vTop = eTop_Bot.get_originVertex();
		var vLeft = eLeft_Bot.get_originVertex();
		var vRight = eRight_Top.get_originVertex();
		var fLeft = eBot_Top.get_leftFace();
		var fRight = eTop_Bot.get_leftFace();
		var fBot = new hxDaedalus.data.Face();
		var fTop = new hxDaedalus.data.Face();
		this._edges.push(eLeft_Right);
		this._edges.push(eRight_Left);
		this._faces.push(fTop);
		this._faces.push(fBot);
		eLeft_Right.setDatas(vLeft,eRight_Left,eRight_Top,fTop,edge.get_isReal(),edge.get_isConstrained());
		eRight_Left.setDatas(vRight,eLeft_Right,eLeft_Bot,fBot,edge.get_isReal(),edge.get_isConstrained());
		fTop.setDatas(eLeft_Right);
		fBot.setDatas(eRight_Left);
		if(vTop.get_edge() == eTop_Bot) vTop.setDatas(eTop_Left);
		if(vBot.get_edge() == eBot_Top) vBot.setDatas(eBot_Right);
		eTop_Left.set_nextLeftEdge(eLeft_Right);
		eTop_Left.set_leftFace(fTop);
		eLeft_Bot.set_nextLeftEdge(eBot_Right);
		eLeft_Bot.set_leftFace(fBot);
		eBot_Right.set_nextLeftEdge(eRight_Left);
		eBot_Right.set_leftFace(fBot);
		eRight_Top.set_nextLeftEdge(eTop_Left);
		eRight_Top.set_leftFace(fTop);
		eBot_Top.dispose();
		eTop_Bot.dispose();
		this._edges.splice(HxOverrides.indexOf(this._edges,eBot_Top,0),1);
		this._edges.splice(HxOverrides.indexOf(this._edges,eTop_Bot,0),1);
		fLeft.dispose();
		fRight.dispose();
		this._faces.splice(HxOverrides.indexOf(this._faces,fLeft,0),1);
		this._faces.splice(HxOverrides.indexOf(this._faces,fRight,0),1);
		return eRight_Left;
	}
	,splitEdge: function(edge,x,y) {
		this.__edgesToCheck.splice(0,this.__edgesToCheck.length);
		var eLeft_Right = edge;
		var eRight_Left = eLeft_Right.get_oppositeEdge();
		var eRight_Top = eLeft_Right.get_nextLeftEdge();
		var eTop_Left = eRight_Top.get_nextLeftEdge();
		var eLeft_Bot = eRight_Left.get_nextLeftEdge();
		var eBot_Right = eLeft_Bot.get_nextLeftEdge();
		var vTop = eTop_Left.get_originVertex();
		var vLeft = eLeft_Right.get_originVertex();
		var vBot = eBot_Right.get_originVertex();
		var vRight = eRight_Left.get_originVertex();
		var fTop = eLeft_Right.get_leftFace();
		var fBot = eRight_Left.get_leftFace();
		if((vLeft.get_pos().x - x) * (vLeft.get_pos().x - x) + (vLeft.get_pos().y - y) * (vLeft.get_pos().y - y) <= 0.0001) return vLeft;
		if((vRight.get_pos().x - x) * (vRight.get_pos().x - x) + (vRight.get_pos().y - y) * (vRight.get_pos().y - y) <= 0.0001) return vRight;
		var vCenter = new hxDaedalus.data.Vertex();
		var eTop_Center = new hxDaedalus.data.Edge();
		var eCenter_Top = new hxDaedalus.data.Edge();
		var eBot_Center = new hxDaedalus.data.Edge();
		var eCenter_Bot = new hxDaedalus.data.Edge();
		var eLeft_Center = new hxDaedalus.data.Edge();
		var eCenter_Left = new hxDaedalus.data.Edge();
		var eRight_Center = new hxDaedalus.data.Edge();
		var eCenter_Right = new hxDaedalus.data.Edge();
		var fTopLeft = new hxDaedalus.data.Face();
		var fBotLeft = new hxDaedalus.data.Face();
		var fBotRight = new hxDaedalus.data.Face();
		var fTopRight = new hxDaedalus.data.Face();
		this._vertices.push(vCenter);
		this._edges.push(eCenter_Top);
		this._edges.push(eTop_Center);
		this._edges.push(eCenter_Left);
		this._edges.push(eLeft_Center);
		this._edges.push(eCenter_Bot);
		this._edges.push(eBot_Center);
		this._edges.push(eCenter_Right);
		this._edges.push(eRight_Center);
		this._faces.push(fTopRight);
		this._faces.push(fBotRight);
		this._faces.push(fBotLeft);
		this._faces.push(fTopLeft);
		vCenter.setDatas(fTop.get_isReal()?eCenter_Top:eCenter_Bot);
		vCenter.get_pos().x = x;
		vCenter.get_pos().y = y;
		hxDaedalus.data.math.Geom2D.projectOrthogonaly(vCenter.get_pos(),eLeft_Right);
		eCenter_Top.setDatas(vCenter,eTop_Center,eTop_Left,fTopLeft,fTop.get_isReal());
		eTop_Center.setDatas(vTop,eCenter_Top,eCenter_Right,fTopRight,fTop.get_isReal());
		eCenter_Left.setDatas(vCenter,eLeft_Center,eLeft_Bot,fBotLeft,edge.get_isReal(),edge.get_isConstrained());
		eLeft_Center.setDatas(vLeft,eCenter_Left,eCenter_Top,fTopLeft,edge.get_isReal(),edge.get_isConstrained());
		eCenter_Bot.setDatas(vCenter,eBot_Center,eBot_Right,fBotRight,fBot.get_isReal());
		eBot_Center.setDatas(vBot,eCenter_Bot,eCenter_Left,fBotLeft,fBot.get_isReal());
		eCenter_Right.setDatas(vCenter,eRight_Center,eRight_Top,fTopRight,edge.get_isReal(),edge.get_isConstrained());
		eRight_Center.setDatas(vRight,eCenter_Right,eCenter_Bot,fBotRight,edge.get_isReal(),edge.get_isConstrained());
		fTopLeft.setDatas(eCenter_Top,fTop.get_isReal());
		fBotLeft.setDatas(eCenter_Left,fBot.get_isReal());
		fBotRight.setDatas(eCenter_Bot,fBot.get_isReal());
		fTopRight.setDatas(eCenter_Right,fTop.get_isReal());
		if(vLeft.get_edge() == eLeft_Right) vLeft.setDatas(eLeft_Center);
		if(vRight.get_edge() == eRight_Left) vRight.setDatas(eRight_Center);
		eTop_Left.set_nextLeftEdge(eLeft_Center);
		eTop_Left.set_leftFace(fTopLeft);
		eLeft_Bot.set_nextLeftEdge(eBot_Center);
		eLeft_Bot.set_leftFace(fBotLeft);
		eBot_Right.set_nextLeftEdge(eRight_Center);
		eBot_Right.set_leftFace(fBotRight);
		eRight_Top.set_nextLeftEdge(eTop_Center);
		eRight_Top.set_leftFace(fTopRight);
		if(eLeft_Right.get_isConstrained()) {
			var fromSegments = eLeft_Right.fromConstraintSegments;
			eLeft_Center.fromConstraintSegments = fromSegments.slice(0);
			eCenter_Left.fromConstraintSegments = eLeft_Center.fromConstraintSegments;
			eCenter_Right.fromConstraintSegments = fromSegments.slice(0);
			eRight_Center.fromConstraintSegments = eCenter_Right.fromConstraintSegments;
			var edges;
			var index;
			var _g1 = 0;
			var _g = eLeft_Right.fromConstraintSegments.length;
			while(_g1 < _g) {
				var i = _g1++;
				edges = eLeft_Right.fromConstraintSegments[i].get_edges();
				index = HxOverrides.indexOf(edges,eLeft_Right,0);
				if(index != -1) {
					edges.splice(index,1);
					edges.splice(index,0,eLeft_Center);
					edges.splice(index + 1,0,eCenter_Right);
				} else {
					var index2 = HxOverrides.indexOf(edges,eRight_Left,0);
					edges.splice(index2,1);
					edges.splice(index2,0,eRight_Center);
					edges.splice(index2,0,eCenter_Left);
				}
			}
			vCenter.set_fromConstraintSegments(fromSegments.slice(0));
		}
		eLeft_Right.dispose();
		eRight_Left.dispose();
		this._edges.splice(HxOverrides.indexOf(this._edges,eLeft_Right,0),1);
		this._edges.splice(HxOverrides.indexOf(this._edges,eRight_Left,0),1);
		fTop.dispose();
		fBot.dispose();
		this._faces.splice(HxOverrides.indexOf(this._faces,fTop,0),1);
		this._faces.splice(HxOverrides.indexOf(this._faces,fBot,0),1);
		this.__centerVertex = vCenter;
		this.__edgesToCheck.push(eTop_Left);
		this.__edgesToCheck.push(eLeft_Bot);
		this.__edgesToCheck.push(eBot_Right);
		this.__edgesToCheck.push(eRight_Top);
		return vCenter;
	}
	,splitFace: function(face,x,y) {
		this.__edgesToCheck.splice(0,this.__edgesToCheck.length);
		var eTop_Left = face.get_edge();
		var eLeft_Right = eTop_Left.get_nextLeftEdge();
		var eRight_Top = eLeft_Right.get_nextLeftEdge();
		var vTop = eTop_Left.get_originVertex();
		var vLeft = eLeft_Right.get_originVertex();
		var vRight = eRight_Top.get_originVertex();
		var vCenter = new hxDaedalus.data.Vertex();
		var eTop_Center = new hxDaedalus.data.Edge();
		var eCenter_Top = new hxDaedalus.data.Edge();
		var eLeft_Center = new hxDaedalus.data.Edge();
		var eCenter_Left = new hxDaedalus.data.Edge();
		var eRight_Center = new hxDaedalus.data.Edge();
		var eCenter_Right = new hxDaedalus.data.Edge();
		var fTopLeft = new hxDaedalus.data.Face();
		var fBot = new hxDaedalus.data.Face();
		var fTopRight = new hxDaedalus.data.Face();
		this._vertices.push(vCenter);
		this._edges.push(eTop_Center);
		this._edges.push(eCenter_Top);
		this._edges.push(eLeft_Center);
		this._edges.push(eCenter_Left);
		this._edges.push(eRight_Center);
		this._edges.push(eCenter_Right);
		this._faces.push(fTopLeft);
		this._faces.push(fBot);
		this._faces.push(fTopRight);
		vCenter.setDatas(eCenter_Top);
		vCenter.get_pos().x = x;
		vCenter.get_pos().y = y;
		eTop_Center.setDatas(vTop,eCenter_Top,eCenter_Right,fTopRight);
		eCenter_Top.setDatas(vCenter,eTop_Center,eTop_Left,fTopLeft);
		eLeft_Center.setDatas(vLeft,eCenter_Left,eCenter_Top,fTopLeft);
		eCenter_Left.setDatas(vCenter,eLeft_Center,eLeft_Right,fBot);
		eRight_Center.setDatas(vRight,eCenter_Right,eCenter_Left,fBot);
		eCenter_Right.setDatas(vCenter,eRight_Center,eRight_Top,fTopRight);
		fTopLeft.setDatas(eCenter_Top);
		fBot.setDatas(eCenter_Left);
		fTopRight.setDatas(eCenter_Right);
		eTop_Left.set_nextLeftEdge(eLeft_Center);
		eTop_Left.set_leftFace(fTopLeft);
		eLeft_Right.set_nextLeftEdge(eRight_Center);
		eLeft_Right.set_leftFace(fBot);
		eRight_Top.set_nextLeftEdge(eTop_Center);
		eRight_Top.set_leftFace(fTopRight);
		face.dispose();
		this._faces.splice(HxOverrides.indexOf(this._faces,face,0),1);
		this.__centerVertex = vCenter;
		this.__edgesToCheck.push(eTop_Left);
		this.__edgesToCheck.push(eLeft_Right);
		this.__edgesToCheck.push(eRight_Top);
		return vCenter;
	}
	,restoreAsDelaunay: function() {
		var edge;
		while(this.__edgesToCheck.length > 0) {
			edge = this.__edgesToCheck.shift();
			if(edge.get_isReal() && !edge.get_isConstrained() && !hxDaedalus.data.math.Geom2D.isDelaunay(edge)) {
				if(edge.get_nextLeftEdge().get_destinationVertex() == this.__centerVertex) {
					this.__edgesToCheck.push(edge.get_nextRightEdge());
					this.__edgesToCheck.push(edge.get_prevRightEdge());
				} else {
					this.__edgesToCheck.push(edge.get_nextLeftEdge());
					this.__edgesToCheck.push(edge.get_prevLeftEdge());
				}
				this.flipEdge(edge);
			}
		}
	}
	,deleteVertex: function(vertex) {
		var i;
		var freeOfConstraint;
		var iterEdges = new hxDaedalus.iterators.FromVertexToOutgoingEdges();
		iterEdges.set_fromVertex(vertex);
		iterEdges.realEdgesOnly = false;
		var edge;
		var outgoingEdges = new Array();
		freeOfConstraint = vertex.get_fromConstraintSegments().length == 0;
		var bound = new Array();
		var realA = false;
		var realB = false;
		var boundA = [];
		var boundB = [];
		if(freeOfConstraint) while((edge = iterEdges.next()) != null) {
			outgoingEdges.push(edge);
			bound.push(edge.get_nextLeftEdge());
		} else {
			var edges;
			var _g1 = 0;
			var _g = vertex.get_fromConstraintSegments().length;
			while(_g1 < _g) {
				var i1 = _g1++;
				edges = vertex.get_fromConstraintSegments()[i1].get_edges();
				if(edges[0].get_originVertex() == vertex || edges[edges.length - 1].get_destinationVertex() == vertex) return false;
			}
			var count = 0;
			while((edge = iterEdges.next()) != null) {
				outgoingEdges.push(edge);
				if(edge.get_isConstrained()) {
					count++;
					if(count > 2) return false;
				}
			}
			boundA = new Array();
			boundB = new Array();
			var constrainedEdgeA = null;
			var constrainedEdgeB = null;
			var edgeA = new hxDaedalus.data.Edge();
			var edgeB = new hxDaedalus.data.Edge();
			this._edges.push(edgeA);
			this._edges.push(edgeB);
			var _g11 = 0;
			var _g2 = outgoingEdges.length;
			while(_g11 < _g2) {
				var i2 = _g11++;
				edge = outgoingEdges[i2];
				if(edge.get_isConstrained()) {
					if(constrainedEdgeA == null) {
						edgeB.setDatas(edge.get_destinationVertex(),edgeA,null,null,true,true);
						boundA.push(edgeA);
						boundA.push(edge.get_nextLeftEdge());
						boundB.push(edgeB);
						constrainedEdgeA = edge;
					} else if(constrainedEdgeB == null) {
						edgeA.setDatas(edge.get_destinationVertex(),edgeB,null,null,true,true);
						boundB.push(edge.get_nextLeftEdge());
						constrainedEdgeB = edge;
					}
				} else if(constrainedEdgeA == null) boundB.push(edge.get_nextLeftEdge()); else if(constrainedEdgeB == null) boundA.push(edge.get_nextLeftEdge()); else boundB.push(edge.get_nextLeftEdge());
			}
			realA = constrainedEdgeA.get_leftFace().get_isReal();
			realB = constrainedEdgeB.get_leftFace().get_isReal();
			edgeA.fromConstraintSegments = constrainedEdgeA.fromConstraintSegments.slice(0);
			edgeB.fromConstraintSegments = edgeA.fromConstraintSegments;
			var index;
			var _g12 = 0;
			var _g3 = vertex.get_fromConstraintSegments().length;
			while(_g12 < _g3) {
				var i3 = _g12++;
				edges = vertex.get_fromConstraintSegments()[i3].get_edges();
				index = HxOverrides.indexOf(edges,constrainedEdgeA,0);
				if(index != -1) {
					edges.splice(index - 1,2);
					edges.splice(index - 1,0,edgeA);
				} else {
					var index2 = HxOverrides.indexOf(edges,constrainedEdgeB,0) - 1;
					edges.splice(index2,2);
					edges.splice(index2,0,edgeB);
				}
			}
		}
		var faceToDelete;
		var _g13 = 0;
		var _g4 = outgoingEdges.length;
		while(_g13 < _g4) {
			var i4 = _g13++;
			edge = outgoingEdges[i4];
			faceToDelete = edge.get_leftFace();
			this._faces.splice(HxOverrides.indexOf(this._faces,faceToDelete,0),1);
			faceToDelete.dispose();
			edge.get_destinationVertex().set_edge(edge.get_nextLeftEdge());
			this._edges.splice((function($this) {
				var $r;
				var x = edge.get_oppositeEdge();
				$r = HxOverrides.indexOf($this._edges,x,0);
				return $r;
			}(this)),1);
			edge.get_oppositeEdge().dispose();
			this._edges.splice(HxOverrides.indexOf(this._edges,edge,0),1);
			edge.dispose();
		}
		this._vertices.splice(HxOverrides.indexOf(this._vertices,vertex,0),1);
		vertex.dispose();
		if(freeOfConstraint) this.triangulate(bound,true); else {
			this.triangulate(boundA,realA);
			this.triangulate(boundB,realB);
		}
		return true;
	}
	,untriangulate: function(edgesList) {
		var i;
		var verticesCleaned = new haxe.ds.ObjectMap();
		var currEdge;
		var outEdge;
		var _g1 = 0;
		var _g = edgesList.length;
		while(_g1 < _g) {
			var i1 = _g1++;
			currEdge = edgesList[i1];
			if((function($this) {
				var $r;
				var key = currEdge.get_originVertex();
				$r = verticesCleaned.h[key.__id__];
				return $r;
			}(this)) == null) {
				currEdge.get_originVertex().set_edge(currEdge.get_prevLeftEdge().get_oppositeEdge());
				var k = currEdge.get_originVertex();
				verticesCleaned.set(k,true);
				true;
			}
			if((function($this) {
				var $r;
				var key1 = currEdge.get_destinationVertex();
				$r = verticesCleaned.h[key1.__id__];
				return $r;
			}(this)) == null) {
				currEdge.get_destinationVertex().set_edge(currEdge.get_nextLeftEdge());
				var k1 = currEdge.get_destinationVertex();
				verticesCleaned.set(k1,true);
				true;
			}
			this._faces.splice((function($this) {
				var $r;
				var x = currEdge.get_leftFace();
				$r = HxOverrides.indexOf($this._faces,x,0);
				return $r;
			}(this)),1);
			currEdge.get_leftFace().dispose();
			if(i1 == edgesList.length - 1) {
				this._faces.splice((function($this) {
					var $r;
					var x1 = currEdge.get_rightFace();
					$r = HxOverrides.indexOf($this._faces,x1,0);
					return $r;
				}(this)),1);
				currEdge.get_rightFace().dispose();
			}
		}
		var _g11 = 0;
		var _g2 = edgesList.length;
		while(_g11 < _g2) {
			var i2 = _g11++;
			currEdge = edgesList[i2];
			this._edges.splice((function($this) {
				var $r;
				var x2 = currEdge.get_oppositeEdge();
				$r = HxOverrides.indexOf($this._edges,x2,0);
				return $r;
			}(this)),1);
			this._edges.splice(HxOverrides.indexOf(this._edges,currEdge,0),1);
			currEdge.get_oppositeEdge().dispose();
			currEdge.dispose();
		}
	}
	,triangulate: function(bound,isReal) {
		if(bound.length < 2) {
			haxe.Log.trace("BREAK ! the hole has less than 2 edges",{ fileName : "Mesh.hx", lineNumber : 1395, className : "hxDaedalus.data.Mesh", methodName : "triangulate"});
			return;
		} else if(bound.length == 2) {
			haxe.Log.trace("BREAK ! the hole has only 2 edges",{ fileName : "Mesh.hx", lineNumber : 1402, className : "hxDaedalus.data.Mesh", methodName : "triangulate"});
			hxDaedalus.debug.Debug.trace("  - edge0: " + bound[0].get_originVertex().get_id() + " -> " + bound[0].get_destinationVertex().get_id(),{ fileName : "Mesh.hx", lineNumber : 1403, className : "hxDaedalus.data.Mesh", methodName : "triangulate"});
			hxDaedalus.debug.Debug.trace("  - edge1: " + bound[1].get_originVertex().get_id() + " -> " + bound[1].get_destinationVertex().get_id(),{ fileName : "Mesh.hx", lineNumber : 1404, className : "hxDaedalus.data.Mesh", methodName : "triangulate"});
			return;
		} else if(bound.length == 3) {
			var f = new hxDaedalus.data.Face();
			f.setDatas(bound[0],isReal);
			this._faces.push(f);
			bound[0].set_leftFace(f);
			bound[1].set_leftFace(f);
			bound[2].set_leftFace(f);
			bound[0].set_nextLeftEdge(bound[1]);
			bound[1].set_nextLeftEdge(bound[2]);
			bound[2].set_nextLeftEdge(bound[0]);
		} else {
			var baseEdge = bound[0];
			var vertexA = baseEdge.get_originVertex();
			var vertexB = baseEdge.get_destinationVertex();
			var vertexC;
			var vertexCheck;
			var circumcenter = new hxDaedalus.data.math.Point2D();
			var radiusSquared;
			var distanceSquared;
			var isDelaunay = false;
			var index = 0;
			var i;
			var _g1 = 2;
			var _g = bound.length;
			while(_g1 < _g) {
				var i1 = _g1++;
				vertexC = bound[i1].get_originVertex();
				if(hxDaedalus.data.math.Geom2D.getRelativePosition2(vertexC.get_pos().x,vertexC.get_pos().y,baseEdge) == 1) {
					index = i1;
					isDelaunay = true;
					hxDaedalus.data.math.Geom2D.getCircumcenter(vertexA.get_pos().x,vertexA.get_pos().y,vertexB.get_pos().x,vertexB.get_pos().y,vertexC.get_pos().x,vertexC.get_pos().y,circumcenter);
					radiusSquared = (vertexA.get_pos().x - circumcenter.x) * (vertexA.get_pos().x - circumcenter.x) + (vertexA.get_pos().y - circumcenter.y) * (vertexA.get_pos().y - circumcenter.y);
					radiusSquared -= 0.0001;
					var _g3 = 2;
					var _g2 = bound.length;
					while(_g3 < _g2) {
						var j = _g3++;
						if(j != i1) {
							vertexCheck = bound[j].get_originVertex();
							distanceSquared = (vertexCheck.get_pos().x - circumcenter.x) * (vertexCheck.get_pos().x - circumcenter.x) + (vertexCheck.get_pos().y - circumcenter.y) * (vertexCheck.get_pos().y - circumcenter.y);
							if(distanceSquared < radiusSquared) {
								isDelaunay = false;
								break;
							}
						}
					}
					if(isDelaunay) break;
				}
			}
			if(!isDelaunay) {
				haxe.Log.trace("NO DELAUNAY FOUND",{ fileName : "Mesh.hx", lineNumber : 1475, className : "hxDaedalus.data.Mesh", methodName : "triangulate"});
				var s = "";
				var _g11 = 0;
				var _g4 = bound.length;
				while(_g11 < _g4) {
					var i2 = _g11++;
					s += bound[i2].get_originVertex().get_pos().x + " , ";
					s += bound[i2].get_originVertex().get_pos().y + " , ";
					s += bound[i2].get_destinationVertex().get_pos().x + " , ";
					s += bound[i2].get_destinationVertex().get_pos().y + " , ";
				}
				index = 2;
			}
			var edgeA = null;
			var edgeAopp = null;
			var edgeB = null;
			var edgeBopp;
			var boundA;
			var boundM;
			var boundB;
			if(index < bound.length - 1) {
				edgeA = new hxDaedalus.data.Edge();
				edgeAopp = new hxDaedalus.data.Edge();
				this._edges.push(edgeA);
				this._edges.push(edgeAopp);
				edgeA.setDatas(vertexA,edgeAopp,null,null,isReal,false);
				edgeAopp.setDatas(bound[index].get_originVertex(),edgeA,null,null,isReal,false);
				boundA = bound.slice(index);
				boundA.push(edgeA);
				this.triangulate(boundA,isReal);
			}
			if(index > 2) {
				edgeB = new hxDaedalus.data.Edge();
				edgeBopp = new hxDaedalus.data.Edge();
				this._edges.push(edgeB);
				this._edges.push(edgeBopp);
				edgeB.setDatas(bound[1].get_originVertex(),edgeBopp,null,null,isReal,false);
				edgeBopp.setDatas(bound[index].get_originVertex(),edgeB,null,null,isReal,false);
				boundB = bound.slice(1,index);
				boundB.push(edgeBopp);
				this.triangulate(boundB,isReal);
			}
			if(index == 2) boundM = [baseEdge,bound[1],edgeAopp]; else if(index == bound.length - 1) boundM = [baseEdge,edgeB,bound[index]]; else boundM = [baseEdge,edgeB,edgeAopp];
			this.triangulate(boundM,isReal);
		}
	}
	,findPositionFromBounds: function(x,y) {
		if(x <= 0) {
			if(y <= 0) return 1; else if(y >= this._height) return 7; else return 8;
		} else if(x >= this._width) {
			if(y <= 0) return 3; else if(y >= this._height) return 5; else return 4;
		} else if(y <= 0) return 2; else if(y >= this._height) return 6; else return 0;
	}
	,debug: function() {
		var i;
		var _g1 = 0;
		var _g = this._vertices.length;
		while(_g1 < _g) {
			var i1 = _g1++;
			hxDaedalus.debug.Debug.trace("-- vertex " + this._vertices[i1].get_id(),{ fileName : "Mesh.hx", lineNumber : 1567, className : "hxDaedalus.data.Mesh", methodName : "debug"});
			hxDaedalus.debug.Debug.trace("  edge " + this._vertices[i1].get_edge().get_id() + " - " + Std.string(this._vertices[i1].get_edge()),{ fileName : "Mesh.hx", lineNumber : 1568, className : "hxDaedalus.data.Mesh", methodName : "debug"});
			hxDaedalus.debug.Debug.trace("  edge isReal: " + Std.string(this._vertices[i1].get_edge().get_isReal()),{ fileName : "Mesh.hx", lineNumber : 1569, className : "hxDaedalus.data.Mesh", methodName : "debug"});
		}
		var _g11 = 0;
		var _g2 = this._edges.length;
		while(_g11 < _g2) {
			var i2 = _g11++;
			hxDaedalus.debug.Debug.trace("-- edge " + Std.string(this._edges[i2]),{ fileName : "Mesh.hx", lineNumber : 1572, className : "hxDaedalus.data.Mesh", methodName : "debug"});
			hxDaedalus.debug.Debug.trace("  isReal " + this._edges[i2].get_id() + " - " + Std.string(this._edges[i2].get_isReal()),{ fileName : "Mesh.hx", lineNumber : 1573, className : "hxDaedalus.data.Mesh", methodName : "debug"});
			hxDaedalus.debug.Debug.trace("  nextLeftEdge " + Std.string(this._edges[i2].get_nextLeftEdge()),{ fileName : "Mesh.hx", lineNumber : 1574, className : "hxDaedalus.data.Mesh", methodName : "debug"});
			hxDaedalus.debug.Debug.trace("  oppositeEdge " + Std.string(this._edges[i2].get_oppositeEdge()),{ fileName : "Mesh.hx", lineNumber : 1575, className : "hxDaedalus.data.Mesh", methodName : "debug"});
		}
	}
};
hxDaedalus.data.Object = function() {
	this._id = hxDaedalus.data.Object.INC;
	hxDaedalus.data.Object.INC++;
	this._pivotX = 0;
	this._pivotY = 0;
	this._matrix = new hxDaedalus.data.math.Matrix2D();
	this._scaleX = 1;
	this._scaleY = 1;
	this._rotation = 0;
	this._x = 0;
	this._y = 0;
	this._coordinates = new Array();
	this._hasChanged = false;
};
hxDaedalus.data.Object.__name__ = true;
hxDaedalus.data.Object.prototype = {
	get_id: function() {
		return this._id;
	}
	,dispose: function() {
		this._matrix = null;
		this._coordinates = null;
		this._constraintShape = null;
	}
	,updateValuesFromMatrix: function() {
	}
	,updateMatrixFromValues: function() {
		this._matrix.identity();
		this._matrix.translate(-this._pivotX,-this._pivotY);
		this._matrix.scale(this._scaleX,this._scaleY);
		this._matrix.rotate(this._rotation);
		this._matrix.translate(this._x,this._y);
	}
	,get_pivotX: function() {
		return this._pivotX;
	}
	,set_pivotX: function(value) {
		this._pivotX = value;
		this._hasChanged = true;
		return value;
	}
	,get_pivotY: function() {
		return this._pivotY;
	}
	,set_pivotY: function(value) {
		this._pivotY = value;
		this._hasChanged = true;
		return value;
	}
	,get_scaleX: function() {
		return this._scaleX;
	}
	,set_scaleX: function(value) {
		if(this._scaleX != value) {
			this._scaleX = value;
			this._hasChanged = true;
		}
		return value;
	}
	,get_scaleY: function() {
		return this._scaleY;
	}
	,set_scaleY: function(value) {
		if(this._scaleY != value) {
			this._scaleY = value;
			this._hasChanged = true;
		}
		return value;
	}
	,get_rotation: function() {
		return this._rotation;
	}
	,set_rotation: function(value) {
		if(this._rotation != value) {
			this._rotation = value;
			this._hasChanged = true;
		}
		return value;
	}
	,get_x: function() {
		return this._x;
	}
	,set_x: function(value) {
		if(this._x != value) {
			this._x = value;
			this._hasChanged = true;
		}
		return value;
	}
	,get_y: function() {
		return this._y;
	}
	,set_y: function(value) {
		if(this._y != value) {
			this._y = value;
			this._hasChanged = true;
		}
		return value;
	}
	,get_matrix: function() {
		return this._matrix;
	}
	,set_matrix: function(value) {
		this._matrix = value;
		this._hasChanged = true;
		return value;
	}
	,get_coordinates: function() {
		return this._coordinates;
	}
	,set_coordinates: function(value) {
		this._coordinates = value;
		this._hasChanged = true;
		return value;
	}
	,get_constraintShape: function() {
		return this._constraintShape;
	}
	,set_constraintShape: function(value) {
		this._constraintShape = value;
		this._hasChanged = true;
		return value;
	}
	,get_hasChanged: function() {
		return this._hasChanged;
	}
	,set_hasChanged: function(value) {
		this._hasChanged = value;
		return value;
	}
	,get_edges: function() {
		var res = new Array();
		var seg = this._constraintShape.segments;
		var _g1 = 0;
		var _g = seg.length;
		while(_g1 < _g) {
			var i = _g1++;
			var _g3 = 0;
			var _g2 = seg[i].get_edges().length;
			while(_g3 < _g2) {
				var j = _g3++;
				res.push(seg[i].get_edges()[j]);
			}
		}
		return res;
	}
};
hxDaedalus.data.Vertex = function() {
	this.colorDebug = -1;
	this._id = hxDaedalus.data.Vertex.INC;
	hxDaedalus.data.Vertex.INC++;
	this._pos = new hxDaedalus.data.math.Point2D();
	this._fromConstraintSegments = new Array();
};
hxDaedalus.data.Vertex.__name__ = true;
hxDaedalus.data.Vertex.prototype = {
	get_id: function() {
		return this._id;
	}
	,get_isReal: function() {
		return this._isReal;
	}
	,get_pos: function() {
		return this._pos;
	}
	,get_fromConstraintSegments: function() {
		return this._fromConstraintSegments;
	}
	,set_fromConstraintSegments: function(value) {
		return this._fromConstraintSegments = value;
	}
	,setDatas: function(edge,isReal) {
		if(isReal == null) isReal = true;
		this._isReal = isReal;
		this._edge = edge;
	}
	,addFromConstraintSegment: function(segment) {
		if(HxOverrides.indexOf(this._fromConstraintSegments,segment,0) == -1) this._fromConstraintSegments.push(segment);
	}
	,removeFromConstraintSegment: function(segment) {
		var index = HxOverrides.indexOf(this._fromConstraintSegments,segment,0);
		if(index != -1) this._fromConstraintSegments.splice(index,1);
	}
	,dispose: function() {
		this._pos = null;
		this._edge = null;
		this._fromConstraintSegments = null;
	}
	,get_edge: function() {
		return this._edge;
	}
	,set_edge: function(value) {
		return this._edge = value;
	}
	,toString: function() {
		return "ver_id " + this._id;
	}
};
hxDaedalus.data.math = {};
hxDaedalus.data.math.Intersection = { __ename__ : true, __constructs__ : ["EVertex","EEdge","EFace","ENull"] };
hxDaedalus.data.math.Intersection.EVertex = function(vertex) { var $x = ["EVertex",0,vertex]; $x.__enum__ = hxDaedalus.data.math.Intersection; return $x; };
hxDaedalus.data.math.Intersection.EEdge = function(edge) { var $x = ["EEdge",1,edge]; $x.__enum__ = hxDaedalus.data.math.Intersection; return $x; };
hxDaedalus.data.math.Intersection.EFace = function(face) { var $x = ["EFace",2,face]; $x.__enum__ = hxDaedalus.data.math.Intersection; return $x; };
hxDaedalus.data.math.Intersection.ENull = ["ENull",3];
hxDaedalus.data.math.Intersection.ENull.__enum__ = hxDaedalus.data.math.Intersection;
hxDaedalus.data.math.Point2D = function(x_,y_) {
	if(y_ == null) y_ = 0;
	if(x_ == null) x_ = 0;
	this.x = x_;
	this.y = y_;
};
hxDaedalus.data.math.Point2D.__name__ = true;
hxDaedalus.data.math.Point2D.prototype = {
	transform: function(matrix) {
		matrix.tranform(this);
	}
	,setXY: function(x_,y_) {
		this.x = x_;
		this.y = y_;
	}
	,clone: function() {
		return new hxDaedalus.data.math.Point2D(this.x,this.y);
	}
	,substract: function(p) {
		this.x -= p.x;
		this.y -= p.y;
	}
	,get_length: function() {
		return Math.sqrt(this.x * this.x + this.y * this.y);
	}
	,normalize: function() {
		var norm = this.get_length();
		this.x = this.x / norm;
		this.y = this.y / norm;
	}
	,scale: function(s) {
		this.x = this.x * s;
		this.y = this.y * s;
	}
	,distanceTo: function(p) {
		var diffX = this.x - p.x;
		var diffY = this.y - p.y;
		return Math.sqrt(diffX * diffX + diffY * diffY);
	}
};
hxDaedalus.data.math.Geom2D = function() {
};
hxDaedalus.data.math.Geom2D.__name__ = true;
hxDaedalus.data.math.Geom2D.locatePosition = function(x,y,mesh) {
	if(hxDaedalus.data.math.Geom2D._randGen == null) hxDaedalus.data.math.Geom2D._randGen = new hxDaedalus.data.math.RandGenerator();
	hxDaedalus.data.math.Geom2D._randGen.set_seed(x * 10 + 4 * y | 0);
	var i;
	hxDaedalus.data.math.Geom2D.__samples.splice(0,hxDaedalus.data.math.Geom2D.__samples.length);
	var numSamples = Std["int"](Math.pow(mesh._vertices.length,0.33333333333333331));
	hxDaedalus.data.math.Geom2D._randGen.rangeMin = 0;
	hxDaedalus.data.math.Geom2D._randGen.rangeMax = mesh._vertices.length - 1;
	var _g = 0;
	while(_g < numSamples) {
		var i1 = _g++;
		var _rnd = hxDaedalus.data.math.Geom2D._randGen.next();
		hxDaedalus.debug.Debug.assertFalse(_rnd < 0 || _rnd > mesh._vertices.length - 1,"_rnd: " + _rnd,{ fileName : "Geom2D.hx", lineNumber : 67, className : "hxDaedalus.data.math.Geom2D", methodName : "locatePosition"});
		hxDaedalus.debug.Debug.assertFalse(mesh._vertices == null,"vertices: " + mesh._vertices.length,{ fileName : "Geom2D.hx", lineNumber : 68, className : "hxDaedalus.data.math.Geom2D", methodName : "locatePosition"});
		hxDaedalus.data.math.Geom2D.__samples.push(mesh._vertices[_rnd]);
	}
	var currVertex;
	var currVertexPos;
	var distSquared;
	var minDistSquared = Infinity;
	var closedVertex = null;
	var _g1 = 0;
	while(_g1 < numSamples) {
		var i2 = _g1++;
		currVertex = hxDaedalus.data.math.Geom2D.__samples[i2];
		currVertexPos = currVertex.get_pos();
		distSquared = (currVertexPos.x - x) * (currVertexPos.x - x) + (currVertexPos.y - y) * (currVertexPos.y - y);
		if(distSquared < minDistSquared) {
			minDistSquared = distSquared;
			closedVertex = currVertex;
		}
	}
	var currFace;
	var iterFace = new hxDaedalus.iterators.FromVertexToHoldingFaces();
	iterFace.set_fromVertex(closedVertex);
	currFace = iterFace.next();
	var faceVisited = new haxe.ds.ObjectMap();
	var currEdge;
	var iterEdge = new hxDaedalus.iterators.FromFaceToInnerEdges();
	var objectContainer = hxDaedalus.data.math.Intersection.ENull;
	var relativPos;
	var numIter = 0;
	while(faceVisited.h[currFace.__id__] || (function($this) {
		var $r;
		var _g2 = objectContainer = hxDaedalus.data.math.Geom2D.isInFace(x,y,currFace);
		$r = (function($this) {
			var $r;
			switch(_g2[1]) {
			case 3:
				$r = true;
				break;
			default:
				$r = false;
			}
			return $r;
		}($this));
		return $r;
	}(this))) {
		faceVisited.h[currFace.__id__];
		numIter++;
		if(numIter == 50) haxe.Log.trace("WALK TAKE MORE THAN 50 LOOP",{ fileName : "Geom2D.hx", lineNumber : 107, className : "hxDaedalus.data.math.Geom2D", methodName : "locatePosition"});
		iterEdge.set_fromFace(currFace);
		do {
			currEdge = iterEdge.next();
			if(currEdge == null) {
				haxe.Log.trace("KILL PATH",{ fileName : "Geom2D.hx", lineNumber : 115, className : "hxDaedalus.data.math.Geom2D", methodName : "locatePosition"});
				return hxDaedalus.data.math.Intersection.ENull;
			}
			relativPos = hxDaedalus.data.math.Geom2D.getRelativePosition(x,y,currEdge);
		} while(relativPos == 1 || relativPos == 0);
		currFace = currEdge.get_rightFace();
	}
	return objectContainer;
};
hxDaedalus.data.math.Geom2D.isCircleIntersectingAnyConstraint = function(x,y,radius,mesh) {
	if(x <= 0 || x >= mesh.get_width() || y <= 0 || y >= mesh.get_height()) return true;
	var loc = hxDaedalus.data.math.Geom2D.locatePosition(x,y,mesh);
	var face;
	switch(loc[1]) {
	case 0:
		var vertex = loc[2];
		face = vertex.get_edge().get_leftFace();
		break;
	case 1:
		var edge = loc[2];
		face = edge.get_leftFace();
		break;
	case 2:
		var face_ = loc[2];
		face = face_;
		break;
	case 3:
		face = null;
		break;
	}
	var radiusSquared = radius * radius;
	var pos;
	var distSquared;
	pos = face.get_edge().get_originVertex().get_pos();
	distSquared = (pos.x - x) * (pos.x - x) + (pos.y - y) * (pos.y - y);
	if(distSquared <= radiusSquared) return true;
	pos = face.get_edge().get_nextLeftEdge().get_originVertex().get_pos();
	distSquared = (pos.x - x) * (pos.x - x) + (pos.y - y) * (pos.y - y);
	if(distSquared <= radiusSquared) return true;
	pos = face.get_edge().get_nextLeftEdge().get_nextLeftEdge().get_originVertex().get_pos();
	distSquared = (pos.x - x) * (pos.x - x) + (pos.y - y) * (pos.y - y);
	if(distSquared <= radiusSquared) return true;
	var edgesToCheck = new Array();
	edgesToCheck.push(face.get_edge());
	edgesToCheck.push(face.get_edge().get_nextLeftEdge());
	edgesToCheck.push(face.get_edge().get_nextLeftEdge().get_nextLeftEdge());
	var edge1;
	var pos1;
	var pos2;
	var checkedEdges = new haxe.ds.ObjectMap();
	var intersecting;
	while(edgesToCheck.length > 0) {
		edge1 = edgesToCheck.pop();
		checkedEdges.set(edge1,true);
		true;
		pos1 = edge1.get_originVertex().get_pos();
		pos2 = edge1.get_destinationVertex().get_pos();
		intersecting = hxDaedalus.data.math.Geom2D.intersectionsSegmentCircle(pos1.x,pos1.y,pos2.x,pos2.y,x,y,radius);
		if(intersecting) {
			if(edge1.get_isConstrained()) return true; else {
				edge1 = edge1.get_oppositeEdge().get_nextLeftEdge();
				if(!checkedEdges.h[edge1.__id__] && !(function($this) {
					var $r;
					var key = edge1.get_oppositeEdge();
					$r = checkedEdges.h[key.__id__];
					return $r;
				}(this)) && HxOverrides.indexOf(edgesToCheck,edge1,0) == -1 && (function($this) {
					var $r;
					var x1 = edge1.get_oppositeEdge();
					$r = HxOverrides.indexOf(edgesToCheck,x1,0);
					return $r;
				}(this)) == -1) edgesToCheck.push(edge1);
				edge1 = edge1.get_nextLeftEdge();
				if(!checkedEdges.h[edge1.__id__] && !(function($this) {
					var $r;
					var key1 = edge1.get_oppositeEdge();
					$r = checkedEdges.h[key1.__id__];
					return $r;
				}(this)) && HxOverrides.indexOf(edgesToCheck,edge1,0) == -1 && (function($this) {
					var $r;
					var x2 = edge1.get_oppositeEdge();
					$r = HxOverrides.indexOf(edgesToCheck,x2,0);
					return $r;
				}(this)) == -1) edgesToCheck.push(edge1);
			}
		}
	}
	return false;
};
hxDaedalus.data.math.Geom2D.getDirection = function(x1,y1,x2,y2,x3,y3) {
	var dot = (x3 - x1) * (y2 - y1) + (y3 - y1) * (-x2 + x1);
	if(dot == 0) return 0; else if(dot > 0) return 1; else return -1;
};
hxDaedalus.data.math.Geom2D.getDirection2 = function(x1,y1,x2,y2,x3,y3) {
	var dot = (x3 - x1) * (y2 - y1) + (y3 - y1) * (-x2 + x1);
	if(dot == 0) return 0; else if(dot > 0) {
		if(hxDaedalus.data.math.Geom2D.distanceSquaredPointToLine(x3,y3,x1,y1,x2,y2) <= 0.0001) return 0; else return 1;
	} else if(hxDaedalus.data.math.Geom2D.distanceSquaredPointToLine(x3,y3,x1,y1,x2,y2) <= 0.0001) return 0; else return -1;
	return 0;
};
hxDaedalus.data.math.Geom2D.getRelativePosition = function(x,y,eUp) {
	return hxDaedalus.data.math.Geom2D.getDirection(eUp.get_originVertex().get_pos().x,eUp.get_originVertex().get_pos().y,eUp.get_destinationVertex().get_pos().x,eUp.get_destinationVertex().get_pos().y,x,y);
};
hxDaedalus.data.math.Geom2D.getRelativePosition2 = function(x,y,eUp) {
	return hxDaedalus.data.math.Geom2D.getDirection2(eUp.get_originVertex().get_pos().x,eUp.get_originVertex().get_pos().y,eUp.get_destinationVertex().get_pos().x,eUp.get_destinationVertex().get_pos().y,x,y);
};
hxDaedalus.data.math.Geom2D.isInFace = function(x,y,polygon) {
	var result = hxDaedalus.data.math.Intersection.ENull;
	var e1_2 = polygon.get_edge();
	var e2_3 = e1_2.get_nextLeftEdge();
	var e3_1 = e2_3.get_nextLeftEdge();
	if(hxDaedalus.data.math.Geom2D.getRelativePosition(x,y,e1_2) >= 0 && hxDaedalus.data.math.Geom2D.getRelativePosition(x,y,e2_3) >= 0 && hxDaedalus.data.math.Geom2D.getRelativePosition(x,y,e3_1) >= 0) {
		var v1 = e1_2.get_originVertex();
		var v2 = e2_3.get_originVertex();
		var v3 = e3_1.get_originVertex();
		var x1 = v1.get_pos().x;
		var y1 = v1.get_pos().y;
		var x2 = v2.get_pos().x;
		var y2 = v2.get_pos().y;
		var x3 = v3.get_pos().x;
		var y3 = v3.get_pos().y;
		var v_v1squaredLength = (x1 - x) * (x1 - x) + (y1 - y) * (y1 - y);
		var v_v2squaredLength = (x2 - x) * (x2 - x) + (y2 - y) * (y2 - y);
		var v_v3squaredLength = (x3 - x) * (x3 - x) + (y3 - y) * (y3 - y);
		var v1_v2squaredLength = (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1);
		var v2_v3squaredLength = (x3 - x2) * (x3 - x2) + (y3 - y2) * (y3 - y2);
		var v3_v1squaredLength = (x1 - x3) * (x1 - x3) + (y1 - y3) * (y1 - y3);
		var dot_v_v1v2 = (x - x1) * (x2 - x1) + (y - y1) * (y2 - y1);
		var dot_v_v2v3 = (x - x2) * (x3 - x2) + (y - y2) * (y3 - y2);
		var dot_v_v3v1 = (x - x3) * (x1 - x3) + (y - y3) * (y1 - y3);
		var v_e1_2squaredLength = v_v1squaredLength - dot_v_v1v2 * dot_v_v1v2 / v1_v2squaredLength;
		var v_e2_3squaredLength = v_v2squaredLength - dot_v_v2v3 * dot_v_v2v3 / v2_v3squaredLength;
		var v_e3_1squaredLength = v_v3squaredLength - dot_v_v3v1 * dot_v_v3v1 / v3_v1squaredLength;
		var closeTo_e1_2 = v_e1_2squaredLength <= 0.0001;
		var closeTo_e2_3 = v_e2_3squaredLength <= 0.0001;
		var closeTo_e3_1 = v_e3_1squaredLength <= 0.0001;
		if(closeTo_e1_2) {
			if(closeTo_e3_1) result = hxDaedalus.data.math.Intersection.EVertex(v1); else if(closeTo_e2_3) result = hxDaedalus.data.math.Intersection.EVertex(v2); else result = hxDaedalus.data.math.Intersection.EEdge(e1_2);
		} else if(closeTo_e2_3) {
			if(closeTo_e3_1) result = hxDaedalus.data.math.Intersection.EVertex(v3); else result = hxDaedalus.data.math.Intersection.EEdge(e2_3);
		} else if(closeTo_e3_1) result = hxDaedalus.data.math.Intersection.EEdge(e3_1); else result = hxDaedalus.data.math.Intersection.EFace(polygon);
	}
	return result;
};
hxDaedalus.data.math.Geom2D.clipSegmentByTriangle = function(s1x,s1y,s2x,s2y,t1x,t1y,t2x,t2y,t3x,t3y,pResult1,pResult2) {
	var side1_1;
	var side1_2;
	side1_1 = hxDaedalus.data.math.Geom2D.getDirection(t1x,t1y,t2x,t2y,s1x,s1y);
	side1_2 = hxDaedalus.data.math.Geom2D.getDirection(t1x,t1y,t2x,t2y,s2x,s2y);
	if(side1_1 <= 0 && side1_2 <= 0) return false;
	var side2_1;
	var side2_2;
	side2_1 = hxDaedalus.data.math.Geom2D.getDirection(t2x,t2y,t3x,t3y,s1x,s1y);
	side2_2 = hxDaedalus.data.math.Geom2D.getDirection(t2x,t2y,t3x,t3y,s2x,s2y);
	if(side2_1 <= 0 && side2_2 <= 0) return false;
	var side3_1;
	var side3_2;
	side3_1 = hxDaedalus.data.math.Geom2D.getDirection(t3x,t3y,t1x,t1y,s1x,s1y);
	side3_2 = hxDaedalus.data.math.Geom2D.getDirection(t3x,t3y,t1x,t1y,s2x,s2y);
	if(side3_1 <= 0 && side3_2 <= 0) return false;
	if(side1_1 >= 0 && side2_1 >= 0 && side3_1 >= 0 && (side1_2 >= 0 && side2_2 >= 0 && side3_2 >= 0)) {
		pResult1.x = s1x;
		pResult1.y = s1y;
		pResult2.x = s2x;
		pResult2.y = s2y;
		return true;
	}
	var n = 0;
	if(hxDaedalus.data.math.Geom2D.intersections2segments(s1x,s1y,s2x,s2y,t1x,t1y,t2x,t2y,pResult1,null)) n++;
	if(n == 0) {
		if(hxDaedalus.data.math.Geom2D.intersections2segments(s1x,s1y,s2x,s2y,t2x,t2y,t3x,t3y,pResult1,null)) n++;
	} else if(hxDaedalus.data.math.Geom2D.intersections2segments(s1x,s1y,s2x,s2y,t2x,t2y,t3x,t3y,pResult2,null)) {
		if(-0.01 > pResult1.x - pResult2.x || pResult1.x - pResult2.x > 0.01 || -0.01 > pResult1.y - pResult2.y || pResult1.y - pResult2.y > 0.01) n++;
	}
	if(n == 0) {
		if(hxDaedalus.data.math.Geom2D.intersections2segments(s1x,s1y,s2x,s2y,t3x,t3y,t1x,t1y,pResult1,null)) n++;
	} else if(n == 1) {
		if(hxDaedalus.data.math.Geom2D.intersections2segments(s1x,s1y,s2x,s2y,t3x,t3y,t1x,t1y,pResult2,null)) {
			if(-0.01 > pResult1.x - pResult2.x || pResult1.x - pResult2.x > 0.01 || -0.01 > pResult1.y - pResult2.y || pResult1.y - pResult2.y > 0.01) n++;
		}
	}
	if(n == 1) {
		if(side1_1 >= 0 && side2_1 >= 0 && side3_1 >= 0) {
			pResult2.x = s1x;
			pResult2.y = s1y;
		} else if(side1_2 >= 0 && side2_2 >= 0 && side3_2 >= 0) {
			pResult2.x = s2x;
			pResult2.y = s2y;
		} else n = 0;
	}
	if(n > 0) return true; else return false;
};
hxDaedalus.data.math.Geom2D.isSegmentIntersectingTriangle = function(s1x,s1y,s2x,s2y,t1x,t1y,t2x,t2y,t3x,t3y) {
	var side1_1;
	var side1_2;
	side1_1 = hxDaedalus.data.math.Geom2D.getDirection(t1x,t1y,t2x,t2y,s1x,s1y);
	side1_2 = hxDaedalus.data.math.Geom2D.getDirection(t1x,t1y,t2x,t2y,s2x,s2y);
	if(side1_1 <= 0 && side1_2 <= 0) return false;
	var side2_1;
	var side2_2;
	side2_1 = hxDaedalus.data.math.Geom2D.getDirection(t2x,t2y,t3x,t3y,s1x,s1y);
	side2_2 = hxDaedalus.data.math.Geom2D.getDirection(t2x,t2y,t3x,t3y,s2x,s2y);
	if(side2_1 <= 0 && side2_2 <= 0) return false;
	var side3_1;
	var side3_2;
	side3_1 = hxDaedalus.data.math.Geom2D.getDirection(t3x,t3y,t1x,t1y,s1x,s1y);
	side3_2 = hxDaedalus.data.math.Geom2D.getDirection(t3x,t3y,t1x,t1y,s2x,s2y);
	if(side3_1 <= 0 && side3_2 <= 0) return false;
	if(side1_1 == 1 && side2_1 == 1 && side3_1 == 1) return true;
	if(side1_1 == 1 && side2_1 == 1 && side3_1 == 1) return true;
	var side1;
	var side2;
	if(side1_1 == 1 && side1_2 <= 0 || side1_1 <= 0 && side1_2 == 1) {
		side1 = hxDaedalus.data.math.Geom2D.getDirection(s1x,s1y,s2x,s2y,t1x,t1y);
		side2 = hxDaedalus.data.math.Geom2D.getDirection(s1x,s1y,s2x,s2y,t2x,t2y);
		if(side1 == 1 && side2 <= 0 || side1 <= 0 && side2 == 1) return true;
	}
	if(side2_1 == 1 && side2_2 <= 0 || side2_1 <= 0 && side2_2 == 1) {
		side1 = hxDaedalus.data.math.Geom2D.getDirection(s1x,s1y,s2x,s2y,t2x,t2y);
		side2 = hxDaedalus.data.math.Geom2D.getDirection(s1x,s1y,s2x,s2y,t3x,t3y);
		if(side1 == 1 && side2 <= 0 || side1 <= 0 && side2 == 1) return true;
	}
	if(side3_1 == 1 && side3_2 <= 0 || side3_1 <= 0 && side3_2 == 1) {
		side1 = hxDaedalus.data.math.Geom2D.getDirection(s1x,s1y,s2x,s2y,t3x,t3y);
		side2 = hxDaedalus.data.math.Geom2D.getDirection(s1x,s1y,s2x,s2y,t1x,t1y);
		if(side1 == 1 && side2 <= 0 || side1 <= 0 && side2 == 1) return true;
	}
	return false;
};
hxDaedalus.data.math.Geom2D.isDelaunay = function(edge) {
	var vLeft = edge.get_originVertex();
	var vRight = edge.get_destinationVertex();
	var vCorner = edge.get_nextLeftEdge().get_destinationVertex();
	var vOpposite = edge.get_nextRightEdge().get_destinationVertex();
	hxDaedalus.data.math.Geom2D.getCircumcenter(vCorner.get_pos().x,vCorner.get_pos().y,vLeft.get_pos().x,vLeft.get_pos().y,vRight.get_pos().x,vRight.get_pos().y,hxDaedalus.data.math.Geom2D.__circumcenter);
	var squaredRadius = (vCorner.get_pos().x - hxDaedalus.data.math.Geom2D.__circumcenter.x) * (vCorner.get_pos().x - hxDaedalus.data.math.Geom2D.__circumcenter.x) + (vCorner.get_pos().y - hxDaedalus.data.math.Geom2D.__circumcenter.y) * (vCorner.get_pos().y - hxDaedalus.data.math.Geom2D.__circumcenter.y);
	var squaredDistance = (vOpposite.get_pos().x - hxDaedalus.data.math.Geom2D.__circumcenter.x) * (vOpposite.get_pos().x - hxDaedalus.data.math.Geom2D.__circumcenter.x) + (vOpposite.get_pos().y - hxDaedalus.data.math.Geom2D.__circumcenter.y) * (vOpposite.get_pos().y - hxDaedalus.data.math.Geom2D.__circumcenter.y);
	return squaredDistance >= squaredRadius;
};
hxDaedalus.data.math.Geom2D.getCircumcenter = function(x1,y1,x2,y2,x3,y3,result) {
	if(result == null) result = new hxDaedalus.data.math.Point2D();
	var m1 = (x1 + x2) / 2;
	var m2 = (y1 + y2) / 2;
	var m3 = (x1 + x3) / 2;
	var m4 = (y1 + y3) / 2;
	var t1 = (m1 * (x1 - x3) + (m2 - m4) * (y1 - y3) + m3 * (x3 - x1)) / (x1 * (y3 - y2) + x2 * (y1 - y3) + x3 * (y2 - y1));
	result.x = m1 + t1 * (y2 - y1);
	result.y = m2 - t1 * (x2 - x1);
	return result;
};
hxDaedalus.data.math.Geom2D.intersections2segments = function(s1p1x,s1p1y,s1p2x,s1p2y,s2p1x,s2p1y,s2p2x,s2p2y,posIntersection,paramIntersection,infiniteLineMode) {
	if(infiniteLineMode == null) infiniteLineMode = false;
	var t1 = 0;
	var t2 = 0;
	var result;
	var divisor = (s1p1x - s1p2x) * (s2p1y - s2p2y) + (s1p2y - s1p1y) * (s2p1x - s2p2x);
	if(divisor == 0) result = false; else {
		result = true;
		if(!infiniteLineMode || posIntersection != null || paramIntersection != null) {
			t1 = (s1p1x * (s2p1y - s2p2y) + s1p1y * (s2p2x - s2p1x) + s2p1x * s2p2y - s2p1y * s2p2x) / divisor;
			t2 = (s1p1x * (s2p1y - s1p2y) + s1p1y * (s1p2x - s2p1x) - s1p2x * s2p1y + s1p2y * s2p1x) / divisor;
			if(!infiniteLineMode && !(0 <= t1 && t1 <= 1 && 0 <= t2 && t2 <= 1)) result = false;
		}
	}
	if(result) {
		if(posIntersection != null) {
			posIntersection.x = s1p1x + t1 * (s1p2x - s1p1x);
			posIntersection.y = s1p1y + t1 * (s1p2y - s1p1y);
		}
		if(paramIntersection != null) {
			paramIntersection.push(t1);
			paramIntersection.push(t2);
		}
	}
	return result;
};
hxDaedalus.data.math.Geom2D.intersections2edges = function(edge1,edge2,posIntersection,paramIntersection,infiniteLineMode) {
	if(infiniteLineMode == null) infiniteLineMode = false;
	return hxDaedalus.data.math.Geom2D.intersections2segments(edge1.get_originVertex().get_pos().x,edge1.get_originVertex().get_pos().y,edge1.get_destinationVertex().get_pos().x,edge1.get_destinationVertex().get_pos().y,edge2.get_originVertex().get_pos().x,edge2.get_originVertex().get_pos().y,edge2.get_destinationVertex().get_pos().x,edge2.get_destinationVertex().get_pos().y,posIntersection,paramIntersection,infiniteLineMode);
};
hxDaedalus.data.math.Geom2D.isConvex = function(edge) {
	var result = true;
	var eLeft;
	var vRight;
	eLeft = edge.get_nextLeftEdge().get_oppositeEdge();
	vRight = edge.get_nextRightEdge().get_destinationVertex();
	if(hxDaedalus.data.math.Geom2D.getRelativePosition(vRight.get_pos().x,vRight.get_pos().y,eLeft) != -1) result = false; else {
		eLeft = edge.get_prevRightEdge();
		vRight = edge.get_prevLeftEdge().get_originVertex();
		if(hxDaedalus.data.math.Geom2D.getRelativePosition(vRight.get_pos().x,vRight.get_pos().y,eLeft) != -1) result = false;
	}
	return result;
};
hxDaedalus.data.math.Geom2D.projectOrthogonaly = function(vertexPos,edge) {
	var a = edge.get_originVertex().get_pos().x;
	var b = edge.get_originVertex().get_pos().y;
	var c = edge.get_destinationVertex().get_pos().x;
	var d = edge.get_destinationVertex().get_pos().y;
	var e = vertexPos.x;
	var f = vertexPos.y;
	var t1 = (a * a - a * c - a * e + b * b - b * d - b * f + c * e + d * f) / (a * a - 2 * a * c + b * b - 2 * b * d + c * c + d * d);
	vertexPos.x = a + t1 * (c - a);
	vertexPos.y = b + t1 * (d - b);
};
hxDaedalus.data.math.Geom2D.intersections2Circles = function(cx1,cy1,r1,cx2,cy2,r2,result) {
	var distRadiusSQRD = (cx2 - cx1) * (cx2 - cx1) + (cy2 - cy1) * (cy2 - cy1);
	if((cx1 != cx2 || cy1 != cy2) && distRadiusSQRD <= (r1 + r2) * (r1 + r2) && distRadiusSQRD >= (r1 - r2) * (r1 - r2)) {
		var transcendPart = Math.sqrt(((r1 + r2) * (r1 + r2) - distRadiusSQRD) * (distRadiusSQRD - (r2 - r1) * (r2 - r1)));
		var xFirstPart = (cx1 + cx2) / 2 + (cx2 - cx1) * (r1 * r1 - r2 * r2) / (2 * distRadiusSQRD);
		var yFirstPart = (cy1 + cy2) / 2 + (cy2 - cy1) * (r1 * r1 - r2 * r2) / (2 * distRadiusSQRD);
		var xFactor = (cy2 - cy1) / (2 * distRadiusSQRD);
		var yFactor = (cx2 - cx1) / (2 * distRadiusSQRD);
		if(result != null) {
			var _g = 0;
			var _g1 = [xFirstPart + xFactor * transcendPart,yFirstPart - yFactor * transcendPart,xFirstPart - xFactor * transcendPart,yFirstPart + yFactor * transcendPart];
			while(_g < _g1.length) {
				var f = _g1[_g];
				++_g;
				result.push(f);
			}
		}
		return true;
	} else return false;
};
hxDaedalus.data.math.Geom2D.intersectionsSegmentCircle = function(p0x,p0y,p1x,p1y,cx,cy,r,result) {
	var p0xSQD = p0x * p0x;
	var p0ySQD = p0y * p0y;
	var a = p1y * p1y - 2 * p1y * p0y + p0ySQD + p1x * p1x - 2 * p1x * p0x + p0xSQD;
	var b = 2 * p0y * cy - 2 * p0xSQD + 2 * p1y * p0y - 2 * p0ySQD + 2 * p1x * p0x - 2 * p1x * cx + 2 * p0x * cx - 2 * p1y * cy;
	var c = p0ySQD + cy * cy + cx * cx - 2 * p0y * cy - 2 * p0x * cx + p0xSQD - r * r;
	var delta = b * b - 4 * a * c;
	var deltaSQRT;
	var t0;
	var t1;
	if(delta < 0) return false; else if(delta == 0) {
		t0 = -b / (2 * a);
		if(t0 < 0 || t0 > 1) return false;
		if(result != null) {
			var _g = 0;
			var _g1 = [p0x + t0 * (p1x - p0x),p0y + t0 * (p1y - p0y),t0];
			while(_g < _g1.length) {
				var f = _g1[_g];
				++_g;
				result.push(f);
			}
		}
		return true;
	} else {
		deltaSQRT = Math.sqrt(delta);
		t0 = (-b + deltaSQRT) / (2 * a);
		t1 = (-b - deltaSQRT) / (2 * a);
		var intersecting = false;
		if(0 <= t0 && t0 <= 1) {
			if(result != null) {
				var _g2 = 0;
				var _g11 = [p0x + t0 * (p1x - p0x),p0y + t0 * (p1y - p0y),t0];
				while(_g2 < _g11.length) {
					var f1 = _g11[_g2];
					++_g2;
					result.push(f1);
				}
			}
			intersecting = true;
		}
		if(0 <= t1 && t1 <= 1) {
			if(result != null) {
				var _g3 = 0;
				var _g12 = [p0x + t1 * (p1x - p0x),p0y + t1 * (p1y - p0y),t1];
				while(_g3 < _g12.length) {
					var f2 = _g12[_g3];
					++_g3;
					result.push(f2);
				}
			}
			intersecting = true;
		}
		return intersecting;
	}
};
hxDaedalus.data.math.Geom2D.intersectionsLineCircle = function(p0x,p0y,p1x,p1y,cx,cy,r,result) {
	var p0xSQD = p0x * p0x;
	var p0ySQD = p0y * p0y;
	var a = p1y * p1y - 2 * p1y * p0y + p0ySQD + p1x * p1x - 2 * p1x * p0x + p0xSQD;
	var b = 2 * p0y * cy - 2 * p0xSQD + 2 * p1y * p0y - 2 * p0ySQD + 2 * p1x * p0x - 2 * p1x * cx + 2 * p0x * cx - 2 * p1y * cy;
	var c = p0ySQD + cy * cy + cx * cx - 2 * p0y * cy - 2 * p0x * cx + p0xSQD - r * r;
	var delta = b * b - 4 * a * c;
	var deltaSQRT;
	var t0;
	var t1;
	if(delta < 0) return false; else if(delta == 0) {
		t0 = -b / (2 * a);
		var _g = 0;
		var _g1 = [p0x + t0 * (p1x - p0x),p0y + t0 * (p1y - p0y),t0];
		while(_g < _g1.length) {
			var f = _g1[_g];
			++_g;
			result.push(f);
		}
	} else if(delta > 0) {
		deltaSQRT = Math.sqrt(delta);
		t0 = (-b + deltaSQRT) / (2 * a);
		t1 = (-b - deltaSQRT) / (2 * a);
		var _g2 = 0;
		var _g11 = [p0x + t0 * (p1x - p0x),p0y + t0 * (p1y - p0y),t0,p0x + t1 * (p1x - p0x),p0y + t1 * (p1y - p0y),t1];
		while(_g2 < _g11.length) {
			var f1 = _g11[_g2];
			++_g2;
			result.push(f1);
		}
	}
	return true;
};
hxDaedalus.data.math.Geom2D.tangentsPointToCircle = function(px,py,cx,cy,r,result) {
	var c2x = (px + cx) / 2;
	var c2y = (py + cy) / 2;
	var r2 = 0.5 * Math.sqrt((px - cx) * (px - cx) + (py - cy) * (py - cy));
	return hxDaedalus.data.math.Geom2D.intersections2Circles(c2x,c2y,r2,cx,cy,r,result);
};
hxDaedalus.data.math.Geom2D.tangentsCrossCircleToCircle = function(r,c1x,c1y,c2x,c2y,result) {
	var distance = Math.sqrt((c1x - c2x) * (c1x - c2x) + (c1y - c2y) * (c1y - c2y));
	var radius = distance / 4;
	var centerX = c1x + (c2x - c1x) / 4;
	var centerY = c1y + (c2y - c1y) / 4;
	if(hxDaedalus.data.math.Geom2D.intersections2Circles(c1x,c1y,r,centerX,centerY,radius,result)) {
		var t1x = result[0];
		var t1y = result[1];
		var t2x = result[2];
		var t2y = result[3];
		var midX = (c1x + c2x) / 2;
		var midY = (c1y + c2y) / 2;
		var dotProd = (t1x - midX) * (c2y - c1y) + (t1y - midY) * (-c2x + c1x);
		var tproj = dotProd / (distance * distance);
		var projx = midX + tproj * (c2y - c1y);
		var projy = midY - tproj * (c2x - c1x);
		var t4x = 2 * projx - t1x;
		var t4y = 2 * projy - t1y;
		var t3x = t4x + t2x - t1x;
		var t3y = t2y + t4y - t1y;
		var _g = 0;
		var _g1 = [t3x,t3y,t4x,t4y];
		while(_g < _g1.length) {
			var f = _g1[_g];
			++_g;
			result.push(f);
		}
		return true;
	} else return false;
};
hxDaedalus.data.math.Geom2D.tangentsParalCircleToCircle = function(r,c1x,c1y,c2x,c2y,result) {
	var distance = Math.sqrt((c1x - c2x) * (c1x - c2x) + (c1y - c2y) * (c1y - c2y));
	var t1x = c1x + r * (c2y - c1y) / distance;
	var t1y = c1y + r * (-c2x + c1x) / distance;
	var t2x = 2 * c1x - t1x;
	var t2y = 2 * c1y - t1y;
	var t3x = t2x + c2x - c1x;
	var t3y = t2y + c2y - c1y;
	var t4x = t1x + c2x - c1x;
	var t4y = t1y + c2y - c1y;
	var _g = 0;
	var _g1 = [t1x,t1y,t2x,t2y,t3x,t3y,t4x,t4y];
	while(_g < _g1.length) {
		var f = _g1[_g];
		++_g;
		result.push(f);
	}
};
hxDaedalus.data.math.Geom2D.distanceSquaredPointToLine = function(px,py,ax,ay,bx,by) {
	var a_b_squaredLength = (bx - ax) * (bx - ax) + (by - ay) * (by - ay);
	var dotProduct = (px - ax) * (bx - ax) + (py - ay) * (by - ay);
	var p_a_squaredLength = (ax - px) * (ax - px) + (ay - py) * (ay - py);
	return p_a_squaredLength - dotProduct * dotProduct / a_b_squaredLength;
};
hxDaedalus.data.math.Geom2D.distanceSquaredPointToSegment = function(px,py,ax,ay,bx,by) {
	var a_b_squaredLength = (bx - ax) * (bx - ax) + (by - ay) * (by - ay);
	var dotProduct = ((px - ax) * (bx - ax) + (py - ay) * (by - ay)) / a_b_squaredLength;
	if(dotProduct < 0) return (px - ax) * (px - ax) + (py - ay) * (py - ay); else if(dotProduct <= 1) {
		var p_a_squaredLength = (ax - px) * (ax - px) + (ay - py) * (ay - py);
		return p_a_squaredLength - dotProduct * dotProduct * a_b_squaredLength;
	} else return (px - bx) * (px - bx) + (py - by) * (py - by);
};
hxDaedalus.data.math.Geom2D.distanceSquaredVertexToEdge = function(vertex,edge) {
	return hxDaedalus.data.math.Geom2D.distanceSquaredPointToSegment(vertex.get_pos().x,vertex.get_pos().y,edge.get_originVertex().get_pos().x,edge.get_originVertex().get_pos().y,edge.get_destinationVertex().get_pos().x,edge.get_destinationVertex().get_pos().y);
};
hxDaedalus.data.math.Geom2D.pathLength = function(path) {
	var sumDistance = 0.;
	var fromX = path[0];
	var fromY = path[1];
	var nextX;
	var nextY;
	var x;
	var y;
	var distance;
	var i = 2;
	while(i < path.length) {
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
};
hxDaedalus.data.math.Matrix2D = function(a_,b_,c_,d_,e_,f_) {
	if(f_ == null) f_ = 0;
	if(e_ == null) e_ = 0;
	if(d_ == null) d_ = 1;
	if(c_ == null) c_ = 0;
	if(b_ == null) b_ = 0;
	if(a_ == null) a_ = 1;
	this.a = a_;
	this.b = b_;
	this.c = c_;
	this.d = d_;
	this.e = e_;
	this.f = f_;
};
hxDaedalus.data.math.Matrix2D.__name__ = true;
hxDaedalus.data.math.Matrix2D.prototype = {
	identity: function() {
		this.a = 1;
		this.b = 0;
		this.c = 0;
		this.d = 1;
		this.e = 0;
		this.f = 0;
	}
	,translate: function(tx,ty) {
		this.e = this.e + tx;
		this.f = this.f + ty;
	}
	,scale: function(sx,sy) {
		this.a = this.a * sx;
		this.b = this.b * sy;
		this.c = this.c * sx;
		this.d = this.d * sy;
		this.e = this.e * sx;
		this.f = this.f * sy;
	}
	,rotate: function(rad) {
		var cos = Math.cos(rad);
		var sin = Math.sin(rad);
		var a_ = this.a * cos + this.b * -sin;
		var b_ = this.a * sin + this.b * cos;
		var c_ = this.c * cos + this.d * -sin;
		var d_ = this.c * sin + this.d * cos;
		var e_ = this.e * cos + this.f * -sin;
		var f_ = this.e * sin + this.f * cos;
		this.a = a_;
		this.b = b_;
		this.c = c_;
		this.d = d_;
		this.e = e_;
		this.f = f_;
	}
	,clone: function() {
		return new hxDaedalus.data.math.Matrix2D(this.a,this.b,this.c,this.d,this.e,this.f);
	}
	,tranform: function(point) {
		var x = this.a * point.x + this.c * point.y + this.e;
		var y = this.b * point.x + this.d * point.y + this.f;
		point.x = x;
		point.y = y;
	}
	,transformX: function(x,y) {
		return this.a * x + this.c * y + this.e;
	}
	,transformY: function(x,y) {
		return this.b * x + this.d * y + this.f;
	}
	,concat: function(matrix) {
		var a_ = this.a * matrix.a + this.b * matrix.c;
		var b_ = this.a * matrix.b + this.b * matrix.d;
		var c_ = this.c * matrix.a + this.d * matrix.c;
		var d_ = this.c * matrix.b + this.d * matrix.d;
		var e_ = this.e * matrix.a + this.f * matrix.c + matrix.e;
		var f_ = this.e * matrix.b + this.f * matrix.d + matrix.f;
		this.a = a_;
		this.b = b_;
		this.c = c_;
		this.d = d_;
		this.e = e_;
		this.f = f_;
	}
};
hxDaedalus.data.math.RandGenerator = function(seed,rangeMin_,rangeMax_) {
	if(rangeMax_ == null) rangeMax_ = 1;
	if(rangeMin_ == null) rangeMin_ = 0;
	if(seed == null) seed = 1234;
	this._originalSeed = this._currSeed = seed;
	this.rangeMin = rangeMin_;
	this.rangeMax = rangeMax_;
	this._numIter = 0;
};
hxDaedalus.data.math.RandGenerator.__name__ = true;
hxDaedalus.data.math.RandGenerator.prototype = {
	set_seed: function(value) {
		this._originalSeed = this._currSeed = value;
		return value;
	}
	,get_seed: function() {
		return this._originalSeed;
	}
	,reset: function() {
		this._currSeed = this._originalSeed;
		this._numIter = 0;
	}
	,next: function() {
		var _floatSeed = this._currSeed * 1.0;
		this._tempString = Std.string(_floatSeed * _floatSeed);
		while(this._tempString.length < 8) this._tempString = "0" + this._tempString;
		this._currSeed = Std.parseInt(HxOverrides.substr(this._tempString,1,5));
		var res = Math.round(this.rangeMin + this._currSeed / 99999 * (this.rangeMax - this.rangeMin));
		if(this._currSeed == 0) this._currSeed = this._originalSeed + this._numIter;
		this._numIter++;
		if(this._numIter == 200) this.reset();
		return res;
	}
};
hxDaedalus.debug = {};
hxDaedalus.debug.Debug = function() { };
hxDaedalus.debug.Debug.__name__ = true;
hxDaedalus.debug.Debug.assertTrue = function(cond,message,pos) {
	if(!cond) throw pos.fileName + ":" + pos.lineNumber + ": Expected true but was false! " + (message != null?message:"");
};
hxDaedalus.debug.Debug.assertFalse = function(cond,message,pos) {
	if(cond) throw pos.fileName + ":" + pos.lineNumber + ": Expected false but was true! " + (message != null?message:"");
};
hxDaedalus.debug.Debug.assertEquals = function(expected,actual,message,pos) {
	if(actual != expected) throw pos.fileName + ":" + pos.lineNumber + ": Expected '" + Std.string(expected) + "' but was '" + Std.string(actual) + "' " + (message != null?message:"");
};
hxDaedalus.debug.Debug.trace = function(value,pos) {
	haxe.Log.trace(value,pos);
};
hxDaedalus.factories = {};
hxDaedalus.factories.RectMesh = function() {
};
hxDaedalus.factories.RectMesh.__name__ = true;
hxDaedalus.factories.RectMesh.buildRectangle = function(width,height) {
	var vTL = new hxDaedalus.data.Vertex();
	var vTR = new hxDaedalus.data.Vertex();
	var vBR = new hxDaedalus.data.Vertex();
	var vBL = new hxDaedalus.data.Vertex();
	var eTL_TR = new hxDaedalus.data.Edge();
	var eTR_TL = new hxDaedalus.data.Edge();
	var eTR_BR = new hxDaedalus.data.Edge();
	var eBR_TR = new hxDaedalus.data.Edge();
	var eBR_BL = new hxDaedalus.data.Edge();
	var eBL_BR = new hxDaedalus.data.Edge();
	var eBL_TL = new hxDaedalus.data.Edge();
	var eTL_BL = new hxDaedalus.data.Edge();
	var eTR_BL = new hxDaedalus.data.Edge();
	var eBL_TR = new hxDaedalus.data.Edge();
	var eTL_BR = new hxDaedalus.data.Edge();
	var eBR_TL = new hxDaedalus.data.Edge();
	var fTL_BL_TR = new hxDaedalus.data.Face();
	var fTR_BL_BR = new hxDaedalus.data.Face();
	var fTL_BR_BL = new hxDaedalus.data.Face();
	var fTL_TR_BR = new hxDaedalus.data.Face();
	var boundShape = new hxDaedalus.data.ConstraintShape();
	var segTop = new hxDaedalus.data.ConstraintSegment();
	var segRight = new hxDaedalus.data.ConstraintSegment();
	var segBot = new hxDaedalus.data.ConstraintSegment();
	var segLeft = new hxDaedalus.data.ConstraintSegment();
	var mesh = new hxDaedalus.data.Mesh(width,height);
	var offset = 10.;
	vTL.get_pos().setXY(0 - offset,0 - offset);
	vTR.get_pos().setXY(width + offset,0 - offset);
	vBR.get_pos().setXY(width + offset,height + offset);
	vBL.get_pos().setXY(0 - offset,height + offset);
	vTL.setDatas(eTL_TR);
	vTR.setDatas(eTR_BR);
	vBR.setDatas(eBR_BL);
	vBL.setDatas(eBL_TL);
	eTL_TR.setDatas(vTL,eTR_TL,eTR_BR,fTL_TR_BR,true,true);
	eTR_TL.setDatas(vTR,eTL_TR,eTL_BL,fTL_BL_TR,true,true);
	eTR_BR.setDatas(vTR,eBR_TR,eBR_TL,fTL_TR_BR,true,true);
	eBR_TR.setDatas(vBR,eTR_BR,eTR_BL,fTR_BL_BR,true,true);
	eBR_BL.setDatas(vBR,eBL_BR,eBL_TL,fTL_BR_BL,true,true);
	eBL_BR.setDatas(vBL,eBR_BL,eBR_TR,fTR_BL_BR,true,true);
	eBL_TL.setDatas(vBL,eTL_BL,eTL_BR,fTL_BR_BL,true,true);
	eTL_BL.setDatas(vTL,eBL_TL,eBL_TR,fTL_BL_TR,true,true);
	eTR_BL.setDatas(vTR,eBL_TR,eBL_BR,fTR_BL_BR,true,false);
	eBL_TR.setDatas(vBL,eTR_BL,eTR_TL,fTL_BL_TR,true,false);
	eTL_BR.setDatas(vTL,eBR_TL,eBR_BL,fTL_BR_BL,false,false);
	eBR_TL.setDatas(vBR,eTL_BR,eTL_TR,fTL_TR_BR,false,false);
	fTL_BL_TR.setDatas(eBL_TR);
	fTR_BL_BR.setDatas(eTR_BL);
	fTL_BR_BL.setDatas(eBR_BL,false);
	fTL_TR_BR.setDatas(eTR_BR,false);
	vTL.set_fromConstraintSegments([segTop,segLeft]);
	vTR.set_fromConstraintSegments([segTop,segRight]);
	vBR.set_fromConstraintSegments([segRight,segBot]);
	vBL.set_fromConstraintSegments([segBot,segLeft]);
	eTL_TR.fromConstraintSegments.push(segTop);
	eTR_TL.fromConstraintSegments.push(segTop);
	eTR_BR.fromConstraintSegments.push(segRight);
	eBR_TR.fromConstraintSegments.push(segRight);
	eBR_BL.fromConstraintSegments.push(segBot);
	eBL_BR.fromConstraintSegments.push(segBot);
	eBL_TL.fromConstraintSegments.push(segLeft);
	eTL_BL.fromConstraintSegments.push(segLeft);
	segTop.get_edges().push(eTL_TR);
	segRight.get_edges().push(eTR_BR);
	segBot.get_edges().push(eBR_BL);
	segLeft.get_edges().push(eBL_TL);
	segTop.fromShape = boundShape;
	segRight.fromShape = boundShape;
	segBot.fromShape = boundShape;
	segLeft.fromShape = boundShape;
	var _g = 0;
	var _g1 = [segTop,segRight,segBot,segLeft];
	while(_g < _g1.length) {
		var f = _g1[_g];
		++_g;
		boundShape.segments.push(f);
	}
	var _g2 = 0;
	var _g11 = [vTL,vTR,vBR,vBL];
	while(_g2 < _g11.length) {
		var f1 = _g11[_g2];
		++_g2;
		mesh._vertices.push(f1);
	}
	var _g3 = 0;
	var _g12 = [eTL_TR,eTR_TL,eTR_BR,eBR_TR,eBR_BL,eBL_BR,eBL_TL,eTL_BL,eTR_BL,eBL_TR,eTL_BR,eBR_TL];
	while(_g3 < _g12.length) {
		var f2 = _g12[_g3];
		++_g3;
		mesh._edges.push(f2);
	}
	var _g4 = 0;
	var _g13 = [fTL_BL_TR,fTR_BL_BR,fTL_BR_BL,fTL_TR_BR];
	while(_g4 < _g13.length) {
		var f3 = _g13[_g4];
		++_g4;
		mesh._faces.push(f3);
	}
	mesh.get___constraintShapes().push(boundShape);
	var securityRect = new Array();
	var _g5 = 0;
	var _g14 = [0,0,width,0];
	while(_g5 < _g14.length) {
		var f4 = _g14[_g5];
		++_g5;
		securityRect.push(f4);
	}
	var _g6 = 0;
	var _g15 = [width,0,width,height];
	while(_g6 < _g15.length) {
		var f5 = _g15[_g6];
		++_g6;
		securityRect.push(f5);
	}
	var _g7 = 0;
	var _g16 = [width,height,0,height];
	while(_g7 < _g16.length) {
		var f6 = _g16[_g7];
		++_g7;
		securityRect.push(f6);
	}
	var _g8 = 0;
	var _g17 = [0,height,0,0];
	while(_g8 < _g17.length) {
		var f7 = _g17[_g8];
		++_g8;
		securityRect.push(f7);
	}
	mesh.set_clipping(false);
	mesh.insertConstraintShape(securityRect);
	mesh.set_clipping(true);
	return mesh;
};
hxDaedalus.iterators = {};
hxDaedalus.iterators.FromFaceToInnerEdges = function() {
};
hxDaedalus.iterators.FromFaceToInnerEdges.__name__ = true;
hxDaedalus.iterators.FromFaceToInnerEdges.prototype = {
	set_fromFace: function(value) {
		this._fromFace = value;
		this._nextEdge = this._fromFace.get_edge();
		return value;
	}
	,next: function() {
		if(this._nextEdge != null) {
			this._resultEdge = this._nextEdge;
			this._nextEdge = this._nextEdge.get_nextLeftEdge();
			if(this._nextEdge == this._fromFace.get_edge()) this._nextEdge = null;
		} else this._resultEdge = null;
		return this._resultEdge;
	}
};
hxDaedalus.iterators.FromMeshToVertices = function() {
};
hxDaedalus.iterators.FromMeshToVertices.__name__ = true;
hxDaedalus.iterators.FromMeshToVertices.prototype = {
	set_fromMesh: function(value) {
		this._fromMesh = value;
		this._currIndex = 0;
		return value;
	}
	,next: function() {
		do if(this._currIndex < this._fromMesh._vertices.length) {
			this._resultVertex = this._fromMesh._vertices[this._currIndex];
			this._currIndex++;
		} else {
			this._resultVertex = null;
			break;
		} while(!this._resultVertex.get_isReal());
		return this._resultVertex;
	}
};
hxDaedalus.iterators.FromVertexToHoldingFaces = function() {
};
hxDaedalus.iterators.FromVertexToHoldingFaces.__name__ = true;
hxDaedalus.iterators.FromVertexToHoldingFaces.prototype = {
	set_fromVertex: function(value) {
		this._fromVertex = value;
		this._nextEdge = this._fromVertex.get_edge();
		return value;
	}
	,next: function() {
		if(this._nextEdge != null) do {
			this._resultFace = this._nextEdge.get_leftFace();
			this._nextEdge = this._nextEdge.get_rotLeftEdge();
			if(this._nextEdge == this._fromVertex.get_edge()) {
				this._nextEdge = null;
				if(!this._resultFace.get_isReal()) this._resultFace = null;
				break;
			}
		} while(!this._resultFace.get_isReal()); else this._resultFace = null;
		return this._resultFace;
	}
};
hxDaedalus.iterators.FromVertexToIncomingEdges = function() {
};
hxDaedalus.iterators.FromVertexToIncomingEdges.__name__ = true;
hxDaedalus.iterators.FromVertexToIncomingEdges.prototype = {
	set_fromVertex: function(value) {
		this._fromVertex = value;
		this._nextEdge = this._fromVertex.get_edge();
		while(!this._nextEdge.get_isReal()) this._nextEdge = this._nextEdge.get_rotLeftEdge();
		return value;
	}
	,next: function() {
		if(this._nextEdge != null) {
			this._resultEdge = this._nextEdge.get_oppositeEdge();
			do {
				this._nextEdge = this._nextEdge.get_rotLeftEdge();
				if(this._nextEdge == this._fromVertex.get_edge()) {
					this._nextEdge = null;
					break;
				}
			} while(!this._nextEdge.get_isReal());
		} else this._resultEdge = null;
		return this._resultEdge;
	}
};
hxDaedalus.iterators.FromVertexToOutgoingEdges = function() {
	this.realEdgesOnly = true;
};
hxDaedalus.iterators.FromVertexToOutgoingEdges.__name__ = true;
hxDaedalus.iterators.FromVertexToOutgoingEdges.prototype = {
	set_fromVertex: function(value) {
		this._fromVertex = value;
		this._nextEdge = this._fromVertex.get_edge();
		while(this.realEdgesOnly && !this._nextEdge.get_isReal()) this._nextEdge = this._nextEdge.get_rotLeftEdge();
		return value;
	}
	,next: function() {
		if(this._nextEdge != null) {
			this._resultEdge = this._nextEdge;
			do {
				this._nextEdge = this._nextEdge.get_rotLeftEdge();
				if(this._nextEdge == this._fromVertex.get_edge()) {
					this._nextEdge = null;
					break;
				}
			} while(this.realEdgesOnly && !this._nextEdge.get_isReal());
		} else this._resultEdge = null;
		return this._resultEdge;
	}
};
hxDaedalus.view = {};
hxDaedalus.view.SimpleViewJS = function() {
	this.basicCanvas = new hxDaedalus.canvas.BasicCanvas();
	this.surface = this.basicCanvas.surface;
};
hxDaedalus.view.SimpleViewJS.__name__ = true;
hxDaedalus.view.SimpleViewJS.prototype = {
	drawMesh: function(mesh_) {
		if(mesh_ != null) this.mesh = mesh_;
		this.basicCanvas.clear();
		this.surface.fillStyle = this.basicCanvas.header.bgColor;
		this.surface.fillRect(0,0,this.mesh.get_width(),this.mesh.get_height());
		var vertex;
		var incomingEdge;
		var holdingFace;
		var iterVertices;
		iterVertices = new hxDaedalus.iterators.FromMeshToVertices();
		iterVertices.set_fromMesh(this.mesh);
		var iterEdges;
		iterEdges = new hxDaedalus.iterators.FromVertexToIncomingEdges();
		var dictVerticesDone = new haxe.ds.ObjectMap();
		while((vertex = iterVertices.next()) != null) {
			dictVerticesDone.set(vertex,true);
			true;
			if(!this.vertexIsInsideAABB(vertex,this.mesh)) continue;
			this.basicCanvas.drawCircle(vertex.get_pos().x,vertex.get_pos().y,0.5);
			this.basicCanvas.endDraw();
			iterEdges.set_fromVertex(vertex);
			while((incomingEdge = iterEdges.next()) != null) if(!(function($this) {
				var $r;
				var key = incomingEdge.get_originVertex();
				$r = dictVerticesDone.h[key.__id__];
				return $r;
			}(this))) {
				if(incomingEdge.get_isConstrained()) {
					this.basicCanvas.beginFill(16711680);
					this.basicCanvas.lineStyle(2,16711680);
					this.surface.moveTo(incomingEdge.get_originVertex().get_pos().x,incomingEdge.get_originVertex().get_pos().y);
					this.surface.lineTo(incomingEdge.get_destinationVertex().get_pos().x,incomingEdge.get_destinationVertex().get_pos().y);
					this.basicCanvas.endDraw();
				} else {
					this.basicCanvas.lineStyle(.25,10066329);
					this.surface.moveTo(incomingEdge.get_originVertex().get_pos().x,incomingEdge.get_originVertex().get_pos().y);
					this.surface.lineTo(incomingEdge.get_destinationVertex().get_pos().x,incomingEdge.get_destinationVertex().get_pos().y);
					this.basicCanvas.endDraw();
				}
			}
		}
	}
	,drawEntity: function(entity) {
		this.basicCanvas.lineStyle(0.5,65280);
		this.basicCanvas.beginFill(65280);
		this.basicCanvas.drawCircle(entity.x,entity.y,entity.get_radius());
		this.basicCanvas.endDraw();
	}
	,drawEntities: function(vEntities) {
		this.basicCanvas.lineStyle(0.5,65280);
		var _g1 = 0;
		var _g = vEntities.length;
		while(_g1 < _g) {
			var i = _g1++;
			this.basicCanvas.beginFill(65280);
			this.basicCanvas.drawCircle(vEntities[i].x,vEntities[i].y,vEntities[i].get_radius());
			this.basicCanvas.endDraw();
		}
	}
	,drawPath: function(path,cleanBefore) {
		if(cleanBefore == null) cleanBefore = true;
		if(path.length == 0) return;
		this.basicCanvas.lineStyle(0.5,16760848);
		this.surface.moveTo(path[0],path[1]);
		var i = 2;
		while(i < path.length) {
			this.surface.lineTo(path[i],path[i + 1]);
			this.surface.moveTo(path[i],path[i + 1]);
			i += 2;
		}
		this.basicCanvas.endDraw();
	}
	,vertexIsInsideAABB: function(vertex,mesh) {
		if(vertex.get_pos().x < 0 || vertex.get_pos().x > mesh.get_width() || vertex.get_pos().y < 0 || vertex.get_pos().y > mesh.get_height()) return false; else return true;
	}
};
var js = {};
js.Boot = function() { };
js.Boot.__name__ = true;
js.Boot.__unhtml = function(s) {
	return s.split("&").join("&amp;").split("<").join("&lt;").split(">").join("&gt;");
};
js.Boot.__trace = function(v,i) {
	var msg;
	if(i != null) msg = i.fileName + ":" + i.lineNumber + ": "; else msg = "";
	msg += js.Boot.__string_rec(v,"");
	if(i != null && i.customParams != null) {
		var _g = 0;
		var _g1 = i.customParams;
		while(_g < _g1.length) {
			var v1 = _g1[_g];
			++_g;
			msg += "," + js.Boot.__string_rec(v1,"");
		}
	}
	var d;
	if(typeof(document) != "undefined" && (d = document.getElementById("haxe:trace")) != null) d.innerHTML += js.Boot.__unhtml(msg) + "<br/>"; else if(typeof console != "undefined" && console.log != null) console.log(msg);
};
js.Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) str += "," + js.Boot.__string_rec(o[i],s); else str += js.Boot.__string_rec(o[i],s);
				}
				return str + ")";
			}
			var l = o.length;
			var i1;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js.Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString) {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str2 = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str2.length != 2) str2 += ", \n";
		str2 += s + k + " : " + js.Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str2 += "\n" + s + "}";
		return str2;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
if(Array.prototype.indexOf) HxOverrides.indexOf = function(a,o,i) {
	return Array.prototype.indexOf.call(a,o,i);
};
String.__name__ = true;
Array.__name__ = true;
haxe.ds.ObjectMap.count = 0;
hxDaedalus.ai.EntityAI.NUM_SEGMENTS = 6;
hxDaedalus.canvas.CanvasHeader.__meta__ = { fields : { parseInt : { 'static' : null}, toHashColor : { 'static' : null}}};
hxDaedalus.data.Constants.EPSILON = 0.01;
hxDaedalus.data.Constants.EPSILON_SQUARED = 0.0001;
hxDaedalus.data.ConstraintSegment.INC = 0;
hxDaedalus.data.ConstraintShape.INC = 0;
hxDaedalus.data.Edge.INC = 0;
hxDaedalus.data.Face.INC = 0;
hxDaedalus.data.Mesh.INC = 0;
hxDaedalus.data.Object.INC = 0;
hxDaedalus.data.Vertex.INC = 0;
hxDaedalus.data.math.Geom2D.__samples = new Array();
hxDaedalus.data.math.Geom2D.__circumcenter = new hxDaedalus.data.math.Point2D();
PathfindingJS.main();
})();

//# sourceMappingURL=daedalusPathfinding.js.map