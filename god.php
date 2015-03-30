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
<head>
<title>Success?</title>
<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
<script src="http://127.0.0.1:8081/socket.io/socket.io.js"></script>
<script language="javascript" type="text/javascript" src="p5.js"></script>
<!-- uncomment lines below to include extra p5 libraries -->
<script language="javascript" src="addons/p5.dom.js"></script>
<script language="javascript" src="addons/p5.sound.js"></script>
<script>
    incrementAgitation = function () {
        $('#dump').load('php/g_inc_agit.php', function () {
            //do something here!
        })
    };

    decrementAgitation = function () {
        $('#dump').load('php/g_dec_agit.php', function () {
            //Do something here too!
        })
    };



    var leftY, rightY, leftX, rightX, agit, nLeftFollowers, nRightFollowers;
    socket = io.connect('http://127.0.0.1', { port: 8081, rememberTransport: false});
    console.log('oi');
    socket.on('connect', function () {
        // sends to socket.io server the host/port of oscServer
        // and oscClient
        socket.emit('config',
            {
                server: {
                    port: 3333,
                    host: '127.0.0.1'
                },
                client: {
                    port: 3334,
                    host: '127.0.0.1'
                }
            }
        );
    });

    socket.on('message', function (obj) {
        leftX = obj[7];
        rightX = obj[6];
        nRightFollowers = obj[5];
        nLeftFollowers = obj[4];
        leftY = obj[3];
        rightY = obj[2];
        agit = obj[1];

    });
</script>
<script language="javascript" type="text/javascript">
    //sketch
    var xoff = 0.0;
    var xincrement = 0.01;
    var yoff = 0.0;
    var yincrement = 0.01;
    //text
    var textW = 180;
    var textH = 80;
    var maxCircles = 20;
    var qrScale = 5;
    var qr;

    //sprites
    var leftGatorImg;
    var rightGatorImg;
    var cakeImg;

    //scoring and stages
    var MaxGoal = 3;
    var leftScore = 0;
    var rightScore = 0;
    var yGoal;
    var xGoal;
    var yGoals = [1, 2, 3, 1, 0];
    var xGoals = [1, 3, 2.5, 0.5];
    var currentStage = 0;
    var nStages = 5;
    var count = 0;
    var scoreCheckRate = 40;
    var gameStatus = 0;

    //dimensions for scoring bars
    var scoreBotMargin = 40;
    var scoreTopMargin = 180;
    var scoreLeftMargin = 20;
    var scoreRightMargin = 20;

    var url = "http://<? echo $ip; ?>:8888/Populus2/follower.php"
    var leftTickYPos;
    var leftTickXPos;

    var rightTickYPos;
    var rightTickXPos;
    var goalYPos;
    var goalXPos;

    scoreAdd = function () {
        $('#dump').load('php/score_add.php', function () {
            //do something here!
        })
    };

    function setup() {
        createCanvas(window.innerWidth, window.innerHeight);
        background(0);
        noStroke();
        qr = loadImage("https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=http://<? echo $ip; ?>:8888/Populus2/follower.php&chld=H");
        leftGatorImg = loadImage("assets/images/redAlligator.png");
        rightGatorImg = loadImage("assets/images/blueAlligator.png");
        cakeImg = loadImage("assets/images/cake.png");

        //set up goals
        yGoals = [MaxGoal, MaxGoal / 3, MaxGoal / 1.1, MaxGoal/3, MaxGoal/8, MaxGoal];
        xGoals = [MaxGoal/1.1, MaxGoal / 1.1, MaxGoal / 2.6, MaxGoal/5, MaxGoal/8, MaxGoal];
        yGoal = yGoals[currentStage];
        xGoal = xGoals[currentStage];
    }

    function drawClouds(agit) {
        for (i = 0; i < maxCircles * agit + 1; i++) {
            n = noise(xoff) * width * agit;
            v = noise(yoff) * height * agit;
            // With each cycle, increment xoff
            xoff += xincrement;
            yoff += yincrement;

            // Draw the ellipse at the value produced by perlin noise
            fill(200);
            ellipse(n + random(30), v + random(30), 64 + 100 * agit, 64 + 100 * agit);
        }
        for (i = 0; i < maxCircles * agit + 1; i++) {
            n = noise(xoff) * width * agit;
            v = noise(yoff) * height * agit;
            // With each cycle, increment xoff
            xoff += xincrement;
            yoff += yincrement;

            // Draw the ellipse at the value produced by perlin noise
            fill(200);
            ellipse(width - (n + random(30)), (v + random(30)), 64 + 100 * agit, 64 + 100 * agit);
        }
    }

    function drawText() {
        //text
        textSize(32);
        fill(153, 24, 24);
        text("TEAM LEFT", 10, 30, textW, textH);
        text(leftScore.toString(), 10, 30 + textH * 2.5);
        fill(0, 102, 153);
        text("TEAM RIGHT", width - 10 - textW / 2, 30, textW, textH);
        text(rightScore.toString(), width - 10 - textW / 2, 30 + textH * 2.5);
        fill(180, 180, 180);
        text(url, width / 4, height - 200);
    }

    function drawQRCode() {
        image(qr, width / 2 - width / qrScale / 2, 0, width / qrScale, width / qrScale);
    }
    function endGame() {
        yGoal = 0;
        xGoal = 0;
        if (leftScore > rightScore) {
            gameStatus = 1;
            text("GAVE OVER", width / 2 - 40, height / 2 - 40, 80, 80);
        }
        else {
            gameStatus = 2;
            text("GAVE OVER", width / 2 - 40, height / 2 - 40, 80, 80);
        }
    }
    function updateGoals() {
        currentStage++;
        yGoal = yGoals[currentStage];
        xGoal = xGoals[currentStage];
        if(currentStage>=nStages) currentStage = 0;
        scoreAdd();
    }
    var limit = 0.1;
    var rounder = 2;
    function isCollision(x,y,w,h) {
        goalw = 60;
        goalh = 60;
        console.log("x: ",x, "-", x+w," goal: ", goalXPos, "-", goalXPos+goalw);
        console.log("y: ",y, "-", y+h," goal: ", goalYPos, "-", goalYPos+goalh);
        return (((x > goalXPos) && ((x) < (goalXPos+goalw))) || (((x+w) > goalXPos) && ((x+w) < (goalXPos+goalw)))
            && ((y > goalYPos) && (y < (goalYPos + goalh))) || ((y+h) > (goalYPos)) && ((y+h) < (goalYPos + goalh)))
        }

    function checkScore() {
        count++;
        count = count % scoreCheckRate;


        if (count == 0) {
            //console.log("Left: ", (leftTickXPos / 10).toFixed(rounder), " ", (leftTickYPos / 10).toFixed(rounder), " right ", (rightTickXPos / 10).toFixed(rounder), " ", (rightTickYPos / 10).toFixed(rounder), " goal ", (goalXPos / 10).toFixed(rounder), (goalYPos / 10).toFixed(rounder));
            //console.log("left: ", isCollision(leftTickXPos,leftTickYPos,120,120), "right: ", isCollision(rightTickXPos, rightTickYPos,120,120))
            if (isCollision(leftTickXPos,leftTickYPos,120,120)) {
                console.log("");
                currentStage++;
                if (currentStage == nStages) {
                    endGame();
                }
                else {
                    leftScore++;
                    updateGoals();
                }
            }
            else if (isCollision(rightTickXPos, rightTickYPos,120,120)) {
                currentStage++;
                if (currentStage == nStages) {
                    endGame();
                }
                else {
                    rightScore++;
                    updateGoals();
                }
            }

        }
    }

    function drawTeams() {
        yDist = height - (scoreBotMargin + scoreTopMargin);
        xDist = width - (scoreLeftMargin + scoreRightMargin);
        leftTickYPos = (leftY / MaxGoal) * yDist + scoreBotMargin;
        leftTickXPos = (leftX / MaxGoal) * xDist + scoreLeftMargin;

        rightTickYPos = (rightY / MaxGoal) * yDist + scoreBotMargin;
        rightTickXPos = ((rightX / MaxGoal) * xDist) - scoreRightMargin;
        goalYPos = (yGoal / MaxGoal) * yDist + scoreBotMargin;
        goalXPos = (xGoal / MaxGoal) * xDist + scoreBotMargin;

        leftCloseness = (yGoal - leftY) / yGoal;
        rightCloseness = (xGoal - rightY) / xGoal;

        //leftY
        fill(255, 40, 40);
        //line(scoreXmargin, scoreBotMargin, scoreXmargin, scoreTopMargin);
        image(leftGatorImg, leftTickXPos, leftTickYPos, 120, 120);
        fill(255, 255, 255);

        //rightY
        fill(40, 40, 255);
        //line(width - scoreXmargin, scoreBotMargin, width - scoreXmargin, scoreTopMargin);
        image(rightGatorImg, rightTickXPos, rightTickYPos, 120, 120);
        fill(255, 255, 255);
        image(cakeImg, goalXPos, goalYPos, 60, 60);
    }

    function draw() {
        // Create an alpha blended background
        fill(0, 10);
        rect(0, 0, width, height);

        //float n = random(0,width);  // Try this line instead of noise

        // Get a noise value based on xoff and scale
        // it according to the window's width
        drawClouds(agit);
        drawQRCode();

        drawText();
        drawTeams();
        checkScore();
        if(gameStatus) {
            endGame();
        }
    }
</script>
<style>
    body {
        padding: 0;
        margin: 0;
    }
</style>
</head>
<div id="dump"></div>
<body>
<? echo $ip; ?>:8888/Populus2/follower.php
<!--<img src="https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=http://-->
<? // echo $ip; ?><!--:8888/Populus2/follower.php&chld=H"/>-->
<button onclick="incrementAgitation();" id="agit-inc">+</button>
<button onclick="decrementAgitation();" id="agit-dec">-</button>

</body>
</html>