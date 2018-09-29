package;

import kha.Color;

class MenuState extends State {

	public function new() {
		super();
		bgColor = Color.fromString('#5577EE');
	}

	override public function update(deltaTime:Float):Void {
		super.update(deltaTime);

		if (Controls.instance.start) {
			game.switchState(new PlayState());
		}
	}
}