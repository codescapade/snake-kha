package;

import kha.math.Vector2i;

class PlayState extends State {
	public var snake:Snake;
	public var food:Food;

	private var walls:Array<Wall>;

	private var snakeDelay = 0.4;
	private var snakeTimer:Float = 0;

	private var desiredDirection:Vector2i;

	private var gameStarted = false;
	
	public function new() {
		super();
		createMap();
		food = new Food(Level.width, Level.height, this);
		add(food);
		

		desiredDirection = new Vector2i(1, 0);
	}

	public override function update(deltaTime:Float):Void {
		super.update(deltaTime);

		if (!gameStarted) {
			if (Controls.instance.start) {
				gameStarted = true;
			}
			return;
		}

		if (Controls.instance.left) {
			desiredDirection.x = -1;
			desiredDirection.y = 0;
		} else if (Controls.instance.right) {
			desiredDirection.x = 1;
			desiredDirection.y = 0;
		} else if (Controls.instance.up) {
			desiredDirection.x = 0;
			desiredDirection.y = -1;
		} else if (Controls.instance.down) {
			desiredDirection.x = 0;
			desiredDirection.y = 1;
		}

		if (snakeTimer < snakeDelay) {
			snakeTimer += deltaTime;
		} else {
			snakeTimer = 0;
			snake.update(desiredDirection);
		}
	}

	public function hitWall(x:Int, y:Int):Bool {
		var hit = false;
		for (wall in walls) {
			if (wall.hit(x, y)) {
				hit = true;
				break;
			}
		}

		return hit;
	}

	private function createMap():Void {
		walls = [];
		for (y in 0...Level.height) {
			for (x in 0...Level.width) {
				var tile = Level.map[y][x];
				if (tile == 1) {
					var wall = new Wall(x, y);
					walls.push(wall);
					add(wall);
				} else if (tile == 5) {
					snake = new Snake(x, y, this);
				}
			}
		}
	}
}