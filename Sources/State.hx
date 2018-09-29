package;

import kha.System;
import kha.Scaler;
import kha.Framebuffer;
import kha.Image;
import kha.Color;

class State {
	public var bgColor = Color.fromString('#000000');
	
	private var backBuffer:Image;

	private var gameObjects:Array<GameObject>;

	public function new() {
		gameObjects = [];
		backBuffer = Image.createRenderTarget(Constants.DESIGN_WIDTH, Constants.DESIGN_HEIGHT);
	}

	public function update(deltaTime:Float):Void {
		for (obj in gameObjects) {
			obj.update(deltaTime);
		}
	}

	public function render(frameBuffers:Array<Framebuffer>):Void {
		var graphics = backBuffer.g2;
		graphics.begin(bgColor);
		for (obj in gameObjects) {
			obj.render(graphics);
		}
		graphics.end();

		frameBuffers[0].g2.begin();
		Scaler.scale(backBuffer, frameBuffers[0], System.screenRotation);
		frameBuffers[0].g2.end();
	}

	public function add(obj:GameObject):Void {
		if (gameObjects.indexOf(obj) == -1) {
			gameObjects.push(obj);
		}
	}

	public function remove(obj:GameObject):Void {
		var index = gameObjects.indexOf(obj);
		if (index != -1) {
			gameObjects.remove(obj);
			obj.destroy();
		}
	}

	public function destroy():Void {
		while (gameObjects.length > 0) {
			var obj = gameObjects.pop();
			obj.destroy();
		}
	}
}