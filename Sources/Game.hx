package;

import kha.input.Keyboard;
import kha.System;
import kha.Scheduler;
import kha.Framebuffer;
import kha.Assets;

class Game {
	private var timer:Timer;

	private var initialState:State;

	private var currentState:State;

	public function new(initialState:State) {
		this.initialState = initialState;
		Assets.loadEverything(loadFinished);
	}

	public function switchState(newState:State):Void {
		currentState.destroy();
		newState.game = this;
		currentState = newState;
	}

	private function update():Void {
		timer.update();

		if (currentState != null) {
			currentState.update(timer.detlaTime);
		}
	}

	private function render(frameBuffers:Array<Framebuffer>):Void {
		if (currentState != null) {
			currentState.render(frameBuffers);
		}
	}

	private function loadFinished():Void {
		timer = new Timer();

		currentState = initialState;
		currentState.game = this;
		Scheduler.addTimeTask(update, 0, 1 / 60);
		System.notifyOnFrames(render);
		Keyboard.get().notify(Controls.instance.keyDown, Controls.instance.keyUp);

		
	}
}