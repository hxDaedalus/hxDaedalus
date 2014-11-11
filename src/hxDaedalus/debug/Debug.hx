package hxDaedalus.debug;

import haxe.PosInfos;


/**
 * Used for sanity-checks throughout the code when in debug mode (or if -D DAEDALUS_CHECKS is passed to the compiler).
 * Should be automatically stripped out by the compiler in release mode (or if -D NO_DAEDALUS_CHECKS is passed to the compiler).
 * Same applies to -D DAEDALUS_TRACE and -D NO_DAEDALUS_TRACE.
 */
class Debug
{
	
#if ((debug && !NO_DAEDALUS_CHECKS) || DAEDALUS_CHECKS)

	static public function assertTrue(cond:Bool, ?message:String, ?pos:PosInfos) {
		if (!cond) {
			throw pos.fileName + ":" + pos.lineNumber + ": Expected true but was false! " + (message != null ? message : "");
		}
	}
	
	static public function assertFalse(cond:Bool, ?message:String, ?pos:PosInfos) {
		if (cond) {
			throw pos.fileName + ":" + pos.lineNumber + ": Expected false but was true! " + (message != null ? message : "");
		}
	}
	
	static public function assertEquals<T>(expected:T, actual:T, ?message:String, ?pos:PosInfos) {
		if (actual != expected) {
			throw pos.fileName + ":" + pos.lineNumber + ": Expected '" + expected + "' but was '" + actual + "' " + (message != null ? message : "");
		}
	}
	
#elseif (!debug || NO_DAEDALUS_CHECKS)

	inline static public function assertTrue(cond:Bool, ?message:String, ?pos:PosInfos) {
		return;
	}
	
	inline static public function assertFalse(cond:Bool, ?message:String, ?pos:PosInfos) {
		return;
	}
	
	inline static public function assertEquals<T>(expected:T, actual:T, ?message:String, ?pos:PosInfos) {
		return;
	}

#end


#if ((debug && !NO_DAEDALUS_TRACE) || DAEDALUS_TRACE)

	inline static public function trace(value:Dynamic, ?pos:PosInfos) {
		haxe.Log.Debug.trace(value, pos);
	}

#elseif (!debug || NO_DAEDALUS_TRACE)

	inline static public function trace(value:Dynamic, ?pos:PosInfos) {
		return;
	}

#end
}