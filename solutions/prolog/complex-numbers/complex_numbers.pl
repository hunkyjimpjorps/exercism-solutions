real((Re, _), Re).
imaginary((_, Im), Im).

conjugate((Re, Im), (Re, -1*Im)).
abs((Re, Im), (Re**2 + Im**2)**0.5).

add((A, B), (C, D), (A + C, B + D)).
sub((A, B), (C, D), (A - C, B - D)).

mul((A, B), (C, D), (A * C - B * D, B * C + A * D)).
div((A, B), (C, D), (RealPart, ImPart)) :-
    Denominator is C^2 + D^2,
    RealPart is (A * C + B * D)/Denominator, 
    ImPart is (B * C - A * D)/Denominator.
