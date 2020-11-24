[![](https://data.jsdelivr.com/v1/package/gh/giusreds/pwadapter/badge)](https://www.jsdelivr.com/package/gh/giusreds/pwadapter)

PWAdapter is a library that brings the [Web App Manifest](https://developers.google.com/web/fundamentals/web-app-manifest/) to non-compliant browsers for better [Progressive Web Apps](https://en.wikipedia.org/wiki/Progressive_Web_Apps).
This mostly means creating splash screens and icons for Mobile Safari, as well as supporting IE/Edge's Pinned Sites feature.

So, if you've created a `manifest.json` but want to have wide support everywhere else look no further.
We recommend including it from CDN to get the latest version:

```html
<!-- Link your WebManifest -->
<link rel="manifest" href="manifest.json" />
<!-- Link the PWAdapter script -->
<script async src="https://cdn.jsdelivr.net/gh/giusreds/pwadapter@dist/pwadapter.min.js"></script>
```

And you're done! 🎉📄

For more on the Web App Manifest, read 📖 [how to add a Web App Manifest and mobile-proof your site](https://medium.com/dev-channel/how-to-add-a-web-app-manifest-and-mobile-proof-your-site-450e6e485638), watch 📹 [theming as part of The Standard](https://www.youtube.com/watch?v=5fEMTxpA6BA), or check out 📬 [the Web Fundamentals post](https://developers.google.com/web/fundamentals/web-app-manifest/).


# Best Practice &amp; Caveats

While PWAdapter can generate most icons, meta tags etc that your PWA might need, it's best practice to include at least one `<link rel="icon" ... />`.
This is standardized and older browsers, along with search engines, may use it from your page to display an icon.
For example:

```html
<!-- Include 'standard' favicon -->
<link rel="icon" type="image/png" href="res/icon-128.png" sizes="128x128" />
```

You should also consider only loading PWAdapter after your site is loaded, as adding your site to a homescreen is a pretty rare operation.

## iOS

PWAdapter looks for a viewport tag which includes `viewport-fit=cover` or `viewport-fit=contain`, such as `<meta name="viewport" content="viewport-fit=cover">`.
If this tag is detected, PWAdapter will generate a meta tag that makes your PWA load in fullscreen mode and with **black status bar** - this is particularly useful for devices with a notch.

<!--
You can customize the generated splash screen's font by using a CSS Variable.
For example:

```html
<style>
  link[rel="manifest"] {
     --PWAdapter-splash-font: 24px Verdana;
  }
</style>
```

This is set directly as a [canvas font](https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/font), so you must as a minimum include size _and_ family.
The default value is "24px HelveticaNeue-CondensedBold".

⚠️ PWAdapter won't wait for your fonts to load, so if you're using custom fonts, be sure to only load the library after they're ready.
-->

### Old Versions

Prior to **iOS 12.2**, Mobile Safari opens external sites in the regular browser, meaning that flows like Oauth won't complete correctly.
This is an issue with all PWAs on iOS generally.

## Session Storage

PWAdapter uses `window.sessionStorage` to cache your site's manifest (and on iOS, any updated icons and generated splash screens).
This expires after a user navigates away from your page or closes their tab.

# Details

What does PWAdapter actually do?
If you provide a Web App Manifest, PWAdapter will update your page and:

* Create meta icon tags for all icons in the manifest (e.g., for a favicon, older browsers)
* Create fallback meta tags for various browsers (e.g., iOS, WebKit/Chromium forks etc) describing how a PWA should open
* Sets [the theme color](https://developers.google.com/web/updates/2014/11/Support-for-theme-color-in-Chrome-39-for-Android) based on the manifest

For Safari, PWAdapter also:

* Sets `apple-mobile-web-app-capable` (opening without a browser chrome) for display modes `standalone`, `fullscreen` or `minimal-ui`
* Creates `apple-touch-icon` images, adding the manifest background to transparent icons: otherwise, iOS renders transparency as black
* Creates dynamic splash images, closely matching the splash images generated [for Chromium-based browsers](https://cs.chromium.org/chromium/src/chrome/android/java/src/org/chromium/chrome/browser/webapps/WebappSplashScreenController.java?type=cs&q=webappsplash&sq=package:chromium&g=0&l=70)

For IE and Edge:

* Adds meta tags for the [Pinned Sites](https://blogs.msdn.microsoft.com/jennifer/2011/04/20/ie-pinned-sites-part-1-what-are-pinned-sites/) feature

For PWAs on Windows with access to UWP APIs:

* Sets the titlebar color

# Web App Manifest

Your Web App Manifest is:

* normally named `manifest.json` or `manifest.webmanifest`
* referenced from all pages on your site like `<link rel="manifest" href="path/to/manifest.json" />`
* and should look a bit like this:

```js
{
  "name": "Always Be Progressive",
  "short_name": "Progressive!",
  "display": "fullscreen",
  "start_url": "index.html?scope=pwa",
  "background_color": "#102a48",
  "icons": [
    {
      "src": "res/icon-m-256.png",
      "sizes": "256x256",
      "purpose": "maskable"
    },
    {
      "src": "res/icon-256.png",
      "sizes": "256x256",
      "purpose": "any"
    }
  ]
}
```

For more information on the Web App Manifest, and how e.g., modern browsers will prompt engaged users to install your site to their home screen, check out [Web Fundamentals](https://developers.google.com/web/fundamentals/web-app-manifest/).

# License

&copy; 2020 Giuseppe Rossi

The license for this repository is a [GNU Affero General Public License version 3](LICENSE) (SPDX: AGPL-3.0). 

This project is based on [PWACompat](https://github.com/GoogleChromeLabs/pwacompat/) from Google Chrome Labs. Please see the [NOTICE](NOTICE) file for full reference.

# Release

Compile code with [Google Closure Compiler](https://closure-compiler.appspot.com/home).

```
// ==ClosureCompiler==
// @compilation_level SIMPLE_OPTIMIZATIONS
// @output_file_name pwadapter.min.js
// ==/ClosureCompiler==

// code here
```