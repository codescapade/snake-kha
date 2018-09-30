package;

import kha.graphics2.Graphics;
import kha.Color;
import kha.Font;

class Text extends GameObject {

	public var text:String;
	public var font:Font;
	public var fontSize:Int;
	public var color:Color;

	public var width(get, null):Int;

	public function new(x:Int, y:Int, text:String, font:Font, size:Int = 14, color = Color.White) {
		super(x, y);
		this.x = x;
		this.y = y;
		this.text = text;
		this.font = font;
		this.fontSize = size;
		this.color = color;
		
	}

	public override function render(graphics:Graphics):Void {
		graphics.font = font;
		graphics.fontSize = fontSize;
		graphics.color = color;
		graphics.drawString(text, x, y);
	}

	private function get_width():Int {
		return Math.round(font.width(fontSize, text));
	}
}