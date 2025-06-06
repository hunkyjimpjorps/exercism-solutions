conversion("Earth", 1.0).
conversion("Mercury", 0.2408467).
conversion("Venus", 0.61519726).
conversion("Mars", 1.8808158).
conversion("Jupiter", 11.862615).
conversion("Saturn", 29.447498).
conversion("Uranus", 84.016846).
conversion("Neptune", 164.79132).

seconds_to_years(Seconds, Years) :-
    Years is Seconds / 31557600.

space_age(Planet, AgeSec, Years) :-
    conversion(Planet, YearFactor),
    seconds_to_years(AgeSec, AgeYears),
    Years is AgeYears / YearFactor.