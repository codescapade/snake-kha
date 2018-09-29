package;

import kha.Scheduler;

class Timer {
	public var detlaTime(default, null):Float;
	public var elapsedTime(default, null):Float;

	private var lastTime:Float;

	public function update() {
		var currentTime:Float = Scheduler.time();
		detlaTime = currentTime - lastTime;
		elapsedTime+= detlaTime;
		lastTime = currentTime;
	}
	public function reset():Void {
		lastTime = Scheduler.time();
		detlaTime = 0;
		elapsedTime = 0;
	}
}