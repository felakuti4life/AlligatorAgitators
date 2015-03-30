Alligator Agitators
=================
by Ethan Geller

Interactive piece of electronic music that allows the audience to control the parameters of the performance. The actual
code base is a *complete* mess due to time constraints. On the plus side, it's a good way to look at the variety of ways
you can send OSC messages from a web page.

Components
----------

`Populus.ck`: A Chuck script that controls all of the audio, and keeps track of all of the parameters.

`god.php`: The page that contains visualizations of everything going on in the piece, and receives OSC messages from Chuck via sockets.io.

`follower.php`: The page that the audience accesses to control the piece. Features a few buttons that jQuery load in php pages that send out an OSC message.
 all of the php could be stripped out of this project in favor of using sockets.io to send the OSC messages, but that wouldn't be as fun :)
 
 `php/`: collection of pages loaded in to send out osc messages, as well as the osc.php library
 
 `osc-web`: stuff for a node server that handles OSC messaging. Called with `node bridge.js`
 