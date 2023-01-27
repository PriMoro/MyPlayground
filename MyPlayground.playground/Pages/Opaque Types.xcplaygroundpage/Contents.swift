import Foundation

protocol Fighter { }

struct XWing: Fighter { }

func launchFighter() -> Fighter {
    XWing()
    // Swift 5.1 no longer requires the return keyword in single-expression functions
}

let red5 = launchFighter()

//Opaque types solve this problem because even though we just see a protocol being used, internally the Swift compiler knows exactly what that protocol actually resolves to – it knows it’s an XWing, an array of strings, or whatever.

func launchOpaqueFighter() -> some Fighter {
    XWing()
}

func makeInt() -> some Equatable {
    Int.random(in: 1...10)
}

let int1 = makeInt()
let int2 = makeInt()

print(int1 == int2)

func makeString() -> some Equatable {
    "Red"
}

let str1 = makeString()

// print(int1 == str1)

// An important proviso here is that functions with opaque return types must always return one specific type.

protocol ImperialFighter {
    init()
}

struct TIEFighter: ImperialFighter { }
struct TIEAdvanced: ImperialFighter { }

func launchImperialFighter<T: ImperialFighter>() -> T {
    T()
}

let fighter1: TIEFighter = launchImperialFighter()
let fighter2: TIEAdvanced = launchImperialFighter()

/*
 Opaque result types allow us to do several things:

 Our functions decide what type of data gets returned, not the caller of those functions.
 We don’t need to worry about Self or associated type requirements, because the compiler knows exactly what type is inside.
 We get to change our minds in the future whenever we need to.
 We don’t expose private internal types to the outside world.

 */
