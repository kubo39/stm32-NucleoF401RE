import stm32f401re;

import stm32f401re.led;
import stm32f401re.timer;

@nogc:
nothrow:

extern (C) void main()
{
    pragma(LDC_never_inline);

    auto tim2 = powerOn!"TIM2"();
    initLED();

    tim2.pause();
    tim2.setPrescaler(7999);

    while (true)
    {
        auto ticks = 1000;
        foreach (led; LEDS)
        {
            led.on();
            tim2.delay(ticks);
            led.off();
            tim2.delay(ticks);
        }
    }
}

void delay(Tim* tim, uint ticks)
{
    tim.setAutoreload(ticks);
    tim.resume();

    while (!tim.isUpdated())
    {
    }
    tim.clearUpdateFlag();
}
