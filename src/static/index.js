require('./styles/pure-min.css');
require('./styles/main.css');

var Elm = require('../elm/Main');
Elm.Main.embed(document.getElementById('main'));
