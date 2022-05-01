# 1 "main.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 288 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "D:/packs/Microchip/PIC18Fxxxx_DFP/1.2.26/xc8\\pic\\include\\language_support.h" 1 3
# 2 "<built-in>" 2
# 1 "main.c" 2
# 1 "./config.h" 1
# 26 "./config.h"
#pragma config OSC=HS
#pragma config FCMEN = OFF
#pragma config IESO = OFF
#pragma config PWRT = OFF
#pragma config BOREN = OFF
#pragma config BORV = 46
#pragma config WDT=OFF
#pragma config WDTPS = 1
#pragma config MCLRE=ON
#pragma config LPT1OSC = OFF
#pragma config PBADEN = ON
#pragma config CCP2MX = PORTC
#pragma config STVREN = OFF
#pragma config LVP=OFF
#pragma config XINST = OFF
#pragma config DEBUG = OFF

#pragma config CP0 = OFF
#pragma config CP1 = OFF
#pragma config CP2 = OFF
#pragma config CP3 = OFF
#pragma config CPB = OFF
#pragma config CPD = OFF

#pragma config WRT0 = OFF
#pragma config WRT1 = OFF
#pragma config WRT2 = OFF
#pragma config WRT3 = OFF
#pragma config WRTB = OFF
#pragma config WRTC = OFF
#pragma config WRTD = OFF

#pragma config EBTR0 = OFF
#pragma config EBTR1 = OFF
#pragma config EBTR2 = OFF
#pragma config EBTR3 = OFF
#pragma config EBTRB = OFF
# 1 "main.c" 2

# 1 "./lcd.h" 1


  void lcdCommand(char value);
  void lcdChar(char value);
  void lcdString(char msg[]);
  void lcdNumber(int value);
  void lcdPosition(int line, int col);
  void lcdInit(void);
# 2 "main.c" 2

# 1 "./keypad.h" 1


 unsigned int kpRead(void);
    char kpReadKey(void);
 void kpDebounce(void);
 void kpInit(void);
# 3 "main.c" 2

# 1 "./adc.h" 1
# 22 "./adc.h"
 void adcInit(void);
 int adcRead(unsigned int channel);
# 4 "main.c" 2

# 1 "./rgb.h" 1
# 20 "./rgb.h"
 void rgbColor(int led);
 void turnOn(int led);
 void turnOff(int led);
 void rgbInit(void);
# 5 "main.c" 2

# 1 "./bits.h" 1
# 6 "main.c" 2

# 1 "./atraso.h" 1



void atraso_ms(unsigned int num);
# 7 "main.c" 2

# 1 "./io.h" 1
# 12 "./io.h"
enum pin_label{
    PIN_A0,PIN_A1,PIN_A2,PIN_A3,PIN_A4,PIN_A5,PIN_A6,PIN_A7,
    PIN_B0,PIN_B1,PIN_B2,PIN_B3,PIN_B4,PIN_B5,PIN_B6,PIN_B7,
    PIN_C0,PIN_C1,PIN_C2,PIN_C3,PIN_C4,PIN_C5,PIN_C6,PIN_C7,
    PIN_D0,PIN_D1,PIN_D2,PIN_D3,PIN_D4,PIN_D5,PIN_D6,PIN_D7,
    PIN_E0,PIN_E1,PIN_E2,PIN_E3,PIN_E4,PIN_E5,PIN_E6,PIN_E7
};
# 43 "./io.h"
void digitalWrite(int pin, int value);
int digitalRead(int pin);
void pinMode(int pin, int type);
# 8 "main.c" 2

# 1 "./so.h" 1



 void soInit (void);
 void soWrite(int value);
# 9 "main.c" 2


static const char valor[] = {
    0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D,
    0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C,
    0x39, 0x5E, 0x79, 0x71
};
static char display = 0;
static char v0, v1, v2, v3;
int v = 0000;

void main(void) {
    pinMode(PIN_D0, 0);
    pinMode(PIN_D1, 0);
    pinMode(PIN_D2, 0);
    pinMode(PIN_D3, 0);
    soInit();
    rgbInit();
    adcInit();

    int tempo = 350;


    int player=0;
    lcdInit();
    kpInit();
    for(;;) {







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



        digitalWrite(PIN_D0, 0);
        digitalWrite(PIN_D1, 0);
        digitalWrite(PIN_D2, 0);
        digitalWrite(PIN_D3, 0);
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
                        digitalWrite(PIN_D3, 1);
                        display = 1;
                        v++;
                        atraso_ms(20);
                        break;
                    case 1:
                        soWrite(valor[v1]);
                        digitalWrite(PIN_D2, 1);
                        display = 2;
                        v++;
                        atraso_ms(20);
                        break;
                    case 2:
                        soWrite(valor[v2]);
                        digitalWrite(PIN_D1, 1);
                        display = 3;
                        v++;
                        atraso_ms(20);
                        break;
                    case 3:
                        soWrite(valor[v3]);
                        digitalWrite(PIN_D0, 1);
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
                        digitalWrite(PIN_D3, 1);
                        display = 1;
                        v++;
                        atraso_ms(20);
                        break;
                    case 1:
                        soWrite(valor[v1]);
                        digitalWrite(PIN_D2, 1);
                        display = 2;
                        v++;
                        atraso_ms(20);
                        break;
                    case 2:
                        soWrite(valor[v2]);
                        digitalWrite(PIN_D1, 1);
                        display = 3;
                        v++;
                        atraso_ms(20);
                        break;
                    case 3:
                        soWrite(valor[v3]);
                        digitalWrite(PIN_D0, 1);
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
                        digitalWrite(PIN_D3, 1);
                        display = 1;
                        v++;
                        atraso_ms(20);
                        break;
                    case 1:
                        soWrite(valor[v1]);
                        digitalWrite(PIN_D2, 1);
                        display = 2;
                        v++;
                        atraso_ms(20);
                        break;
                    case 2:
                        soWrite(valor[v2]);
                        digitalWrite(PIN_D1, 1);
                        display = 3;
                        v++;
                        atraso_ms(20);
                        break;
                    case 3:
                        soWrite(valor[v3]);
                        digitalWrite(PIN_D0, 1);
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
                        digitalWrite(PIN_D3, 1);
                        display = 1;
                        v++;
                        atraso_ms(20);
                        break;
                    case 1:
                        soWrite(valor[v1]);
                        digitalWrite(PIN_D2, 1);
                        display = 2;
                        v++;
                        atraso_ms(20);
                        break;
                    case 2:
                        soWrite(valor[v2]);
                        digitalWrite(PIN_D1, 1);
                        display = 3;
                        v++;
                        atraso_ms(20);
                        break;
                    case 3:
                        soWrite(valor[v3]);
                        digitalWrite(PIN_D0, 1);
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

    }

}
