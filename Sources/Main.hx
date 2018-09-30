package;

import kha.Assets;
import kha.math.Random;
import kha.System;

class Main {

	public static function main() {
		System.start({title: "Project", width: 640, height: 480}, init);
	}

	private static function init(_):Void {
		Assets.loadEverything(function() {
			var seed:Int = Math.floor(Math.random() * 1000000);
			Random.init(seed);
			new Game(new MenuState());
		});
	}
}
