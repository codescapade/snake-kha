package;

import kha.math.Random;
import kha.Assets;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

class Main {

	public static function main() {
		System.start({title: "Project", width: 640, height: 480}, function (_) {
			var seed:Int = Math.floor(Math.random() * 1000000);
			Random.init(seed);
			new Game(new PlayState());
		});
	}
}
