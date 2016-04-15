(function () {
"use strict";

var threshold, audio;

function getThreshold () {
	return threshold;
}

function setThreshold (t) {
	threshold = t;
}

function scream (start) {
	if (start) {
		audio.loop = true;
		audio.play();
	} else {
		audio.loop = false;
	}
}

function init (callback, getThreshold) {
	var isFalling = false, input;

	audio = document.getElementById('scream');
	input = document.getElementById('threshold');

	input.addEventListener('change', function () {
		setThreshold(input.value);
	}, false);

	setThreshold(input.value);

	window.addEventListener('devicemotion', function (e) {
		var a = e.accelerationIncludingGravity;
		a = Math.sqrt(a.x * a.x + a.y * a.y + a.z * a.z);
		if ((a < getThreshold()) !== isFalling) {
			isFalling = !isFalling;
			callback(isFalling);
		}
	}, false);
}

init(scream, getThreshold);
})();