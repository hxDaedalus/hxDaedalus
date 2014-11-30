(function () { "use strict";
var BasicsJS = function() {
	var _0 = hxDaedalus.factories.RectMesh.buildRectangle(600,400);
	this.mesh = _0;
	var _1 = new hxDaedalus.view.SimpleViewJS();
	this.view = _1;
	var _2 = this.mesh.insertVertex(550,50);
	var vertex = _2;
	var _3 = this.mesh.insertConstraintSegment(70,300,530,320);
	var segment = _3;
	var _4 = [50.,50.,100.,50.,100.,50.,100.,100.,100.,100.,50.,100.,50.,100.,50.,50.,20.,50.,130.,100.];
	var _5 = this.mesh.insertConstraintShape(_4);
	var shape = _5;
	var _6 = new Array();
	var objectCoords = _6;
	var _7 = new hxDaedalus.data.Object();
	this.object = _7;
	var _8 = [-50.,0.,50.,0.,0.,-50.,0.,50.,-30.,-30.,30.,30.,30.,-30.,-30.,30.];
	this.object.set_coordinates(_8);
	var _9 = this.object;
	this.mesh.insertObject(_9);
	this.object.set_x(400);
	this.object.set_y(200);
	this.object.set_scaleX(2);
	this.object.set_scaleY(2);
	var _10 = $bind(this,this.onEnterFrame);
	this.view.basicCanvas.onEnterFrame = _10;
};
BasicsJS.__name__ = true;
BasicsJS.main = function() {
	new BasicsJS();
};
BasicsJS.prototype = {
	onEnterFrame: function() {
		var _0 = this.object;
		var _g = _0;
		var _1 = _g.get_rotation();
		var _2 = _1 + 0.05;
		_g.set_rotation(_2);
		this.mesh.updateObjects();
		var _3 = this.mesh;
		this.view.drawMesh(_3);
	}
};
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.cca = function(s,index) {
	var x = s.charCodeAt(index);
	if(x != x) return undefined;
	return x;
};
HxOverrides.substr = function(s,pos,len) {
	var _0 = pos != null;
	var _1;
	if(_0) _1 = pos != 0; else _1 = false;
	var _2;
	if(_1) _2 = len != null; else _2 = false;
	var _3;
	if(_2) _3 = len < 0; else _3 = false;
	if(_3) return "";
	var _4 = len == null;
	if(_4) {
		var _5 = s.length;
		len = _5;
	}
	var _6 = pos < 0;
	if(_6) {
		var _7 = s.length;
		var _8 = _7 + pos;
		pos = _8;
		var _9 = pos < 0;
		if(_9) pos = 0;
	} else {
		var _10 = len < 0;
		if(_10) {
			var _11 = s.length;
			var _12 = _11 + len;
			var _13 = _12 - pos;
			len = _13;
		}
	}
	var _14 = s.substr(pos,len);
	return _14;
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
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	var _0 = js.Boot.__string_rec(s,"");
	return _0;
};
Std["int"] = function(x) {
	var _0 = x | 0;
	return _0;
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
	while(true) {
		var _0 = n & 15;
		var _1 = hexChars.charAt(_0);
		var _2 = _1 + s;
		s = _2;
		n >>>= 4;
		var _3 = n > 0;
		var _4 = !_3;
		if(_4) break;
	}
	var _5 = digits != null;
	if(_5) while(true) {
		var _6 = s.length;
		var _7 = _6 < digits;
		var _8 = !_7;
		if(_8) break;
		var _9 = "0" + s;
		s = _9;
	}
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
	var _0 = { };
	this.h = _0;
	var _1 = { };
	this.h.__keys__ = _1;
};
haxe.ds.ObjectMap.__name__ = true;
haxe.ds.ObjectMap.__interfaces__ = [IMap];
haxe.ds.ObjectMap.prototype = {
	set: function(key,value) {
		var _1 = key.__id__;
		var _2 = !_1;
		var _4;
		if(_2) {
			var _3 = ++haxe.ds.ObjectMap.count;
			var _0 = _3;
			_4 = key.__id__ = _0;
		} else _4 = true;
		var id = _4;
		var _5 = this.h;
		_5[id] = value;
		var _6 = this.h.__keys__;
		_6[id] = key;
	}
	,get: function(key) {
		var _0 = this.h;
		var _1 = key.__id__;
		var _2 = _0[_1];
		return _2;
	}
};
var hxDaedalus = {};
hxDaedalus.ai = {};
hxDaedalus.ai.EntityAI = function() {
	this._radius = 10;
	var _0 = this.y = 0;
	this.x = _0;
	this.dirNormX = 1;
	this.dirNormY = 0;
	this.angleFOV = 60;
};
hxDaedalus.ai.EntityAI.__name__ = true;
hxDaedalus.ai.EntityAI.prototype = {
	buildApproximation: function() {
		var _0 = new hxDaedalus.data.Object();
		this._approximateObject = _0;
		var _1 = this.x;
		var _2 = this.y;
		this._approximateObject.get_matrix().translate(_1,_2);
		var _3 = new Array();
		var coordinates = _3;
		var _4 = coordinates;
		this._approximateObject.set_coordinates(_4);
		var _5 = this._radius;
		var _6 = _5 == 0;
		if(_6) return;
		var _g = 0;
		while(true) {
			var _7 = _g < 6;
			var _8 = !_7;
			if(_8) break;
			var _9 = _g++;
			var i = _9;
			var _10 = this._radius;
			var _11 = Math.PI;
			var _12 = 2 * _11;
			var _13 = _12 * i;
			var _14 = _13 / 6;
			var _15 = Math.cos(_14);
			var _16 = _10 * _15;
			coordinates.push(_16);
			var _17 = this._radius;
			var _18 = Math.PI;
			var _19 = 2 * _18;
			var _20 = _19 * i;
			var _21 = _20 / 6;
			var _22 = Math.sin(_21);
			var _23 = _17 * _22;
			coordinates.push(_23);
			var _24 = this._radius;
			var _25 = Math.PI;
			var _26 = 2 * _25;
			var _27 = i + 1;
			var _28 = _26 * _27;
			var _29 = _28 / 6;
			var _30 = Math.cos(_29);
			var _31 = _24 * _30;
			coordinates.push(_31);
			var _32 = this._radius;
			var _33 = Math.PI;
			var _34 = 2 * _33;
			var _35 = i + 1;
			var _36 = _34 * _35;
			var _37 = _36 / 6;
			var _38 = Math.sin(_37);
			var _39 = _32 * _38;
			coordinates.push(_39);
		}
	}
	,get_approximateObject: function() {
		this._approximateObject.get_matrix().identity();
		var _0 = this.x;
		var _1 = this.y;
		this._approximateObject.get_matrix().translate(_0,_1);
		var _2 = this._approximateObject;
		return _2;
	}
	,get_radius: function() {
		var _0 = this._radius;
		return _0;
	}
	,get_radiusSquared: function() {
		var _0 = this._radiusSquared;
		return _0;
	}
	,set_radius: function(value) {
		this._radius = value;
		var _0 = this._radius;
		var _1 = this._radius;
		var _2 = _0 * _1;
		this._radiusSquared = _2;
		return value;
	}
};
hxDaedalus.canvas = {};
hxDaedalus.canvas.BasicCanvas = function() {
	this.canvas = (function($this) {
		var $r;
		var _this = window.document;
		$r = _this.createElement("canvas");
		return $r;
	}(this));
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
	var s = (function($this) {
		var $r;
		var _this1 = window.document;
		$r = _this1.createElement("style");
		return $r;
	}(this));
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
		var _0 = this.header.width;
		var _1 = this.header.height;
		this.surface.clearRect(0,0,_0,_1);
	}
	,drawCircle: function(x,y,radius) {
		this.surface.beginPath();
		var _0 = Math.PI;
		var _1 = 2 * _0;
		this.surface.arc(x,y,radius,0,_1,false);
		this.surface.stroke();
		this.surface.closePath();
		this.surface.fill();
	}
	,lineStyle: function(wid,col) {
		this.surface.lineWidth = wid;
		var _0 = StringTools.hex(col,6);
		var _1 = "#" + _0;
		this.surface.strokeStyle = _1;
	}
	,beginFill: function(col) {
		var _0 = StringTools.hex(col,6);
		var _1 = "#" + _0;
		this.surface.fillStyle = _1;
		this.surface.beginPath();
	}
	,endDraw: function() {
		this.surface.stroke();
		this.surface.closePath();
		this.surface.fill();
	}
};
hxDaedalus.canvas.CanvasHeader = function() {
	var _0 = "600:400:60:FFFFFF".split(":");
	var canvasHeader = _0;
	var _1 = canvasHeader;
	var _2 = _1[0];
	var _3 = Std.parseInt(_2);
	this.width = _3;
	var _4 = canvasHeader;
	var _5 = _4[1];
	var _6 = Std.parseInt(_5);
	this.height = _6;
	var _7 = canvasHeader;
	var _8 = _7[2];
	var _9 = Std.parseInt(_8);
	this.frameRate = _9;
	var _10 = canvasHeader;
	var _11 = _10[3];
	var _12 = "#" + _11;
	this.bgColor = _12;
};
hxDaedalus.canvas.CanvasHeader.__name__ = true;
hxDaedalus.canvas.CanvasHeader.prototype = {
	parseInt: function(e) {
		var _0 = Std.parseInt(e);
		return _0;
	}
	,toHashColor: function(e) {
		var _0 = "#" + e;
		return _0;
	}
};
hxDaedalus.data = {};
hxDaedalus.data.Constants = function() { };
hxDaedalus.data.Constants.__name__ = true;
hxDaedalus.data.ConstraintSegment = function() {
	var _0 = hxDaedalus.data.ConstraintSegment.INC;
	this._id = _0;
	hxDaedalus.data.ConstraintSegment.INC++;
	var _1 = new Array();
	this._edges = _1;
};
hxDaedalus.data.ConstraintSegment.__name__ = true;
hxDaedalus.data.ConstraintSegment.prototype = {
	get_id: function() {
		var _0 = this._id;
		return _0;
	}
	,addEdge: function(edge) {
		var _0 = this._edges;
		var _1 = null != null;
		var _2;
		if(_1) _2 = null; else _2 = 0;
		var _3 = HxOverrides.indexOf(_0,edge,_2);
		var _4 = -1;
		var _10 = _3 == _4;
		var _16;
		if(_10) {
			var _9;
			var _11 = edge.get_oppositeEdge();
			var _5 = _11;
			var x = _5;
			var _12 = this._edges;
			var _6 = _12;
			var _13 = null != null;
			var _7 = _13;
			var _8;
			if(_7) _8 = null; else _8 = 0;
			var _14 = _6;
			var _15 = HxOverrides.indexOf(_14,x,_8);
			_9 = _15;
			_16 = _9 == -1;
		} else _16 = false;
		if(_16) this._edges.push(edge);
	}
	,removeEdge: function(edge) {
		var index;
		var _0 = this._edges;
		var _1 = null != null;
		var _2;
		if(_1) _2 = null; else _2 = 0;
		var _3 = HxOverrides.indexOf(_0,edge,_2);
		index = _3;
		var _4 = index == -1;
		if(_4) {
			var _9;
			var _5 = edge.get_oppositeEdge();
			var x = _5;
			var _6 = this._edges;
			var _7 = null != null;
			var _8;
			if(_7) _8 = null; else _8 = 0;
			_9 = HxOverrides.indexOf(_6,x,_8);
			index = _9;
		}
		var _10 = index != -1;
		if(_10) this._edges.splice(index,1);
	}
	,get_edges: function() {
		var _0 = this._edges;
		return _0;
	}
	,dispose: function() {
		var _0 = null;
		this._edges = _0;
		this.fromShape = null;
	}
	,toString: function() {
		var _0 = this._id;
		var _1 = "seg_id " + _0;
		return _1;
	}
};
hxDaedalus.data.ConstraintShape = function() {
	var _0 = hxDaedalus.data.ConstraintShape.INC;
	this._id = _0;
	hxDaedalus.data.ConstraintShape.INC++;
	var _1 = new Array();
	this.segments = _1;
};
hxDaedalus.data.ConstraintShape.__name__ = true;
hxDaedalus.data.ConstraintShape.prototype = {
	get_id: function() {
		var _0 = this._id;
		return _0;
	}
	,dispose: function() {
		while(true) {
			var _0 = this.segments.length;
			var _1 = _0 > 0;
			var _2 = !_1;
			if(_2) break;
			this.segments.pop().dispose();
		}
		var _3 = null;
		this.segments = _3;
	}
};
hxDaedalus.data.Edge = function() {
	this.colorDebug = -1;
	var _0 = hxDaedalus.data.Edge.INC;
	this._id = _0;
	hxDaedalus.data.Edge.INC++;
	var _1 = new Array();
	this.fromConstraintSegments = _1;
};
hxDaedalus.data.Edge.__name__ = true;
hxDaedalus.data.Edge.prototype = {
	get_id: function() {
		var _0 = this._id;
		return _0;
	}
	,get_isReal: function() {
		var _0 = this._isReal;
		return _0;
	}
	,get_isConstrained: function() {
		var _0 = this._isConstrained;
		return _0;
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
		var _0 = this.fromConstraintSegments;
		var _1 = null != null;
		var _2;
		if(_1) _2 = null; else _2 = 0;
		var _3 = HxOverrides.indexOf(_0,segment,_2);
		var _4 = _3 == -1;
		if(_4) this.fromConstraintSegments.push(segment);
	}
	,removeFromConstraintSegment: function(segment) {
		var _0 = this.fromConstraintSegments;
		var _1 = null != null;
		var _2;
		if(_1) _2 = null; else _2 = 0;
		var _3 = HxOverrides.indexOf(_0,segment,_2);
		var index = _3;
		var _4 = index != -1;
		if(_4) this.fromConstraintSegments.splice(index,1);
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
		var _0 = null;
		this.fromConstraintSegments = _0;
	}
	,get_originVertex: function() {
		var _0 = this._originVertex;
		return _0;
	}
	,get_destinationVertex: function() {
		var _0 = this.get_oppositeEdge().get_originVertex();
		return _0;
	}
	,get_oppositeEdge: function() {
		var _0 = this._oppositeEdge;
		return _0;
	}
	,get_nextLeftEdge: function() {
		var _0 = this._nextLeftEdge;
		return _0;
	}
	,get_prevLeftEdge: function() {
		var _0 = this._nextLeftEdge.get_nextLeftEdge();
		return _0;
	}
	,get_nextRightEdge: function() {
		var _0 = this._oppositeEdge.get_nextLeftEdge().get_nextLeftEdge().get_oppositeEdge();
		return _0;
	}
	,get_prevRightEdge: function() {
		var _0 = this._oppositeEdge.get_nextLeftEdge().get_oppositeEdge();
		return _0;
	}
	,get_rotLeftEdge: function() {
		var _0 = this._nextLeftEdge.get_nextLeftEdge().get_oppositeEdge();
		return _0;
	}
	,get_rotRightEdge: function() {
		var _0 = this._oppositeEdge.get_nextLeftEdge();
		return _0;
	}
	,get_leftFace: function() {
		var _0 = this._leftFace;
		return _0;
	}
	,get_rightFace: function() {
		var _0 = this._oppositeEdge.get_leftFace();
		return _0;
	}
	,toString: function() {
		var _0 = this.get_originVertex().get_id();
		var _1 = "edge " + _0;
		var _2 = _1 + " - ";
		var _3 = this.get_destinationVertex().get_id();
		var _4 = _2 + _3;
		return _4;
	}
};
hxDaedalus.data.Face = function() {
	this.colorDebug = -1;
	var _0 = hxDaedalus.data.Face.INC;
	this._id = _0;
	hxDaedalus.data.Face.INC++;
};
hxDaedalus.data.Face.__name__ = true;
hxDaedalus.data.Face.prototype = {
	get_id: function() {
		var _0 = this._id;
		return _0;
	}
	,get_isReal: function() {
		var _0 = this._isReal;
		return _0;
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
		var _0 = this._edge;
		return _0;
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
	var _0 = hxDaedalus.data.Mesh.INC;
	this._id = _0;
	hxDaedalus.data.Mesh.INC++;
	this._width = width;
	this._height = height;
	this._clipping = true;
	var _1 = new Array();
	this._vertices = _1;
	var _2 = new Array();
	this._edges = _2;
	var _3 = new Array();
	this._faces = _3;
	var _4 = new Array();
	this._constraintShapes = _4;
	var _5 = new Array();
	this._objects = _5;
	var _6 = new Array();
	this.__edgesToCheck = _6;
};
hxDaedalus.data.Mesh.__name__ = true;
hxDaedalus.data.Mesh.prototype = {
	get_height: function() {
		var _0 = this._height;
		return _0;
	}
	,get_width: function() {
		var _0 = this._width;
		return _0;
	}
	,get_clipping: function() {
		var _0 = this._clipping;
		return _0;
	}
	,set_clipping: function(value) {
		this._clipping = value;
		return value;
	}
	,get_id: function() {
		var _0 = this._id;
		return _0;
	}
	,dispose: function() {
		while(true) {
			var _0 = this._vertices.length;
			var _1 = _0 > 0;
			var _2 = !_1;
			if(_2) break;
			this._vertices.pop().dispose();
		}
		var _3 = null;
		this._vertices = _3;
		while(true) {
			var _4 = this._edges.length;
			var _5 = _4 > 0;
			var _6 = !_5;
			if(_6) break;
			this._edges.pop().dispose();
		}
		var _7 = null;
		this._edges = _7;
		while(true) {
			var _8 = this._faces.length;
			var _9 = _8 > 0;
			var _10 = !_9;
			if(_10) break;
			this._faces.pop().dispose();
		}
		var _11 = null;
		this._faces = _11;
		while(true) {
			var _12 = this._constraintShapes.length;
			var _13 = _12 > 0;
			var _14 = !_13;
			if(_14) break;
			this._constraintShapes.pop().dispose();
		}
		var _15 = null;
		this._constraintShapes = _15;
		while(true) {
			var _16 = this._objects.length;
			var _17 = _16 > 0;
			var _18 = !_17;
			if(_18) break;
			this._objects.pop().dispose();
		}
		var _19 = null;
		this._objects = _19;
		var _20 = null;
		this.__edgesToCheck = _20;
		this.__centerVertex = null;
	}
	,get___constraintShapes: function() {
		var _0 = this._constraintShapes;
		return _0;
	}
	,buildFromRecord: function(rec) {
		var _0 = rec.split(";");
		var positions = _0;
		var i = 0;
		while(true) {
			var _1 = positions.length;
			var _2 = i < _1;
			var _3 = !_2;
			if(_3) break;
			var _4 = positions;
			var _5 = _4[i];
			var _6 = Std.parseFloat(_5);
			var _7 = positions;
			var _8 = i + 1;
			var _9 = _7[_8];
			var _10 = Std.parseFloat(_9);
			var _11 = positions;
			var _12 = i + 2;
			var _13 = _11[_12];
			var _14 = Std.parseFloat(_13);
			var _15 = positions;
			var _16 = i + 3;
			var _17 = _15[_16];
			var _18 = Std.parseFloat(_17);
			this.insertConstraintSegment(_6,_10,_14,_18);
			i += 4;
		}
	}
	,insertObject: function(object) {
		var _0 = object.get_constraintShape();
		var _1 = _0 != null;
		if(_1) this.deleteObject(object);
		var _2 = new hxDaedalus.data.ConstraintShape();
		var shape = _2;
		var segment;
		var _3 = object.get_coordinates();
		var coordinates = _3;
		var _4 = object.get_matrix();
		var m = _4;
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
		while(true) {
			var _5 = coordinates.length;
			var _6 = i < _5;
			var _7 = !_6;
			if(_7) break;
			var _8 = coordinates;
			var _9 = _8[i];
			x1 = _9;
			var _10 = coordinates;
			var _11 = i + 1;
			var _12 = _10[_11];
			y1 = _12;
			var _13 = coordinates;
			var _14 = i + 2;
			var _15 = _13[_14];
			x2 = _15;
			var _16 = coordinates;
			var _17 = i + 3;
			var _18 = _16[_17];
			y2 = _18;
			var _19 = m.transformX(x1,y1);
			transfx1 = _19;
			var _20 = m.transformY(x1,y1);
			transfy1 = _20;
			var _21 = m.transformX(x2,y2);
			transfx2 = _21;
			var _22 = m.transformY(x2,y2);
			transfy2 = _22;
			var _23 = this.insertConstraintSegment(transfx1,transfy1,transfx2,transfy2);
			segment = _23;
			var _24 = segment != null;
			if(_24) {
				segment.fromShape = shape;
				shape.segments.push(segment);
			}
			i += 4;
		}
		this._constraintShapes.push(shape);
		object.set_constraintShape(shape);
		var _25 = this.__objectsUpdateInProgress;
		var _26 = !_25;
		if(_26) this._objects.push(object);
	}
	,deleteObject: function(object) {
		var _0 = object.get_constraintShape();
		var _1 = _0 == null;
		if(_1) return;
		var _2 = object.get_constraintShape();
		this.deleteConstraintShape(_2);
		object.set_constraintShape(null);
		var _3 = this.__objectsUpdateInProgress;
		var _4 = !_3;
		if(_4) {
			var _5 = this._objects;
			var _6 = null != null;
			var _7;
			if(_6) _7 = null; else _7 = 0;
			var _8 = HxOverrides.indexOf(_5,object,_7);
			var index = _8;
			this._objects.splice(index,1);
		}
	}
	,updateObjects: function() {
		this.__objectsUpdateInProgress = true;
		var _g1 = 0;
		var _0 = this._objects.length;
		var _g = _0;
		while(true) {
			var _1 = _g1 < _g;
			var _2 = !_1;
			if(_2) break;
			var _3 = _g1++;
			var i = _3;
			var _4 = this._objects;
			var _5 = _4[i].get_hasChanged();
			if(_5) {
				var _6 = this._objects;
				var _7 = _6[i];
				this.deleteObject(_7);
				var _8 = this._objects;
				var _9 = _8[i];
				this.insertObject(_9);
				var _10 = this._objects;
				_10[i].set_hasChanged(false);
			}
		}
		this.__objectsUpdateInProgress = false;
	}
	,insertConstraintShape: function(coordinates) {
		var _0 = new hxDaedalus.data.ConstraintShape();
		var shape = _0;
		var segment = null;
		var i = 0;
		while(true) {
			var _1 = coordinates.length;
			var _2 = i < _1;
			var _3 = !_2;
			if(_3) break;
			var _4 = coordinates;
			var _5 = _4[i];
			var _6 = coordinates;
			var _7 = i + 1;
			var _8 = _6[_7];
			var _9 = coordinates;
			var _10 = i + 2;
			var _11 = _9[_10];
			var _12 = coordinates;
			var _13 = i + 3;
			var _14 = _12[_13];
			var _15 = this.insertConstraintSegment(_5,_8,_11,_14);
			segment = _15;
			var _16 = segment != null;
			if(_16) {
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
		var _0 = shape.segments.length;
		var _g = _0;
		while(true) {
			var _1 = _g1 < _g;
			var _2 = !_1;
			if(_2) break;
			var _3 = _g1++;
			var i = _3;
			var _4 = shape.segments;
			var _5 = _4[i];
			this.deleteConstraintSegment(_5);
		}
		shape.dispose();
		var _6 = this._constraintShapes;
		var _7 = null != null;
		var _8;
		if(_7) _8 = null; else _8 = 0;
		var _9 = HxOverrides.indexOf(_6,shape,_8);
		this._constraintShapes.splice(_9,1);
	}
	,insertConstraintSegment: function(x1,y1,x2,y2) {
		var _0 = this.findPositionFromBounds(x1,y1);
		var p1pos = _0;
		var _1 = this.findPositionFromBounds(x2,y2);
		var p2pos = _1;
		var newX1 = x1;
		var newY1 = y1;
		var newX2 = x2;
		var newY2 = y2;
		var _4 = this._clipping;
		var _7;
		if(_4) {
			var _5 = p1pos != 0;
			var _2 = _5;
			var _6 = !_2;
			var _3 = _6;
			if(_3) _7 = p2pos != 0; else _7 = true;
		} else _7 = false;
		if(_7) {
			var _8 = new hxDaedalus.data.math.Point2D();
			var intersectPoint = _8;
			var _9 = p1pos != 0;
			var _10;
			if(_9) _10 = p2pos != 0; else _10 = false;
			if(_10) {
				var _11 = x1 <= 0;
				var _16;
				if(_11) _16 = x2 <= 0; else _16 = false;
				var _17 = !_16;
				var _25;
				if(_17) {
					var _22 = this._width;
					var _18 = _22;
					var _12 = _18;
					var _23 = x1 >= _12;
					var _19 = _23;
					var _14 = _19;
					if(_14) {
						var _24 = this._width;
						var _20 = _24;
						var _15 = _20;
						var _13 = _15;
						_25 = x2 >= _13;
					} else _25 = false;
				} else _25 = true;
				var _26 = !_25;
				var _33;
				if(_26) {
					var _32 = y1 <= 0;
					var _27 = _32;
					var _21 = _27;
					if(_21) _33 = y2 <= 0; else _33 = false;
				} else _33 = true;
				var _34 = !_33;
				var _38;
				if(_34) {
					var _35 = this._height;
					var _28 = _35;
					var _36 = y1 >= _28;
					var _30 = _36;
					if(_30) {
						var _37 = this._height;
						var _31 = _37;
						var _29 = _31;
						_38 = y2 >= _29;
					} else _38 = false;
				} else _38 = true;
				if(_38) return null;
				var _39 = p1pos == 8;
				var _41;
				if(_39) _41 = p2pos == 4; else _41 = false;
				var _42 = !_41;
				var _44;
				if(_42) {
					var _43 = p1pos == 4;
					var _40 = _43;
					if(_40) _44 = p2pos == 8; else _44 = false;
				} else _44 = true;
				if(_44) {
					var _45 = this._height;
					hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,0,_45,intersectPoint);
					var _46 = intersectPoint.x;
					newX1 = _46;
					var _47 = intersectPoint.y;
					newY1 = _47;
					var _48 = this._width;
					var _49 = this._width;
					var _50 = this._height;
					hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,_48,0,_49,_50,intersectPoint);
					var _51 = intersectPoint.x;
					newX2 = _51;
					var _52 = intersectPoint.y;
					newY2 = _52;
				} else {
					var _53 = p1pos == 2;
					var _55;
					if(_53) _55 = p2pos == 6; else _55 = false;
					var _56 = !_55;
					var _58;
					if(_56) {
						var _57 = p1pos == 6;
						var _54 = _57;
						if(_54) _58 = p2pos == 2; else _58 = false;
					} else _58 = true;
					if(_58) {
						var _59 = this._width;
						hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,_59,0,intersectPoint);
						var _60 = intersectPoint.x;
						newX1 = _60;
						var _61 = intersectPoint.y;
						newY1 = _61;
						var _62 = this._height;
						var _63 = this._width;
						var _64 = this._height;
						hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,_62,_63,_64,intersectPoint);
						var _65 = intersectPoint.x;
						newX2 = _65;
						var _66 = intersectPoint.y;
						newY2 = _66;
					} else {
						var _67 = p1pos == 2;
						var _69;
						if(_67) _69 = p2pos == 8; else _69 = false;
						var _70 = !_69;
						var _72;
						if(_70) {
							var _71 = p1pos == 8;
							var _68 = _71;
							if(_68) _72 = p2pos == 2; else _72 = false;
						} else _72 = true;
						if(_72) {
							var _73 = this._width;
							var _74 = hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,_73,0,intersectPoint);
							if(_74) {
								var _75 = intersectPoint.x;
								newX1 = _75;
								var _76 = intersectPoint.y;
								newY1 = _76;
								var _77 = this._height;
								hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,0,_77,intersectPoint);
								var _78 = intersectPoint.x;
								newX2 = _78;
								var _79 = intersectPoint.y;
								newY2 = _79;
							} else return null;
						} else {
							var _80 = p1pos == 2;
							var _82;
							if(_80) _82 = p2pos == 4; else _82 = false;
							var _83 = !_82;
							var _85;
							if(_83) {
								var _84 = p1pos == 4;
								var _81 = _84;
								if(_81) _85 = p2pos == 2; else _85 = false;
							} else _85 = true;
							if(_85) {
								var _86 = this._width;
								var _87 = hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,_86,0,intersectPoint);
								if(_87) {
									var _88 = intersectPoint.x;
									newX1 = _88;
									var _89 = intersectPoint.y;
									newY1 = _89;
									var _90 = this._width;
									var _91 = this._width;
									var _92 = this._height;
									hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,_90,0,_91,_92,intersectPoint);
									var _93 = intersectPoint.x;
									newX2 = _93;
									var _94 = intersectPoint.y;
									newY2 = _94;
								} else return null;
							} else {
								var _95 = p1pos == 6;
								var _97;
								if(_95) _97 = p2pos == 4; else _97 = false;
								var _98 = !_97;
								var _100;
								if(_98) {
									var _99 = p1pos == 4;
									var _96 = _99;
									if(_96) _100 = p2pos == 6; else _100 = false;
								} else _100 = true;
								if(_100) {
									var _101 = this._height;
									var _102 = this._width;
									var _103 = this._height;
									var _104 = hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,_101,_102,_103,intersectPoint);
									if(_104) {
										var _105 = intersectPoint.x;
										newX1 = _105;
										var _106 = intersectPoint.y;
										newY1 = _106;
										var _107 = this._width;
										var _108 = this._width;
										var _109 = this._height;
										hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,_107,0,_108,_109,intersectPoint);
										var _110 = intersectPoint.x;
										newX2 = _110;
										var _111 = intersectPoint.y;
										newY2 = _111;
									} else return null;
								} else {
									var _112 = p1pos == 8;
									var _114;
									if(_112) _114 = p2pos == 6; else _114 = false;
									var _115 = !_114;
									var _117;
									if(_115) {
										var _116 = p1pos == 6;
										var _113 = _116;
										if(_113) _117 = p2pos == 8; else _117 = false;
									} else _117 = true;
									if(_117) {
										var _118 = this._height;
										var _119 = this._width;
										var _120 = this._height;
										var _121 = hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,_118,_119,_120,intersectPoint);
										if(_121) {
											var _122 = intersectPoint.x;
											newX1 = _122;
											var _123 = intersectPoint.y;
											newY1 = _123;
											var _124 = this._height;
											hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,0,_124,intersectPoint);
											var _125 = intersectPoint.x;
											newX2 = _125;
											var _126 = intersectPoint.y;
											newY2 = _126;
										} else return null;
									} else {
										var firstDone = false;
										var secondDone = false;
										var _127 = this._width;
										var _128 = hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,_127,0,intersectPoint);
										if(_128) {
											var _129 = intersectPoint.x;
											newX1 = _129;
											var _130 = intersectPoint.y;
											newY1 = _130;
											firstDone = true;
										}
										var _131 = this._width;
										var _132 = this._width;
										var _133 = this._height;
										var _134 = hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,_131,0,_132,_133,intersectPoint);
										if(_134) {
											var _135 = !firstDone;
											if(_135) {
												var _136 = intersectPoint.x;
												newX1 = _136;
												var _137 = intersectPoint.y;
												newY1 = _137;
												firstDone = true;
											} else {
												var _138 = intersectPoint.x;
												newX2 = _138;
												var _139 = intersectPoint.y;
												newY2 = _139;
												secondDone = true;
											}
										}
										var _143 = !secondDone;
										var _147;
										if(_143) {
											var _144 = this._height;
											var _140 = _144;
											var _145 = this._width;
											var _141 = _145;
											var _146 = this._height;
											var _142 = _146;
											_147 = hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,_140,_141,_142,intersectPoint);
										} else _147 = false;
										if(_147) {
											var _148 = !firstDone;
											if(_148) {
												var _149 = intersectPoint.x;
												newX1 = _149;
												var _150 = intersectPoint.y;
												newY1 = _150;
												firstDone = true;
											} else {
												var _151 = intersectPoint.x;
												newX2 = _151;
												var _152 = intersectPoint.y;
												newY2 = _152;
												secondDone = true;
											}
										}
										var _154 = !secondDone;
										var _156;
										if(_154) {
											var _155 = this._height;
											var _153 = _155;
											_156 = hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,0,_153,intersectPoint);
										} else _156 = false;
										if(_156) {
											var _157 = intersectPoint.x;
											newX2 = _157;
											var _158 = intersectPoint.y;
											newY2 = _158;
										}
										var _159 = !firstDone;
										if(_159) return null;
									}
								}
							}
						}
					}
				}
			} else {
				var _160 = p1pos == 2;
				var _161 = !_160;
				var _162;
				if(_161) _162 = p2pos == 2; else _162 = true;
				if(_162) {
					var _163 = this._width;
					hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,_163,0,intersectPoint);
				} else {
					var _164 = p1pos == 4;
					var _165 = !_164;
					var _166;
					if(_165) _166 = p2pos == 4; else _166 = true;
					if(_166) {
						var _167 = this._width;
						var _168 = this._width;
						var _169 = this._height;
						hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,_167,0,_168,_169,intersectPoint);
					} else {
						var _170 = p1pos == 6;
						var _171 = !_170;
						var _172;
						if(_171) _172 = p2pos == 6; else _172 = true;
						if(_172) {
							var _173 = this._height;
							var _174 = this._width;
							var _175 = this._height;
							hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,_173,_174,_175,intersectPoint);
						} else {
							var _176 = p1pos == 8;
							var _177 = !_176;
							var _178;
							if(_177) _178 = p2pos == 8; else _178 = true;
							if(_178) {
								var _179 = this._height;
								hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,0,_179,intersectPoint);
							} else {
								var _180 = this._width;
								var _181 = hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,_180,0,intersectPoint);
								var _182 = !_181;
								if(_182) {
									var _183 = this._width;
									var _184 = this._width;
									var _185 = this._height;
									var _186 = hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,_183,0,_184,_185,intersectPoint);
									var _187 = !_186;
									if(_187) {
										var _188 = this._height;
										var _189 = this._width;
										var _190 = this._height;
										var _191 = hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,_188,_189,_190,intersectPoint);
										var _192 = !_191;
										if(_192) {
											var _193 = this._height;
											hxDaedalus.data.math.Geom2D.intersections2segments(x1,y1,x2,y2,0,0,0,_193,intersectPoint);
										}
									}
								}
							}
						}
					}
				}
				var _194 = p1pos == 0;
				if(_194) {
					newX1 = x1;
					newY1 = y1;
				} else {
					newX1 = x2;
					newY1 = y2;
				}
				var _195 = intersectPoint.x;
				newX2 = _195;
				var _196 = intersectPoint.y;
				newY2 = _196;
			}
		}
		var _197 = this.insertVertex(newX1,newY1);
		var vertexDown = _197;
		var _198 = vertexDown == null;
		if(_198) return null;
		var _199 = this.insertVertex(newX2,newY2);
		var vertexUp = _199;
		var _200 = vertexUp == null;
		if(_200) return null;
		var _201 = vertexDown == vertexUp;
		if(_201) return null;
		var _202 = new hxDaedalus.iterators.FromVertexToOutgoingEdges();
		var iterVertexToOutEdges = _202;
		var currVertex;
		var currEdge;
		var i;
		var _203 = new hxDaedalus.data.ConstraintSegment();
		var segment = _203;
		var _204 = new hxDaedalus.data.Edge();
		var tempEdgeDownUp = _204;
		var _205 = new hxDaedalus.data.Edge();
		var tempSdgeUpDown = _205;
		tempEdgeDownUp.setDatas(vertexDown,tempSdgeUpDown,null,null,true,true);
		tempSdgeUpDown.setDatas(vertexUp,tempEdgeDownUp,null,null,true,true);
		var _206 = new Array();
		var intersectedEdges = _206;
		var _207 = new Array();
		var leftBoundingEdges = _207;
		var _208 = new Array();
		var rightBoundingEdges = _208;
		var currObjet;
		var _209 = new hxDaedalus.data.math.Point2D();
		var pIntersect = _209;
		var edgeLeft;
		var newEdgeDownUp;
		var newEdgeUpDown;
		var done;
		currVertex = vertexDown;
		var _210 = hxDaedalus.data.math.Intersection.EVertex(currVertex);
		currObjet = _210;
		try {
			while(true) {
				var _211 = !true;
				if(_211) throw "__break__";
				done = false;
				switch(currObjet[1]) {
				case 0:
					var vertex = currObjet[2];
					currVertex = vertex;
					iterVertexToOutEdges.set_fromVertex(currVertex);
					while(true) {
						var _212 = iterVertexToOutEdges.next();
						currEdge = _212;
						var _213 = currEdge;
						var _214 = _213 != null;
						var _215 = !_214;
						if(_215) break;
						var _216 = currEdge.get_destinationVertex();
						var _217 = _216 == vertexUp;
						if(_217) {
							var _218 = currEdge.get_isConstrained();
							var _219 = !_218;
							if(_219) {
								currEdge.set_isConstrained(true);
								currEdge.get_oppositeEdge().set_isConstrained(true);
							}
							currEdge.addFromConstraintSegment(segment);
							var _220 = currEdge.fromConstraintSegments;
							currEdge.get_oppositeEdge().fromConstraintSegments = _220;
							vertexDown.addFromConstraintSegment(segment);
							vertexUp.addFromConstraintSegment(segment);
							segment.addEdge(currEdge);
							return segment;
						}
						var _221 = currEdge.get_destinationVertex();
						var _222 = hxDaedalus.data.math.Geom2D.distanceSquaredVertexToEdge(_221,tempEdgeDownUp);
						var _223 = _222 <= 0.0001;
						if(_223) {
							var _224 = currEdge.get_isConstrained();
							var _225 = !_224;
							if(_225) {
								currEdge.set_isConstrained(true);
								currEdge.get_oppositeEdge().set_isConstrained(true);
							}
							currEdge.addFromConstraintSegment(segment);
							var _226 = currEdge.fromConstraintSegments;
							currEdge.get_oppositeEdge().fromConstraintSegments = _226;
							vertexDown.addFromConstraintSegment(segment);
							segment.addEdge(currEdge);
							var _227 = currEdge.get_destinationVertex();
							vertexDown = _227;
							tempEdgeDownUp.set_originVertex(vertexDown);
							var _228 = hxDaedalus.data.math.Intersection.EVertex(vertexDown);
							currObjet = _228;
							done = true;
							break;
						}
					}
					if(done) {
						var _229 = !true;
						if(_229) throw "__break__"; else continue;
					}
					iterVertexToOutEdges.set_fromVertex(currVertex);
					while(true) {
						var _230 = iterVertexToOutEdges.next();
						currEdge = _230;
						var _231 = currEdge;
						var _232 = _231 != null;
						var _233 = !_232;
						if(_233) break;
						var _234 = currEdge.get_nextLeftEdge();
						currEdge = _234;
						var _235 = hxDaedalus.data.math.Geom2D.intersections2edges(currEdge,tempEdgeDownUp,pIntersect);
						if(_235) {
							var _236 = currEdge.get_isConstrained();
							if(_236) {
								var _237 = pIntersect.x;
								var _238 = pIntersect.y;
								var _239 = this.splitEdge(currEdge,_237,_238);
								vertexDown = _239;
								iterVertexToOutEdges.set_fromVertex(currVertex);
								while(true) {
									var _240 = iterVertexToOutEdges.next();
									currEdge = _240;
									var _241 = currEdge;
									var _242 = _241 != null;
									var _243 = !_242;
									if(_243) break;
									var _244 = currEdge.get_destinationVertex();
									var _245 = _244 == vertexDown;
									if(_245) {
										currEdge.set_isConstrained(true);
										currEdge.get_oppositeEdge().set_isConstrained(true);
										currEdge.addFromConstraintSegment(segment);
										var _246 = currEdge.fromConstraintSegments;
										currEdge.get_oppositeEdge().fromConstraintSegments = _246;
										segment.addEdge(currEdge);
										break;
									}
								}
								currVertex.addFromConstraintSegment(segment);
								tempEdgeDownUp.set_originVertex(vertexDown);
								var _247 = hxDaedalus.data.math.Intersection.EVertex(vertexDown);
								currObjet = _247;
							} else {
								intersectedEdges.push(currEdge);
								var _248 = currEdge.get_nextLeftEdge();
								leftBoundingEdges.unshift(_248);
								var _249 = currEdge.get_prevLeftEdge();
								rightBoundingEdges.push(_249);
								var _250 = currEdge.get_oppositeEdge();
								currEdge = _250;
								var _251 = hxDaedalus.data.math.Intersection.EEdge(currEdge);
								currObjet = _251;
							}
							break;
						}
					}
					break;
				case 1:
					var edge = currObjet[2];
					currEdge = edge;
					var _252 = currEdge.get_nextLeftEdge();
					edgeLeft = _252;
					var _253 = edgeLeft.get_destinationVertex();
					var _254 = _253 == vertexUp;
					if(_254) {
						var _255 = edgeLeft.get_nextLeftEdge();
						leftBoundingEdges.unshift(_255);
						rightBoundingEdges.push(edgeLeft);
						var _256 = new hxDaedalus.data.Edge();
						newEdgeDownUp = _256;
						var _257 = new hxDaedalus.data.Edge();
						newEdgeUpDown = _257;
						newEdgeDownUp.setDatas(vertexDown,newEdgeUpDown,null,null,true,true);
						newEdgeUpDown.setDatas(vertexUp,newEdgeDownUp,null,null,true,true);
						leftBoundingEdges.push(newEdgeDownUp);
						rightBoundingEdges.push(newEdgeUpDown);
						var _258 = intersectedEdges;
						var _259 = leftBoundingEdges;
						var _260 = rightBoundingEdges;
						this.insertNewConstrainedEdge(segment,newEdgeDownUp,_258,_259,_260);
						return segment;
					} else {
						var _261 = edgeLeft.get_destinationVertex();
						var _262 = hxDaedalus.data.math.Geom2D.distanceSquaredVertexToEdge(_261,tempEdgeDownUp);
						var _263 = _262 <= 0.0001;
						if(_263) {
							var _264 = edgeLeft.get_nextLeftEdge();
							leftBoundingEdges.unshift(_264);
							rightBoundingEdges.push(edgeLeft);
							var _265 = new hxDaedalus.data.Edge();
							newEdgeDownUp = _265;
							var _266 = new hxDaedalus.data.Edge();
							newEdgeUpDown = _266;
							newEdgeDownUp.setDatas(vertexDown,newEdgeUpDown,null,null,true,true);
							var _267 = edgeLeft.get_destinationVertex();
							newEdgeUpDown.setDatas(_267,newEdgeDownUp,null,null,true,true);
							leftBoundingEdges.push(newEdgeDownUp);
							rightBoundingEdges.push(newEdgeUpDown);
							var _268 = intersectedEdges;
							var _269 = leftBoundingEdges;
							var _270 = rightBoundingEdges;
							this.insertNewConstrainedEdge(segment,newEdgeDownUp,_268,_269,_270);
							var _271 = intersectedEdges.length;
							intersectedEdges.splice(0,_271);
							var _272 = leftBoundingEdges.length;
							leftBoundingEdges.splice(0,_272);
							var _273 = rightBoundingEdges.length;
							rightBoundingEdges.splice(0,_273);
							var _274 = edgeLeft.get_destinationVertex();
							vertexDown = _274;
							tempEdgeDownUp.set_originVertex(vertexDown);
							var _275 = hxDaedalus.data.math.Intersection.EVertex(vertexDown);
							currObjet = _275;
						} else {
							var _276 = hxDaedalus.data.math.Geom2D.intersections2edges(edgeLeft,tempEdgeDownUp,pIntersect);
							if(_276) {
								var _277 = edgeLeft.get_isConstrained();
								if(_277) {
									var _278 = pIntersect.x;
									var _279 = pIntersect.y;
									var _280 = this.splitEdge(edgeLeft,_278,_279);
									currVertex = _280;
									iterVertexToOutEdges.set_fromVertex(currVertex);
									while(true) {
										var _281 = iterVertexToOutEdges.next();
										currEdge = _281;
										var _282 = currEdge;
										var _283 = _282 != null;
										var _284 = !_283;
										if(_284) break;
										var _285 = currEdge.get_destinationVertex();
										var _286 = leftBoundingEdges;
										var _287 = _286[0].get_originVertex();
										var _288 = _285 == _287;
										if(_288) leftBoundingEdges.unshift(currEdge);
										var _289 = currEdge.get_destinationVertex();
										var _290 = rightBoundingEdges;
										var _291 = rightBoundingEdges.length;
										var _292 = _291 - 1;
										var _293 = _290[_292].get_destinationVertex();
										var _294 = _289 == _293;
										if(_294) {
											var _295 = currEdge.get_oppositeEdge();
											rightBoundingEdges.push(_295);
										}
									}
									var _296 = new hxDaedalus.data.Edge();
									newEdgeDownUp = _296;
									var _297 = new hxDaedalus.data.Edge();
									newEdgeUpDown = _297;
									newEdgeDownUp.setDatas(vertexDown,newEdgeUpDown,null,null,true,true);
									newEdgeUpDown.setDatas(currVertex,newEdgeDownUp,null,null,true,true);
									leftBoundingEdges.push(newEdgeDownUp);
									rightBoundingEdges.push(newEdgeUpDown);
									var _298 = intersectedEdges;
									var _299 = leftBoundingEdges;
									var _300 = rightBoundingEdges;
									this.insertNewConstrainedEdge(segment,newEdgeDownUp,_298,_299,_300);
									var _301 = intersectedEdges.length;
									intersectedEdges.splice(0,_301);
									var _302 = leftBoundingEdges.length;
									leftBoundingEdges.splice(0,_302);
									var _303 = rightBoundingEdges.length;
									rightBoundingEdges.splice(0,_303);
									vertexDown = currVertex;
									tempEdgeDownUp.set_originVertex(vertexDown);
									var _304 = hxDaedalus.data.math.Intersection.EVertex(vertexDown);
									currObjet = _304;
								} else {
									intersectedEdges.push(edgeLeft);
									var _305 = edgeLeft.get_nextLeftEdge();
									leftBoundingEdges.unshift(_305);
									var _306 = edgeLeft.get_oppositeEdge();
									currEdge = _306;
									var _307 = hxDaedalus.data.math.Intersection.EEdge(currEdge);
									currObjet = _307;
								}
							} else {
								var _308 = edgeLeft.get_nextLeftEdge();
								edgeLeft = _308;
								hxDaedalus.data.math.Geom2D.intersections2edges(edgeLeft,tempEdgeDownUp,pIntersect);
								var _309 = edgeLeft.get_isConstrained();
								if(_309) {
									var _310 = pIntersect.x;
									var _311 = pIntersect.y;
									var _312 = this.splitEdge(edgeLeft,_310,_311);
									currVertex = _312;
									iterVertexToOutEdges.set_fromVertex(currVertex);
									while(true) {
										var _313 = iterVertexToOutEdges.next();
										currEdge = _313;
										var _314 = currEdge;
										var _315 = _314 != null;
										var _316 = !_315;
										if(_316) break;
										var _317 = currEdge.get_destinationVertex();
										var _318 = leftBoundingEdges;
										var _319 = _318[0].get_originVertex();
										var _320 = _317 == _319;
										if(_320) leftBoundingEdges.unshift(currEdge);
										var _321 = currEdge.get_destinationVertex();
										var _322 = rightBoundingEdges;
										var _323 = rightBoundingEdges.length;
										var _324 = _323 - 1;
										var _325 = _322[_324].get_destinationVertex();
										var _326 = _321 == _325;
										if(_326) {
											var _327 = currEdge.get_oppositeEdge();
											rightBoundingEdges.push(_327);
										}
									}
									var _328 = new hxDaedalus.data.Edge();
									newEdgeDownUp = _328;
									var _329 = new hxDaedalus.data.Edge();
									newEdgeUpDown = _329;
									newEdgeDownUp.setDatas(vertexDown,newEdgeUpDown,null,null,true,true);
									newEdgeUpDown.setDatas(currVertex,newEdgeDownUp,null,null,true,true);
									leftBoundingEdges.push(newEdgeDownUp);
									rightBoundingEdges.push(newEdgeUpDown);
									var _330 = intersectedEdges;
									var _331 = leftBoundingEdges;
									var _332 = rightBoundingEdges;
									this.insertNewConstrainedEdge(segment,newEdgeDownUp,_330,_331,_332);
									var _333 = intersectedEdges.length;
									intersectedEdges.splice(0,_333);
									var _334 = leftBoundingEdges.length;
									leftBoundingEdges.splice(0,_334);
									var _335 = rightBoundingEdges.length;
									rightBoundingEdges.splice(0,_335);
									vertexDown = currVertex;
									tempEdgeDownUp.set_originVertex(vertexDown);
									var _336 = hxDaedalus.data.math.Intersection.EVertex(vertexDown);
									currObjet = _336;
								} else {
									intersectedEdges.push(edgeLeft);
									var _337 = edgeLeft.get_prevLeftEdge();
									rightBoundingEdges.push(_337);
									var _338 = edgeLeft.get_oppositeEdge();
									currEdge = _338;
									var _339 = hxDaedalus.data.math.Intersection.EEdge(currEdge);
									currObjet = _339;
								}
							}
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
		} catch( e ) { if( e != "__break__" ) throw e; }
		return segment;
	}
	,insertNewConstrainedEdge: function(fromSegment,edgeDownUp,intersectedEdges,leftBoundingEdges,rightBoundingEdges) {
		this._edges.push(edgeDownUp);
		var _0 = edgeDownUp.get_oppositeEdge();
		this._edges.push(_0);
		edgeDownUp.addFromConstraintSegment(fromSegment);
		var _1 = edgeDownUp.fromConstraintSegments;
		edgeDownUp.get_oppositeEdge().fromConstraintSegments = _1;
		fromSegment.addEdge(edgeDownUp);
		edgeDownUp.get_originVertex().addFromConstraintSegment(fromSegment);
		edgeDownUp.get_destinationVertex().addFromConstraintSegment(fromSegment);
		var _2 = intersectedEdges;
		this.untriangulate(_2);
		var _3 = leftBoundingEdges;
		this.triangulate(_3,true);
		var _4 = rightBoundingEdges;
		this.triangulate(_4,true);
	}
	,deleteConstraintSegment: function(segment) {
		var i;
		var _0 = new Array();
		var vertexToDelete = _0;
		var edge = null;
		var vertex;
		var fromConstraintSegment;
		var _g1 = 0;
		var _1 = segment.get_edges().length;
		var _g = _1;
		while(true) {
			var _2 = _g1 < _g;
			var _3 = !_2;
			if(_3) break;
			var _4 = _g1++;
			var i1 = _4;
			var _5 = segment.get_edges();
			var _6 = _5[i1];
			edge = _6;
			edge.removeFromConstraintSegment(segment);
			var _7 = edge.fromConstraintSegments.length;
			var _8 = _7 == 0;
			if(_8) {
				edge.set_isConstrained(false);
				edge.get_oppositeEdge().set_isConstrained(false);
			}
			var _9 = edge.get_originVertex();
			vertex = _9;
			vertex.removeFromConstraintSegment(segment);
			vertexToDelete.push(vertex);
		}
		var _10 = edge.get_destinationVertex();
		vertex = _10;
		vertex.removeFromConstraintSegment(segment);
		vertexToDelete.push(vertex);
		var _g11 = 0;
		var _11 = vertexToDelete.length;
		var _g2 = _11;
		while(true) {
			var _12 = _g11 < _g2;
			var _13 = !_12;
			if(_13) break;
			var _14 = _g11++;
			var i2 = _14;
			var _15 = vertexToDelete;
			var _16 = _15[i2];
			this.deleteVertex(_16);
		}
		segment.dispose();
	}
	,check: function() {
		var _g1 = 0;
		var _0 = this._edges.length;
		var _g = _0;
		while(true) {
			var _1 = _g1 < _g;
			var _2 = !_1;
			if(_2) break;
			var _3 = _g1++;
			var i = _3;
			var _4 = this._edges;
			var _5 = _4[i].get_nextLeftEdge();
			var _6 = _5 == null;
			if(_6) {
				haxe.Log.trace("!!! missing nextLeftEdge",{ fileName : "Mesh.hx", lineNumber : 793, className : "hxDaedalus.data.Mesh", methodName : "check"});
				return;
			}
		}
		haxe.Log.trace("check OK",{ fileName : "Mesh.hx", lineNumber : 797, className : "hxDaedalus.data.Mesh", methodName : "check"});
	}
	,insertVertex: function(x,y) {
		var _0 = x < 0;
		var _1 = !_0;
		var _3;
		if(_1) _3 = y < 0; else _3 = true;
		var _4 = !_3;
		var _8;
		if(_4) {
			var _7 = this._width;
			var _5 = _7;
			var _2 = _5;
			_8 = x > _2;
		} else _8 = true;
		var _9 = !_8;
		var _11;
		if(_9) {
			var _10 = this._height;
			var _6 = _10;
			_11 = y > _6;
		} else _11 = true;
		if(_11) return null;
		var _12 = this.__edgesToCheck.length;
		this.__edgesToCheck.splice(0,_12);
		var _13 = hxDaedalus.data.math.Geom2D.locatePosition(x,y,this);
		var inObject = _13;
		var newVertex = null;
		switch(inObject[1]) {
		case 0:
			var vertex = inObject[2];
			newVertex = vertex;
			break;
		case 1:
			var edge = inObject[2];
			var _14 = this.splitEdge(edge,x,y);
			newVertex = _14;
			break;
		case 2:
			var face = inObject[2];
			var _15 = this.splitFace(face,x,y);
			newVertex = _15;
			break;
		case 3:
			break;
		}
		this.restoreAsDelaunay();
		return newVertex;
	}
	,flipEdge: function(edge) {
		var eBot_Top = edge;
		var _0 = edge.get_oppositeEdge();
		var eTop_Bot = _0;
		var _1 = new hxDaedalus.data.Edge();
		var eLeft_Right = _1;
		var _2 = new hxDaedalus.data.Edge();
		var eRight_Left = _2;
		var _3 = eBot_Top.get_nextLeftEdge();
		var eTop_Left = _3;
		var _4 = eTop_Left.get_nextLeftEdge();
		var eLeft_Bot = _4;
		var _5 = eTop_Bot.get_nextLeftEdge();
		var eBot_Right = _5;
		var _6 = eBot_Right.get_nextLeftEdge();
		var eRight_Top = _6;
		var _7 = eBot_Top.get_originVertex();
		var vBot = _7;
		var _8 = eTop_Bot.get_originVertex();
		var vTop = _8;
		var _9 = eLeft_Bot.get_originVertex();
		var vLeft = _9;
		var _10 = eRight_Top.get_originVertex();
		var vRight = _10;
		var _11 = eBot_Top.get_leftFace();
		var fLeft = _11;
		var _12 = eTop_Bot.get_leftFace();
		var fRight = _12;
		var _13 = new hxDaedalus.data.Face();
		var fBot = _13;
		var _14 = new hxDaedalus.data.Face();
		var fTop = _14;
		this._edges.push(eLeft_Right);
		this._edges.push(eRight_Left);
		this._faces.push(fTop);
		this._faces.push(fBot);
		var _15 = edge.get_isReal();
		var _16 = edge.get_isConstrained();
		eLeft_Right.setDatas(vLeft,eRight_Left,eRight_Top,fTop,_15,_16);
		var _17 = edge.get_isReal();
		var _18 = edge.get_isConstrained();
		eRight_Left.setDatas(vRight,eLeft_Right,eLeft_Bot,fBot,_17,_18);
		fTop.setDatas(eLeft_Right);
		fBot.setDatas(eRight_Left);
		var _19 = vTop.get_edge();
		var _20 = _19 == eTop_Bot;
		if(_20) vTop.setDatas(eTop_Left);
		var _21 = vBot.get_edge();
		var _22 = _21 == eBot_Top;
		if(_22) vBot.setDatas(eBot_Right);
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
		var _23 = this._edges;
		var _24 = null != null;
		var _25;
		if(_24) _25 = null; else _25 = 0;
		var _26 = HxOverrides.indexOf(_23,eBot_Top,_25);
		this._edges.splice(_26,1);
		var _27 = this._edges;
		var _28 = null != null;
		var _29;
		if(_28) _29 = null; else _29 = 0;
		var _30 = HxOverrides.indexOf(_27,eTop_Bot,_29);
		this._edges.splice(_30,1);
		fLeft.dispose();
		fRight.dispose();
		var _31 = this._faces;
		var _32 = null != null;
		var _33;
		if(_32) _33 = null; else _33 = 0;
		var _34 = HxOverrides.indexOf(_31,fLeft,_33);
		this._faces.splice(_34,1);
		var _35 = this._faces;
		var _36 = null != null;
		var _37;
		if(_36) _37 = null; else _37 = 0;
		var _38 = HxOverrides.indexOf(_35,fRight,_37);
		this._faces.splice(_38,1);
		return eRight_Left;
	}
	,splitEdge: function(edge,x,y) {
		var _0 = this.__edgesToCheck.length;
		this.__edgesToCheck.splice(0,_0);
		var eLeft_Right = edge;
		var _1 = eLeft_Right.get_oppositeEdge();
		var eRight_Left = _1;
		var _2 = eLeft_Right.get_nextLeftEdge();
		var eRight_Top = _2;
		var _3 = eRight_Top.get_nextLeftEdge();
		var eTop_Left = _3;
		var _4 = eRight_Left.get_nextLeftEdge();
		var eLeft_Bot = _4;
		var _5 = eLeft_Bot.get_nextLeftEdge();
		var eBot_Right = _5;
		var _6 = eTop_Left.get_originVertex();
		var vTop = _6;
		var _7 = eLeft_Right.get_originVertex();
		var vLeft = _7;
		var _8 = eBot_Right.get_originVertex();
		var vBot = _8;
		var _9 = eRight_Left.get_originVertex();
		var vRight = _9;
		var _10 = eLeft_Right.get_leftFace();
		var fTop = _10;
		var _11 = eRight_Left.get_leftFace();
		var fBot = _11;
		var _12 = vLeft.get_pos().x;
		var _13 = _12 - x;
		var _14 = vLeft.get_pos().x;
		var _15 = _14 - x;
		var _16 = _13 * _15;
		var _17 = vLeft.get_pos().y;
		var _18 = _17 - y;
		var _19 = vLeft.get_pos().y;
		var _20 = _19 - y;
		var _21 = _18 * _20;
		var _22 = _16 + _21;
		var _23 = _22 <= 0.0001;
		if(_23) return vLeft;
		var _24 = vRight.get_pos().x;
		var _25 = _24 - x;
		var _26 = vRight.get_pos().x;
		var _27 = _26 - x;
		var _28 = _25 * _27;
		var _29 = vRight.get_pos().y;
		var _30 = _29 - y;
		var _31 = vRight.get_pos().y;
		var _32 = _31 - y;
		var _33 = _30 * _32;
		var _34 = _28 + _33;
		var _35 = _34 <= 0.0001;
		if(_35) return vRight;
		var _36 = new hxDaedalus.data.Vertex();
		var vCenter = _36;
		var _37 = new hxDaedalus.data.Edge();
		var eTop_Center = _37;
		var _38 = new hxDaedalus.data.Edge();
		var eCenter_Top = _38;
		var _39 = new hxDaedalus.data.Edge();
		var eBot_Center = _39;
		var _40 = new hxDaedalus.data.Edge();
		var eCenter_Bot = _40;
		var _41 = new hxDaedalus.data.Edge();
		var eLeft_Center = _41;
		var _42 = new hxDaedalus.data.Edge();
		var eCenter_Left = _42;
		var _43 = new hxDaedalus.data.Edge();
		var eRight_Center = _43;
		var _44 = new hxDaedalus.data.Edge();
		var eCenter_Right = _44;
		var _45 = new hxDaedalus.data.Face();
		var fTopLeft = _45;
		var _46 = new hxDaedalus.data.Face();
		var fBotLeft = _46;
		var _47 = new hxDaedalus.data.Face();
		var fBotRight = _47;
		var _48 = new hxDaedalus.data.Face();
		var fTopRight = _48;
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
		var _49 = fTop.get_isReal();
		var _50;
		if(_49) _50 = eCenter_Top; else _50 = eCenter_Bot;
		vCenter.setDatas(_50);
		vCenter.get_pos().x = x;
		vCenter.get_pos().y = y;
		var _51 = vCenter.get_pos();
		hxDaedalus.data.math.Geom2D.projectOrthogonaly(_51,eLeft_Right);
		var _52 = fTop.get_isReal();
		eCenter_Top.setDatas(vCenter,eTop_Center,eTop_Left,fTopLeft,_52);
		var _53 = fTop.get_isReal();
		eTop_Center.setDatas(vTop,eCenter_Top,eCenter_Right,fTopRight,_53);
		var _54 = edge.get_isReal();
		var _55 = edge.get_isConstrained();
		eCenter_Left.setDatas(vCenter,eLeft_Center,eLeft_Bot,fBotLeft,_54,_55);
		var _56 = edge.get_isReal();
		var _57 = edge.get_isConstrained();
		eLeft_Center.setDatas(vLeft,eCenter_Left,eCenter_Top,fTopLeft,_56,_57);
		var _58 = fBot.get_isReal();
		eCenter_Bot.setDatas(vCenter,eBot_Center,eBot_Right,fBotRight,_58);
		var _59 = fBot.get_isReal();
		eBot_Center.setDatas(vBot,eCenter_Bot,eCenter_Left,fBotLeft,_59);
		var _60 = edge.get_isReal();
		var _61 = edge.get_isConstrained();
		eCenter_Right.setDatas(vCenter,eRight_Center,eRight_Top,fTopRight,_60,_61);
		var _62 = edge.get_isReal();
		var _63 = edge.get_isConstrained();
		eRight_Center.setDatas(vRight,eCenter_Right,eCenter_Bot,fBotRight,_62,_63);
		var _64 = fTop.get_isReal();
		fTopLeft.setDatas(eCenter_Top,_64);
		var _65 = fBot.get_isReal();
		fBotLeft.setDatas(eCenter_Left,_65);
		var _66 = fBot.get_isReal();
		fBotRight.setDatas(eCenter_Bot,_66);
		var _67 = fTop.get_isReal();
		fTopRight.setDatas(eCenter_Right,_67);
		var _68 = vLeft.get_edge();
		var _69 = _68 == eLeft_Right;
		if(_69) vLeft.setDatas(eLeft_Center);
		var _70 = vRight.get_edge();
		var _71 = _70 == eRight_Left;
		if(_71) vRight.setDatas(eRight_Center);
		eTop_Left.set_nextLeftEdge(eLeft_Center);
		eTop_Left.set_leftFace(fTopLeft);
		eLeft_Bot.set_nextLeftEdge(eBot_Center);
		eLeft_Bot.set_leftFace(fBotLeft);
		eBot_Right.set_nextLeftEdge(eRight_Center);
		eBot_Right.set_leftFace(fBotRight);
		eRight_Top.set_nextLeftEdge(eTop_Center);
		eRight_Top.set_leftFace(fTopRight);
		var _72 = eLeft_Right.get_isConstrained();
		if(_72) {
			var _73 = eLeft_Right.fromConstraintSegments;
			var fromSegments = _73;
			var _74 = fromSegments.slice(0);
			eLeft_Center.fromConstraintSegments = _74;
			var _75 = eLeft_Center.fromConstraintSegments;
			eCenter_Left.fromConstraintSegments = _75;
			var _76 = fromSegments.slice(0);
			eCenter_Right.fromConstraintSegments = _76;
			var _77 = eCenter_Right.fromConstraintSegments;
			eRight_Center.fromConstraintSegments = _77;
			var edges;
			var index;
			var _g1 = 0;
			var _78 = eLeft_Right.fromConstraintSegments.length;
			var _g = _78;
			while(true) {
				var _79 = _g1 < _g;
				var _80 = !_79;
				if(_80) break;
				var _81 = _g1++;
				var i = _81;
				var _82 = eLeft_Right.fromConstraintSegments;
				var _83 = _82[i].get_edges();
				edges = _83;
				var _84 = edges;
				var _85 = null != null;
				var _86;
				if(_85) _86 = null; else _86 = 0;
				var _87 = HxOverrides.indexOf(_84,eLeft_Right,_86);
				index = _87;
				var _88 = index != -1;
				if(_88) {
					edges.splice(index,1);
					edges.splice(index,0,eLeft_Center);
					var _89 = index + 1;
					edges.splice(_89,0,eCenter_Right);
				} else {
					var _90 = edges;
					var _91 = null != null;
					var _92;
					if(_91) _92 = null; else _92 = 0;
					var _93 = HxOverrides.indexOf(_90,eRight_Left,_92);
					var index2 = _93;
					edges.splice(index2,1);
					edges.splice(index2,0,eRight_Center);
					edges.splice(index2,0,eCenter_Left);
				}
			}
			var _94 = fromSegments.slice(0);
			vCenter.set_fromConstraintSegments(_94);
		}
		eLeft_Right.dispose();
		eRight_Left.dispose();
		var _95 = this._edges;
		var _96 = null != null;
		var _97;
		if(_96) _97 = null; else _97 = 0;
		var _98 = HxOverrides.indexOf(_95,eLeft_Right,_97);
		this._edges.splice(_98,1);
		var _99 = this._edges;
		var _100 = null != null;
		var _101;
		if(_100) _101 = null; else _101 = 0;
		var _102 = HxOverrides.indexOf(_99,eRight_Left,_101);
		this._edges.splice(_102,1);
		fTop.dispose();
		fBot.dispose();
		var _103 = this._faces;
		var _104 = null != null;
		var _105;
		if(_104) _105 = null; else _105 = 0;
		var _106 = HxOverrides.indexOf(_103,fTop,_105);
		this._faces.splice(_106,1);
		var _107 = this._faces;
		var _108 = null != null;
		var _109;
		if(_108) _109 = null; else _109 = 0;
		var _110 = HxOverrides.indexOf(_107,fBot,_109);
		this._faces.splice(_110,1);
		this.__centerVertex = vCenter;
		this.__edgesToCheck.push(eTop_Left);
		this.__edgesToCheck.push(eLeft_Bot);
		this.__edgesToCheck.push(eBot_Right);
		this.__edgesToCheck.push(eRight_Top);
		return vCenter;
	}
	,splitFace: function(face,x,y) {
		var _0 = this.__edgesToCheck.length;
		this.__edgesToCheck.splice(0,_0);
		var _1 = face.get_edge();
		var eTop_Left = _1;
		var _2 = eTop_Left.get_nextLeftEdge();
		var eLeft_Right = _2;
		var _3 = eLeft_Right.get_nextLeftEdge();
		var eRight_Top = _3;
		var _4 = eTop_Left.get_originVertex();
		var vTop = _4;
		var _5 = eLeft_Right.get_originVertex();
		var vLeft = _5;
		var _6 = eRight_Top.get_originVertex();
		var vRight = _6;
		var _7 = new hxDaedalus.data.Vertex();
		var vCenter = _7;
		var _8 = new hxDaedalus.data.Edge();
		var eTop_Center = _8;
		var _9 = new hxDaedalus.data.Edge();
		var eCenter_Top = _9;
		var _10 = new hxDaedalus.data.Edge();
		var eLeft_Center = _10;
		var _11 = new hxDaedalus.data.Edge();
		var eCenter_Left = _11;
		var _12 = new hxDaedalus.data.Edge();
		var eRight_Center = _12;
		var _13 = new hxDaedalus.data.Edge();
		var eCenter_Right = _13;
		var _14 = new hxDaedalus.data.Face();
		var fTopLeft = _14;
		var _15 = new hxDaedalus.data.Face();
		var fBot = _15;
		var _16 = new hxDaedalus.data.Face();
		var fTopRight = _16;
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
		var _17 = this._faces;
		var _18 = null != null;
		var _19;
		if(_18) _19 = null; else _19 = 0;
		var _20 = HxOverrides.indexOf(_17,face,_19);
		this._faces.splice(_20,1);
		this.__centerVertex = vCenter;
		this.__edgesToCheck.push(eTop_Left);
		this.__edgesToCheck.push(eLeft_Right);
		this.__edgesToCheck.push(eRight_Top);
		return vCenter;
	}
	,restoreAsDelaunay: function() {
		var edge;
		while(true) {
			var _0 = this.__edgesToCheck.length;
			var _1 = _0 > 0;
			var _2 = !_1;
			if(_2) break;
			var _3 = this.__edgesToCheck.shift();
			edge = _3;
			var _5 = edge.get_isReal();
			var _9;
			if(_5) {
				var _8 = edge.get_isConstrained();
				var _6 = _8;
				var _4 = _6;
				_9 = !_4;
			} else _9 = false;
			var _11;
			if(_9) {
				var _10 = hxDaedalus.data.math.Geom2D.isDelaunay(edge);
				var _7 = _10;
				_11 = !_7;
			} else _11 = false;
			if(_11) {
				var _12 = edge.get_nextLeftEdge().get_destinationVertex();
				var _13 = this.__centerVertex;
				var _14 = _12 == _13;
				if(_14) {
					var _15 = edge.get_nextRightEdge();
					this.__edgesToCheck.push(_15);
					var _16 = edge.get_prevRightEdge();
					this.__edgesToCheck.push(_16);
				} else {
					var _17 = edge.get_nextLeftEdge();
					this.__edgesToCheck.push(_17);
					var _18 = edge.get_prevLeftEdge();
					this.__edgesToCheck.push(_18);
				}
				this.flipEdge(edge);
			}
		}
	}
	,deleteVertex: function(vertex) {
		var i;
		var freeOfConstraint;
		var _0 = new hxDaedalus.iterators.FromVertexToOutgoingEdges();
		var iterEdges = _0;
		iterEdges.set_fromVertex(vertex);
		iterEdges.realEdgesOnly = false;
		var edge;
		var _1 = new Array();
		var outgoingEdges = _1;
		var _2 = vertex.get_fromConstraintSegments().length;
		var _3 = _2 == 0;
		freeOfConstraint = _3;
		var _4 = new Array();
		var bound = _4;
		var realA = false;
		var realB = false;
		var _5 = [];
		var boundA = _5;
		var _6 = [];
		var boundB = _6;
		if(freeOfConstraint) while(true) {
			var _7 = iterEdges.next();
			edge = _7;
			var _8 = edge;
			var _9 = _8 != null;
			var _10 = !_9;
			if(_10) break;
			outgoingEdges.push(edge);
			var _11 = edge.get_nextLeftEdge();
			bound.push(_11);
		} else {
			var edges;
			var _g1 = 0;
			var _12 = vertex.get_fromConstraintSegments().length;
			var _g = _12;
			while(true) {
				var _13 = _g1 < _g;
				var _14 = !_13;
				if(_14) break;
				var _15 = _g1++;
				var i1 = _15;
				var _16 = vertex.get_fromConstraintSegments();
				var _17 = _16[i1].get_edges();
				edges = _17;
				var _18 = edges;
				var _19 = _18[0].get_originVertex();
				var _24 = _19 == vertex;
				var _25 = !_24;
				var _31;
				if(_25) {
					var _26 = edges;
					var _20 = _26;
					var _27 = edges.length;
					var _21 = _27;
					var _28 = _21 - 1;
					var _22 = _28;
					var _29 = _20;
					var _30 = _29[_22].get_destinationVertex();
					var _23 = _30;
					_31 = _23 == vertex;
				} else _31 = true;
				if(_31) return false;
			}
			var count = 0;
			while(true) {
				var _32 = iterEdges.next();
				edge = _32;
				var _33 = edge;
				var _34 = _33 != null;
				var _35 = !_34;
				if(_35) break;
				outgoingEdges.push(edge);
				var _36 = edge.get_isConstrained();
				if(_36) {
					count++;
					var _37 = count > 2;
					if(_37) return false;
				}
			}
			var _38 = new Array();
			boundA = _38;
			var _39 = new Array();
			boundB = _39;
			var constrainedEdgeA = null;
			var constrainedEdgeB = null;
			var _40 = new hxDaedalus.data.Edge();
			var edgeA = _40;
			var _41 = new hxDaedalus.data.Edge();
			var edgeB = _41;
			this._edges.push(edgeA);
			this._edges.push(edgeB);
			var _g11 = 0;
			var _42 = outgoingEdges.length;
			var _g2 = _42;
			while(true) {
				var _43 = _g11 < _g2;
				var _44 = !_43;
				if(_44) break;
				var _45 = _g11++;
				var i2 = _45;
				var _46 = outgoingEdges;
				var _47 = _46[i2];
				edge = _47;
				var _48 = edge.get_isConstrained();
				if(_48) {
					var _49 = constrainedEdgeA == null;
					if(_49) {
						var _50 = edge.get_destinationVertex();
						edgeB.setDatas(_50,edgeA,null,null,true,true);
						boundA.push(edgeA);
						var _51 = edge.get_nextLeftEdge();
						boundA.push(_51);
						boundB.push(edgeB);
						constrainedEdgeA = edge;
					} else {
						var _52 = constrainedEdgeB == null;
						if(_52) {
							var _53 = edge.get_destinationVertex();
							edgeA.setDatas(_53,edgeB,null,null,true,true);
							var _54 = edge.get_nextLeftEdge();
							boundB.push(_54);
							constrainedEdgeB = edge;
						}
					}
				} else {
					var _55 = constrainedEdgeA == null;
					if(_55) {
						var _56 = edge.get_nextLeftEdge();
						boundB.push(_56);
					} else {
						var _57 = constrainedEdgeB == null;
						if(_57) {
							var _58 = edge.get_nextLeftEdge();
							boundA.push(_58);
						} else {
							var _59 = edge.get_nextLeftEdge();
							boundB.push(_59);
						}
					}
				}
			}
			var _60 = constrainedEdgeA.get_leftFace().get_isReal();
			realA = _60;
			var _61 = constrainedEdgeB.get_leftFace().get_isReal();
			realB = _61;
			var _62 = constrainedEdgeA.fromConstraintSegments.slice(0);
			edgeA.fromConstraintSegments = _62;
			var _63 = edgeA.fromConstraintSegments;
			edgeB.fromConstraintSegments = _63;
			var index;
			var _g12 = 0;
			var _64 = vertex.get_fromConstraintSegments().length;
			var _g3 = _64;
			while(true) {
				var _65 = _g12 < _g3;
				var _66 = !_65;
				if(_66) break;
				var _67 = _g12++;
				var i3 = _67;
				var _68 = vertex.get_fromConstraintSegments();
				var _69 = _68[i3].get_edges();
				edges = _69;
				var _70 = edges;
				var _71 = null != null;
				var _72;
				if(_71) _72 = null; else _72 = 0;
				var _73 = HxOverrides.indexOf(_70,constrainedEdgeA,_72);
				index = _73;
				var _74 = index != -1;
				if(_74) {
					var _75 = index - 1;
					edges.splice(_75,2);
					var _76 = index - 1;
					edges.splice(_76,0,edgeA);
				} else {
					var _77 = edges;
					var _78 = null != null;
					var _79;
					if(_78) _79 = null; else _79 = 0;
					var _80 = HxOverrides.indexOf(_77,constrainedEdgeB,_79);
					var _81 = _80 - 1;
					var index2 = _81;
					edges.splice(index2,2);
					edges.splice(index2,0,edgeB);
				}
			}
		}
		var faceToDelete;
		var _g13 = 0;
		var _82 = outgoingEdges.length;
		var _g4 = _82;
		while(true) {
			var _83 = _g13 < _g4;
			var _84 = !_83;
			if(_84) break;
			var _85 = _g13++;
			var i4 = _85;
			var _86 = outgoingEdges;
			var _87 = _86[i4];
			edge = _87;
			var _88 = edge.get_leftFace();
			faceToDelete = _88;
			var _89 = this._faces;
			var _90 = null != null;
			var _91;
			if(_90) _91 = null; else _91 = 0;
			var _92 = HxOverrides.indexOf(_89,faceToDelete,_91);
			this._faces.splice(_92,1);
			faceToDelete.dispose();
			var _93 = edge.get_nextLeftEdge();
			edge.get_destinationVertex().set_edge(_93);
			var _98;
			var _94 = edge.get_oppositeEdge();
			var x = _94;
			var _95 = this._edges;
			var _96 = null != null;
			var _97;
			if(_96) _97 = null; else _97 = 0;
			_98 = HxOverrides.indexOf(_95,x,_97);
			this._edges.splice(_98,1);
			edge.get_oppositeEdge().dispose();
			var _99 = this._edges;
			var _100 = null != null;
			var _101;
			if(_100) _101 = null; else _101 = 0;
			var _102 = HxOverrides.indexOf(_99,edge,_101);
			this._edges.splice(_102,1);
			edge.dispose();
		}
		var _103 = this._vertices;
		var _104 = null != null;
		var _105;
		if(_104) _105 = null; else _105 = 0;
		var _106 = HxOverrides.indexOf(_103,vertex,_105);
		this._vertices.splice(_106,1);
		vertex.dispose();
		if(freeOfConstraint) {
			var _107 = bound;
			this.triangulate(_107,true);
		} else {
			var _108 = boundA;
			this.triangulate(_108,realA);
			var _109 = boundB;
			this.triangulate(_109,realB);
		}
		return true;
	}
	,untriangulate: function(edgesList) {
		var i;
		var _2;
		var _1 = new haxe.ds.ObjectMap();
		var _0 = _1;
		_2 = _0;
		var verticesCleaned = _2;
		var currEdge;
		var outEdge;
		var _g1 = 0;
		var _3 = edgesList.length;
		var _g = _3;
		while(true) {
			var _4 = _g1 < _g;
			var _5 = !_4;
			if(_5) break;
			var _6 = _g1++;
			var i1 = _6;
			var _7 = edgesList;
			var _8 = _7[i1];
			currEdge = _8;
			var _10;
			var _9 = currEdge.get_originVertex();
			var key = _9;
			_10 = verticesCleaned.get(key);
			var _11 = _10 == null;
			if(_11) {
				var _12 = currEdge.get_prevLeftEdge().get_oppositeEdge();
				currEdge.get_originVertex().set_edge(_12);
				var _13 = currEdge.get_originVertex();
				var k = _13;
				verticesCleaned.set(k,true);
				true;
			}
			var _15;
			var _14 = currEdge.get_destinationVertex();
			var key1 = _14;
			_15 = verticesCleaned.get(key1);
			var _16 = _15 == null;
			if(_16) {
				var _17 = currEdge.get_nextLeftEdge();
				currEdge.get_destinationVertex().set_edge(_17);
				var _18 = currEdge.get_destinationVertex();
				var k1 = _18;
				verticesCleaned.set(k1,true);
				true;
			}
			var _23;
			var _19 = currEdge.get_leftFace();
			var x = _19;
			var _20 = this._faces;
			var _21 = null != null;
			var _22;
			if(_21) _22 = null; else _22 = 0;
			_23 = HxOverrides.indexOf(_20,x,_22);
			this._faces.splice(_23,1);
			currEdge.get_leftFace().dispose();
			var _24 = edgesList.length;
			var _25 = _24 - 1;
			var _26 = i1 == _25;
			if(_26) {
				var _31;
				var _27 = currEdge.get_rightFace();
				var x1 = _27;
				var _28 = this._faces;
				var _29 = null != null;
				var _30;
				if(_29) _30 = null; else _30 = 0;
				_31 = HxOverrides.indexOf(_28,x1,_30);
				this._faces.splice(_31,1);
				currEdge.get_rightFace().dispose();
			}
		}
		var _g11 = 0;
		var _32 = edgesList.length;
		var _g2 = _32;
		while(true) {
			var _33 = _g11 < _g2;
			var _34 = !_33;
			if(_34) break;
			var _35 = _g11++;
			var i2 = _35;
			var _36 = edgesList;
			var _37 = _36[i2];
			currEdge = _37;
			var _42;
			var _38 = currEdge.get_oppositeEdge();
			var x2 = _38;
			var _39 = this._edges;
			var _40 = null != null;
			var _41;
			if(_40) _41 = null; else _41 = 0;
			_42 = HxOverrides.indexOf(_39,x2,_41);
			this._edges.splice(_42,1);
			var _43 = this._edges;
			var _44 = null != null;
			var _45;
			if(_44) _45 = null; else _45 = 0;
			var _46 = HxOverrides.indexOf(_43,currEdge,_45);
			this._edges.splice(_46,1);
			currEdge.get_oppositeEdge().dispose();
			currEdge.dispose();
		}
	}
	,triangulate: function(bound,isReal) {
		var _0 = bound.length;
		var _1 = _0 < 2;
		if(_1) {
			haxe.Log.trace("BREAK ! the hole has less than 2 edges",{ fileName : "Mesh.hx", lineNumber : 1395, className : "hxDaedalus.data.Mesh", methodName : "triangulate"});
			return;
		} else {
			var _2 = bound.length;
			var _3 = _2 == 2;
			if(_3) {
				haxe.Log.trace("BREAK ! the hole has only 2 edges",{ fileName : "Mesh.hx", lineNumber : 1402, className : "hxDaedalus.data.Mesh", methodName : "triangulate"});
				var _4 = bound;
				var _5 = _4[0].get_originVertex().get_id();
				var _6 = "  - edge0: " + _5;
				var _7 = _6 + " -> ";
				var _8 = bound;
				var _9 = _8[0].get_destinationVertex().get_id();
				var _10 = _7 + _9;
				var _11 = { fileName : "Mesh.hx", lineNumber : 1403, className : "hxDaedalus.data.Mesh", methodName : "triangulate"};
				hxDaedalus.debug.Debug.trace(_10,_11);
				var _12 = bound;
				var _13 = _12[1].get_originVertex().get_id();
				var _14 = "  - edge1: " + _13;
				var _15 = _14 + " -> ";
				var _16 = bound;
				var _17 = _16[1].get_destinationVertex().get_id();
				var _18 = _15 + _17;
				var _19 = { fileName : "Mesh.hx", lineNumber : 1404, className : "hxDaedalus.data.Mesh", methodName : "triangulate"};
				hxDaedalus.debug.Debug.trace(_18,_19);
				return;
			} else {
				var _20 = bound.length;
				var _21 = _20 == 3;
				if(_21) {
					var _22 = new hxDaedalus.data.Face();
					var f = _22;
					var _23 = bound;
					var _24 = _23[0];
					f.setDatas(_24,isReal);
					this._faces.push(f);
					var _25 = bound;
					_25[0].set_leftFace(f);
					var _26 = bound;
					_26[1].set_leftFace(f);
					var _27 = bound;
					_27[2].set_leftFace(f);
					var _28 = bound;
					var _29 = bound;
					var _30 = _29[1];
					_28[0].set_nextLeftEdge(_30);
					var _31 = bound;
					var _32 = bound;
					var _33 = _32[2];
					_31[1].set_nextLeftEdge(_33);
					var _34 = bound;
					var _35 = bound;
					var _36 = _35[0];
					_34[2].set_nextLeftEdge(_36);
				} else {
					var _37 = bound;
					var _38 = _37[0];
					var baseEdge = _38;
					var _39 = baseEdge.get_originVertex();
					var vertexA = _39;
					var _40 = baseEdge.get_destinationVertex();
					var vertexB = _40;
					var vertexC;
					var vertexCheck;
					var _41 = new hxDaedalus.data.math.Point2D();
					var circumcenter = _41;
					var radiusSquared;
					var distanceSquared;
					var isDelaunay = false;
					var index = 0;
					var i;
					var _g1 = 2;
					var _42 = bound.length;
					var _g = _42;
					while(true) {
						var _43 = _g1 < _g;
						var _44 = !_43;
						if(_44) break;
						var _45 = _g1++;
						var i1 = _45;
						var _46 = bound;
						var _47 = _46[i1].get_originVertex();
						vertexC = _47;
						var _48 = vertexC.get_pos().x;
						var _49 = vertexC.get_pos().y;
						var _50 = hxDaedalus.data.math.Geom2D.getRelativePosition2(_48,_49,baseEdge);
						var _51 = _50 == 1;
						if(_51) {
							index = i1;
							isDelaunay = true;
							var _52 = vertexA.get_pos().x;
							var _53 = vertexA.get_pos().y;
							var _54 = vertexB.get_pos().x;
							var _55 = vertexB.get_pos().y;
							var _56 = vertexC.get_pos().x;
							var _57 = vertexC.get_pos().y;
							hxDaedalus.data.math.Geom2D.getCircumcenter(_52,_53,_54,_55,_56,_57,circumcenter);
							var _58 = vertexA.get_pos().x;
							var _59 = circumcenter.x;
							var _60 = _58 - _59;
							var _61 = vertexA.get_pos().x;
							var _62 = circumcenter.x;
							var _63 = _61 - _62;
							var _64 = _60 * _63;
							var _65 = vertexA.get_pos().y;
							var _66 = circumcenter.y;
							var _67 = _65 - _66;
							var _68 = vertexA.get_pos().y;
							var _69 = circumcenter.y;
							var _70 = _68 - _69;
							var _71 = _67 * _70;
							var _72 = _64 + _71;
							radiusSquared = _72;
							radiusSquared -= 0.0001;
							var _g3 = 2;
							var _73 = bound.length;
							var _g2 = _73;
							while(true) {
								var _74 = _g3 < _g2;
								var _75 = !_74;
								if(_75) break;
								var _76 = _g3++;
								var j = _76;
								var _77 = j != i1;
								if(_77) {
									var _78 = bound;
									var _79 = _78[j].get_originVertex();
									vertexCheck = _79;
									var _80 = vertexCheck.get_pos().x;
									var _81 = circumcenter.x;
									var _82 = _80 - _81;
									var _83 = vertexCheck.get_pos().x;
									var _84 = circumcenter.x;
									var _85 = _83 - _84;
									var _86 = _82 * _85;
									var _87 = vertexCheck.get_pos().y;
									var _88 = circumcenter.y;
									var _89 = _87 - _88;
									var _90 = vertexCheck.get_pos().y;
									var _91 = circumcenter.y;
									var _92 = _90 - _91;
									var _93 = _89 * _92;
									var _94 = _86 + _93;
									distanceSquared = _94;
									var _95 = distanceSquared < radiusSquared;
									if(_95) {
										isDelaunay = false;
										break;
									}
								}
							}
							if(isDelaunay) break;
						}
					}
					var _96 = !isDelaunay;
					if(_96) {
						haxe.Log.trace("NO DELAUNAY FOUND",{ fileName : "Mesh.hx", lineNumber : 1475, className : "hxDaedalus.data.Mesh", methodName : "triangulate"});
						var s = "";
						var _g11 = 0;
						var _97 = bound.length;
						var _g4 = _97;
						while(true) {
							var _98 = _g11 < _g4;
							var _99 = !_98;
							if(_99) break;
							var _100 = _g11++;
							var i2 = _100;
							var _101 = bound;
							var _102 = _101[i2].get_originVertex().get_pos().x;
							var _103 = _102 + " , ";
							s += _103;
							var _104 = bound;
							var _105 = _104[i2].get_originVertex().get_pos().y;
							var _106 = _105 + " , ";
							s += _106;
							var _107 = bound;
							var _108 = _107[i2].get_destinationVertex().get_pos().x;
							var _109 = _108 + " , ";
							s += _109;
							var _110 = bound;
							var _111 = _110[i2].get_destinationVertex().get_pos().y;
							var _112 = _111 + " , ";
							s += _112;
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
					var _113 = bound.length;
					var _114 = _113 - 1;
					var _115 = index < _114;
					if(_115) {
						var _116 = new hxDaedalus.data.Edge();
						edgeA = _116;
						var _117 = new hxDaedalus.data.Edge();
						edgeAopp = _117;
						this._edges.push(edgeA);
						this._edges.push(edgeAopp);
						edgeA.setDatas(vertexA,edgeAopp,null,null,isReal,false);
						var _118 = bound;
						var _119 = _118[index].get_originVertex();
						edgeAopp.setDatas(_119,edgeA,null,null,isReal,false);
						var _120 = bound.slice(index);
						boundA = _120;
						boundA.push(edgeA);
						var _121 = boundA;
						this.triangulate(_121,isReal);
					}
					var _122 = index > 2;
					if(_122) {
						var _123 = new hxDaedalus.data.Edge();
						edgeB = _123;
						var _124 = new hxDaedalus.data.Edge();
						edgeBopp = _124;
						this._edges.push(edgeB);
						this._edges.push(edgeBopp);
						var _125 = bound;
						var _126 = _125[1].get_originVertex();
						edgeB.setDatas(_126,edgeBopp,null,null,isReal,false);
						var _127 = bound;
						var _128 = _127[index].get_originVertex();
						edgeBopp.setDatas(_128,edgeB,null,null,isReal,false);
						var _129 = bound.slice(1,index);
						boundB = _129;
						boundB.push(edgeBopp);
						var _130 = boundB;
						this.triangulate(_130,isReal);
					}
					var _131 = index == 2;
					if(_131) {
						var _132 = bound;
						var _133 = _132[1];
						var _134 = [baseEdge,_133,edgeAopp];
						boundM = _134;
					} else {
						var _135 = bound.length;
						var _136 = _135 - 1;
						var _137 = index == _136;
						if(_137) {
							var _138 = bound;
							var _139 = _138[index];
							var _140 = [baseEdge,edgeB,_139];
							boundM = _140;
						} else {
							var _141 = [baseEdge,edgeB,edgeAopp];
							boundM = _141;
						}
					}
					var _142 = boundM;
					this.triangulate(_142,isReal);
				}
			}
		}
	}
	,findPositionFromBounds: function(x,y) {
		var _0 = x <= 0;
		if(_0) {
			var _1 = y <= 0;
			if(_1) return 1; else {
				var _2 = this._height;
				var _3 = y >= _2;
				if(_3) return 7; else return 8;
			}
		} else {
			var _4 = this._width;
			var _5 = x >= _4;
			if(_5) {
				var _6 = y <= 0;
				if(_6) return 3; else {
					var _7 = this._height;
					var _8 = y >= _7;
					if(_8) return 5; else return 4;
				}
			} else {
				var _9 = y <= 0;
				if(_9) return 2; else {
					var _10 = this._height;
					var _11 = y >= _10;
					if(_11) return 6; else return 0;
				}
			}
		}
	}
	,debug: function() {
		var i;
		var _g1 = 0;
		var _0 = this._vertices.length;
		var _g = _0;
		while(true) {
			var _1 = _g1 < _g;
			var _2 = !_1;
			if(_2) break;
			var _3 = _g1++;
			var i1 = _3;
			var _4 = this._vertices;
			var _5 = _4[i1].get_id();
			var _6 = "-- vertex " + _5;
			var _7 = { fileName : "Mesh.hx", lineNumber : 1567, className : "hxDaedalus.data.Mesh", methodName : "debug"};
			hxDaedalus.debug.Debug.trace(_6,_7);
			var _8 = this._vertices;
			var _9 = _8[i1].get_edge().get_id();
			var _10 = "  edge " + _9;
			var _11 = _10 + " - ";
			var _12 = this._vertices;
			var _13 = _12[i1].get_edge();
			var _14 = Std.string(_13);
			var _15 = _11 + _14;
			var _16 = { fileName : "Mesh.hx", lineNumber : 1568, className : "hxDaedalus.data.Mesh", methodName : "debug"};
			hxDaedalus.debug.Debug.trace(_15,_16);
			var _17 = this._vertices;
			var _18 = _17[i1].get_edge().get_isReal();
			var _19 = Std.string(_18);
			var _20 = "  edge isReal: " + _19;
			var _21 = { fileName : "Mesh.hx", lineNumber : 1569, className : "hxDaedalus.data.Mesh", methodName : "debug"};
			hxDaedalus.debug.Debug.trace(_20,_21);
		}
		var _g11 = 0;
		var _22 = this._edges.length;
		var _g2 = _22;
		while(true) {
			var _23 = _g11 < _g2;
			var _24 = !_23;
			if(_24) break;
			var _25 = _g11++;
			var i2 = _25;
			var _26 = this._edges;
			var _27 = _26[i2];
			var _28 = Std.string(_27);
			var _29 = "-- edge " + _28;
			var _30 = { fileName : "Mesh.hx", lineNumber : 1572, className : "hxDaedalus.data.Mesh", methodName : "debug"};
			hxDaedalus.debug.Debug.trace(_29,_30);
			var _31 = this._edges;
			var _32 = _31[i2].get_id();
			var _33 = "  isReal " + _32;
			var _34 = _33 + " - ";
			var _35 = this._edges;
			var _36 = _35[i2].get_isReal();
			var _37 = Std.string(_36);
			var _38 = _34 + _37;
			var _39 = { fileName : "Mesh.hx", lineNumber : 1573, className : "hxDaedalus.data.Mesh", methodName : "debug"};
			hxDaedalus.debug.Debug.trace(_38,_39);
			var _40 = this._edges;
			var _41 = _40[i2].get_nextLeftEdge();
			var _42 = Std.string(_41);
			var _43 = "  nextLeftEdge " + _42;
			var _44 = { fileName : "Mesh.hx", lineNumber : 1574, className : "hxDaedalus.data.Mesh", methodName : "debug"};
			hxDaedalus.debug.Debug.trace(_43,_44);
			var _45 = this._edges;
			var _46 = _45[i2].get_oppositeEdge();
			var _47 = Std.string(_46);
			var _48 = "  oppositeEdge " + _47;
			var _49 = { fileName : "Mesh.hx", lineNumber : 1575, className : "hxDaedalus.data.Mesh", methodName : "debug"};
			hxDaedalus.debug.Debug.trace(_48,_49);
		}
	}
};
hxDaedalus.data.Object = function() {
	var _0 = hxDaedalus.data.Object.INC;
	this._id = _0;
	hxDaedalus.data.Object.INC++;
	this._pivotX = 0;
	this._pivotY = 0;
	var _1 = new hxDaedalus.data.math.Matrix2D();
	this._matrix = _1;
	this._scaleX = 1;
	this._scaleY = 1;
	this._rotation = 0;
	this._x = 0;
	this._y = 0;
	var _2 = new Array();
	this._coordinates = _2;
	this._hasChanged = false;
};
hxDaedalus.data.Object.__name__ = true;
hxDaedalus.data.Object.prototype = {
	get_id: function() {
		var _0 = this._id;
		return _0;
	}
	,dispose: function() {
		this._matrix = null;
		var _0 = null;
		this._coordinates = _0;
		this._constraintShape = null;
	}
	,updateValuesFromMatrix: function() {
	}
	,updateMatrixFromValues: function() {
		this._matrix.identity();
		var _0 = this._pivotX;
		var _1 = -_0;
		var _2 = this._pivotY;
		var _3 = -_2;
		this._matrix.translate(_1,_3);
		var _4 = this._scaleX;
		var _5 = this._scaleY;
		this._matrix.scale(_4,_5);
		var _6 = this._rotation;
		this._matrix.rotate(_6);
		var _7 = this._x;
		var _8 = this._y;
		this._matrix.translate(_7,_8);
	}
	,get_pivotX: function() {
		var _0 = this._pivotX;
		return _0;
	}
	,set_pivotX: function(value) {
		this._pivotX = value;
		this._hasChanged = true;
		return value;
	}
	,get_pivotY: function() {
		var _0 = this._pivotY;
		return _0;
	}
	,set_pivotY: function(value) {
		this._pivotY = value;
		this._hasChanged = true;
		return value;
	}
	,get_scaleX: function() {
		var _0 = this._scaleX;
		return _0;
	}
	,set_scaleX: function(value) {
		var _0 = this._scaleX;
		var _1 = _0 != value;
		if(_1) {
			this._scaleX = value;
			this._hasChanged = true;
		}
		return value;
	}
	,get_scaleY: function() {
		var _0 = this._scaleY;
		return _0;
	}
	,set_scaleY: function(value) {
		var _0 = this._scaleY;
		var _1 = _0 != value;
		if(_1) {
			this._scaleY = value;
			this._hasChanged = true;
		}
		return value;
	}
	,get_rotation: function() {
		var _0 = this._rotation;
		return _0;
	}
	,set_rotation: function(value) {
		var _0 = this._rotation;
		var _1 = _0 != value;
		if(_1) {
			this._rotation = value;
			this._hasChanged = true;
		}
		return value;
	}
	,get_x: function() {
		var _0 = this._x;
		return _0;
	}
	,set_x: function(value) {
		var _0 = this._x;
		var _1 = _0 != value;
		if(_1) {
			this._x = value;
			this._hasChanged = true;
		}
		return value;
	}
	,get_y: function() {
		var _0 = this._y;
		return _0;
	}
	,set_y: function(value) {
		var _0 = this._y;
		var _1 = _0 != value;
		if(_1) {
			this._y = value;
			this._hasChanged = true;
		}
		return value;
	}
	,get_matrix: function() {
		var _0 = this._matrix;
		return _0;
	}
	,set_matrix: function(value) {
		this._matrix = value;
		this._hasChanged = true;
		return value;
	}
	,get_coordinates: function() {
		var _0 = this._coordinates;
		return _0;
	}
	,set_coordinates: function(value) {
		var _0 = value;
		this._coordinates = _0;
		this._hasChanged = true;
		var _1 = value;
		return _1;
	}
	,get_constraintShape: function() {
		var _0 = this._constraintShape;
		return _0;
	}
	,set_constraintShape: function(value) {
		this._constraintShape = value;
		this._hasChanged = true;
		return value;
	}
	,get_hasChanged: function() {
		var _0 = this._hasChanged;
		return _0;
	}
	,set_hasChanged: function(value) {
		this._hasChanged = value;
		return value;
	}
	,get_edges: function() {
		var _0 = new Array();
		var res = _0;
		var _1 = this._constraintShape.segments;
		var seg = _1;
		var _g1 = 0;
		var _2 = seg.length;
		var _g = _2;
		while(true) {
			var _3 = _g1 < _g;
			var _4 = !_3;
			if(_4) break;
			var _5 = _g1++;
			var i = _5;
			var _g3 = 0;
			var _6 = seg;
			var _7 = _6[i].get_edges().length;
			var _g2 = _7;
			while(true) {
				var _8 = _g3 < _g2;
				var _9 = !_8;
				if(_9) break;
				var _10 = _g3++;
				var j = _10;
				var _11 = seg;
				var _12 = _11[i].get_edges();
				var _13 = _12[j];
				res.push(_13);
			}
		}
		var _14 = res;
		return _14;
	}
};
hxDaedalus.data.Vertex = function() {
	this.colorDebug = -1;
	var _0 = hxDaedalus.data.Vertex.INC;
	this._id = _0;
	hxDaedalus.data.Vertex.INC++;
	var _1 = new hxDaedalus.data.math.Point2D();
	this._pos = _1;
	var _2 = new Array();
	this._fromConstraintSegments = _2;
};
hxDaedalus.data.Vertex.__name__ = true;
hxDaedalus.data.Vertex.prototype = {
	get_id: function() {
		var _0 = this._id;
		return _0;
	}
	,get_isReal: function() {
		var _0 = this._isReal;
		return _0;
	}
	,get_pos: function() {
		var _0 = this._pos;
		return _0;
	}
	,get_fromConstraintSegments: function() {
		var _0 = this._fromConstraintSegments;
		return _0;
	}
	,set_fromConstraintSegments: function(value) {
		var _0 = value;
		var _1 = this._fromConstraintSegments = _0;
		return _1;
	}
	,setDatas: function(edge,isReal) {
		if(isReal == null) isReal = true;
		this._isReal = isReal;
		this._edge = edge;
	}
	,addFromConstraintSegment: function(segment) {
		var _0 = this._fromConstraintSegments;
		var _1 = null != null;
		var _2;
		if(_1) _2 = null; else _2 = 0;
		var _3 = HxOverrides.indexOf(_0,segment,_2);
		var _4 = _3 == -1;
		if(_4) this._fromConstraintSegments.push(segment);
	}
	,removeFromConstraintSegment: function(segment) {
		var _0 = this._fromConstraintSegments;
		var _1 = null != null;
		var _2;
		if(_1) _2 = null; else _2 = 0;
		var _3 = HxOverrides.indexOf(_0,segment,_2);
		var index = _3;
		var _4 = index != -1;
		if(_4) this._fromConstraintSegments.splice(index,1);
	}
	,dispose: function() {
		this._pos = null;
		this._edge = null;
		var _0 = null;
		this._fromConstraintSegments = _0;
	}
	,get_edge: function() {
		var _0 = this._edge;
		return _0;
	}
	,set_edge: function(value) {
		var _0 = this._edge = value;
		return _0;
	}
	,toString: function() {
		var _0 = this._id;
		var _1 = "ver_id " + _0;
		return _1;
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
		var _0 = this.x;
		var _1 = this.y;
		var _2 = new hxDaedalus.data.math.Point2D(_0,_1);
		return _2;
	}
	,substract: function(p) {
		var _0 = p.x;
		this.x -= _0;
		var _1 = p.y;
		this.y -= _1;
	}
	,get_length: function() {
		var _0 = this.x;
		var _1 = this.x;
		var _2 = _0 * _1;
		var _3 = this.y;
		var _4 = this.y;
		var _5 = _3 * _4;
		var _6 = _2 + _5;
		var _7 = Math.sqrt(_6);
		return _7;
	}
	,normalize: function() {
		var _0 = this.get_length();
		var norm = _0;
		var _1 = this.x;
		var _2 = _1 / norm;
		this.x = _2;
		var _3 = this.y;
		var _4 = _3 / norm;
		this.y = _4;
	}
	,scale: function(s) {
		var _0 = this.x;
		var _1 = _0 * s;
		this.x = _1;
		var _2 = this.y;
		var _3 = _2 * s;
		this.y = _3;
	}
	,distanceTo: function(p) {
		var _0 = this.x;
		var _1 = p.x;
		var _2 = _0 - _1;
		var diffX = _2;
		var _3 = this.y;
		var _4 = p.y;
		var _5 = _3 - _4;
		var diffY = _5;
		var _6 = diffX * diffX;
		var _7 = diffY * diffY;
		var _8 = _6 + _7;
		var _9 = Math.sqrt(_8);
		return _9;
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
	var numSamples = Std["int"](Math.pow(mesh._vertices.length,1 / 3));
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
	var faceVisited = (function($this) {
		var $r;
		var _0 = new haxe.ds.ObjectMap();
		$r = _0;
		return $r;
	}(this));
	var currEdge;
	var iterEdge = new hxDaedalus.iterators.FromFaceToInnerEdges();
	var objectContainer = hxDaedalus.data.math.Intersection.ENull;
	var relativPos;
	var numIter = 0;
	while(faceVisited.get(currFace) || (function($this) {
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
		faceVisited.get(currFace);
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
	var _2 = x <= 0;
	var _3 = !_2;
	var _6;
	if(_3) {
		var _5 = mesh.get_width();
		var _4 = _5;
		var _1 = _4;
		_6 = x >= _1;
	} else _6 = true;
	var _7 = !_6;
	var _9;
	if(_7) _9 = y <= 0; else _9 = true;
	var _10 = !_9;
	var _12;
	if(_10) {
		var _11 = mesh.get_height();
		var _8 = _11;
		_12 = y >= _8;
	} else _12 = true;
	if(_12) return true;
	var _13 = hxDaedalus.data.math.Geom2D.locatePosition(x,y,mesh);
	var loc = _13;
	var face;
	switch(loc[1]) {
	case 0:
		var vertex = loc[2];
		var _14 = vertex.get_edge().get_leftFace();
		face = _14;
		break;
	case 1:
		var edge = loc[2];
		var _15 = edge.get_leftFace();
		face = _15;
		break;
	case 2:
		var face_ = loc[2];
		face = face_;
		break;
	case 3:
		face = null;
		break;
	}
	var _16 = radius * radius;
	var radiusSquared = _16;
	var pos;
	var distSquared;
	var _17 = face.get_edge().get_originVertex().get_pos();
	pos = _17;
	var _18 = pos.x;
	var _19 = _18 - x;
	var _20 = pos.x;
	var _21 = _20 - x;
	var _22 = _19 * _21;
	var _23 = pos.y;
	var _24 = _23 - y;
	var _25 = pos.y;
	var _26 = _25 - y;
	var _27 = _24 * _26;
	var _28 = _22 + _27;
	distSquared = _28;
	var _29 = distSquared <= radiusSquared;
	if(_29) return true;
	var _30 = face.get_edge().get_nextLeftEdge().get_originVertex().get_pos();
	pos = _30;
	var _31 = pos.x;
	var _32 = _31 - x;
	var _33 = pos.x;
	var _34 = _33 - x;
	var _35 = _32 * _34;
	var _36 = pos.y;
	var _37 = _36 - y;
	var _38 = pos.y;
	var _39 = _38 - y;
	var _40 = _37 * _39;
	var _41 = _35 + _40;
	distSquared = _41;
	var _42 = distSquared <= radiusSquared;
	if(_42) return true;
	var _43 = face.get_edge().get_nextLeftEdge().get_nextLeftEdge().get_originVertex().get_pos();
	pos = _43;
	var _44 = pos.x;
	var _45 = _44 - x;
	var _46 = pos.x;
	var _47 = _46 - x;
	var _48 = _45 * _47;
	var _49 = pos.y;
	var _50 = _49 - y;
	var _51 = pos.y;
	var _52 = _51 - y;
	var _53 = _50 * _52;
	var _54 = _48 + _53;
	distSquared = _54;
	var _55 = distSquared <= radiusSquared;
	if(_55) return true;
	var _56 = new Array();
	var edgesToCheck = _56;
	var _57 = face.get_edge();
	edgesToCheck.push(_57);
	var _58 = face.get_edge().get_nextLeftEdge();
	edgesToCheck.push(_58);
	var _59 = face.get_edge().get_nextLeftEdge().get_nextLeftEdge();
	edgesToCheck.push(_59);
	var edge1;
	var pos1;
	var pos2;
	var _61;
	var _60 = new haxe.ds.ObjectMap();
	var _0 = _60;
	_61 = _0;
	var checkedEdges = _61;
	var intersecting;
	while(true) {
		var _62 = edgesToCheck.length;
		var _63 = _62 > 0;
		var _64 = !_63;
		if(_64) break;
		var _65 = edgesToCheck.pop();
		edge1 = _65;
		checkedEdges.set(edge1,true);
		true;
		var _66 = edge1.get_originVertex().get_pos();
		pos1 = _66;
		var _67 = edge1.get_destinationVertex().get_pos();
		pos2 = _67;
		var _68 = pos1.x;
		var _69 = pos1.y;
		var _70 = pos2.x;
		var _71 = pos2.y;
		var _72 = hxDaedalus.data.math.Geom2D.intersectionsSegmentCircle(_68,_69,_70,_71,x,y,radius);
		intersecting = _72;
		if(intersecting) {
			var _73 = edge1.get_isConstrained();
			if(_73) return true; else {
				var _74 = edge1.get_oppositeEdge().get_nextLeftEdge();
				edge1 = _74;
				var _75 = checkedEdges.get(edge1);
				var _78 = !_75;
				var _88;
				if(_78) {
					var _77;
					var _86 = edge1.get_oppositeEdge();
					var _79 = _86;
					var _76 = _79;
					var key = _76;
					var _87 = checkedEdges.get(key);
					var _80 = _87;
					_77 = _80;
					_88 = !_77;
				} else _88 = false;
				var _106;
				if(_88) {
					var _99 = edgesToCheck;
					var _89 = _99;
					var _100 = _89;
					var _81 = _100;
					var _101 = null != null;
					var _90 = _101;
					var _82 = _90;
					var _83;
					if(_82) _83 = null; else _83 = 0;
					var _102 = _81;
					var _91 = _102;
					var _103 = _91;
					var _104 = HxOverrides.indexOf(_103,edge1,_83);
					var _92 = _104;
					var _84 = _92;
					var _105 = -1;
					var _93 = _105;
					var _85 = _93;
					_106 = _84 == _85;
				} else _106 = false;
				var _112;
				if(_106) {
					var _98;
					var _107 = edge1.get_oppositeEdge();
					var _94 = _107;
					var x1 = _94;
					var _108 = edgesToCheck;
					var _95 = _108;
					var _109 = null != null;
					var _96 = _109;
					var _97;
					if(_96) _97 = null; else _97 = 0;
					var _110 = _95;
					var _111 = HxOverrides.indexOf(_110,x1,_97);
					_98 = _111;
					_112 = _98 == -1;
				} else _112 = false;
				if(_112) edgesToCheck.push(edge1);
				var _113 = edge1.get_nextLeftEdge();
				edge1 = _113;
				var _114 = checkedEdges.get(edge1);
				var _117 = !_114;
				var _127;
				if(_117) {
					var _116;
					var _125 = edge1.get_oppositeEdge();
					var _118 = _125;
					var _115 = _118;
					var key1 = _115;
					var _126 = checkedEdges.get(key1);
					var _119 = _126;
					_116 = _119;
					_127 = !_116;
				} else _127 = false;
				var _145;
				if(_127) {
					var _138 = edgesToCheck;
					var _128 = _138;
					var _139 = _128;
					var _120 = _139;
					var _140 = null != null;
					var _129 = _140;
					var _121 = _129;
					var _122;
					if(_121) _122 = null; else _122 = 0;
					var _141 = _120;
					var _130 = _141;
					var _142 = _130;
					var _143 = HxOverrides.indexOf(_142,edge1,_122);
					var _131 = _143;
					var _123 = _131;
					var _144 = -1;
					var _132 = _144;
					var _124 = _132;
					_145 = _123 == _124;
				} else _145 = false;
				var _151;
				if(_145) {
					var _137;
					var _146 = edge1.get_oppositeEdge();
					var _133 = _146;
					var x2 = _133;
					var _147 = edgesToCheck;
					var _134 = _147;
					var _148 = null != null;
					var _135 = _148;
					var _136;
					if(_135) _136 = null; else _136 = 0;
					var _149 = _134;
					var _150 = HxOverrides.indexOf(_149,x2,_136);
					_137 = _150;
					_151 = _137 == -1;
				} else _151 = false;
				if(_151) edgesToCheck.push(edge1);
			}
		}
	}
	return false;
};
hxDaedalus.data.math.Geom2D.getDirection = function(x1,y1,x2,y2,x3,y3) {
	var _0 = x3 - x1;
	var _1 = y2 - y1;
	var _2 = _0 * _1;
	var _3 = y3 - y1;
	var _4 = -x2;
	var _5 = _4 + x1;
	var _6 = _3 * _5;
	var _7 = _2 + _6;
	var dot = _7;
	var _8 = dot == 0;
	var _10;
	if(_8) _10 = 0; else {
		var _9 = dot > 0;
		if(_9) _10 = 1; else _10 = -1;
	}
	return _10;
};
hxDaedalus.data.math.Geom2D.getDirection2 = function(x1,y1,x2,y2,x3,y3) {
	var _0 = x3 - x1;
	var _1 = y2 - y1;
	var _2 = _0 * _1;
	var _3 = y3 - y1;
	var _4 = -x2;
	var _5 = _4 + x1;
	var _6 = _3 * _5;
	var _7 = _2 + _6;
	var dot = _7;
	var _8 = dot == 0;
	if(_8) return 0; else {
		var _9 = dot > 0;
		if(_9) {
			var _10 = hxDaedalus.data.math.Geom2D.distanceSquaredPointToLine(x3,y3,x1,y1,x2,y2);
			var _11 = _10 <= 0.0001;
			if(_11) return 0; else return 1;
		} else {
			var _12 = hxDaedalus.data.math.Geom2D.distanceSquaredPointToLine(x3,y3,x1,y1,x2,y2);
			var _13 = _12 <= 0.0001;
			if(_13) return 0; else return -1;
		}
	}
	return 0;
};
hxDaedalus.data.math.Geom2D.getRelativePosition = function(x,y,eUp) {
	var _0 = eUp.get_originVertex().get_pos().x;
	var _1 = eUp.get_originVertex().get_pos().y;
	var _2 = eUp.get_destinationVertex().get_pos().x;
	var _3 = eUp.get_destinationVertex().get_pos().y;
	var _4 = hxDaedalus.data.math.Geom2D.getDirection(_0,_1,_2,_3,x,y);
	return _4;
};
hxDaedalus.data.math.Geom2D.getRelativePosition2 = function(x,y,eUp) {
	var _0 = eUp.get_originVertex().get_pos().x;
	var _1 = eUp.get_originVertex().get_pos().y;
	var _2 = eUp.get_destinationVertex().get_pos().x;
	var _3 = eUp.get_destinationVertex().get_pos().y;
	var _4 = hxDaedalus.data.math.Geom2D.getDirection2(_0,_1,_2,_3,x,y);
	return _4;
};
hxDaedalus.data.math.Geom2D.isInFace = function(x,y,polygon) {
	var _0 = hxDaedalus.data.math.Intersection.ENull;
	var result = _0;
	var _1 = polygon.get_edge();
	var e1_2 = _1;
	var _2 = e1_2.get_nextLeftEdge();
	var e2_3 = _2;
	var _3 = e2_3.get_nextLeftEdge();
	var e3_1 = _3;
	var _4 = hxDaedalus.data.math.Geom2D.getRelativePosition(x,y,e1_2);
	var _6 = _4 >= 0;
	var _10;
	if(_6) {
		var _9 = hxDaedalus.data.math.Geom2D.getRelativePosition(x,y,e2_3);
		var _7 = _9;
		var _5 = _7;
		_10 = _5 >= 0;
	} else _10 = false;
	var _12;
	if(_10) {
		var _11 = hxDaedalus.data.math.Geom2D.getRelativePosition(x,y,e3_1);
		var _8 = _11;
		_12 = _8 >= 0;
	} else _12 = false;
	if(_12) {
		var _13 = e1_2.get_originVertex();
		var v1 = _13;
		var _14 = e2_3.get_originVertex();
		var v2 = _14;
		var _15 = e3_1.get_originVertex();
		var v3 = _15;
		var _16 = v1.get_pos().x;
		var x1 = _16;
		var _17 = v1.get_pos().y;
		var y1 = _17;
		var _18 = v2.get_pos().x;
		var x2 = _18;
		var _19 = v2.get_pos().y;
		var y2 = _19;
		var _20 = v3.get_pos().x;
		var x3 = _20;
		var _21 = v3.get_pos().y;
		var y3 = _21;
		var _22 = x1 - x;
		var _23 = x1 - x;
		var _24 = _22 * _23;
		var _25 = y1 - y;
		var _26 = y1 - y;
		var _27 = _25 * _26;
		var _28 = _24 + _27;
		var v_v1squaredLength = _28;
		var _29 = x2 - x;
		var _30 = x2 - x;
		var _31 = _29 * _30;
		var _32 = y2 - y;
		var _33 = y2 - y;
		var _34 = _32 * _33;
		var _35 = _31 + _34;
		var v_v2squaredLength = _35;
		var _36 = x3 - x;
		var _37 = x3 - x;
		var _38 = _36 * _37;
		var _39 = y3 - y;
		var _40 = y3 - y;
		var _41 = _39 * _40;
		var _42 = _38 + _41;
		var v_v3squaredLength = _42;
		var _43 = x2 - x1;
		var _44 = x2 - x1;
		var _45 = _43 * _44;
		var _46 = y2 - y1;
		var _47 = y2 - y1;
		var _48 = _46 * _47;
		var _49 = _45 + _48;
		var v1_v2squaredLength = _49;
		var _50 = x3 - x2;
		var _51 = x3 - x2;
		var _52 = _50 * _51;
		var _53 = y3 - y2;
		var _54 = y3 - y2;
		var _55 = _53 * _54;
		var _56 = _52 + _55;
		var v2_v3squaredLength = _56;
		var _57 = x1 - x3;
		var _58 = x1 - x3;
		var _59 = _57 * _58;
		var _60 = y1 - y3;
		var _61 = y1 - y3;
		var _62 = _60 * _61;
		var _63 = _59 + _62;
		var v3_v1squaredLength = _63;
		var _64 = x - x1;
		var _65 = x2 - x1;
		var _66 = _64 * _65;
		var _67 = y - y1;
		var _68 = y2 - y1;
		var _69 = _67 * _68;
		var _70 = _66 + _69;
		var dot_v_v1v2 = _70;
		var _71 = x - x2;
		var _72 = x3 - x2;
		var _73 = _71 * _72;
		var _74 = y - y2;
		var _75 = y3 - y2;
		var _76 = _74 * _75;
		var _77 = _73 + _76;
		var dot_v_v2v3 = _77;
		var _78 = x - x3;
		var _79 = x1 - x3;
		var _80 = _78 * _79;
		var _81 = y - y3;
		var _82 = y1 - y3;
		var _83 = _81 * _82;
		var _84 = _80 + _83;
		var dot_v_v3v1 = _84;
		var _85 = dot_v_v1v2 * dot_v_v1v2;
		var _86 = _85 / v1_v2squaredLength;
		var _87 = v_v1squaredLength - _86;
		var v_e1_2squaredLength = _87;
		var _88 = dot_v_v2v3 * dot_v_v2v3;
		var _89 = _88 / v2_v3squaredLength;
		var _90 = v_v2squaredLength - _89;
		var v_e2_3squaredLength = _90;
		var _91 = dot_v_v3v1 * dot_v_v3v1;
		var _92 = _91 / v3_v1squaredLength;
		var _93 = v_v3squaredLength - _92;
		var v_e3_1squaredLength = _93;
		var _94 = v_e1_2squaredLength <= 0.0001;
		var closeTo_e1_2 = _94;
		var _95 = v_e2_3squaredLength <= 0.0001;
		var closeTo_e2_3 = _95;
		var _96 = v_e3_1squaredLength <= 0.0001;
		var closeTo_e3_1 = _96;
		if(closeTo_e1_2) {
			if(closeTo_e3_1) {
				var _97 = hxDaedalus.data.math.Intersection.EVertex(v1);
				result = _97;
			} else if(closeTo_e2_3) {
				var _98 = hxDaedalus.data.math.Intersection.EVertex(v2);
				result = _98;
			} else {
				var _99 = hxDaedalus.data.math.Intersection.EEdge(e1_2);
				result = _99;
			}
		} else if(closeTo_e2_3) {
			if(closeTo_e3_1) {
				var _100 = hxDaedalus.data.math.Intersection.EVertex(v3);
				result = _100;
			} else {
				var _101 = hxDaedalus.data.math.Intersection.EEdge(e2_3);
				result = _101;
			}
		} else if(closeTo_e3_1) {
			var _102 = hxDaedalus.data.math.Intersection.EEdge(e3_1);
			result = _102;
		} else {
			var _103 = hxDaedalus.data.math.Intersection.EFace(polygon);
			result = _103;
		}
	}
	return result;
};
hxDaedalus.data.math.Geom2D.clipSegmentByTriangle = function(s1x,s1y,s2x,s2y,t1x,t1y,t2x,t2y,t3x,t3y,pResult1,pResult2) {
	var side1_1;
	var side1_2;
	var _0 = hxDaedalus.data.math.Geom2D.getDirection(t1x,t1y,t2x,t2y,s1x,s1y);
	side1_1 = _0;
	var _1 = hxDaedalus.data.math.Geom2D.getDirection(t1x,t1y,t2x,t2y,s2x,s2y);
	side1_2 = _1;
	var _2 = side1_1 <= 0;
	var _3;
	if(_2) _3 = side1_2 <= 0; else _3 = false;
	if(_3) return false;
	var side2_1;
	var side2_2;
	var _4 = hxDaedalus.data.math.Geom2D.getDirection(t2x,t2y,t3x,t3y,s1x,s1y);
	side2_1 = _4;
	var _5 = hxDaedalus.data.math.Geom2D.getDirection(t2x,t2y,t3x,t3y,s2x,s2y);
	side2_2 = _5;
	var _6 = side2_1 <= 0;
	var _7;
	if(_6) _7 = side2_2 <= 0; else _7 = false;
	if(_7) return false;
	var side3_1;
	var side3_2;
	var _8 = hxDaedalus.data.math.Geom2D.getDirection(t3x,t3y,t1x,t1y,s1x,s1y);
	side3_1 = _8;
	var _9 = hxDaedalus.data.math.Geom2D.getDirection(t3x,t3y,t1x,t1y,s2x,s2y);
	side3_2 = _9;
	var _10 = side3_1 <= 0;
	var _11;
	if(_10) _11 = side3_2 <= 0; else _11 = false;
	if(_11) return false;
	var _12 = side1_1 >= 0;
	var _13;
	if(_12) _13 = side2_1 >= 0; else _13 = false;
	var _16;
	if(_13) _16 = side3_1 >= 0; else _16 = false;
	var _19;
	if(_16) {
		var _17 = side1_2 >= 0;
		var _14 = _17;
		var _15;
		if(_14) {
			var _18 = side2_2 >= 0;
			_15 = _18;
		} else _15 = false;
		if(_15) _19 = side3_2 >= 0; else _19 = false;
	} else _19 = false;
	if(_19) {
		pResult1.x = s1x;
		pResult1.y = s1y;
		pResult2.x = s2x;
		pResult2.y = s2y;
		return true;
	}
	var n = 0;
	var _20 = null;
	var _21 = hxDaedalus.data.math.Geom2D.intersections2segments(s1x,s1y,s2x,s2y,t1x,t1y,t2x,t2y,pResult1,_20);
	if(_21) n++;
	var _22 = n == 0;
	if(_22) {
		var _23 = null;
		var _24 = hxDaedalus.data.math.Geom2D.intersections2segments(s1x,s1y,s2x,s2y,t2x,t2y,t3x,t3y,pResult1,_23);
		if(_24) n++;
	} else {
		var _25 = null;
		var _26 = hxDaedalus.data.math.Geom2D.intersections2segments(s1x,s1y,s2x,s2y,t2x,t2y,t3x,t3y,pResult2,_25);
		if(_26) {
			var _27 = -0.01;
			var _28 = pResult1.x;
			var _29 = pResult2.x;
			var _30 = _28 - _29;
			var _34 = _27 > _30;
			var _35 = !_34;
			var _46;
			if(_35) {
				var _43 = pResult1.x;
				var _36 = _43;
				var _31 = _36;
				var _44 = pResult2.x;
				var _37 = _44;
				var _32 = _37;
				var _45 = _31 - _32;
				var _38 = _45;
				var _33 = _38;
				_46 = _33 > 0.01;
			} else _46 = true;
			var _47 = !_46;
			var _59;
			if(_47) {
				var _55 = -0.01;
				var _48 = _55;
				var _39 = _48;
				var _56 = pResult1.y;
				var _49 = _56;
				var _40 = _49;
				var _57 = pResult2.y;
				var _50 = _57;
				var _41 = _50;
				var _58 = _40 - _41;
				var _51 = _58;
				var _42 = _51;
				_59 = _39 > _42;
			} else _59 = true;
			var _60 = !_59;
			var _64;
			if(_60) {
				var _61 = pResult1.y;
				var _52 = _61;
				var _62 = pResult2.y;
				var _53 = _62;
				var _63 = _52 - _53;
				var _54 = _63;
				_64 = _54 > 0.01;
			} else _64 = true;
			if(_64) n++;
		}
	}
	var _65 = n == 0;
	if(_65) {
		var _66 = null;
		var _67 = hxDaedalus.data.math.Geom2D.intersections2segments(s1x,s1y,s2x,s2y,t3x,t3y,t1x,t1y,pResult1,_66);
		if(_67) n++;
	} else {
		var _68 = n == 1;
		if(_68) {
			var _69 = null;
			var _70 = hxDaedalus.data.math.Geom2D.intersections2segments(s1x,s1y,s2x,s2y,t3x,t3y,t1x,t1y,pResult2,_69);
			if(_70) {
				var _71 = -0.01;
				var _72 = pResult1.x;
				var _73 = pResult2.x;
				var _74 = _72 - _73;
				var _78 = _71 > _74;
				var _79 = !_78;
				var _90;
				if(_79) {
					var _87 = pResult1.x;
					var _80 = _87;
					var _75 = _80;
					var _88 = pResult2.x;
					var _81 = _88;
					var _76 = _81;
					var _89 = _75 - _76;
					var _82 = _89;
					var _77 = _82;
					_90 = _77 > 0.01;
				} else _90 = true;
				var _91 = !_90;
				var _103;
				if(_91) {
					var _99 = -0.01;
					var _92 = _99;
					var _83 = _92;
					var _100 = pResult1.y;
					var _93 = _100;
					var _84 = _93;
					var _101 = pResult2.y;
					var _94 = _101;
					var _85 = _94;
					var _102 = _84 - _85;
					var _95 = _102;
					var _86 = _95;
					_103 = _83 > _86;
				} else _103 = true;
				var _104 = !_103;
				var _108;
				if(_104) {
					var _105 = pResult1.y;
					var _96 = _105;
					var _106 = pResult2.y;
					var _97 = _106;
					var _107 = _96 - _97;
					var _98 = _107;
					_108 = _98 > 0.01;
				} else _108 = true;
				if(_108) n++;
			}
		}
	}
	var _109 = n == 1;
	if(_109) {
		var _110 = side1_1 >= 0;
		var _111;
		if(_110) _111 = side2_1 >= 0; else _111 = false;
		var _112;
		if(_111) _112 = side3_1 >= 0; else _112 = false;
		if(_112) {
			pResult2.x = s1x;
			pResult2.y = s1y;
		} else {
			var _113 = side1_2 >= 0;
			var _114;
			if(_113) _114 = side2_2 >= 0; else _114 = false;
			var _115;
			if(_114) _115 = side3_2 >= 0; else _115 = false;
			if(_115) {
				pResult2.x = s2x;
				pResult2.y = s2y;
			} else n = 0;
		}
	}
	var _116 = n > 0;
	if(_116) return true; else return false;
};
hxDaedalus.data.math.Geom2D.isSegmentIntersectingTriangle = function(s1x,s1y,s2x,s2y,t1x,t1y,t2x,t2y,t3x,t3y) {
	var side1_1;
	var side1_2;
	var _0 = hxDaedalus.data.math.Geom2D.getDirection(t1x,t1y,t2x,t2y,s1x,s1y);
	side1_1 = _0;
	var _1 = hxDaedalus.data.math.Geom2D.getDirection(t1x,t1y,t2x,t2y,s2x,s2y);
	side1_2 = _1;
	var _2 = side1_1 <= 0;
	var _3;
	if(_2) _3 = side1_2 <= 0; else _3 = false;
	if(_3) return false;
	var side2_1;
	var side2_2;
	var _4 = hxDaedalus.data.math.Geom2D.getDirection(t2x,t2y,t3x,t3y,s1x,s1y);
	side2_1 = _4;
	var _5 = hxDaedalus.data.math.Geom2D.getDirection(t2x,t2y,t3x,t3y,s2x,s2y);
	side2_2 = _5;
	var _6 = side2_1 <= 0;
	var _7;
	if(_6) _7 = side2_2 <= 0; else _7 = false;
	if(_7) return false;
	var side3_1;
	var side3_2;
	var _8 = hxDaedalus.data.math.Geom2D.getDirection(t3x,t3y,t1x,t1y,s1x,s1y);
	side3_1 = _8;
	var _9 = hxDaedalus.data.math.Geom2D.getDirection(t3x,t3y,t1x,t1y,s2x,s2y);
	side3_2 = _9;
	var _10 = side3_1 <= 0;
	var _11;
	if(_10) _11 = side3_2 <= 0; else _11 = false;
	if(_11) return false;
	var _12 = side1_1 == 1;
	var _13;
	if(_12) _13 = side2_1 == 1; else _13 = false;
	var _14;
	if(_13) _14 = side3_1 == 1; else _14 = false;
	if(_14) return true;
	var _15 = side1_1 == 1;
	var _16;
	if(_15) _16 = side2_1 == 1; else _16 = false;
	var _17;
	if(_16) _17 = side3_1 == 1; else _17 = false;
	if(_17) return true;
	var side1;
	var side2;
	var _18 = side1_1 == 1;
	var _20;
	if(_18) _20 = side1_2 <= 0; else _20 = false;
	var _21 = !_20;
	var _23;
	if(_21) {
		var _22 = side1_1 <= 0;
		var _19 = _22;
		if(_19) _23 = side1_2 == 1; else _23 = false;
	} else _23 = true;
	if(_23) {
		var _24 = hxDaedalus.data.math.Geom2D.getDirection(s1x,s1y,s2x,s2y,t1x,t1y);
		side1 = _24;
		var _25 = hxDaedalus.data.math.Geom2D.getDirection(s1x,s1y,s2x,s2y,t2x,t2y);
		side2 = _25;
		var _26 = side1 == 1;
		var _28;
		if(_26) _28 = side2 <= 0; else _28 = false;
		var _29 = !_28;
		var _31;
		if(_29) {
			var _30 = side1 <= 0;
			var _27 = _30;
			if(_27) _31 = side2 == 1; else _31 = false;
		} else _31 = true;
		if(_31) return true;
	}
	var _32 = side2_1 == 1;
	var _34;
	if(_32) _34 = side2_2 <= 0; else _34 = false;
	var _35 = !_34;
	var _37;
	if(_35) {
		var _36 = side2_1 <= 0;
		var _33 = _36;
		if(_33) _37 = side2_2 == 1; else _37 = false;
	} else _37 = true;
	if(_37) {
		var _38 = hxDaedalus.data.math.Geom2D.getDirection(s1x,s1y,s2x,s2y,t2x,t2y);
		side1 = _38;
		var _39 = hxDaedalus.data.math.Geom2D.getDirection(s1x,s1y,s2x,s2y,t3x,t3y);
		side2 = _39;
		var _40 = side1 == 1;
		var _42;
		if(_40) _42 = side2 <= 0; else _42 = false;
		var _43 = !_42;
		var _45;
		if(_43) {
			var _44 = side1 <= 0;
			var _41 = _44;
			if(_41) _45 = side2 == 1; else _45 = false;
		} else _45 = true;
		if(_45) return true;
	}
	var _46 = side3_1 == 1;
	var _48;
	if(_46) _48 = side3_2 <= 0; else _48 = false;
	var _49 = !_48;
	var _51;
	if(_49) {
		var _50 = side3_1 <= 0;
		var _47 = _50;
		if(_47) _51 = side3_2 == 1; else _51 = false;
	} else _51 = true;
	if(_51) {
		var _52 = hxDaedalus.data.math.Geom2D.getDirection(s1x,s1y,s2x,s2y,t3x,t3y);
		side1 = _52;
		var _53 = hxDaedalus.data.math.Geom2D.getDirection(s1x,s1y,s2x,s2y,t1x,t1y);
		side2 = _53;
		var _54 = side1 == 1;
		var _56;
		if(_54) _56 = side2 <= 0; else _56 = false;
		var _57 = !_56;
		var _59;
		if(_57) {
			var _58 = side1 <= 0;
			var _55 = _58;
			if(_55) _59 = side2 == 1; else _59 = false;
		} else _59 = true;
		if(_59) return true;
	}
	return false;
};
hxDaedalus.data.math.Geom2D.isDelaunay = function(edge) {
	var _0 = edge.get_originVertex();
	var vLeft = _0;
	var _1 = edge.get_destinationVertex();
	var vRight = _1;
	var _2 = edge.get_nextLeftEdge().get_destinationVertex();
	var vCorner = _2;
	var _3 = edge.get_nextRightEdge().get_destinationVertex();
	var vOpposite = _3;
	var _4 = vCorner.get_pos().x;
	var _5 = vCorner.get_pos().y;
	var _6 = vLeft.get_pos().x;
	var _7 = vLeft.get_pos().y;
	var _8 = vRight.get_pos().x;
	var _9 = vRight.get_pos().y;
	var _10 = hxDaedalus.data.math.Geom2D.__circumcenter;
	hxDaedalus.data.math.Geom2D.getCircumcenter(_4,_5,_6,_7,_8,_9,_10);
	var _11 = vCorner.get_pos().x;
	var _12 = hxDaedalus.data.math.Geom2D.__circumcenter.x;
	var _13 = _11 - _12;
	var _14 = vCorner.get_pos().x;
	var _15 = hxDaedalus.data.math.Geom2D.__circumcenter.x;
	var _16 = _14 - _15;
	var _17 = _13 * _16;
	var _18 = vCorner.get_pos().y;
	var _19 = hxDaedalus.data.math.Geom2D.__circumcenter.y;
	var _20 = _18 - _19;
	var _21 = vCorner.get_pos().y;
	var _22 = hxDaedalus.data.math.Geom2D.__circumcenter.y;
	var _23 = _21 - _22;
	var _24 = _20 * _23;
	var _25 = _17 + _24;
	var squaredRadius = _25;
	var _26 = vOpposite.get_pos().x;
	var _27 = hxDaedalus.data.math.Geom2D.__circumcenter.x;
	var _28 = _26 - _27;
	var _29 = vOpposite.get_pos().x;
	var _30 = hxDaedalus.data.math.Geom2D.__circumcenter.x;
	var _31 = _29 - _30;
	var _32 = _28 * _31;
	var _33 = vOpposite.get_pos().y;
	var _34 = hxDaedalus.data.math.Geom2D.__circumcenter.y;
	var _35 = _33 - _34;
	var _36 = vOpposite.get_pos().y;
	var _37 = hxDaedalus.data.math.Geom2D.__circumcenter.y;
	var _38 = _36 - _37;
	var _39 = _35 * _38;
	var _40 = _32 + _39;
	var squaredDistance = _40;
	var _41 = squaredDistance >= squaredRadius;
	return _41;
};
hxDaedalus.data.math.Geom2D.getCircumcenter = function(x1,y1,x2,y2,x3,y3,result) {
	var _0 = result == null;
	if(_0) {
		var _1 = new hxDaedalus.data.math.Point2D();
		result = _1;
	}
	var _2 = x1 + x2;
	var _3 = _2 / 2;
	var m1 = _3;
	var _4 = y1 + y2;
	var _5 = _4 / 2;
	var m2 = _5;
	var _6 = x1 + x3;
	var _7 = _6 / 2;
	var m3 = _7;
	var _8 = y1 + y3;
	var _9 = _8 / 2;
	var m4 = _9;
	var _10 = x1 - x3;
	var _11 = m1 * _10;
	var _12 = m2 - m4;
	var _13 = y1 - y3;
	var _14 = _12 * _13;
	var _15 = _11 + _14;
	var _16 = x3 - x1;
	var _17 = m3 * _16;
	var _18 = _15 + _17;
	var _19 = y3 - y2;
	var _20 = x1 * _19;
	var _21 = y1 - y3;
	var _22 = x2 * _21;
	var _23 = _20 + _22;
	var _24 = y2 - y1;
	var _25 = x3 * _24;
	var _26 = _23 + _25;
	var _27 = _18 / _26;
	var t1 = _27;
	var _28 = y2 - y1;
	var _29 = t1 * _28;
	var _30 = m1 + _29;
	result.x = _30;
	var _31 = x2 - x1;
	var _32 = t1 * _31;
	var _33 = m2 - _32;
	result.y = _33;
	return result;
};
hxDaedalus.data.math.Geom2D.intersections2segments = function(s1p1x,s1p1y,s1p2x,s1p2y,s2p1x,s2p1y,s2p2x,s2p2y,posIntersection,paramIntersection,infiniteLineMode) {
	if(infiniteLineMode == null) infiniteLineMode = false;
	var t1 = 0;
	var t2 = 0;
	var result;
	var _0 = s1p1x - s1p2x;
	var _1 = s2p1y - s2p2y;
	var _2 = _0 * _1;
	var _3 = s1p2y - s1p1y;
	var _4 = s2p1x - s2p2x;
	var _5 = _3 * _4;
	var _6 = _2 + _5;
	var divisor = _6;
	var _7 = divisor == 0;
	if(_7) result = false; else {
		result = true;
		var _8 = !infiniteLineMode;
		var _9 = !_8;
		var _12;
		if(_9) _12 = posIntersection != null; else _12 = true;
		var _13 = !_12;
		var _18;
		if(_13) {
			var _14 = paramIntersection;
			var _10 = _14;
			var _15 = null;
			var _11 = _15;
			var _16 = _10;
			var _17 = _11;
			_18 = _16 != _17;
		} else _18 = true;
		if(_18) {
			var _19 = s2p1y - s2p2y;
			var _20 = s1p1x * _19;
			var _21 = s2p2x - s2p1x;
			var _22 = s1p1y * _21;
			var _23 = _20 + _22;
			var _24 = s2p1x * s2p2y;
			var _25 = _23 + _24;
			var _26 = s2p1y * s2p2x;
			var _27 = _25 - _26;
			var _28 = _27 / divisor;
			t1 = _28;
			var _29 = s2p1y - s1p2y;
			var _30 = s1p1x * _29;
			var _31 = s1p2x - s2p1x;
			var _32 = s1p1y * _31;
			var _33 = _30 + _32;
			var _34 = s1p2x * s2p1y;
			var _35 = _33 - _34;
			var _36 = s1p2y * s2p1x;
			var _37 = _35 + _36;
			var _38 = _37 / divisor;
			t2 = _38;
			var _43 = !infiniteLineMode;
			var _48;
			if(_43) {
				var _44 = 0 <= t1;
				var _39 = _44;
				var _40;
				if(_39) {
					var _45 = t1 <= 1;
					_40 = _45;
				} else _40 = false;
				var _41;
				if(_40) {
					var _46 = 0 <= t2;
					_41 = _46;
				} else _41 = false;
				var _42;
				if(_41) {
					var _47 = t2 <= 1;
					_42 = _47;
				} else _42 = false;
				_48 = !_42;
			} else _48 = false;
			if(_48) result = false;
		}
	}
	if(result) {
		var _49 = posIntersection != null;
		if(_49) {
			var _50 = s1p2x - s1p1x;
			var _51 = t1 * _50;
			var _52 = s1p1x + _51;
			posIntersection.x = _52;
			var _53 = s1p2y - s1p1y;
			var _54 = t1 * _53;
			var _55 = s1p1y + _54;
			posIntersection.y = _55;
		}
		var _56 = paramIntersection;
		var _57 = null;
		var _58 = _56 != _57;
		if(_58) {
			paramIntersection.push(t1);
			paramIntersection.push(t2);
		}
	}
	return result;
};
hxDaedalus.data.math.Geom2D.intersections2edges = function(edge1,edge2,posIntersection,paramIntersection,infiniteLineMode) {
	if(infiniteLineMode == null) infiniteLineMode = false;
	var _0 = edge1.get_originVertex().get_pos().x;
	var _1 = edge1.get_originVertex().get_pos().y;
	var _2 = edge1.get_destinationVertex().get_pos().x;
	var _3 = edge1.get_destinationVertex().get_pos().y;
	var _4 = edge2.get_originVertex().get_pos().x;
	var _5 = edge2.get_originVertex().get_pos().y;
	var _6 = edge2.get_destinationVertex().get_pos().x;
	var _7 = edge2.get_destinationVertex().get_pos().y;
	var _8 = paramIntersection;
	var _9 = hxDaedalus.data.math.Geom2D.intersections2segments(_0,_1,_2,_3,_4,_5,_6,_7,posIntersection,_8,infiniteLineMode);
	return _9;
};
hxDaedalus.data.math.Geom2D.isConvex = function(edge) {
	var result = true;
	var eLeft;
	var vRight;
	var _0 = edge.get_nextLeftEdge().get_oppositeEdge();
	eLeft = _0;
	var _1 = edge.get_nextRightEdge().get_destinationVertex();
	vRight = _1;
	var _2 = vRight.get_pos().x;
	var _3 = vRight.get_pos().y;
	var _4 = hxDaedalus.data.math.Geom2D.getRelativePosition(_2,_3,eLeft);
	var _5 = _4 != -1;
	if(_5) result = false; else {
		var _6 = edge.get_prevRightEdge();
		eLeft = _6;
		var _7 = edge.get_prevLeftEdge().get_originVertex();
		vRight = _7;
		var _8 = vRight.get_pos().x;
		var _9 = vRight.get_pos().y;
		var _10 = hxDaedalus.data.math.Geom2D.getRelativePosition(_8,_9,eLeft);
		var _11 = _10 != -1;
		if(_11) result = false;
	}
	return result;
};
hxDaedalus.data.math.Geom2D.projectOrthogonaly = function(vertexPos,edge) {
	var _0 = edge.get_originVertex().get_pos().x;
	var a = _0;
	var _1 = edge.get_originVertex().get_pos().y;
	var b = _1;
	var _2 = edge.get_destinationVertex().get_pos().x;
	var c = _2;
	var _3 = edge.get_destinationVertex().get_pos().y;
	var d = _3;
	var _4 = vertexPos.x;
	var e = _4;
	var _5 = vertexPos.y;
	var f = _5;
	var _6 = a * a;
	var _7 = a * c;
	var _8 = _6 - _7;
	var _9 = a * e;
	var _10 = _8 - _9;
	var _11 = b * b;
	var _12 = _10 + _11;
	var _13 = b * d;
	var _14 = _12 - _13;
	var _15 = b * f;
	var _16 = _14 - _15;
	var _17 = c * e;
	var _18 = _16 + _17;
	var _19 = d * f;
	var _20 = _18 + _19;
	var _21 = a * a;
	var _22 = 2 * a;
	var _23 = _22 * c;
	var _24 = _21 - _23;
	var _25 = b * b;
	var _26 = _24 + _25;
	var _27 = 2 * b;
	var _28 = _27 * d;
	var _29 = _26 - _28;
	var _30 = c * c;
	var _31 = _29 + _30;
	var _32 = d * d;
	var _33 = _31 + _32;
	var _34 = _20 / _33;
	var t1 = _34;
	var _35 = c - a;
	var _36 = t1 * _35;
	var _37 = a + _36;
	vertexPos.x = _37;
	var _38 = d - b;
	var _39 = t1 * _38;
	var _40 = b + _39;
	vertexPos.y = _40;
};
hxDaedalus.data.math.Geom2D.intersections2Circles = function(cx1,cy1,r1,cx2,cy2,r2,result) {
	var _0 = cx2 - cx1;
	var _1 = cx2 - cx1;
	var _2 = _0 * _1;
	var _3 = cy2 - cy1;
	var _4 = cy2 - cy1;
	var _5 = _3 * _4;
	var _6 = _2 + _5;
	var distRadiusSQRD = _6;
	var _7 = cx1 != cx2;
	var _8 = !_7;
	var _12;
	if(_8) _12 = cy1 != cy2; else _12 = true;
	var _22;
	if(_12) {
		var _19 = r1 + r2;
		var _13 = _19;
		var _9 = _13;
		var _20 = r1 + r2;
		var _14 = _20;
		var _10 = _14;
		var _21 = _9 * _10;
		var _15 = _21;
		var _11 = _15;
		_22 = distRadiusSQRD <= _11;
	} else _22 = false;
	var _26;
	if(_22) {
		var _23 = r1 - r2;
		var _16 = _23;
		var _24 = r1 - r2;
		var _17 = _24;
		var _25 = _16 * _17;
		var _18 = _25;
		_26 = distRadiusSQRD >= _18;
	} else _26 = false;
	if(_26) {
		var _27 = r1 + r2;
		var _28 = r1 + r2;
		var _29 = _27 * _28;
		var _30 = _29 - distRadiusSQRD;
		var _31 = r2 - r1;
		var _32 = r2 - r1;
		var _33 = _31 * _32;
		var _34 = distRadiusSQRD - _33;
		var _35 = _30 * _34;
		var _36 = Math.sqrt(_35);
		var transcendPart = _36;
		var _37 = cx1 + cx2;
		var _38 = _37 / 2;
		var _39 = cx2 - cx1;
		var _40 = r1 * r1;
		var _41 = r2 * r2;
		var _42 = _40 - _41;
		var _43 = _39 * _42;
		var _44 = 2 * distRadiusSQRD;
		var _45 = _43 / _44;
		var _46 = _38 + _45;
		var xFirstPart = _46;
		var _47 = cy1 + cy2;
		var _48 = _47 / 2;
		var _49 = cy2 - cy1;
		var _50 = r1 * r1;
		var _51 = r2 * r2;
		var _52 = _50 - _51;
		var _53 = _49 * _52;
		var _54 = 2 * distRadiusSQRD;
		var _55 = _53 / _54;
		var _56 = _48 + _55;
		var yFirstPart = _56;
		var _57 = cy2 - cy1;
		var _58 = 2 * distRadiusSQRD;
		var _59 = _57 / _58;
		var xFactor = _59;
		var _60 = cx2 - cx1;
		var _61 = 2 * distRadiusSQRD;
		var _62 = _60 / _61;
		var yFactor = _62;
		var _63 = result;
		var _64 = null;
		var _65 = _63 != _64;
		if(_65) {
			var _g = 0;
			var _66 = xFactor * transcendPart;
			var _67 = xFirstPart + _66;
			var _68 = yFactor * transcendPart;
			var _69 = yFirstPart - _68;
			var _70 = xFactor * transcendPart;
			var _71 = xFirstPart - _70;
			var _72 = yFactor * transcendPart;
			var _73 = yFirstPart + _72;
			var _74 = [_67,_69,_71,_73];
			var _g1 = _74;
			while(true) {
				var _75 = _g1.length;
				var _76 = _g < _75;
				var _77 = !_76;
				if(_77) break;
				var _78 = _g1;
				var _79 = _78[_g];
				var f = _79;
				++_g;
				result.push(f);
			}
		}
		return true;
	} else return false;
};
hxDaedalus.data.math.Geom2D.intersectionsSegmentCircle = function(p0x,p0y,p1x,p1y,cx,cy,r,result) {
	var _0 = p0x * p0x;
	var p0xSQD = _0;
	var _1 = p0y * p0y;
	var p0ySQD = _1;
	var _2 = p1y * p1y;
	var _3 = 2 * p1y;
	var _4 = _3 * p0y;
	var _5 = _2 - _4;
	var _6 = _5 + p0ySQD;
	var _7 = p1x * p1x;
	var _8 = _6 + _7;
	var _9 = 2 * p1x;
	var _10 = _9 * p0x;
	var _11 = _8 - _10;
	var _12 = _11 + p0xSQD;
	var a = _12;
	var _13 = 2 * p0y;
	var _14 = _13 * cy;
	var _15 = 2 * p0xSQD;
	var _16 = _14 - _15;
	var _17 = 2 * p1y;
	var _18 = _17 * p0y;
	var _19 = _16 + _18;
	var _20 = 2 * p0ySQD;
	var _21 = _19 - _20;
	var _22 = 2 * p1x;
	var _23 = _22 * p0x;
	var _24 = _21 + _23;
	var _25 = 2 * p1x;
	var _26 = _25 * cx;
	var _27 = _24 - _26;
	var _28 = 2 * p0x;
	var _29 = _28 * cx;
	var _30 = _27 + _29;
	var _31 = 2 * p1y;
	var _32 = _31 * cy;
	var _33 = _30 - _32;
	var b = _33;
	var _34 = cy * cy;
	var _35 = p0ySQD + _34;
	var _36 = cx * cx;
	var _37 = _35 + _36;
	var _38 = 2 * p0y;
	var _39 = _38 * cy;
	var _40 = _37 - _39;
	var _41 = 2 * p0x;
	var _42 = _41 * cx;
	var _43 = _40 - _42;
	var _44 = _43 + p0xSQD;
	var _45 = r * r;
	var _46 = _44 - _45;
	var c = _46;
	var _47 = b * b;
	var _48 = 4 * a;
	var _49 = _48 * c;
	var _50 = _47 - _49;
	var delta = _50;
	var deltaSQRT;
	var t0;
	var t1;
	var _51 = delta < 0;
	if(_51) return false; else {
		var _52 = delta == 0;
		if(_52) {
			var _53 = -b;
			var _54 = 2 * a;
			var _55 = _53 / _54;
			t0 = _55;
			var _56 = t0 < 0;
			var _57 = !_56;
			var _58;
			if(_57) _58 = t0 > 1; else _58 = true;
			if(_58) return false;
			var _59 = result;
			var _60 = null;
			var _61 = _59 != _60;
			if(_61) {
				var _g = 0;
				var _62 = p1x - p0x;
				var _63 = t0 * _62;
				var _64 = p0x + _63;
				var _65 = p1y - p0y;
				var _66 = t0 * _65;
				var _67 = p0y + _66;
				var _68 = [_64,_67,t0];
				var _g1 = _68;
				while(true) {
					var _69 = _g1.length;
					var _70 = _g < _69;
					var _71 = !_70;
					if(_71) break;
					var _72 = _g1;
					var _73 = _72[_g];
					var f = _73;
					++_g;
					result.push(f);
				}
			}
			return true;
		} else {
			var _74 = Math.sqrt(delta);
			deltaSQRT = _74;
			var _75 = -b;
			var _76 = _75 + deltaSQRT;
			var _77 = 2 * a;
			var _78 = _76 / _77;
			t0 = _78;
			var _79 = -b;
			var _80 = _79 - deltaSQRT;
			var _81 = 2 * a;
			var _82 = _80 / _81;
			t1 = _82;
			var intersecting = false;
			var _83 = 0 <= t0;
			var _84;
			if(_83) _84 = t0 <= 1; else _84 = false;
			if(_84) {
				var _85 = result;
				var _86 = null;
				var _87 = _85 != _86;
				if(_87) {
					var _g2 = 0;
					var _88 = p1x - p0x;
					var _89 = t0 * _88;
					var _90 = p0x + _89;
					var _91 = p1y - p0y;
					var _92 = t0 * _91;
					var _93 = p0y + _92;
					var _94 = [_90,_93,t0];
					var _g11 = _94;
					while(true) {
						var _95 = _g11.length;
						var _96 = _g2 < _95;
						var _97 = !_96;
						if(_97) break;
						var _98 = _g11;
						var _99 = _98[_g2];
						var f1 = _99;
						++_g2;
						result.push(f1);
					}
				}
				intersecting = true;
			}
			var _100 = 0 <= t1;
			var _101;
			if(_100) _101 = t1 <= 1; else _101 = false;
			if(_101) {
				var _102 = result;
				var _103 = null;
				var _104 = _102 != _103;
				if(_104) {
					var _g3 = 0;
					var _105 = p1x - p0x;
					var _106 = t1 * _105;
					var _107 = p0x + _106;
					var _108 = p1y - p0y;
					var _109 = t1 * _108;
					var _110 = p0y + _109;
					var _111 = [_107,_110,t1];
					var _g12 = _111;
					while(true) {
						var _112 = _g12.length;
						var _113 = _g3 < _112;
						var _114 = !_113;
						if(_114) break;
						var _115 = _g12;
						var _116 = _115[_g3];
						var f2 = _116;
						++_g3;
						result.push(f2);
					}
				}
				intersecting = true;
			}
			return intersecting;
		}
	}
};
hxDaedalus.data.math.Geom2D.intersectionsLineCircle = function(p0x,p0y,p1x,p1y,cx,cy,r,result) {
	var _0 = p0x * p0x;
	var p0xSQD = _0;
	var _1 = p0y * p0y;
	var p0ySQD = _1;
	var _2 = p1y * p1y;
	var _3 = 2 * p1y;
	var _4 = _3 * p0y;
	var _5 = _2 - _4;
	var _6 = _5 + p0ySQD;
	var _7 = p1x * p1x;
	var _8 = _6 + _7;
	var _9 = 2 * p1x;
	var _10 = _9 * p0x;
	var _11 = _8 - _10;
	var _12 = _11 + p0xSQD;
	var a = _12;
	var _13 = 2 * p0y;
	var _14 = _13 * cy;
	var _15 = 2 * p0xSQD;
	var _16 = _14 - _15;
	var _17 = 2 * p1y;
	var _18 = _17 * p0y;
	var _19 = _16 + _18;
	var _20 = 2 * p0ySQD;
	var _21 = _19 - _20;
	var _22 = 2 * p1x;
	var _23 = _22 * p0x;
	var _24 = _21 + _23;
	var _25 = 2 * p1x;
	var _26 = _25 * cx;
	var _27 = _24 - _26;
	var _28 = 2 * p0x;
	var _29 = _28 * cx;
	var _30 = _27 + _29;
	var _31 = 2 * p1y;
	var _32 = _31 * cy;
	var _33 = _30 - _32;
	var b = _33;
	var _34 = cy * cy;
	var _35 = p0ySQD + _34;
	var _36 = cx * cx;
	var _37 = _35 + _36;
	var _38 = 2 * p0y;
	var _39 = _38 * cy;
	var _40 = _37 - _39;
	var _41 = 2 * p0x;
	var _42 = _41 * cx;
	var _43 = _40 - _42;
	var _44 = _43 + p0xSQD;
	var _45 = r * r;
	var _46 = _44 - _45;
	var c = _46;
	var _47 = b * b;
	var _48 = 4 * a;
	var _49 = _48 * c;
	var _50 = _47 - _49;
	var delta = _50;
	var deltaSQRT;
	var t0;
	var t1;
	var _51 = delta < 0;
	if(_51) return false; else {
		var _52 = delta == 0;
		if(_52) {
			var _53 = -b;
			var _54 = 2 * a;
			var _55 = _53 / _54;
			t0 = _55;
			var _g = 0;
			var _56 = p1x - p0x;
			var _57 = t0 * _56;
			var _58 = p0x + _57;
			var _59 = p1y - p0y;
			var _60 = t0 * _59;
			var _61 = p0y + _60;
			var _62 = [_58,_61,t0];
			var _g1 = _62;
			while(true) {
				var _63 = _g1.length;
				var _64 = _g < _63;
				var _65 = !_64;
				if(_65) break;
				var _66 = _g1;
				var _67 = _66[_g];
				var f = _67;
				++_g;
				result.push(f);
			}
		} else {
			var _68 = delta > 0;
			if(_68) {
				var _69 = Math.sqrt(delta);
				deltaSQRT = _69;
				var _70 = -b;
				var _71 = _70 + deltaSQRT;
				var _72 = 2 * a;
				var _73 = _71 / _72;
				t0 = _73;
				var _74 = -b;
				var _75 = _74 - deltaSQRT;
				var _76 = 2 * a;
				var _77 = _75 / _76;
				t1 = _77;
				var _g2 = 0;
				var _78 = p1x - p0x;
				var _79 = t0 * _78;
				var _80 = p0x + _79;
				var _81 = p1y - p0y;
				var _82 = t0 * _81;
				var _83 = p0y + _82;
				var _84 = p1x - p0x;
				var _85 = t1 * _84;
				var _86 = p0x + _85;
				var _87 = p1y - p0y;
				var _88 = t1 * _87;
				var _89 = p0y + _88;
				var _90 = [_80,_83,t0,_86,_89,t1];
				var _g11 = _90;
				while(true) {
					var _91 = _g11.length;
					var _92 = _g2 < _91;
					var _93 = !_92;
					if(_93) break;
					var _94 = _g11;
					var _95 = _94[_g2];
					var f1 = _95;
					++_g2;
					result.push(f1);
				}
			}
		}
	}
	return true;
};
hxDaedalus.data.math.Geom2D.tangentsPointToCircle = function(px,py,cx,cy,r,result) {
	var _0 = px + cx;
	var _1 = _0 / 2;
	var c2x = _1;
	var _2 = py + cy;
	var _3 = _2 / 2;
	var c2y = _3;
	var _4 = px - cx;
	var _5 = px - cx;
	var _6 = _4 * _5;
	var _7 = py - cy;
	var _8 = py - cy;
	var _9 = _7 * _8;
	var _10 = _6 + _9;
	var _11 = Math.sqrt(_10);
	var _12 = 0.5 * _11;
	var r2 = _12;
	var _13 = result;
	var _14 = hxDaedalus.data.math.Geom2D.intersections2Circles(c2x,c2y,r2,cx,cy,r,_13);
	return _14;
};
hxDaedalus.data.math.Geom2D.tangentsCrossCircleToCircle = function(r,c1x,c1y,c2x,c2y,result) {
	var _0 = c1x - c2x;
	var _1 = c1x - c2x;
	var _2 = _0 * _1;
	var _3 = c1y - c2y;
	var _4 = c1y - c2y;
	var _5 = _3 * _4;
	var _6 = _2 + _5;
	var _7 = Math.sqrt(_6);
	var distance = _7;
	var _8 = distance / 4;
	var radius = _8;
	var _9 = c2x - c1x;
	var _10 = _9 / 4;
	var _11 = c1x + _10;
	var centerX = _11;
	var _12 = c2y - c1y;
	var _13 = _12 / 4;
	var _14 = c1y + _13;
	var centerY = _14;
	var _15 = result;
	var _16 = hxDaedalus.data.math.Geom2D.intersections2Circles(c1x,c1y,r,centerX,centerY,radius,_15);
	if(_16) {
		var _17 = result;
		var _18 = _17[0];
		var t1x = _18;
		var _19 = result;
		var _20 = _19[1];
		var t1y = _20;
		var _21 = result;
		var _22 = _21[2];
		var t2x = _22;
		var _23 = result;
		var _24 = _23[3];
		var t2y = _24;
		var _25 = c1x + c2x;
		var _26 = _25 / 2;
		var midX = _26;
		var _27 = c1y + c2y;
		var _28 = _27 / 2;
		var midY = _28;
		var _29 = t1x - midX;
		var _30 = c2y - c1y;
		var _31 = _29 * _30;
		var _32 = t1y - midY;
		var _33 = -c2x;
		var _34 = _33 + c1x;
		var _35 = _32 * _34;
		var _36 = _31 + _35;
		var dotProd = _36;
		var _37 = distance * distance;
		var _38 = dotProd / _37;
		var tproj = _38;
		var _39 = c2y - c1y;
		var _40 = tproj * _39;
		var _41 = midX + _40;
		var projx = _41;
		var _42 = c2x - c1x;
		var _43 = tproj * _42;
		var _44 = midY - _43;
		var projy = _44;
		var _45 = 2 * projx;
		var _46 = _45 - t1x;
		var t4x = _46;
		var _47 = 2 * projy;
		var _48 = _47 - t1y;
		var t4y = _48;
		var _49 = t4x + t2x;
		var _50 = _49 - t1x;
		var t3x = _50;
		var _51 = t2y + t4y;
		var _52 = _51 - t1y;
		var t3y = _52;
		var _g = 0;
		var _53 = [t3x,t3y,t4x,t4y];
		var _g1 = _53;
		while(true) {
			var _54 = _g1.length;
			var _55 = _g < _54;
			var _56 = !_55;
			if(_56) break;
			var _57 = _g1;
			var _58 = _57[_g];
			var f = _58;
			++_g;
			result.push(f);
		}
		return true;
	} else return false;
};
hxDaedalus.data.math.Geom2D.tangentsParalCircleToCircle = function(r,c1x,c1y,c2x,c2y,result) {
	var _0 = c1x - c2x;
	var _1 = c1x - c2x;
	var _2 = _0 * _1;
	var _3 = c1y - c2y;
	var _4 = c1y - c2y;
	var _5 = _3 * _4;
	var _6 = _2 + _5;
	var _7 = Math.sqrt(_6);
	var distance = _7;
	var _8 = c2y - c1y;
	var _9 = r * _8;
	var _10 = _9 / distance;
	var _11 = c1x + _10;
	var t1x = _11;
	var _12 = -c2x;
	var _13 = _12 + c1x;
	var _14 = r * _13;
	var _15 = _14 / distance;
	var _16 = c1y + _15;
	var t1y = _16;
	var _17 = 2 * c1x;
	var _18 = _17 - t1x;
	var t2x = _18;
	var _19 = 2 * c1y;
	var _20 = _19 - t1y;
	var t2y = _20;
	var _21 = t2x + c2x;
	var _22 = _21 - c1x;
	var t3x = _22;
	var _23 = t2y + c2y;
	var _24 = _23 - c1y;
	var t3y = _24;
	var _25 = t1x + c2x;
	var _26 = _25 - c1x;
	var t4x = _26;
	var _27 = t1y + c2y;
	var _28 = _27 - c1y;
	var t4y = _28;
	var _g = 0;
	var _29 = [t1x,t1y,t2x,t2y,t3x,t3y,t4x,t4y];
	var _g1 = _29;
	while(true) {
		var _30 = _g1.length;
		var _31 = _g < _30;
		var _32 = !_31;
		if(_32) break;
		var _33 = _g1;
		var _34 = _33[_g];
		var f = _34;
		++_g;
		result.push(f);
	}
};
hxDaedalus.data.math.Geom2D.distanceSquaredPointToLine = function(px,py,ax,ay,bx,by) {
	var _0 = bx - ax;
	var _1 = bx - ax;
	var _2 = _0 * _1;
	var _3 = by - ay;
	var _4 = by - ay;
	var _5 = _3 * _4;
	var _6 = _2 + _5;
	var a_b_squaredLength = _6;
	var _7 = px - ax;
	var _8 = bx - ax;
	var _9 = _7 * _8;
	var _10 = py - ay;
	var _11 = by - ay;
	var _12 = _10 * _11;
	var _13 = _9 + _12;
	var dotProduct = _13;
	var _14 = ax - px;
	var _15 = ax - px;
	var _16 = _14 * _15;
	var _17 = ay - py;
	var _18 = ay - py;
	var _19 = _17 * _18;
	var _20 = _16 + _19;
	var p_a_squaredLength = _20;
	var _21 = dotProduct * dotProduct;
	var _22 = _21 / a_b_squaredLength;
	var _23 = p_a_squaredLength - _22;
	return _23;
};
hxDaedalus.data.math.Geom2D.distanceSquaredPointToSegment = function(px,py,ax,ay,bx,by) {
	var _0 = bx - ax;
	var _1 = bx - ax;
	var _2 = _0 * _1;
	var _3 = by - ay;
	var _4 = by - ay;
	var _5 = _3 * _4;
	var _6 = _2 + _5;
	var a_b_squaredLength = _6;
	var _7 = px - ax;
	var _8 = bx - ax;
	var _9 = _7 * _8;
	var _10 = py - ay;
	var _11 = by - ay;
	var _12 = _10 * _11;
	var _13 = _9 + _12;
	var _14 = _13 / a_b_squaredLength;
	var dotProduct = _14;
	var _15 = dotProduct < 0;
	if(_15) {
		var _16 = px - ax;
		var _17 = px - ax;
		var _18 = _16 * _17;
		var _19 = py - ay;
		var _20 = py - ay;
		var _21 = _19 * _20;
		var _22 = _18 + _21;
		return _22;
	} else {
		var _23 = dotProduct <= 1;
		if(_23) {
			var _24 = ax - px;
			var _25 = ax - px;
			var _26 = _24 * _25;
			var _27 = ay - py;
			var _28 = ay - py;
			var _29 = _27 * _28;
			var _30 = _26 + _29;
			var p_a_squaredLength = _30;
			var _31 = dotProduct * dotProduct;
			var _32 = _31 * a_b_squaredLength;
			var _33 = p_a_squaredLength - _32;
			return _33;
		} else {
			var _34 = px - bx;
			var _35 = px - bx;
			var _36 = _34 * _35;
			var _37 = py - by;
			var _38 = py - by;
			var _39 = _37 * _38;
			var _40 = _36 + _39;
			return _40;
		}
	}
};
hxDaedalus.data.math.Geom2D.distanceSquaredVertexToEdge = function(vertex,edge) {
	var _0 = vertex.get_pos().x;
	var _1 = vertex.get_pos().y;
	var _2 = edge.get_originVertex().get_pos().x;
	var _3 = edge.get_originVertex().get_pos().y;
	var _4 = edge.get_destinationVertex().get_pos().x;
	var _5 = edge.get_destinationVertex().get_pos().y;
	var _6 = hxDaedalus.data.math.Geom2D.distanceSquaredPointToSegment(_0,_1,_2,_3,_4,_5);
	return _6;
};
hxDaedalus.data.math.Geom2D.pathLength = function(path) {
	var sumDistance = 0.;
	var _0 = path;
	var _1 = _0[0];
	var fromX = _1;
	var _2 = path;
	var _3 = _2[1];
	var fromY = _3;
	var nextX;
	var nextY;
	var x;
	var y;
	var distance;
	var i = 2;
	while(true) {
		var _4 = path.length;
		var _5 = i < _4;
		var _6 = !_5;
		if(_6) break;
		var _7 = path;
		var _8 = _7[i];
		nextX = _8;
		var _9 = path;
		var _10 = i + 1;
		var _11 = _9[_10];
		nextY = _11;
		var _12 = nextX - fromX;
		x = _12;
		var _13 = nextY - fromY;
		y = _13;
		var _14 = x * x;
		var _15 = y * y;
		var _16 = _14 + _15;
		var _17 = Math.sqrt(_16);
		distance = _17;
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
		var _0 = this.e;
		var _1 = _0 + tx;
		this.e = _1;
		var _2 = this.f;
		var _3 = _2 + ty;
		this.f = _3;
	}
	,scale: function(sx,sy) {
		var _0 = this.a;
		var _1 = _0 * sx;
		this.a = _1;
		var _2 = this.b;
		var _3 = _2 * sy;
		this.b = _3;
		var _4 = this.c;
		var _5 = _4 * sx;
		this.c = _5;
		var _6 = this.d;
		var _7 = _6 * sy;
		this.d = _7;
		var _8 = this.e;
		var _9 = _8 * sx;
		this.e = _9;
		var _10 = this.f;
		var _11 = _10 * sy;
		this.f = _11;
	}
	,rotate: function(rad) {
		var _0 = Math.cos(rad);
		var cos = _0;
		var _1 = Math.sin(rad);
		var sin = _1;
		var _2 = this.a;
		var _3 = _2 * cos;
		var _4 = this.b;
		var _5 = -sin;
		var _6 = _4 * _5;
		var _7 = _3 + _6;
		var a_ = _7;
		var _8 = this.a;
		var _9 = _8 * sin;
		var _10 = this.b;
		var _11 = _10 * cos;
		var _12 = _9 + _11;
		var b_ = _12;
		var _13 = this.c;
		var _14 = _13 * cos;
		var _15 = this.d;
		var _16 = -sin;
		var _17 = _15 * _16;
		var _18 = _14 + _17;
		var c_ = _18;
		var _19 = this.c;
		var _20 = _19 * sin;
		var _21 = this.d;
		var _22 = _21 * cos;
		var _23 = _20 + _22;
		var d_ = _23;
		var _24 = this.e;
		var _25 = _24 * cos;
		var _26 = this.f;
		var _27 = -sin;
		var _28 = _26 * _27;
		var _29 = _25 + _28;
		var e_ = _29;
		var _30 = this.e;
		var _31 = _30 * sin;
		var _32 = this.f;
		var _33 = _32 * cos;
		var _34 = _31 + _33;
		var f_ = _34;
		this.a = a_;
		this.b = b_;
		this.c = c_;
		this.d = d_;
		this.e = e_;
		this.f = f_;
	}
	,clone: function() {
		var _0 = this.a;
		var _1 = this.b;
		var _2 = this.c;
		var _3 = this.d;
		var _4 = this.e;
		var _5 = this.f;
		var _6 = new hxDaedalus.data.math.Matrix2D(_0,_1,_2,_3,_4,_5);
		return _6;
	}
	,tranform: function(point) {
		var _0 = this.a;
		var _1 = point.x;
		var _2 = _0 * _1;
		var _3 = this.c;
		var _4 = point.y;
		var _5 = _3 * _4;
		var _6 = _2 + _5;
		var _7 = this.e;
		var _8 = _6 + _7;
		var x = _8;
		var _9 = this.b;
		var _10 = point.x;
		var _11 = _9 * _10;
		var _12 = this.d;
		var _13 = point.y;
		var _14 = _12 * _13;
		var _15 = _11 + _14;
		var _16 = this.f;
		var _17 = _15 + _16;
		var y = _17;
		point.x = x;
		point.y = y;
	}
	,transformX: function(x,y) {
		var _0 = this.a;
		var _1 = _0 * x;
		var _2 = this.c;
		var _3 = _2 * y;
		var _4 = _1 + _3;
		var _5 = this.e;
		var _6 = _4 + _5;
		return _6;
	}
	,transformY: function(x,y) {
		var _0 = this.b;
		var _1 = _0 * x;
		var _2 = this.d;
		var _3 = _2 * y;
		var _4 = _1 + _3;
		var _5 = this.f;
		var _6 = _4 + _5;
		return _6;
	}
	,concat: function(matrix) {
		var _0 = this.a;
		var _1 = matrix.a;
		var _2 = _0 * _1;
		var _3 = this.b;
		var _4 = matrix.c;
		var _5 = _3 * _4;
		var _6 = _2 + _5;
		var a_ = _6;
		var _7 = this.a;
		var _8 = matrix.b;
		var _9 = _7 * _8;
		var _10 = this.b;
		var _11 = matrix.d;
		var _12 = _10 * _11;
		var _13 = _9 + _12;
		var b_ = _13;
		var _14 = this.c;
		var _15 = matrix.a;
		var _16 = _14 * _15;
		var _17 = this.d;
		var _18 = matrix.c;
		var _19 = _17 * _18;
		var _20 = _16 + _19;
		var c_ = _20;
		var _21 = this.c;
		var _22 = matrix.b;
		var _23 = _21 * _22;
		var _24 = this.d;
		var _25 = matrix.d;
		var _26 = _24 * _25;
		var _27 = _23 + _26;
		var d_ = _27;
		var _28 = this.e;
		var _29 = matrix.a;
		var _30 = _28 * _29;
		var _31 = this.f;
		var _32 = matrix.c;
		var _33 = _31 * _32;
		var _34 = _30 + _33;
		var _35 = matrix.e;
		var _36 = _34 + _35;
		var e_ = _36;
		var _37 = this.e;
		var _38 = matrix.b;
		var _39 = _37 * _38;
		var _40 = this.f;
		var _41 = matrix.d;
		var _42 = _40 * _41;
		var _43 = _39 + _42;
		var _44 = matrix.f;
		var _45 = _43 + _44;
		var f_ = _45;
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
	var _0 = this._currSeed = seed;
	this._originalSeed = _0;
	this.rangeMin = rangeMin_;
	this.rangeMax = rangeMax_;
	this._numIter = 0;
};
hxDaedalus.data.math.RandGenerator.__name__ = true;
hxDaedalus.data.math.RandGenerator.prototype = {
	set_seed: function(value) {
		var _0 = this._currSeed = value;
		this._originalSeed = _0;
		return value;
	}
	,get_seed: function() {
		var _0 = this._originalSeed;
		return _0;
	}
	,reset: function() {
		var _0 = this._originalSeed;
		this._currSeed = _0;
		this._numIter = 0;
	}
	,next: function() {
		var _0 = this._currSeed;
		var _1 = _0 * 1.0;
		var _floatSeed = _1;
		var _2 = _floatSeed * _floatSeed;
		var _3 = Std.string(_2);
		this._tempString = _3;
		while(true) {
			var _4 = this._tempString.length;
			var _5 = _4 < 8;
			var _6 = !_5;
			if(_6) break;
			var _7 = this._tempString;
			var _8 = "0" + _7;
			this._tempString = _8;
		}
		var _9 = this._tempString;
		var _10 = HxOverrides.substr(_9,1,5);
		var _11 = Std.parseInt(_10);
		this._currSeed = _11;
		var _12 = this.rangeMin;
		var _13 = this._currSeed;
		var _14 = _13 / 99999;
		var _15 = this.rangeMax;
		var _16 = this.rangeMin;
		var _17 = _15 - _16;
		var _18 = _14 * _17;
		var _19 = _12 + _18;
		var _20 = Math.round(_19);
		var res = _20;
		var _21 = this._currSeed;
		var _22 = _21 == 0;
		if(_22) {
			var _23 = this._originalSeed;
			var _24 = this._numIter;
			var _25 = _23 + _24;
			this._currSeed = _25;
		}
		this._numIter++;
		var _26 = this._numIter;
		var _27 = _26 == 200;
		if(_27) this.reset();
		return res;
	}
};
hxDaedalus.debug = {};
hxDaedalus.debug.Debug = function() { };
hxDaedalus.debug.Debug.__name__ = true;
hxDaedalus.debug.Debug.assertTrue = function(cond,message,pos) {
	var _0 = !cond;
	if(_0) {
		var _1 = pos.fileName;
		var _2 = _1 + ":";
		var _3 = pos.lineNumber;
		var _4 = _2 + _3;
		var _5 = _4 + ": Expected true but was false! ";
		var _6 = message != null;
		var _7;
		if(_6) _7 = message; else _7 = "";
		throw _5 + _7;
	}
};
hxDaedalus.debug.Debug.assertFalse = function(cond,message,pos) {
	if(cond) {
		var _0 = pos.fileName;
		var _1 = _0 + ":";
		var _2 = pos.lineNumber;
		var _3 = _1 + _2;
		var _4 = _3 + ": Expected false but was true! ";
		var _5 = message != null;
		var _6;
		if(_5) _6 = message; else _6 = "";
		throw _4 + _6;
	}
};
hxDaedalus.debug.Debug.assertEquals = function(expected,actual,message,pos) {
	var _0 = actual != expected;
	if(_0) {
		var _1 = pos.fileName;
		var _2 = _1 + ":";
		var _3 = pos.lineNumber;
		var _4 = _2 + _3;
		var _5 = _4 + ": Expected '";
		var _6 = Std.string(expected);
		var _7 = _5 + _6;
		var _8 = _7 + "' but was '";
		var _9 = Std.string(actual);
		var _10 = _8 + _9;
		var _11 = _10 + "' ";
		var _12 = message != null;
		var _13;
		if(_12) _13 = message; else _13 = "";
		throw _11 + _13;
	}
};
hxDaedalus.debug.Debug.trace = function(value,pos) {
	haxe.Log.trace(value,pos);
};
hxDaedalus.factories = {};
hxDaedalus.factories.RectMesh = function() {
};
hxDaedalus.factories.RectMesh.__name__ = true;
hxDaedalus.factories.RectMesh.buildRectangle = function(width,height) {
	var _0 = new hxDaedalus.data.Vertex();
	var vTL = _0;
	var _1 = new hxDaedalus.data.Vertex();
	var vTR = _1;
	var _2 = new hxDaedalus.data.Vertex();
	var vBR = _2;
	var _3 = new hxDaedalus.data.Vertex();
	var vBL = _3;
	var _4 = new hxDaedalus.data.Edge();
	var eTL_TR = _4;
	var _5 = new hxDaedalus.data.Edge();
	var eTR_TL = _5;
	var _6 = new hxDaedalus.data.Edge();
	var eTR_BR = _6;
	var _7 = new hxDaedalus.data.Edge();
	var eBR_TR = _7;
	var _8 = new hxDaedalus.data.Edge();
	var eBR_BL = _8;
	var _9 = new hxDaedalus.data.Edge();
	var eBL_BR = _9;
	var _10 = new hxDaedalus.data.Edge();
	var eBL_TL = _10;
	var _11 = new hxDaedalus.data.Edge();
	var eTL_BL = _11;
	var _12 = new hxDaedalus.data.Edge();
	var eTR_BL = _12;
	var _13 = new hxDaedalus.data.Edge();
	var eBL_TR = _13;
	var _14 = new hxDaedalus.data.Edge();
	var eTL_BR = _14;
	var _15 = new hxDaedalus.data.Edge();
	var eBR_TL = _15;
	var _16 = new hxDaedalus.data.Face();
	var fTL_BL_TR = _16;
	var _17 = new hxDaedalus.data.Face();
	var fTR_BL_BR = _17;
	var _18 = new hxDaedalus.data.Face();
	var fTL_BR_BL = _18;
	var _19 = new hxDaedalus.data.Face();
	var fTL_TR_BR = _19;
	var _20 = new hxDaedalus.data.ConstraintShape();
	var boundShape = _20;
	var _21 = new hxDaedalus.data.ConstraintSegment();
	var segTop = _21;
	var _22 = new hxDaedalus.data.ConstraintSegment();
	var segRight = _22;
	var _23 = new hxDaedalus.data.ConstraintSegment();
	var segBot = _23;
	var _24 = new hxDaedalus.data.ConstraintSegment();
	var segLeft = _24;
	var _25 = new hxDaedalus.data.Mesh(width,height);
	var mesh = _25;
	var _26 = 0.01 * 1000;
	var offset = _26;
	var _27 = 0 - offset;
	var _28 = 0 - offset;
	vTL.get_pos().setXY(_27,_28);
	var _29 = width + offset;
	var _30 = 0 - offset;
	vTR.get_pos().setXY(_29,_30);
	var _31 = width + offset;
	var _32 = height + offset;
	vBR.get_pos().setXY(_31,_32);
	var _33 = 0 - offset;
	var _34 = height + offset;
	vBL.get_pos().setXY(_33,_34);
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
	var _35 = [segTop,segLeft];
	vTL.set_fromConstraintSegments(_35);
	var _36 = [segTop,segRight];
	vTR.set_fromConstraintSegments(_36);
	var _37 = [segRight,segBot];
	vBR.set_fromConstraintSegments(_37);
	var _38 = [segBot,segLeft];
	vBL.set_fromConstraintSegments(_38);
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
	var _39 = [segTop,segRight,segBot,segLeft];
	var _g1 = _39;
	while(true) {
		var _40 = _g1.length;
		var _41 = _g < _40;
		var _42 = !_41;
		if(_42) break;
		var _43 = _g1;
		var _44 = _43[_g];
		var f = _44;
		++_g;
		boundShape.segments.push(f);
	}
	var _g2 = 0;
	var _45 = [vTL,vTR,vBR,vBL];
	var _g11 = _45;
	while(true) {
		var _46 = _g11.length;
		var _47 = _g2 < _46;
		var _48 = !_47;
		if(_48) break;
		var _49 = _g11;
		var _50 = _49[_g2];
		var f1 = _50;
		++_g2;
		mesh._vertices.push(f1);
	}
	var _g3 = 0;
	var _51 = [eTL_TR,eTR_TL,eTR_BR,eBR_TR,eBR_BL,eBL_BR,eBL_TL,eTL_BL,eTR_BL,eBL_TR,eTL_BR,eBR_TL];
	var _g12 = _51;
	while(true) {
		var _52 = _g12.length;
		var _53 = _g3 < _52;
		var _54 = !_53;
		if(_54) break;
		var _55 = _g12;
		var _56 = _55[_g3];
		var f2 = _56;
		++_g3;
		mesh._edges.push(f2);
	}
	var _g4 = 0;
	var _57 = [fTL_BL_TR,fTR_BL_BR,fTL_BR_BL,fTL_TR_BR];
	var _g13 = _57;
	while(true) {
		var _58 = _g13.length;
		var _59 = _g4 < _58;
		var _60 = !_59;
		if(_60) break;
		var _61 = _g13;
		var _62 = _61[_g4];
		var f3 = _62;
		++_g4;
		mesh._faces.push(f3);
	}
	mesh.get___constraintShapes().push(boundShape);
	var _63 = new Array();
	var securityRect = _63;
	var _g5 = 0;
	var _64 = [0,0,width,0];
	var _g14 = _64;
	while(true) {
		var _65 = _g14.length;
		var _66 = _g5 < _65;
		var _67 = !_66;
		if(_67) break;
		var _68 = _g14;
		var _69 = _68[_g5];
		var f4 = _69;
		++_g5;
		securityRect.push(f4);
	}
	var _g6 = 0;
	var _70 = [width,0,width,height];
	var _g15 = _70;
	while(true) {
		var _71 = _g15.length;
		var _72 = _g6 < _71;
		var _73 = !_72;
		if(_73) break;
		var _74 = _g15;
		var _75 = _74[_g6];
		var f5 = _75;
		++_g6;
		securityRect.push(f5);
	}
	var _g7 = 0;
	var _76 = [width,height,0,height];
	var _g16 = _76;
	while(true) {
		var _77 = _g16.length;
		var _78 = _g7 < _77;
		var _79 = !_78;
		if(_79) break;
		var _80 = _g16;
		var _81 = _80[_g7];
		var f6 = _81;
		++_g7;
		securityRect.push(f6);
	}
	var _g8 = 0;
	var _82 = [0,height,0,0];
	var _g17 = _82;
	while(true) {
		var _83 = _g17.length;
		var _84 = _g8 < _83;
		var _85 = !_84;
		if(_85) break;
		var _86 = _g17;
		var _87 = _86[_g8];
		var f7 = _87;
		++_g8;
		securityRect.push(f7);
	}
	mesh.set_clipping(false);
	var _88 = securityRect;
	mesh.insertConstraintShape(_88);
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
		var _0 = this._fromFace.get_edge();
		this._nextEdge = _0;
		return value;
	}
	,next: function() {
		var _0 = this._nextEdge;
		var _1 = _0 != null;
		if(_1) {
			var _2 = this._nextEdge;
			this._resultEdge = _2;
			var _3 = this._nextEdge.get_nextLeftEdge();
			this._nextEdge = _3;
			var _4 = this._nextEdge;
			var _5 = this._fromFace.get_edge();
			var _6 = _4 == _5;
			if(_6) this._nextEdge = null;
		} else this._resultEdge = null;
		var _7 = this._resultEdge;
		return _7;
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
		while(true) {
			var _0 = this._currIndex;
			var _1 = this._fromMesh._vertices.length;
			var _2 = _0 < _1;
			if(_2) {
				var _3 = this._fromMesh._vertices;
				var _4 = this._currIndex;
				var _5 = _3[_4];
				this._resultVertex = _5;
				this._currIndex++;
			} else {
				this._resultVertex = null;
				break;
			}
			var _6 = this._resultVertex.get_isReal();
			var _7 = !_6;
			var _8 = !_7;
			if(_8) break;
		}
		var _9 = this._resultVertex;
		return _9;
	}
};
hxDaedalus.iterators.FromVertexToHoldingFaces = function() {
};
hxDaedalus.iterators.FromVertexToHoldingFaces.__name__ = true;
hxDaedalus.iterators.FromVertexToHoldingFaces.prototype = {
	set_fromVertex: function(value) {
		this._fromVertex = value;
		var _0 = this._fromVertex.get_edge();
		this._nextEdge = _0;
		return value;
	}
	,next: function() {
		var _0 = this._nextEdge;
		var _1 = _0 != null;
		if(_1) while(true) {
			var _2 = this._nextEdge.get_leftFace();
			this._resultFace = _2;
			var _3 = this._nextEdge.get_rotLeftEdge();
			this._nextEdge = _3;
			var _4 = this._nextEdge;
			var _5 = this._fromVertex.get_edge();
			var _6 = _4 == _5;
			if(_6) {
				this._nextEdge = null;
				var _7 = this._resultFace.get_isReal();
				var _8 = !_7;
				if(_8) this._resultFace = null;
				break;
			}
			var _9 = this._resultFace.get_isReal();
			var _10 = !_9;
			var _11 = !_10;
			if(_11) break;
		} else this._resultFace = null;
		var _12 = this._resultFace;
		return _12;
	}
};
hxDaedalus.iterators.FromVertexToIncomingEdges = function() {
};
hxDaedalus.iterators.FromVertexToIncomingEdges.__name__ = true;
hxDaedalus.iterators.FromVertexToIncomingEdges.prototype = {
	set_fromVertex: function(value) {
		this._fromVertex = value;
		var _0 = this._fromVertex.get_edge();
		this._nextEdge = _0;
		while(true) {
			var _1 = this._nextEdge.get_isReal();
			var _2 = !_1;
			var _3 = !_2;
			if(_3) break;
			var _4 = this._nextEdge.get_rotLeftEdge();
			this._nextEdge = _4;
		}
		return value;
	}
	,next: function() {
		var _0 = this._nextEdge;
		var _1 = _0 != null;
		if(_1) {
			var _2 = this._nextEdge.get_oppositeEdge();
			this._resultEdge = _2;
			while(true) {
				var _3 = this._nextEdge.get_rotLeftEdge();
				this._nextEdge = _3;
				var _4 = this._nextEdge;
				var _5 = this._fromVertex.get_edge();
				var _6 = _4 == _5;
				if(_6) {
					this._nextEdge = null;
					break;
				}
				var _7 = this._nextEdge.get_isReal();
				var _8 = !_7;
				var _9 = !_8;
				if(_9) break;
			}
		} else this._resultEdge = null;
		var _10 = this._resultEdge;
		return _10;
	}
};
hxDaedalus.iterators.FromVertexToOutgoingEdges = function() {
	this.realEdgesOnly = true;
};
hxDaedalus.iterators.FromVertexToOutgoingEdges.__name__ = true;
hxDaedalus.iterators.FromVertexToOutgoingEdges.prototype = {
	set_fromVertex: function(value) {
		this._fromVertex = value;
		var _0 = this._fromVertex.get_edge();
		this._nextEdge = _0;
		while(true) {
			var _2 = this.realEdgesOnly;
			var _4;
			if(_2) {
				var _3 = this._nextEdge.get_isReal();
				var _1 = _3;
				_4 = !_1;
			} else _4 = false;
			var _5 = !_4;
			if(_5) break;
			var _6 = this._nextEdge.get_rotLeftEdge();
			this._nextEdge = _6;
		}
		return value;
	}
	,next: function() {
		var _0 = this._nextEdge;
		var _1 = _0 != null;
		if(_1) {
			var _2 = this._nextEdge;
			this._resultEdge = _2;
			while(true) {
				var _3 = this._nextEdge.get_rotLeftEdge();
				this._nextEdge = _3;
				var _4 = this._nextEdge;
				var _5 = this._fromVertex.get_edge();
				var _6 = _4 == _5;
				if(_6) {
					this._nextEdge = null;
					break;
				}
				var _8 = this.realEdgesOnly;
				var _10;
				if(_8) {
					var _9 = this._nextEdge.get_isReal();
					var _7 = _9;
					_10 = !_7;
				} else _10 = false;
				var _11 = !_10;
				if(_11) break;
			}
		} else this._resultEdge = null;
		var _12 = this._resultEdge;
		return _12;
	}
};
hxDaedalus.view = {};
hxDaedalus.view.SimpleViewJS = function() {
	var _0 = new hxDaedalus.canvas.BasicCanvas();
	this.basicCanvas = _0;
	var _1 = this.basicCanvas.surface;
	this.surface = _1;
};
hxDaedalus.view.SimpleViewJS.__name__ = true;
hxDaedalus.view.SimpleViewJS.prototype = {
	drawMesh: function(mesh_) {
		var _1 = mesh_ != null;
		if(_1) this.mesh = mesh_;
		this.basicCanvas.clear();
		this.basicCanvas.lineStyle(0.5,16711680);
		this.surface.beginPath();
		var _2 = this.mesh.get_width();
		var _3 = this.mesh.get_height();
		this.surface.rect(0,0,_2,_3);
		this.basicCanvas.endDraw();
		var vertex;
		var incomingEdge;
		var holdingFace;
		var iterVertices;
		var _4 = new hxDaedalus.iterators.FromMeshToVertices();
		iterVertices = _4;
		var _5 = this.mesh;
		iterVertices.set_fromMesh(_5);
		var iterEdges;
		var _6 = new hxDaedalus.iterators.FromVertexToIncomingEdges();
		iterEdges = _6;
		var _8;
		var _7 = new haxe.ds.ObjectMap();
		var _0 = _7;
		_8 = _0;
		var dictVerticesDone = _8;
		while(true) {
			var _9 = iterVertices.next();
			vertex = _9;
			var _10 = vertex;
			var _11 = _10 != null;
			var _12 = !_11;
			if(_12) break;
			dictVerticesDone.set(vertex,true);
			true;
			var _13 = this.mesh;
			var _14 = this.vertexIsInsideAABB(vertex,_13);
			var _15 = !_14;
			if(_15) {
				var _16 = iterVertices.next();
				vertex = _16;
				var _17 = vertex;
				var _18 = _17 != null;
				var _19 = !_18;
				if(_19) break; else continue;
			}
			var _20 = vertex.get_pos().x;
			var _21 = vertex.get_pos().y;
			this.basicCanvas.drawCircle(_20,_21,0.5);
			this.basicCanvas.endDraw();
			iterEdges.set_fromVertex(vertex);
			while(true) {
				var _22 = iterEdges.next();
				incomingEdge = _22;
				var _23 = incomingEdge;
				var _24 = _23 != null;
				var _25 = !_24;
				if(_25) break;
				var _27;
				var _26 = incomingEdge.get_originVertex();
				var key = _26;
				_27 = dictVerticesDone.get(key);
				var _28 = !_27;
				if(_28) {
					var _29 = incomingEdge.get_isConstrained();
					if(_29) {
						this.basicCanvas.lineStyle(0.5,16711680);
						var _30 = incomingEdge.get_originVertex().get_pos().x;
						var _31 = incomingEdge.get_originVertex().get_pos().y;
						this.surface.moveTo(_30,_31);
						var _32 = incomingEdge.get_destinationVertex().get_pos().x;
						var _33 = incomingEdge.get_destinationVertex().get_pos().y;
						this.surface.lineTo(_32,_33);
						this.basicCanvas.endDraw();
					} else {
						this.basicCanvas.lineStyle(0.5,10066329);
						var _34 = incomingEdge.get_originVertex().get_pos().x;
						var _35 = incomingEdge.get_originVertex().get_pos().y;
						this.surface.moveTo(_34,_35);
						var _36 = incomingEdge.get_destinationVertex().get_pos().x;
						var _37 = incomingEdge.get_destinationVertex().get_pos().y;
						this.surface.lineTo(_36,_37);
						this.basicCanvas.endDraw();
					}
				}
			}
		}
	}
	,drawEntity: function(entity) {
		this.basicCanvas.lineStyle(0.5,65280);
		this.basicCanvas.beginFill(65280);
		var _0 = entity.x;
		var _1 = entity.y;
		var _2 = entity.get_radius();
		this.basicCanvas.drawCircle(_0,_1,_2);
		this.basicCanvas.endDraw();
	}
	,drawEntities: function(vEntities) {
		this.basicCanvas.lineStyle(0.5,65280);
		var _g1 = 0;
		var _0 = vEntities.length;
		var _g = _0;
		while(true) {
			var _1 = _g1 < _g;
			var _2 = !_1;
			if(_2) break;
			var _3 = _g1++;
			var i = _3;
			this.basicCanvas.beginFill(65280);
			var _4 = vEntities;
			var _5 = _4[i].x;
			var _6 = vEntities;
			var _7 = _6[i].y;
			var _8 = vEntities;
			var _9 = _8[i].get_radius();
			this.basicCanvas.drawCircle(_5,_7,_9);
			this.basicCanvas.endDraw();
		}
	}
	,drawPath: function(path,cleanBefore) {
		if(cleanBefore == null) cleanBefore = true;
		var _0 = path.length;
		var _1 = _0 == 0;
		if(_1) return;
		this.basicCanvas.lineStyle(0.5,16760848);
		var _2 = path;
		var _3 = _2[0];
		var _4 = path;
		var _5 = _4[1];
		this.surface.moveTo(_3,_5);
		var i = 2;
		while(true) {
			var _6 = path.length;
			var _7 = i < _6;
			var _8 = !_7;
			if(_8) break;
			var _9 = path;
			var _10 = _9[i];
			var _11 = path;
			var _12 = i + 1;
			var _13 = _11[_12];
			this.surface.lineTo(_10,_13);
			var _14 = path;
			var _15 = _14[i];
			var _16 = path;
			var _17 = i + 1;
			var _18 = _16[_17];
			this.surface.moveTo(_15,_18);
			i += 2;
		}
		this.basicCanvas.endDraw();
	}
	,vertexIsInsideAABB: function(vertex,mesh) {
		var _0 = vertex.get_pos().x;
		var _3 = _0 < 0;
		var _4 = !_3;
		var _10;
		if(_4) {
			var _8 = vertex.get_pos().x;
			var _5 = _8;
			var _1 = _5;
			var _9 = mesh.get_width();
			var _6 = _9;
			var _2 = _6;
			_10 = _1 > _2;
		} else _10 = true;
		var _11 = !_10;
		var _16;
		if(_11) {
			var _15 = vertex.get_pos().y;
			var _12 = _15;
			var _7 = _12;
			_16 = _7 < 0;
		} else _16 = true;
		var _17 = !_16;
		var _20;
		if(_17) {
			var _18 = vertex.get_pos().y;
			var _13 = _18;
			var _19 = mesh.get_height();
			var _14 = _19;
			_20 = _13 > _14;
		} else _20 = true;
		if(_20) return false; else return true;
	}
};
var js = {};
js.Boot = function() { };
js.Boot.__name__ = true;
js.Boot.__unhtml = function(s) {
	var _0 = s.split("&").join("&amp;").split("<").join("&lt;").split(">").join("&gt;");
	return _0;
};
js.Boot.__trace = function(v,i) {
	var msg = i != null?i.fileName + ":" + i.lineNumber + ": ":"";
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
BasicsJS.main();
})();

//# sourceMappingURL=daedalusBasic.js.map