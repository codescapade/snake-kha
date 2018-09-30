package;

import kha.System;
import kha.Assets;
import kha.Color;

class MenuState extends State {

	public function new() {
		super();
		bgColor = Color.fromString('#000000');

		var title = new Text(0, 0, 'Snake Kha', Assets.fonts.get('kenpixel_mini_square'), 100);
		title.x = Math.floor(System.windowWidth() * 0.5 - title.width * 0.5);
		title.y = 40;
		add(title);

		var instruction = new Text(0, 0, 'Press shift to start', Assets.fonts.get('kenpixel_mini_square'), 40);
		instruction.x = Math.floor(System.windowWidth() * 0.5 - instruction.width * 0.5);
		instruction.y = 350;
		add(instruction);
	}

	override public function update(deltaTime:Float):Void {
		super.update(deltaTime);

		if (Controls.instance.start) {
			game.switchState(new PlayState());
		}
	}
}