'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "b9186159d284f32b84b2f6fcfcc71617",
"assets/AssetManifest.bin.json": "59611d6e5f17962a5951b6b25725a052",
"assets/AssetManifest.json": "ddacb1003e115b06fa16104481c6ac00",
"assets/assets/fonts/open_sauce/OpenSauceOne-Black.ttf": "287d5a2e51e6508c5e2b88c892e01022",
"assets/assets/fonts/open_sauce/OpenSauceOne-BlackItalic.ttf": "7ad50214b9df3479f37f0034822eba0c",
"assets/assets/fonts/open_sauce/OpenSauceOne-Bold.ttf": "0e268a3722a812efd54be873b658899f",
"assets/assets/fonts/open_sauce/OpenSauceOne-BoldItalic.ttf": "f7395393d59ab01f03e34c3e59933a8d",
"assets/assets/fonts/open_sauce/OpenSauceOne-ExtraBold.ttf": "4f21651ce74ba1be9bbacbb27148a73b",
"assets/assets/fonts/open_sauce/OpenSauceOne-ExtraBoldItalic.ttf": "815db4030ff30cd0f378c961b638dad6",
"assets/assets/fonts/open_sauce/OpenSauceOne-Italic.ttf": "68caadb2c93d025ccae5fa31af8a3d72",
"assets/assets/fonts/open_sauce/OpenSauceOne-Light.ttf": "08ec37ac4d3d22714c8e90259fb920d8",
"assets/assets/fonts/open_sauce/OpenSauceOne-LightItalic.ttf": "56c15e701ca2de40ad73e6a8c19a2869",
"assets/assets/fonts/open_sauce/OpenSauceOne-Medium.ttf": "6ef948a1709d31aa107f9440276fc740",
"assets/assets/fonts/open_sauce/OpenSauceOne-MediumItalic.ttf": "7bcb4b76a30924f24fc01a2a16fb06aa",
"assets/assets/fonts/open_sauce/OpenSauceOne-Regular.ttf": "63b00baa18384c03e2e3cc11e8795f36",
"assets/assets/fonts/open_sauce/OpenSauceOne-SemiBold.ttf": "a7f1a46339f8e9307b7442d43e651fd1",
"assets/assets/fonts/open_sauce/OpenSauceOne-SemiBoldItalic.ttf": "a1e2674f18d90d9ca8b82cebe7c6b7fa",
"assets/assets/logos/movimiento_cristiano.jpg": "5de4643680342005f1d1e43dd13c74ff",
"assets/assets/xlsx/caso1.xlsx": "b22bfc4bc0f7e91a7316cf1c63526eba",
"assets/assets/xlsx/caso2.xlsx": "6233560b1500c37344f631fa7dacd36b",
"assets/assets/xlsx/caso3.xlsx": "58888c2001ee8102d185c50377fe4bef",
"assets/assets/xlsx/caso4.xlsx": "5c96dbd3eb6475a6016e4bcf5854c427",
"assets/assets/xlsx/filtrado.xlsx": "5c96dbd3eb6475a6016e4bcf5854c427",
"assets/FontManifest.json": "addc7eab467aabee2fa8d13f35e1755a",
"assets/fonts/MaterialIcons-Regular.otf": "213ead556766ccafb782b56044fcddaf",
"assets/NOTICES": "99363816986b9169ffc5d39829e2505d",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "17ee8e30dde24e349e70ffcdc0073fb0",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "f3307f62ddff94d2cd8b103daf8d1b0f",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "04f83c01dded195a11d21c2edf643455",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "769d9c07215ed33d8c09dd567708c125",
"/": "769d9c07215ed33d8c09dd567708c125",
"main.dart.js": "f5403a301a3262cd99edc1fa597b2719",
"manifest.json": "3721af901c402f83fdd6c4260c2bac2b",
"version.json": "8f054c0e602f9b9bdecabcbe27bdb32c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
