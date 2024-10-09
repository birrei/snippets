# PHP in Visual Studio Code
## To disable the built-in PHP smart completions 
in favor of suggestions from an installed PHP extension, uncheck PHP > Suggest: Basic, which sets php.suggest.basic to false in your settings.json file.
https://code.visualstudio.com/docs/languages/php

## Snippet "php": 
File > Preferences > Configure Snippets > "html.json" 
```
	"php": {
		"prefix": "php",
		"body": ["<?php", "$0", "?>"],
		"description": "php tag"
	  }

```
