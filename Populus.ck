//Populus 2
//by Ethan Geller

//MARK: tempo Params
220 => float bpm;
16 => int steps;
0.1 => float agitation;
0.660 => float swing;
0.0 => float snareChatter;
0.0 => float lbChatter;
0.0 => float rbChatter;
0.0 => float lsChatter;
0.0 => float rsChatter;
1 => int leftFollowers;
1 => int rightFollowers;
0 => int scores;

//MARK: Heat Maps:
[70, 67, 70, 74, 77, 82, 75, 82, 75, 87, 75, 82, 75, 75, 77, 79] @=>int lsPM1[];
[0.1, 0.5, 0.1, 0.5, 0.3, 0.5, 0.1, 0.5, 0.3, 0.5, 0.1, 0.5, 0.3, 0.5, 0.1, 0.5] @=>float lsHM1[];

[68, 67, 84, 85, 84, 63, 68, 72, 70, 67, 75, 68, 68, 67, 68, 70] @=>int lsPM2[];
[0.6, 0.2, 0.6, 0.2, 0.7, 0.7, 0.5, 0.8, 0.7, 0.6, 0.2, 0.8, 0.5, 0.5, 0.8, 0.5] @=>float lsHM2[];

[48, 52, 55, 58, 60, 58, 56, 58, 60, 63, 65, 63, 48, 51, 55, 56] @=>int lsPM3[];
[0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.3, 0.3, 0.3, 0.3, 0.2, 0.2, 0.5] @=>float lsHM3[];



[75, 70, 75, 77, 80, 87, 80, 86, 80, 90, 70, 86, 70, 70, 72, 72] @=>int rsPM1[];
[0.2, 0.5, 0.3, 0.5, 0.1, 0.5, 0.3, 0.5, 0.1, 0.5, 0.3, 0.5, 0.1, 0.5, 0.3, 0.5] @=>float rsHM1[];

[65, 65, 62, 63, 62, 96, 94, 92, 91, 60, 63, 65, 60, 58, 60, 63] @=>int rsPM2[];
[0.2, 0.6, 0.6, 0.2, 0.2, 0.6, 0.7, 0.2, 0.2, 0.6, 0.7, 0.2, 0.2, 0.6, 0.7, 0.5] @=>float rsHM2[];

[99, 96, 94, 92, 91, 48, 48, 49, 48, 99, 102, 94, 96, 48, 48, 49] @=>int rsPM3[];
[0.2, 0.5, 0.3, 0.5, 0.1, 0.5, 0.3, 0.5, 0.1, 0.5, 0.3, 0.5, 0.1, 0.5, 0.3, 0.5] @=>float rsHM3[];

[60, 63, 65, 67, 70, 72, 70, 63, 65, 75, 72, 78, 77, 78, 77, 75] @=>int lbPM[];
[0.95, 0.1, 0.4, 0.1, 0.05, 0.1, 0.4, 0.1, 0.95, 0.1, 0.4, 0.1, 0.05, 0.1, 0.4, 0.1] @=>float lbHM[];

[64, 70, 72, 75, 84, 80, 72, 75, 64, 63, 64, 63, 64, 58, 60, 63] @=>int rbPM[];
[0.95, 0.1, 0.4, 0.1, 0.05, 0.1, 0.4, 0.1, 0.95, 0.1, 0.4, 0.1, 0.05, 0.1, 0.4, 0.1] @=>float rbHM[];

[0.05, 0.2, 0.1, 0.2, 0.95, 0.2, 0.1, 0.2, 0.05, 0.2, 0.1, 0.2, 0.95, 0.2, 0.1, 0.2] @=>float snrHM[];
[0.95, 0.1, 0.4, 0.1, 0.05, 0.1, 0.4, 0.1, 0.95, 0.1, 0.4, 0.1, 0.05, 0.1, 0.4, 0.1] @=>float bassHM[];
[0.25, 0.25, 0.4, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.4, 0.25] @=>float hhcHM[];
[0.05, 0.05, 0.75, 0.05, 0.75, 0.05, 0.05, 0.05, 0.75, 0.05, 0.05, 0.75, 0.05, 0.05, 0.75, 0.05] @=>float cowHM[];

lsPM1 @=>int lsPM[];
lsHM1 @=>float lsHM[];

rsPM1 @=> int rsPM[];
rsHM1 @=> float rsHM[];

//MARK: Sounds
//left synth
SinOsc lsMod => SinOsc lsSrc => ADSR lsEnv => Pan2 lsPan => dac;

fun void ls(dur len, float vel) {
    vel * 0.35 => lsSrc.gain;
    lsEnv.attackTime() => dur atk;
    lsEnv.keyOn();
    atk => now;
    lsEnv.keyOff();
    len - atk => now; 
}


400 => lsSrc.freq;
5 => lsMod.freq;
10 => lsMod.gain;
0.3 => lsSrc.gain;
-0.9 => lsPan.pan;

2 => lsSrc.sync;

lsEnv.set(2::ms, 2::ms, 0.5, 350::ms);

//right synth
SinOsc rsMod => SinOsc rsSrc => ADSR rsEnv => Pan2 rsPan => dac;

fun void rs(dur len, float vel) {
    vel * 0.35 => rsSrc.gain;
    rsEnv.attackTime() => dur atk;
    rsEnv.keyOn();
    atk => now;
    rsEnv.keyOff();
    len - atk => now; 
}


400 => rsSrc.freq;
3 => rsMod.freq;
14 => rsMod.gain;
0.3 => rsSrc.gain;
0.9 => rsPan.pan;

2 => rsSrc.sync;

rsEnv.set(2::ms, 2::ms, 0.5, 350::ms);


//left bass
SinOsc lbMod => SinOsc lbSrc => ADSR lbEnv => Pan2 lbPan => dac;

fun void lb(dur len, float vel) {
    vel => lbSrc.gain;
    lbEnv.attackTime() => dur atk;
    lbEnv.keyOn();
    atk => now;
    lbEnv.keyOff();
    len - atk => now; 
}


240 => lbSrc.freq;
40 => lbMod.freq;
40 => lbMod.gain;
0.5 => lbSrc.gain;
-1 => lbPan.pan;

2 => lbSrc.sync;

lbEnv.set(2::ms, 2::ms, 0.5, 150::ms);

//right bass
SinOsc rbMod => SinOsc rbSrc => ADSR rbEnv => Pan2 rbPan => dac;

fun void rb(dur len, float vel) {
    vel => rbSrc.gain;
    rbEnv.attackTime() => dur atk;
    rbEnv.keyOn();
    atk => now;
    rbEnv.keyOff();
    len - atk => now; 
}


240 => rbSrc.freq;
40 => rbMod.freq;
40 => rbMod.gain;
0.5 => rbSrc.gain;
1 => rbPan.pan;

2 => rbSrc.sync;

rbEnv.set(2::ms, 2::ms, 0.5, 150::ms);


//snare
SinOsc snrMod => SinOsc snrSrc => ADSR snrEnv => Pan2 snrPan => dac;

fun void snare(dur len, float vel) {
    vel => snrSrc.gain;
    snrEnv.attackTime() => dur atk;
    snrEnv.keyOn();
    atk => now;
    snrEnv.keyOff();
    len - atk => now; 
}


240 => snrSrc.freq;
40 => snrMod.freq;
80000 => snrMod.gain;
0.5 => snrSrc.gain;
0 => snrPan.pan;

2 => snrSrc.sync;

snrEnv.set(2::ms, 2::ms, 0.5, 150::ms);



//bass
SinOsc bassMod => SinOsc bassSrc => ADSR bassEnv => Pan2 bassPan => dac;

fun void bass(dur len, float vel) {
    vel => bassSrc.gain;
    bassEnv.attackTime() => dur atk;
    bassEnv.keyOn();
    atk => now;
    bassEnv.keyOff();
    len - atk => now; 
}

2 => bassSrc.sync;
1.2 => bassSrc.gain;
45 => bassSrc.freq;
30 => bassMod.freq;
20 => bassMod.gain;

bassEnv.set(10::ms, 2::ms, 0.5, 450::ms);

//Hi hat closed
SinOsc hhMod => SqrOsc hhSrc => ADSR hhEnv => Pan2 hhPan => dac;

fun void hhc(dur len,float vel) {
    vel => hhSrc.gain;
    hhEnv.attackTime() => dur atk;
    hhEnv.keyOn();
    atk => now;
    hhEnv.keyOff();
    len - atk => now; 
}

2 => hhSrc.sync;

2500 => hhSrc.freq;
80 => hhMod.freq;
1200 => hhMod.gain;
0.4 => hhPan.pan;

hhEnv.set(1::ms, 2::ms, 1.0, 10::ms);

//Hi hat open
SinOsc hhoMod => SinOsc hhoSrc => ADSR hhoEnv => Pan2 hhoPan => dac;

fun void hho(dur len,float vel) {
    vel => hhoSrc.gain;
    hhoEnv.attackTime() => dur atk;
    hhoEnv.keyOn();
    atk => now;
    hhoEnv.keyOff();
    len - atk => now; 
}

2 => hhoSrc.sync;

4500 => hhoSrc.freq;
400 => hhoMod.freq;
1200 => hhoMod.gain;

hhoEnv.set(1::ms, 2::ms, 1.0, 800::ms);
//cowbell
SinOsc cowMod => SinOsc cowSrc => ADSR cowEnv => Pan2 cowPan => dac;

fun void cow(dur len, float vel) {
    vel => cowSrc.gain;
    cowEnv.attackTime() => dur atk;
    cowEnv.keyOn();
    atk => now;
    cowEnv.keyOff();
    len - atk => now; 
}

2 => cowSrc.sync;

330 => cowSrc.freq;
80 => cowMod.freq;
10 => cowMod.gain;

cowEnv.set(10::ms, 2::ms, 1.0, 28::ms);
-0.5 => cowPan.pan;
//MARK: timing functions
0 => int step;

fun dur qtr() {
    return (1.0/bpm)::minute;
}
fun dur half() {
    return ((1.0/bpm)*2)::minute;
}
fun dur whole() {
    return ((1.0/bpm)*4)::minute;
}

fun dur eighth() {
    return ((1.0/bpm)/2.0)::minute;
}

fun dur swEighth() {
    return ((1.0/bpm)*swing)::minute;
}

fun dur upswEighth() {
    return ((1.0/bpm)*(1-swing))::minute;
}

fun dur sixteenth() {
    return ((1.0/bpm)/4.0)::minute;
}

fun dur thirtysecond() {
    return ((1.0/bpm)/8.0)::minute;
}

fun dur sixtyforth() {
    return ((1.0/bpm)/16.0)::minute;
}

fun float chance() {
    return Math.randomf() * agitation;
}

//run it
fun void play() {
    0 => float leftBass;
    0 => int s;
    0 => int b;
    0 => int h;
    0 => int c;
    
    0::ms => dur len;
    //apply swing
    if(step % 2) {
        swEighth() => len;
    }
    else {
        upswEighth() => len;
    }
    //run probabilities
    if(lsHM[step] < chance() * lsChatter){
        Std.mtof(lsPM[step]) => lsSrc.freq;
        spork ~ls(len, lsHM[step]);
    }
    
    if(rsHM[step] < chance() * rsChatter){
        Std.mtof(rsPM[step]) => rsSrc.freq;
        spork ~rs(len, rsHM[step]);
    }
    
    if(lbHM[step] < chance() * lbChatter){
        Std.mtof(lbPM[step]-12) => lbSrc.freq;
        spork ~lb(len, lbHM[step]);
        Std.mtof(lbPM[step]) => leftBass;
    }
    
    if(rbHM[step] < chance() * rbChatter){
        Std.mtof(rbPM[step]-12) => rbSrc.freq;
        spork ~rb(len, rbHM[step]);
    }
    
    if(bassHM[step] < chance()){
        spork ~bass(len, bassHM[step] * 1.1);
        1 => b;
    }
    if(hhcHM[step] < chance()){
        spork ~hhc(len, hhcHM[step]);
        1 => h;
    }
    if(snrHM[step] < chance() * snareChatter){
        spork ~snare(len,snrHM[step]);
        1=> s;
    }
    
    if(cowHM[step] < chance()){
        spork ~cow(len,cowHM[step]);
        1=> c;
    }
    len=>now;
    (step+1) % steps => step;
}



//mark— OSC management
OscRecv orec;

9900 => orec.port;

orec.listen();

orec.event("test, i") @=> OscEvent start;

//god commands
orec.event("g_agit, i") @=> OscEvent god;
//follower commands
orec.event("f_agit, i") @=> OscEvent follower;
orec.event("f_left, i") @=> OscEvent followerLeft;
orec.event("f_right, i") @=> OscEvent followerRight;
orec.event("f_left_add, i") @=> OscEvent leftAdd;
orec.event("f_right_add, i") @=> OscEvent rightAdd;
orec.event("lml, i") @=> OscEvent lml;
orec.event("lmr, i") @=> OscEvent lmr;
orec.event("rml, i") @=> OscEvent rml;
orec.event("rmr, i") @=> OscEvent rmr;
orec.event("score_add, i") @=> OscEvent scoreAdd;

fun void handleScoreAdd() {
    while(1){
        scoreAdd => now;
        while(scoreAdd.nextMsg()!=0){
            scores+1 => scores;
            <<<"score! ",scores>>>;
            if(scores==1) {
                <<<"hit! 1">>>;
                lsPM2 @=> lsPM;
                lsHM2 @=> lsHM;

                rsPM2 @=> rsPM;
                rsHM2 @=> rsHM;
            }
            else if(scores == 2){
                <<<"hit! 2">>>;
                lsPM3 @=>lsPM;
                lsHM3 @=>lsHM;

                rsPM3 @=>rsPM;
                rsHM3 @=>rsHM;
            }
            else if(scores == 3){
                <<<"hit! 3">>>;
                lsPM1 @=>lsPM;
                lsHM1 @=>lsHM;
                
                rsPM1 @=>rsPM;
                rsHM1 @=> float rsHM[];
                0 => scores;
            }
        }
    }
}

fun void handleGod() {
    while(1){
    god => now;
    while(god.nextMsg()!=0){
        god.getInt() => int i;
        if(i == 1) agitation + 0.05 => agitation;
        if(i == 0) agitation - 0.05 => agitation;
        <<<"Agitation: ",agitation>>>;
    }
    }
}

fun void handleFollower() {
    while(1){
        follower => now;
        while(follower.nextMsg()!=0){
            follower.getInt() => int i;
            if(i == 1) agitation + 0.01 => agitation;
            if(i == 0) agitation - 0.01 => agitation;
        }
    }
}

fun void handleLeft() {
    while(1){
        followerLeft => now;
        while(followerLeft.nextMsg()!=0){
            0.2/ leftFollowers => float incr;
            followerLeft.getInt() => int i;
            if(i == 0) {
                
                lsChatter + incr => lsChatter;
            }
            else {
                
                lsChatter - incr => lsChatter;
            }
            <<<"Left side score:", lsChatter>>>;
        }
    }
}

fun void handleRight() {
    while(1){
        followerRight => now;
        while(followerRight.nextMsg()!=0){
            0.2/ rightFollowers => float incr;
            followerRight.getInt() => int i;
            if(i == 0) {
                
                rsChatter + incr => rsChatter;
            }
            else {
                
                rsChatter - incr => rsChatter;
            }
            <<<"Right side score:", rsChatter>>>;
        }
    }
}

fun void handleLeftAdd() {
    while(1) {
        leftAdd => now;
        while(leftAdd.nextMsg()!=0){
            leftFollowers+1 => leftFollowers;
            <<<"Hit!">>>;
        }
    }
}

fun void handleRightAdd() {
    while(1) {
        rightAdd => now;
        while(rightAdd.nextMsg()!=0){
            rightFollowers+1 => rightFollowers;
            <<<"Hit!">>>;
        }
    }
}

fun void handleLml() {
    while(1) {
        lml => now;
        while(lml.nextMsg()!=0){
            0.2/ leftFollowers => float incr;
            lbChatter - incr => lbChatter;
            <<<"lml">>>;
        }
    }
}

fun void handleLmr() {
    while(1) {
        lmr => now;
        while(lmr.nextMsg()!=0){
            0.2/ leftFollowers => float incr;
            lbChatter + incr => lbChatter;
            <<<"lmr">>>;
        }
    }
}

fun void handleRml() {
    while(1) {
        rml => now;
        while(rml.nextMsg()!=0){
            0.2/ rightFollowers => float incr;
            rbChatter - incr => rbChatter;
            <<<"rml">>>;
        }
    }
}

fun void handleRmr() {
    while(1) {
        rmr => now;
        while(rmr.nextMsg()!=0){
            0.2/ rightFollowers => float incr;
            rbChatter + incr => rbChatter;
            <<<"rmr">>>;
        }
    }
}
//sender
OscSend status;
status.setHost("localhost", 3333);

fun void sendStatus() {
    while(true){
        status.startMsg("stat", "f,f,f,i,i,f,f");
        agitation => status.addFloat;
        rsChatter => status.addFloat;
        lsChatter => status.addFloat;
        leftFollowers => status.addInt;
        rightFollowers => status.addInt;
        rbChatter => status.addFloat;
        lbChatter => status.addFloat;
        0.05::second => now;
    }
}

spork~ handleScoreAdd();
spork~ handleGod();
spork~ handleFollower();
spork~ handleLeft();
spork~ handleRight();
spork~ handleLml();
spork~ handleLmr();
spork~ handleRml();
spork~ handleRmr();
spork~ handleLeftAdd();
spork~ handleRightAdd();
spork~ sendStatus();
start=>now;
start.nextMsg();
<<<start.getInt()>>>;

while(true){
    play();
}
