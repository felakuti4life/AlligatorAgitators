<?php
/**
 * Created by IntelliJ IDEA.
 * User: Ethan
 * Date: 3/2/15
 * Time: 2:43 PM
 */

require_once('php/osc.php');
ini_set('display_errors', 'On');



?>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0"/> <!--320-->
<head>
    <title>Follower</title>
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
    <script>
        var team = 0;
        var count = 0;
        var turn = 150;
        var status = $('#status');
        incrementAgitation = function () {
            $('#dump').load('php/f_inc_agit.php', function () {
                //do something here!
            });
            count++;
        };

        decrementAgitation = function () {
            $('#dump').load('php/f_dec_agit.php', function () {
                //Do something here too!
            })
        };

        moveUp = function () {
            $('#status').empty();
            $('#status').append("MOVING...");
            if (team) {

                $('#dump').load('php/f_inc_left.php', function () {
                    //Do something here too!
                    $('#status').empty();
                    $('#status').append("MOVED UP");
                });
            }
            else {
                $('#dump').load('php/f_inc_right.php', function () {
                    //Do something here too!
                    $('#status').empty();
                    $('#status').append("MOVED UP");
                });
            }
            if(count>= turn) decrementAgitation();
            else incrementAgitation();
        };

        moveDown = function () {
            $('#status').empty();
            $('#status').append("MOVING...");
            if (team) {
                $('#dump').load('php/f_dec_left.php', function () {
                    //Do something here too!
                    $('#status').empty();
                    $('#status').append("MOVED DOWN");
                });

                incrementAgitation();
            }
            else {
                $('#dump').load('php/f_dec_right.php', function () {
                    //Do something here too!
                    $('#status').empty();
                    $('#status').append("MOVED DOWN");
                });
                if(count>= turn) decrementAgitation();
                else incrementAgitation();
            }
        };

        moveLeft = function () {
            $('#status').empty();
            $('#status').append("MOVING...");
            if (team) {
                $('#dump').load('php/lml.php', function () {
                    //Do something here too!
                    $('#status').empty();
                    $('#status').append("MOVED LEFT");
                });
            }
            else {
                $('#dump').load('php/rml.php', function () {
                    //Do something here too!
                    $('#status').empty();
                    $('#status').append("MOVED LEFT");
                });
            }
            if(count>= turn) decrementAgitation();
            else incrementAgitation();
        };

        moveRight = function () {
            $('#status').empty();
            $('#status').append("MOVING...");
            if (team) {
                $('#dump').load('php/lmr.php', function () {
                    //Do something here too!
                    $('#status').empty();
                    $('#status').append("MOVED RIGHT");
                });
            }
            else {
                $('#dump').load('php/rmr.php', function () {
                    //Do something here too!
                    $('#status').empty();
                    $('#status').append("MOVED RIGHT");
                });
            }
            if(count>= turn) decrementAgitation();
            else incrementAgitation();
        };


        teamChosen = function () {
            var teamButtons = $('#team-buttons');
            teamButtons.empty();
            if (team) {
                teamButtons.append("<h1>TEAM LEFT<h1><p>That red gator on the screen is YOU. Get it to the CAKE.</p>");
                $("body").css("background-color", "#FF3355");
                $('#dump').load('php/f_left_add.php', function () {
                    //Do something here too!
                });
                window.title = "TEAM LEFT";
            }
            else {
                teamButtons.append("<h1>TEAM RIGHT<h1><p>That blue gator on the screen is YOU. Get it to the CAKE.</p>");
                $("body").css("background-color", "#3355FF");
                $('#dump').load('php/f_right_add.php', function () {
                    //Do something here too!
                });
                window.title = "TEAM RIGHT";
            }

        }

    </script>
    <style type="text/css">
        body {
            background-color: #BBBBBB;
            font-family: "Arial Black", Gadget, sans-serif;
        }

        button {
            width: 48%;
            height: 20%;
            font-size: 180%;
            font-style: oblique;
        }

        #status {
            margin-top: 20px;
            margin-left: auto;
            margin-right: auto;
            width: 20%;
            text-align: center;
        }

        #mid-buttons {
            width: 90%;
            margin-left: auto;
            margin-right: auto;
        }

        #inc {
            width = 50px;
            margin-left: 40%;
            margin-right: auto;
        }

        #dec {
            width = 50px;
            margin-left: 40%;
            margin-right: auto;
        }
    </style>
</head>
<div id="dump"></div>
<body>

<div id="team-buttons">
    <h2>choose a team:</h2>
    <button onclick="team = 1; teamChosen()" id="teamleft">left</button>
    <button onclick="team = 0; teamChosen()" id="teamright">right</button>
</div>

<p>MOVE YOUR TEAM</p>

<div id="inc">
    <button onclick="moveUp();">up</button>
</div>
<div id="mid-buttons">
    <button onclick="moveLeft();" id="left">left</button>
    <button onclick="moveRight();" id="right">right</button>
</div>
<div id="dec">
    <button onclick="moveDown();">down</button>
</div>
<div id="status">

</div>
</body>
</html>