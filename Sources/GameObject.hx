package;

import kha.graphics2.Graphics;

class GameObject {
	@:isVar
	public var x(get, set):Int;
	@:isVar
	public var y(get, set):Int;

	public function new (x:Int = 0, y:Int = 0) {
		this.x = x;
		this.y = y;
	}

	public function update(deltaTime:Float):Void {

	}

	public function render(grahpics:Graphics):Void {

	}

	public function destroy():Void {
		
	}

	private function get_x():Int {
		return x;
	}

	private function set_x(value:Int):Int {
		x = value;

		return x;
	}

	private function get_y():Int {
		return y;
	}

	private function set_y(value:Int):Int {
		y = value;

		return y;
	}
}