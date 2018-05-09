module stm32f401re;

version (ARM_Thumb):
@nogc:
nothrow:

version(LDC)
{
    pragma(LDC_no_moduleinfo);
    pragma(LDC_no_typeinfo);
}

public import cortexm;


/**
Power on each peripherals.
 */
auto powerOn(string name)()
{
    static if (name == "GPIOA" || name == "GPIOB" || name == "GPIOC" || name == "GPIOD" || name == "GPIOE")
    {
        import stm32f401re.gpio;
        return powerOnGPIO!(name)();
    }
    else static if (name == "TIM2" || name == "TIM3" || name == "TIM4" || name == "TIM5")
    {
        import stm32f401re.timer;
        return powerOnTIM!(name)();
    }
    else static assert (false);
}


