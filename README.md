# QRScanJS
QR-Code scanner library for JavaScript based on [ZBar](http://zbar.sourceforge.net/) and [zbarjs](https://github.com/yurydelendik/zbarjs), compiled with emscripten. However, any types of code other than QR Codes are disabled, so QRScanJS runs faster than zbarjs and is therefore more suited for lower-end systems.

### Example
**You can try out QRScanJS [without downloading](https://Jeija.github.io/QRScanJS/example.html)**

### Usage
Download QRScanJS and include qrscan.js in your HTML:
```HTML
<script type="text/javascript" src="QRScanJS/qrscan.js"></script>
```
Add a video element to your HTML:
```HTML
<video autoplay="true" id="webcam" width=320></video>
```

In your JavaScript, you have to initialize QRScanJS by calling
```
QRReader.init(selector, baseurl);
```
`selector` is the querySelector of the video tag. `baseurl` is the path to QRScanJS from the working directory of your JavaScript. If you just cloned QRScanJS into your project next to the HTML / JavaScript code, you can use:
```
QRReader.init("#webcam", "QRScanJS/");
```
Invoking `QRReader.init()` will likely request permissions for camera usage from the user. If multiple cameras are found (e.g. on mobile phones) and the browser doesn't provide a way to choose between them, QRScanJS will use the environment-facing camera (back-facing camera on smartphones).

In order to initiate a scanning process, call
```
QRReader.scan(function (result) {
    console.log(result);
});
```

Callback() will only be called once. If you want to scan for multiple QR Codes, you have to call `QRReader.scan` again.

### Usage with bower
QRScanJS is on [Bower](http://bower.io/). You can install it using
```bash
bower install qrscanjs
```

This is the minimal example file adopted to work with bower. Mind that both the script `src` URL has changed as well as the second parameter to `QRReader.init`:
```html
<!DOCTYPE html>

<html>
<head>
	<title>QRScanJS Bower</title>
	<script type="text/javascript" src="bower_components/qrscanjs/qrscan.js"></script>
</head>
<body>
	<h1>My Bower project using QRScanJS</h1>
	<video autoplay="true" id="webcam" width=320></video>
	<ul id="list"></ul>

	<script type="text/javascript">
		QRReader.init("#webcam", "bower_components/qrscanjs/");
		function scan() {
			QRReader.scan(function (result) {
				var list = document.getElementById("list");
				var li = document.createElement("li");
				li.appendChild(document.createTextNode(result));
				list.appendChild(li);
				setTimeout(scan, 200);
			});
		}
		scan();
	</script>
</body>
</html>
```

### Compilation
`decoder.js` and `decoder.min.js` are compiled from the ZBar source code. You can generate these files yourself by following these steps:

* Install emscripten, you will need `emconfigure`. `emmake` and `emcc`
* Log out and back in if emscripten wasn't already installed
* Get the [latest ZBar source code](https://github.com/ZBar/ZBar): `git clone https://github.com/ZBar/ZBar; cd ZBar`
* Copy the `templates` directory and the `generate-decoder.sh` script from this project into the ZBar source code directory
* Execute the `generate-decoder.sh` script and wait until finished. You might want to edit the script in order to support different kinds of codes.
* Minify the generated `decoder.js` file with your favorite JavaScript minifier and copy `decoder.js` and the minified `decoder.min.js` to the QRScanJS directory

### Attribution
This library wouldn't have been possible without Yury Delendik's work on zbarjs, the barcode scanner for Firefox OS. My work is mostly based on his [zbarjs project](https://github.com/yurydelendik/zbarjs) and his [instructions on how to compile zbar to JavaScript](https://gist.github.com/yurydelendik/5953383). He licensed (most of) his code under the LGPL.

### License
QRScanJS is licensed under the GNU Lesser General Public License, version 2.1. This means (for short) that you can use this library in both open source and commercial applications. See the LICENSE file for details.
