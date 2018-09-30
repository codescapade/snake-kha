package;

import kha.graphics2.Graphics;
import kha.Color;

class Wall extends Sprite {

	public function new (x:Int, y:Int) {
		super(x, y, 18, 18, Color.fromString("#44AAFf"));
	}
}