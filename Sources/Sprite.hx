package;

import kha.Color;
import kha.graphics2.Graphics;

class Sprite extends GameObject{
	// public override var x(get, set):Int;
	// public override var y(get, set):Int;
	
	public var width:Int;
	public var height:Int;
	
	public var color:Color;

	private var worldX:Int;
	private var worldY:Int;

	public function new(x:Int, y:Int, width:Int, height:Int, color:Color = Color.White) {
		super();
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.color = color;
	}


	public override function render(graphics:Graphics):Void {
		graphics.color = color;
		graphics.fillRect(worldX - width * 0.5, worldY - height * 0.5, width, height);
	}

	public function hit(x:Int, y:Int):Bool {
		return this.x == x && this.y == y;
	}

	private override function get_x():Int {
		return Math.floor((worldX - Constants.GRID_SIZE * 0.5) / Constants.GRID_SIZE);
	}

	private override function set_x(value:Int):Int {
		worldX = Math.floor(value * Constants.GRID_SIZE + Constants.GRID_SIZE * 0.5);

		return value;
	}

	private override function get_y():Int {
		return Math.floor((worldY - Constants.GRID_SIZE * 0.5) / Constants.GRID_SIZE);
	}

	private override function set_y(value:Int):Int {
		worldY = Math.floor(value * Constants.GRID_SIZE + Constants.GRID_SIZE * 0.5);
		
		return value;
	}
}