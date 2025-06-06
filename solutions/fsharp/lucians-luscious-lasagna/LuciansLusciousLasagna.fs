module LuciansLusciousLasagna

let expectedMinutesInOven = 40

let remainingMinutesInOven t = expectedMinutesInOven - t

let preparationTimeInMinutes layers = 2 * layers

let elapsedTimeInMinutes layers t = preparationTimeInMinutes layers + t
