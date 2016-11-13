require('./styles/normalize.css');
require('./styles/main.css');

var Elm = require('../elm/Main');
Elm.Main.embed(document.getElementById('elm-urm'));
