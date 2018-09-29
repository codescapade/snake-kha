package;

import kha.input.KeyCode;

class Controls {
	public var left = false;
	public var right = false;
	public var up = false;
	public var down = false;
	public var start = false;

	public function new() {

	}

	public function keyDown(keyCode:KeyCode) {
		switch (keyCode) {
			case Left:
				left = true;
			case Right:
				right = true;
			case Up:
				up = true;
			case Down:
				down = true;
			case Shift:
				start = true;
			default:
		}
	}

	public function keyUp(keyCode:KeyCode) {
		switch (keyCode) {
			case Left:
				left = false;
			case Right:
				right = false;
			case Up:
				up = false;
			case Down:
				down = false;
			case Shift:
				start = false;
			default:
		}
	}
}