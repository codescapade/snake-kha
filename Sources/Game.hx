package;

import kha.Scaler;
import kha.Color;
import kha.Image;
import kha.graphics2.Graphics;
import kha.System;
import kha.Scheduler;
import kha.Framebuffer;
import kha.Assets;

class Game {

	private var backBuffer:Image;
	private var bgColor:Color = Color.fromString("#000000");

	private var walls:Array<Wall>;

	public function new() {
		Assets.loadEverything(loadFinished);
	}

	private function update():Void {

	}

	private function render(frameBuffers:Array<Framebuffer>):Void {
		var graphics:Graphics = backBuffer.g2;
		graphics.begin(bgColor);
		for (i in 0...walls.length) {
			walls[i].render(graphics);
		}
		graphics.end();

		frameBuffers[0].g2.begin();
		Scaler.scale(backBuffer, frameBuffers[0], System.screenRotation);
		frameBuffers[0].g2.end();
	}

	private function loadFinished():Void {
		backBuffer = Image.createRenderTarget(Constants.DESIGN_WIDTH, Constants.DESIGN_HEIGHT);

		createMap();

		Scheduler.addTimeTask(update, 0, 1 / 60);
		System.notifyOnFrames(render);
	}

	private function createMap():Void {
		walls = [];
		for (y in 0...Level.height) {
			for (x in 0...Level.width) {
				if (Level.map[y][x] == 1) {
					var wall:Wall = new Wall(x, y);
					walls.push(wall);
				}
			}
		}
	}
}