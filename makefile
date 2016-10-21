CONTENTS = app.js COPYING.txt icon128.png icon512.png index.html manifest.webapp scream.ogg xkcd_phone.png

.PHONY: all
all: fall.zip fall.manifest.webapp github.manifest.webapp

.PHONY: clean
clean:
	find . -name '*~' -delete

.PHONY: icons
icons: icon128.png icon512.png

icon128.png: icon.svg
	rsvg-convert -w 128 icon.svg -o icon128.png
	optipng icon128.png

img/icon512.png: icon.svg
	rsvg-convert -w 512 icon.svg -o icon512.png
	optipng icon512.png

fall.zip: clean icons $(CONTENTS)
	rm -f fall.zip
	zip -r fall.zip $(CONTENTS)

fall.manifest.webapp: manifest.webapp
	sed manifest.webapp -e 's/"launch_path"\s*:\s*"[^"]*"/"package_path": "http:\/\/localhost:8080\/fall.zip"/' > fall.manifest.webapp

github.manifest.webapp: manifest.webapp
	sed manifest.webapp -e 's/"launch_path"\s*:\s*"[^"]*"/"package_path": "https:\/\/schnark.github.io\/fall\/fall.zip"/' > github.manifest.webapp
