package;

import kha.math.Vector2i;
import kha.graphics2.Graphics;
import kha.Color;

class Snake {

	private static var SNAKE_COLOR = Color.fromString("#66DDAA");
	private var head:Sprite;
	private var body:Array<Sprite>;
	private var currentDirection:Vector2i;
	private var state:PlayState;

	public function new(x:Int, y:Int, state:PlayState) {
		this.state = state;
		head = new Sprite(x, y, 16, 16, SNAKE_COLOR);
		state.add(head);
		body = [];
		body.push(createSegment(x - 1, y));
		body.push(createSegment(x - 2, y));

		currentDirection = new Vector2i(1, 0);
	}

	public function update(direction:Vector2i):Void {
		if (!invalidDirection(direction)) {
			currentDirection.x = direction.x;
			currentDirection.y = direction.y;
		}

		var lastX = head.x;
		var lastY = head.y;

		var newX = head.x + currentDirection.x;
		var newY = head.y + currentDirection.y;

		if (state.hitWall(newX, newY) || hitSelf(newX, newY)) {
			return;
		}

		head.x = newX;
		head.y = newY;
		
		if (state.food.hit(newX, newY)) {
			var segment = createSegment(lastX, lastY);
			body.unshift(segment);
			state.food.setRndPosition();
		} else {
			var lastPart = body.pop();
			lastPart.x = lastX;
			lastPart.y = lastY;
			body.unshift(lastPart);
		}		
	}

	// public function render(graphics:Graphics):Void {
	// 	for (segment in body) {
	// 		segment.render(graphics);
	// 	}
	// 	head.render(graphics);
	// }

	public function hit(x:Int, y:Int):Bool {
		return head.hit(x, y) || hitSelf(x, y);
	}
	
	private function createSegment(x:Int, y:Int):Sprite {
		var segment = new Sprite(x, y, 12, 12, SNAKE_COLOR);
		state.add(segment);
		return segment;
		// return new Sprite(x, y, 12, 12, SNAKE_COLOR);
	}

	private function invalidDirection(direction:Vector2i):Bool {
		return direction.x + currentDirection.x == 0 && direction.y + currentDirection.y == 0;
	}

	private function hitSelf(x:Int, y:Int):Bool {
		var hit = false;
		for (segment in body) {
			if (segment.hit(x, y)) {
				hit = true;
				break;
			}
		}

		return hit;
	}
}