package;

import kha.math.Random;
import kha.Color;

class Food extends Sprite {

	private var state:PlayState;
	private var levelWidth:Int;
	private var levelHeight:Int;

	public function new(levelWidth:Int, levelHeight:Int, state:PlayState) {
		super(0, 0, 12, 12, Color.fromString("#EE9922"));

		this.state = state;
		this.levelWidth = levelWidth;
		this.levelHeight = levelHeight;

		setRndPosition();
	}

	public function setRndPosition():Void {
		var positionFound = false;
		var rndX:Int;
		var rndY:Int;
		while (!positionFound) {
			rndX = Random.getIn(0, levelWidth - 1);
			rndY = Random.getIn(0, levelHeight - 1);
			if (!state.hitWall(rndX, rndY) && !state.snake.hit(rndX, rndY)) {
				positionFound = true;
				x = rndX;
				y = rndY;
			}
		}
	}
}