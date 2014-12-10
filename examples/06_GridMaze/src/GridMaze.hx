package ;

import hxDaedalus.data.math.RandGenerator;
import hxDaedalus.data.Object;

/**
 * @see http://weblog.jamisbuck.org/2011/1/27/maze-generation-growing-tree-algorithm 
 * 
 * Adapted for readability, not performance
 **/
class GridMaze
{
	static public var object(default, null):Object;
	
	static public var tileWidth(default, null):Float;
	static public var tileHeight(default, null):Float;
	
	static public var rows(default, null):Int;
	static public var cols(default, null):Int;
	
	static public var grid:Array<Array<Cell>>;
	static public var rng:RandGenerator;
	
	static public function generate(width:Float, height:Float, cols:Int, rows:Int, seed:Int = 7459) 
	{
		tileWidth = Std.int(width / cols);
		tileHeight = Std.int(height / rows);
		GridMaze.cols = cols;
		GridMaze.rows = rows;
		
		rng = new RandGenerator(seed);
		
		makeGrid();
		traverseGrid();
		populateObject();
	}
	
	static function makeGrid() 
	{
		grid = [];
		for (c in 0...cols) {
			grid[c] = [];
			for (r in 0...rows) {
				var cell = new Cell(c, r);
				grid[c][r] = cell;
				var topLeft = [c * tileWidth, r * tileHeight];
				var topRight = [(c + 1) * tileWidth, r * tileHeight];
				var bottomLeft = [c * tileWidth, (r + 1) * tileHeight];
				var bottomRight = [(c + 1) * tileWidth, (r + 1) * tileHeight];
				cell.walls[DIR.N] = topLeft.concat(topRight);
				/*if (r != rows-1 || c != cols-1)*/ cell.walls[DIR.E] = topRight.concat(bottomRight);
				cell.walls[DIR.S] = bottomLeft.concat(bottomRight);
				if (r != 0 || c != 0) cell.walls[DIR.W] = topLeft.concat(bottomLeft);
			}
		}
	}
	
	static function traverseGrid() 
	{
		//         N   E   S   W
		var DX = [ 0,  1,  0, -1];
		var DY = [-1,  0,  1,  0];
		var REVERSED_DIR = [DIR.S, DIR.W, DIR.N, DIR.E];
		
		var c = rng.nextInRange(0, cols - 1);
		var r = rng.nextInRange(0, rows - 1);
		
		var cells = [grid[c][r]];
		while (cells.length > 0) {
			var idx = cells.length - 1;
			var currCell = cells[idx];
			currCell.visited = true;
			var dirs = [DIR.N, DIR.E, DIR.S, DIR.W];
			rng.shuffle(dirs);
			for (dir in dirs) {
				var c = currCell.col + DX[dir];
				var r = currCell.row + DY[dir];
				if (c >= 0 && c < cols && r >= 0 && r < rows && !grid[c][r].visited) {	// remove wall between currCell and chosenCell
					var chosenCell = grid[c][r];
					currCell.walls[dir] = [];
					chosenCell.walls[REVERSED_DIR[dir]] = [];
					chosenCell.visited = true;
					cells.push(chosenCell);
					idx = -1;
					break;
				}
			}
			if (idx >= 0) cells.splice(idx, 1);
		}
	}
	
	static function populateObject() 
	{
        object = new Object();
		var coords = [];
		for (c in 0...cols) {
			for (r in 0...rows) {
				var cell = grid[c][r];
				for (wall in cell.walls) {
					for (coord in wall) coords.push(coord);
				}
			}
		}
		
		object.coordinates = coords;
	}
}

class DIR
{
	inline static public var N:Int = 0;
	inline static public var E:Int = 1;
	inline static public var S:Int = 2;
	inline static public var W:Int = 3;
}

class Cell
{
	public var walls:Array<Array<Float>>;
	public var visited:Bool = false;
	public var col:Int;
	public var row:Int;
	
	public function new(col:Int, row:Int) {
		this.col = col;
		this.row = row;
		
		walls = [for (i in DIR.N...DIR.W + 1) []];
	}
}
