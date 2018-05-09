module stm32f401re.led;

import core.bitop;
import cortexm;
import stm32f401re.gpio;

version (ARM_Thumb) :
@nogc:
nothrow:

version (LDC)
{
    pragma(LDC_no_moduleinfo);
    pragma(LDC_no_typeinfo);
}


/**
Colors for LED.
*/
enum Color : ubyte
{
    Green = 0x05,
}


/**
LED
 */
struct Led
{
    Color color;

    this(Color color) nothrow @nogc
    {
        this.color = color;
    }

    void off() nothrow @nogc
    {
        volatileStore(&GPIOA.odr, volatileLoad(&GPIOA.odr) & ~(1 << this.color));
    }

    void on() nothrow @nogc
    {
        volatileStore(&GPIOA.odr, volatileLoad(&GPIOA.odr) | (1 << this.color));
    }

    void toggle() nothrow @nogc
    {
        auto odr = &GPIOA.odr;
        volatileStore(odr, volatileLoad(odr) ^ (1 << this.color));
    }

    void setMode(Mode mode) nothrow @nogc
    {
        GPIOA.setMode(this.color, mode);
    }
}

__gshared Led[1] LEDS = [Led(Color.Green)];

void initLED()
{
    auto gpioa = powerOnGPIO!"GPIOA"();
    gpioa.setMode(Color.Green, Mode.Out);
}
