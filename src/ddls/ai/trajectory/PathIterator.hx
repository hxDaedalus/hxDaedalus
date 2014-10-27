package DDLS.ai.trajectory
{
	import DDLS.ai.DDLSEntityAI;

	public class DDLSPathIterator
	{
		
		private  var _entity:DDLSEntityAI;
		private var _currentX:Number;
		private var _currentY:Number;
		private var _hasPrev:Boolean;
		private var _hasNext:Boolean;
		
		private var _path:Vector.<Number>;
		private var _count:int;
		private var _countMax:int;
		
		public function DDLSPathIterator()
		{
			
		}
		
		public function get entity():DDLSEntityAI
		{
			return _entity;
		}
		
		public function set entity(value:DDLSEntityAI):void
		{
			_entity = value;
		}
		
		public function get x():Number
		{
			return _currentX;
		}
		
		public function get y():Number
		{
			return _currentY;
		}
		
		public function get hasPrev():Boolean
		{
			return _hasPrev;
		}
		
		public function get hasNext():Boolean
		{
			return _hasNext;
		}
		
		public function get count():int
		{
			return _count;
		}
		
		public function get countMax():int
		{
			return _countMax;
		}
		
		public function set path(value:Vector.<Number>):void
		{
			_path = value;
			_countMax = _path.length / 2;
			reset();
		}
		
		public function reset():void
		{
			_count = 0;
			_currentX = _path[_count];
			_currentY = _path[_count+1];
			updateEntity();
			
			_hasPrev = false;
			if (_path.length > 2)
				_hasNext = true;
			else
				_hasNext = false;
		}
		
		public function prev():Boolean
		{
			if (! _hasPrev)
				return false;
			_hasNext = true;
			
			_count--;
			_currentX = _path[_count*2];
			_currentY = _path[_count*2+1];
			
			updateEntity();
			
			if (_count == 0)
				_hasPrev = false;
			
			return true;
		}
		
		public function next():Boolean
		{
			if (! _hasNext)
				return false;
			_hasPrev = true;
			
			_count++;
			_currentX = _path[_count*2];
			_currentY = _path[_count*2+1];
			
			updateEntity();
			
			if ((_count+1)*2 == _path.length)
				_hasNext = false;
			
			return true;
		}
		
		private function updateEntity():void
		{
			if (!_entity)
				return;
			
			_entity.x = _currentX;
			_entity.y = _currentY;
		}
		
	}
}