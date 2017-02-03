(function() { 
  'use strict';

  // this implements parts of ISimpleDrawingContext in plain js (so it can be used by SimpleView)
  function DrawingContext(canvas) {

    var self = this;

    self.canvas = canvas;
    self.width = canvas.width;
    self.height = canvas.height;
    self.context = canvas.getContext("2d");

    var ctx = self.context;

    function int2rgb(color) {
      return { 
        r: (color >> 16) & 0xFF,
        g: (color >> 8) & 0xFF,
        b: (color) & 0xFF
      }
    }

    self.clear = function() {
      ctx.clearRect(0, 0, self.width, self.height);
    }

    self.lineStyle = function(thickness, color, alpha) {
      alpha = alpha || 1.;
      var rgb = int2rgb(color);
      ctx.lineWidth = thickness;
      ctx.strokeStyle = 'rgba(' + rgb.r + ',' + rgb.g + ',' + rgb.b + ',' + alpha + ')';
    }

    self.beginFill = function(color, alpha) {
      alpha = alpha || 1.;
      var rgb = int2rgb(color);
      ctx.fillStyle = 'rgba(' + rgb.r + ',' + rgb.g + ',' + rgb.b + ',' + alpha + ')';
    }

    self.endFill = function() {
      ctx.stroke();
      ctx.closePath();
      ctx.fill();
    }

    self.moveTo = function(x, y) {
      ctx.beginPath();
      ctx.moveTo(x, y);
    }

    self.lineTo = function(x, y) {
      ctx.lineTo(x, y);
      ctx.closePath();
      ctx.stroke();
    }

    self.drawCircle = function(cx, cy, radius) {
      ctx.beginPath();
      ctx.arc(cx, cy, radius, 0, 2 * Math.PI);
      ctx.stroke();
      ctx.closePath();
    }

    self.drawRect = function(x, y, width, height) {
      ctx.beginPath();
      ctx.moveTo( x, y );
      ctx.lineTo(x + width, y);
      ctx.lineTo(x + width, y + height);
      ctx.lineTo(x, y + height);
      ctx.stroke();
      ctx.closePath();
    }
  }
  
  

  function createCanvas(w, h, id) {
    var canvas = document.createElement('canvas');
    canvas.style.position = 'absolute';
    canvas.style.top = canvas.style.left = 0;
    canvas.id = id;
    canvas.width = w;
    canvas.height = h;
    return canvas;
  }

  // grab images from dom
  var backImage = document.querySelector('#galapagosColor');
  var bwImage = document.querySelector('#galapagosBW');
  var width = backImage.width;
  var height = backImage.height;

  // create two canvas, one layered on top of the other
  var backCanvas = createCanvas(width, height, 'background-canvas');
  var overlayCanvas = createCanvas(width, height, 'overlay-canvas');
  
  // and draw on them
  var context = backCanvas.getContext('2d');
  context.drawImage(backImage, 0, 0);
  document.body.appendChild(backCanvas);
  
  context = overlayCanvas.getContext('2d');
  context.drawImage(bwImage, 0, 0);
  
  // extract data from overlay (and clear it afterwards)
  var imgData = context.getImageData(0, 0, width, height);
  var HxPixels = hxPixels._Pixels.Pixels_Impl_;
  var pixels = HxPixels.fromImageData(imgData);
  context.clearRect(0, 0, width, height);
  document.body.appendChild(overlayCanvas);
  
  // create a rect mesh and insert the object built from extracted data
  var mesh = hxDaedalus.factories.RectMesh.buildRectangle(width, height);
  var object = hxDaedalus.factories.BitmapObject.buildFromBmpData(pixels, 1.8);
  mesh.insertObject(object);

  // add an entity
  var entity = new hxDaedalus.ai.EntityAI();
  entity.set_radius(4);
  entity.x = 50;
  entity.y = 50;

  // setup a path finder
  var pathFinder = new hxDaedalus.ai.PathFinder();
  pathFinder.entity = entity;
  pathFinder.set_mesh(mesh);

  // and a path sampler
  var path = [];
  var pathSampler = new hxDaedalus.ai.trajectory.LinearPathSampler();
  pathSampler.entity = entity;
  pathSampler.set_samplingDistance(10);
  pathSampler.set_path(path);
  
  function drawEntity() {
    context.beginPath();
    context.arc(entity.x, entity.y, entity.get_radius(), 0, 2 * Math.PI);
    context.strokeStyle = '#00ff00';
    context.stroke();
  }

  // create a view and draw the mesh on top of background canvas
  var drawingContext = new DrawingContext(backCanvas)
  var view = new hxDaedalus.view.SimpleView();
  view.graphics = { graphics: drawingContext };
  view.drawMesh(mesh, false);
  
  // create a simple view on top of overlay
  drawingContext = new DrawingContext(overlayCanvas)
  view = new hxDaedalus.view.SimpleView();
  view.graphics = { graphics: drawingContext };
  
  var newPath = false;

  function setupMouseEvents() {
    function onMouseUp(event) {
      newPath = false;
    }

    function onMouseDown(event) {
      newPath = true;
    }

    function onMouseMove(event) {
      var rect = event.target.getBoundingClientRect();
      mouseX = event.clientX - rect.left;
      mouseY = event.clientY - rect.top;
    }

    overlayCanvas.addEventListener('mouseup', onMouseUp);
    overlayCanvas.addEventListener('mousedown', onMouseDown);
    overlayCanvas.addEventListener('mousemove', onMouseMove);
  }

  setupMouseEvents();

  drawEntity();
  var mouseX = 0;
  var mouseY = 0;

  function onEnterFrame() {
    if (newPath) {
      drawingContext.clear();                     // clear overlay
      pathFinder.findPath(mouseX, mouseY, path);  // find new path
      view.drawPath(path);                        // draw path
      pathSampler.reset();                        // reset the path sampler to manage new generated path
    }

	drawEntity();
	
    if (pathSampler.get_hasNext()) {
      pathSampler.next(); // move entity to next sampled position
    }

    window.requestAnimationFrame(onEnterFrame);
  }

  // register main loop
  window.requestAnimationFrame(onEnterFrame);
})();