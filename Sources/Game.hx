package;

import kha.input.Keyboard;
import kha.math.Vector2i;
import kha.Scaler;
import kha.Color;
import kha.Image;
import kha.System;
import kha.Scheduler;
import kha.Framebuffer;
import kha.Assets;

class Game {

	private var backBuffer:Image;
	private var bgColor = Color.fromString("#000000");

	private var walls:Array<Wall>;

	private var snake:Snake;

	private var timer:Timer;

	private var snakeDelay = 0.4;
	private var snakeTimer:Float = 0;

	private var desiredDirection:Vector2i;

	private var controls:Controls;

	private var gameStarted = false;

	public function new() {
		Assets.loadEverything(loadFinished);
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

	private function update():Void {
		timer.update();

		if (!gameStarted) {
			if (controls.start) {
				gameStarted = true;
			}
			return;
		}

		if (controls.left) {
			desiredDirection.x = -1;
			desiredDirection.y = 0;
		} else if (controls.right) {
			desiredDirection.x = 1;
			desiredDirection.y = 0;
		} else if (controls.up) {
			desiredDirection.x = 0;
			desiredDirection.y = -1;
		} else if (controls.down) {
			desiredDirection.x = 0;
			desiredDirection.y = 1;
		}

		if (snakeTimer < snakeDelay) {
			snakeTimer += timer.detlaTime;
		} else {
			snakeTimer = 0;
			snake.update(desiredDirection);
		}
	}

	private function render(frameBuffers:Array<Framebuffer>):Void {
		var graphics = backBuffer.g2;
		graphics.begin(bgColor);
		for (wall in walls) {
			wall.render(graphics);
		}
		snake.render(graphics);
		graphics.end();

		frameBuffers[0].g2.begin();
		Scaler.scale(backBuffer, frameBuffers[0], System.screenRotation);
		frameBuffers[0].g2.end();
	}

	private function loadFinished():Void {
		backBuffer = Image.createRenderTarget(Constants.DESIGN_WIDTH, Constants.DESIGN_HEIGHT);

		createMap();

		desiredDirection = new Vector2i(1, 0);

		controls = new Controls();

		Scheduler.addTimeTask(update, 0, 1 / 60);
		System.notifyOnFrames(render);
		Keyboard.get().notify(controls.keyDown, controls.keyUp);

		timer = new Timer();
	}

	private function createMap():Void {
		walls = [];
		for (y in 0...Level.height) {
			for (x in 0...Level.width) {
				var tile = Level.map[y][x];
				if (tile == 1) {
					var wall = new Wall(x, y);
					walls.push(wall);
				} else if (tile == 5) {
					snake = new Snake(x, y, this);
				}
			}
		}
	}
}