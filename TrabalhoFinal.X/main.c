#include "config.h"
#include "lcd.h"
#include "keypad.h"
#include "adc.h"
#include "rgb.h"
#include "bits.h"
#include "atraso.h"
#include "io.h"
#include "so.h"
#include "timer.h"

static const char valor[] = {
    0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D,
    0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C,
    0x39, 0x5E, 0x79, 0x71
};
static char display = 0;
static char v0, v1, v2, v3;
int v = 0000;

void main(void) {
    pinMode(DISP_1_PIN, OUTPUT);
    pinMode(DISP_2_PIN, OUTPUT);
    pinMode(DISP_3_PIN, OUTPUT);
    pinMode(DISP_4_PIN, OUTPUT);
    soInit();
    rgbInit();
    adcInit();
    timerInit();
    lcdInit();
    kpInit();

    int player=0;
    
    for(;;) {
        timerReset(10000);
        
        /*v0 = ((v / 100) % 10);
        v1 = ((v / 1000) % 6);
        v2 = ((v / 6000) % 10);
        v3 = ((v / 60000) % 6);
         */
        
        
        v0 = ((v / 1) % 10);
        v1 = ((v / 10) % 10);
        v2 = ((v / 100) % 10);
        v3 = ((v / 1000) % 10);
       
        
        if(v==60) {
            v = 100;
        }
        if(v==160) {
            v = 200;
        }
        if(v==260) {
            v = 0;
        }
        
        if((v>=0)&&(v<=59)) {
            rgbColor(2);
        }
        if((v>=100)&&(v<=159)) {
            rgbColor(3);
        }
        if((v>=159)&&(v<=300)) {
            rgbColor(1);
        }
        
        
        
        digitalWrite(DISP_1_PIN, LOW);
        digitalWrite(DISP_2_PIN, LOW);
        digitalWrite(DISP_3_PIN, LOW);
        digitalWrite(DISP_4_PIN, LOW);
        soWrite(0x00);
        kpDebounce();
        lcdCommand(0x80);
        
        switch(player) {
            case 0:
                if(v2 == 3) {
                    v = 0;
                }
                kpDebounce();
                lcdString("Radio 1");
                lcdCommand(0xC0);
                lcdString("BEATLES");
                switch(display) {
                    case 0:
                        soWrite(valor[v0]);
                        digitalWrite(DISP_4_PIN, HIGH);
                        display = 1;
                        v++;
                        atraso_ms(20);
                        break;
                    case 1:
                        soWrite(valor[v1]);
                        digitalWrite(DISP_3_PIN, HIGH);
                        display = 2;
                        v++;
                        atraso_ms(20);
                        break;
                    case 2:
                        soWrite(valor[v2]);
                        digitalWrite(DISP_2_PIN, HIGH);
                        display = 3;
                        v++;
                        atraso_ms(20);
                        break;
                    case 3: 
                        soWrite(valor[v3]);
                        digitalWrite(DISP_1_PIN, HIGH);
                        display = 0;
                        v++;
                        atraso_ms(20);
                        break;
                }
                
                if(kpReadKey() == 'R') {
                    lcdCommand(0x01);
                    player = 1;
                    v= 0;
                    atraso_ms(1000); 
                } else if (kpReadKey() == 'L') {
                    lcdCommand(0x01);
                    player = 3;
                    v= 0;
                    atraso_ms(1000); 
                }
                
                break;
            case 1:
                if(v2 == 3) {
                    v = 0;
                }
                kpDebounce();
                lcdString("Radio 2");
                lcdCommand(0xC0);
                lcdString("ACDC");
                switch(display) {
                    case 0:
                        soWrite(valor[v0]);
                        digitalWrite(DISP_4_PIN, HIGH);
                        display = 1;
                        v++;
                        atraso_ms(20);
                        break;
                    case 1:
                        soWrite(valor[v1]);
                        digitalWrite(DISP_3_PIN, HIGH);
                        display = 2;
                        v++;
                        atraso_ms(20);
                        break;
                    case 2:
                        soWrite(valor[v2]);
                        digitalWrite(DISP_2_PIN, HIGH);
                        display = 3;
                        v++;
                        atraso_ms(20);
                        break;
                    case 3: 
                        soWrite(valor[v3]);
                        digitalWrite(DISP_1_PIN, HIGH);
                        display = 0;
                        v++;
                        atraso_ms(20);
                        break;
                }
                
                if(kpReadKey() == 'R') {
                    lcdCommand(0x01);
                    player = 2;
                    v = 0;
                    atraso_ms(1000); 
                } else if (kpReadKey() == 'L') {
                    lcdCommand(0x01);
                    player = 0;
                    v = 0;
                    atraso_ms(1000);
                }
                 
                break;
            case 2:
                if(v2 == 3) {
                    v = 0;
                }
                kpDebounce();
                lcdString("Radio 3");
                lcdCommand(0xC0);
                lcdString("IMAGINE DRAGONS");
                switch(display) {
                    case 0:
                        soWrite(valor[v0]);
                        digitalWrite(DISP_4_PIN, HIGH);
                        display = 1;
                        v++;
                        atraso_ms(20);
                        break;
                    case 1:
                        soWrite(valor[v1]);
                        digitalWrite(DISP_3_PIN, HIGH);
                        display = 2;
                        v++;
                        atraso_ms(20);
                        break;
                    case 2:
                        soWrite(valor[v2]);
                        digitalWrite(DISP_2_PIN, HIGH);
                        display = 3;
                        v++;
                        atraso_ms(20);
                        break;
                    case 3: 
                        soWrite(valor[v3]);
                        digitalWrite(DISP_1_PIN, HIGH);
                        display = 0;
                        v++;
                        atraso_ms(20);
                        break;
                }
                
                if(kpReadKey() == 'R') {
                    lcdCommand(0x01);
                    player = 3;
                    v = 0;
                    atraso_ms(1000); 
                } else if (kpReadKey() == 'L') {
                    lcdCommand(0x01);
                    player = 1;
                    v = 0;
                    atraso_ms(1000);
                }
                 
                break;
            case 3:
                if(v2 == 3) {
                    v = 0;
                }
                kpDebounce();
                lcdString("Radio 4");
                lcdCommand(0xC0);
                lcdString("BLACKPINK");
                switch(display) {
                    case 0:
                        soWrite(valor[v0]);
                        digitalWrite(DISP_4_PIN, HIGH);
                        display = 1;
                        v++;
                        atraso_ms(20);
                        break;
                    case 1:
                        soWrite(valor[v1]);
                        digitalWrite(DISP_3_PIN, HIGH);
                        display = 2;
                        v++;
                        atraso_ms(20);
                        break;
                    case 2:
                        soWrite(valor[v2]);
                        digitalWrite(DISP_2_PIN, HIGH);
                        display = 3;
                        v++;
                        atraso_ms(20);
                        break;
                    case 3: 
                        soWrite(valor[v3]);
                        digitalWrite(DISP_1_PIN, HIGH);
                        display = 0;
                        v++;
                        atraso_ms(20);
                        break;
                }
                
                if(kpReadKey() == 'R') {
                    lcdCommand(0x01);
                    player = 0;
                    v = 0;
                    atraso_ms(1000); 
                } else if (kpReadKey() == 'L') {
                    lcdCommand(0x01);
                    player = 2;
                    v = 0;
                    atraso_ms(1000); 
                }
                
                break;
            default: 
                player = 0;
                break;
        }
          timerWait(); 
    }
    
}
