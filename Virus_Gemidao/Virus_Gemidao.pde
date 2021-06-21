import kelvinclark.utils.InfiniteMouse;
import ddf.minim.*;

Minim myMinim;
AudioPlayer beep;
AudioPlayer gemido;

InfiniteMouse mouse;

PImage blueScreen;
boolean startIntro = true, change;

static final String RENDERER = JAVA2D;

void setup() {
    fullScreen(RENDERER, SPAN);    
    myMinim = new Minim(this);
    beep = myMinim.loadFile("beep.mp3");
    gemido = myMinim.loadFile("audio.mp3");

    blueScreen = loadImage("Bsodwindows10.png");
    blueScreen.resize(1920, 1080);

    mouse = new InfiniteMouse(this);
    disableWindowClosing();
    surface.setAlwaysOnTop(true);
}
void draw() {
    if (startIntro) {
        introAnimation();
    } else {
        background(0);
        //if (!gemido.isPlaying()) gemido.loop();
        image(blueScreen, 0, 0);
        noCursor();
        mouse.setLocation(1920/2, height/2);
    }
}

void introAnimation() {
    if (frameCount < 100) {
        beep.play();
        cursor(WAIT);

        if (random(1) > .75) {
            if (change ^= true) {
                background(#020555);
                beep.pause();
            } else {
                background(#48275A);
                beep.play();
            }
        }
    } else {
        beep.pause();
        startIntro = false;
    }
}

void keyPressed() {
    if (keyCode == ESC)  key = 0;
    if (key == 'Q') exit();
}

void disableWindowClosing() {
    final Object surf = getSurface().getNative();

    final javax.swing.JFrame jframe = (javax.swing.JFrame)((processing.awt.PSurfaceAWT.SmoothCanvas) surf).getFrame(); 

    for (java.awt.event.WindowListener wl : jframe.getWindowListeners())
        if (wl.toString().startsWith("processing.awt.PSurfaceAWT"))
            jframe.removeWindowListener(wl);

    jframe.setDefaultCloseOperation(javax.swing.WindowConstants.DO_NOTHING_ON_CLOSE);
}
