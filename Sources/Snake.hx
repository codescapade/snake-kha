package;

import kha.math.Vector2i;
import kha.graphics2.Graphics;
import kha.Color;

class Snake {

	private static var SNAKE_COLOR = Color.fromString("#66DDAA");
	private var head:Sprite;
	private var body:Array<Sprite>;
	private var currentDirection:Vector2i;
	private var game:Game;

	public function new(x:Int, y:Int, game:Game) {
		this.game = game;
		head = new Sprite(x, y, 16, 16, SNAKE_COLOR);
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

		var newX = head.x + currentDirection.x;
		var newY = head.y + currentDirection.y;

		if (game.hitWall(newX, newY)) {
			return;
		}
		
		var lastPart = body.pop();
		lastPart.x = head.x;
		lastPart.y = head.y;
		body.unshift(lastPart);
		head.x = newX;
		head.y = newY;
	}

	public function render(graphics:Graphics):Void {
		for (segment in body) {
			segment.render(graphics);
		}
		head.render(graphics);
	}

	public function hit(x:Int, y:Int):Bool {
		return head.hit(x, y) || hitSelf(x, y);
	}
	
	private function createSegment(x:Int, y:Int):Sprite {
		return new Sprite(x, y, 12, 12, SNAKE_COLOR);
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