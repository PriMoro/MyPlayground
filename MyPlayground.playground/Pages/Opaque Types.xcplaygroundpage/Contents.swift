import Foundation

// Unlike returning a value whose type is a protocol type, opaque types preserve type identity—the compiler has access to the type information,
// but clients of the module don’t. Instead of providing a concrete type as the function’s return type, the return value is described in terms of the protocols it supports.
// Hiding type information is useful at boundaries between a module and code that calls into the module, because the underlying type of the return value can remain private.

protocol Shape {
    func draw() -> String
}

struct Triangle: Shape {
    var size: Int
    func draw() -> String {
        var result: [String] = []
        for length in 1...size {
            result.append(String(repeating: "*", count: length))
        }
        return result.joined(separator: "\n")
    }
}
let smallTriangle = Triangle(size: 3)
print(smallTriangle.draw())

struct FlippedShape<T: Shape>: Shape {
    var shape: T
    func draw() -> String {
        let lines = shape.draw().split(separator: "\n")
        return lines.reversed().joined(separator: "\n")
    }
}
let flippedTriangle = FlippedShape(shape: smallTriangle)
print(flippedTriangle.draw())
// The problem is that the flipped result exposes the exact generic types that were used to create it.

struct JoinedShape<T: Shape, U: Shape>: Shape {
    var top: T
    var bottom: U
    func draw() -> String {
        return top.draw() + "\n" + bottom.draw()
    }
}
let joinedTriangles = JoinedShape(top: smallTriangle, bottom: flippedTriangle)
print(joinedTriangles.draw())
// Wrapper types like JoinedShape and FlippedShape don’t matter to the module’s users, and they shouldn’t be visible.
// The module’s public interface consists of operations like joining and flipping a shape, and those operations return another Shape value.


// Returning an Opaque Type
/// Opaque type like being the reverse of a generic type
/// func max<T>(_ x: T, _ y: T) -> T where T: Comparable { ... } --> returns a type that depends on its caller
struct Square: Shape {
    var size: Int
    func draw() -> String {
        let line = String(repeating: "*", count: size)
        let result = Array<String>(repeating: line, count: size)
        return result.joined(separator: "\n")
    }
}

func makeTrapezoid() -> some Shape {
    let top = Triangle(size: 2)
    let middle = Square(size: 2)
    let bottom = FlippedShape(shape: top)
    let trapezoid = JoinedShape(
        top: top,
        bottom: JoinedShape(top: middle, bottom: bottom)
    )
    return trapezoid // returns a trapezoid without exposing the underlying type of that shape.
}
let trapezoid = makeTrapezoid()
print(trapezoid.draw())

func flip<T: Shape>(_ shape: T) -> some Shape {
    return FlippedShape(shape: shape)
}
func join<T: Shape, U: Shape>(_ top: T, _ bottom: U) -> some Shape {
    JoinedShape(top: top, bottom: bottom)
}

let opaqueJoinedTriangles = join(smallTriangle, flip(smallTriangle))
print(opaqueJoinedTriangles.draw())
// Both func return a value of some type that conforms to the Shape protocol


//Differences Between Opaque Types and Protocol Types

func protoFlip<T: Shape>(_ shape: T) -> Shape {
    if shape is Square {
        return shape
    }
    return FlippedShape(shape: shape)
}
// It returns a protocol type instead of an opaque type.
let protoFlippedTriangle = protoFlip(smallTriangle)
let sameThing = protoFlip(smallTriangle)
// protoFlippedTriangle == sameThing -> Error

protocol Container {
    associatedtype Item
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
extension Array: Container { }

// Error: Protocol with associated types can't be used as a return type.
//func makeProtocolContainer<T>(item: T) -> Container {
//    return [item]
//}

// Error: Not enough information to infer C.
// func makeProtocolContainer<T, C: Container>(item: T) -> C {
//    return [item]
//}

// Using the opaque type some Container as a return type expresses the desired API contract—the function returns a container,
// but declines to specify the container’s type:
func makeOpaqueContainer<T>(item: T) -> some Container {
    return [item]
}
let opaqueContainer = makeOpaqueContainer(item: 12)
let twelve = opaqueContainer[0]
print(type(of: twelve))
// Prints "Int"
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

