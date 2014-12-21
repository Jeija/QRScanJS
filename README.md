# QRScanJS
QR-Code scanner library for JavaScript based on [ZBar](http://zbar.sourceforge.net/) and [zbarjs](https://github.com/yurydelendik/zbarjs), compiled with emscripten. However, any types of code other than QR Codes are disabled, so QRScanJS runs a little faster than zbarjs and is therefore more suited for lower-end systems.

### Example
You can try out QRScanJS [wihtout downloading](https://Jeija.github.io/QRScanJS/example.html)

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
