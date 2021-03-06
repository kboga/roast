# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use v6;
use Test;
BEGIN { @*INC.push("t/spec/packages/") };
use TrigTestSupport;


# sin tests

my $base_list = (TrigTest::official_bases() xx *).flat;
my $iter_count = 0;
for TrigTest::sines() -> $angle
{
    
    my $desired-result = $angle.result;

    # Num.sin tests -- very thorough
    is_approx($angle.num(Radians).sin, $desired-result, 
              "Num.sin - {$angle.num(Radians)}");

    # Complex.sin tests -- also very thorough
    my Complex $zp0 = $angle.complex(0.0, Radians);
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.complex(1.0, Radians);
    my Complex $sz1 = { (exp($_ * 1i) - exp(-$_ * 1i)) / 2i }($zp1);
    my Complex $zp2 = $angle.complex(2.0, Radians);
    my Complex $sz2 = { (exp($_ * 1i) - exp(-$_ * 1i)) / 2i }($zp2);
    
    is_approx($zp0.sin, $sz0, "Complex.sin - $zp0");
    is_approx($zp1.sin, $sz1, "Complex.sin - $zp1");
    is_approx($zp2.sin, $sz2, "Complex.sin - $zp2");
}

is(sin(Inf), NaN, "sin(Inf) -");
is(sin(-Inf), NaN, "sin(-Inf) -");
        
# Num tests
is_approx(sin((-6.28318530723787).Num), 0, "sin(Num) - -6.28318530723787");
is_approx(sin(:x((-3.92699081702367).Num)), 0.707106781186548, "sin(:x(Num)) - -3.92699081702367");

# Rat tests
is_approx((-0.523598775603156).Rat(1e-9).sin, -0.5, "Rat.sin - -0.523598775603156");
is_approx(sin((0).Rat(1e-9)), 0, "sin(Rat) - 0");
is_approx(sin(:x((0.523598775603156).Rat(1e-9))), 0.5, "sin(:x(Rat)) - 0.523598775603156");

# Complex tests
is_approx(sin((0.785398163397448 + 2i).Complex), 2.66027408533543 + 2.56457758878695i, "sin(Complex) - 0.785398163397448 + 2i");
is_approx(sin(:x((1.5707963267949 + 2i).Complex)), 3.76219569108363 - 5.28500223497344e-11i, "sin(:x(Complex)) - 1.5707963267949 + 2i");

# Str tests
is_approx((2.3561944902142).Str.sin, 0.707106781186548, "Str.sin - 2.3561944902142");
is_approx(sin((3.14159265361894).Str), 0, "sin(Str) - 3.14159265361894");
is_approx(sin(:x((3.92699081702367).Str)), -0.707106781186548, "sin(:x(Str)) - 3.92699081702367");

# NotComplex tests
is_approx(NotComplex.new(4.71238898038469 + 2i).sin, -3.76219569108363 + 1.58548456399631e-10i, "NotComplex.sin - 4.71238898038469 + 2i");
is_approx(sin(NotComplex.new(5.49778714378214 + 2i)), -2.66027408518037 + 2.56457758893643i, "sin(NotComplex) - 5.49778714378214 + 2i");
is_approx(sin(:x(NotComplex.new(6.28318530717959 + 2i))), 2.19288424696638e-10 + 3.62686040784702i, "sin(:x(NotComplex)) - 6.28318530717959 + 2i");

# DifferentReal tests
is_approx(DifferentReal.new(6.80678408284103).sin, 0.5, "DifferentReal.sin - 6.80678408284103");
is_approx(sin(DifferentReal.new(10.2101761242615)), -0.707106781186548, "sin(DifferentReal) - 10.2101761242615");
is_approx(sin(:x(DifferentReal.new(12.5663706144757))), 0, "sin(:x(DifferentReal)) - 12.5663706144757");


# asin tests

for TrigTest::sines() -> $angle
{
    
    my $desired-result = $angle.result;

    # Num.asin tests -- thorough
    is_approx($desired-result.Num.asin.sin, $desired-result, 
              "Num.asin - {$angle.num(Radians)}");
    
    # Num.asin(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx(sin(asin($z)), $z, 
                  "asin(Complex) - {$angle.num(Radians)}");
        is_approx($z.asin.sin, $z, 
                  "Complex.asin - {$angle.num(Radians)}");
    }
}
        
# Num tests
is_approx(asin((0.5).Num), 0.523598775603156, "asin(Num) - 0.523598775603156");
is_approx(asin(:x((0.707106781186548).Num)), 0.785398163404734, "asin(:x(Num)) - 0.785398163404734");

# Rat tests
is_approx(((0.5).Rat(1e-9)).asin, 0.523598775603156, "Rat.asin - 0.523598775603156");
is_approx(asin((0.707106781186548).Rat(1e-9)), 0.785398163404734, "asin(Rat) - 0.785398163404734");
is_approx(asin(:x((0.5).Rat(1e-9))), 0.523598775603156, "asin(:x(Rat)) - 0.523598775603156");

# Complex tests
is_approx(asin((0.785398163404734 + 2i).Complex), 0.341338918259481 + 1.49709293866352i, "asin(Complex) - 0.341338918259481 + 1.49709293866352i");
is_approx(asin(:x((0.523598775603156 + 2i).Complex)), 0.231190695652916 + 1.46781890096429i, "asin(:x(Complex)) - 0.231190695652916 + 1.46781890096429i");

# Str tests
is_approx(((0.707106781186548).Str).asin, 0.785398163404734, "Str.asin - 0.785398163404734");
is_approx(asin((0.5).Str), 0.523598775603156, "asin(Str) - 0.523598775603156");
is_approx(asin(:x((0.707106781186548).Str)), 0.785398163404734, "asin(:x(Str)) - 0.785398163404734");

# NotComplex tests
is_approx((NotComplex.new(0.523598775603156 + 2i)).asin, 0.231190695652916 + 1.46781890096429i, "NotComplex.asin - 0.231190695652916 + 1.46781890096429i");
is_approx(asin(NotComplex.new(0.785398163404734 + 2i)), 0.341338918259481 + 1.49709293866352i, "asin(NotComplex) - 0.341338918259481 + 1.49709293866352i");
is_approx(asin(:x(NotComplex.new(0.523598775603156 + 2i))), 0.231190695652916 + 1.46781890096429i, "asin(:x(NotComplex)) - 0.231190695652916 + 1.46781890096429i");

# DifferentReal tests
is_approx((DifferentReal.new(0.707106781186548)).asin, 0.785398163404734, "DifferentReal.asin - 0.785398163404734");
is_approx(asin(DifferentReal.new(0.5)), 0.523598775603156, "asin(DifferentReal) - 0.523598775603156");
is_approx(asin(:x(DifferentReal.new(0.707106781186548))), 0.785398163404734, "asin(:x(DifferentReal)) - 0.785398163404734");

done;

# vim: ft=perl6 nomodifiable
