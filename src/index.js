require('./styles/pure-min.css');
require('./styles/main.css');

const { Elm } = require('./elm/Main');
Elm.Main.init({ node: document.getElementById('main') });
