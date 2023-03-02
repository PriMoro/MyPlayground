import Foundation

// Bitwise Operators -> to manipulate the individual raw data bits within a data structure.
// Bitwise NOT Operator: inverts all bits in a number
let initialBits: UInt8 = 0b000001111
let invertedBits = ~initialBits
print(invertedBits)
print(initialBits)

// Bitwise AND Operator: combines the bits of two numbers and returns a new number whose bits are set to 1 only if the bits were equal to 1 in both input numbers
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8 = 0b00111111
let middleFourBits = firstSixBits & lastSixBits

// Bitwise OR Operator: compares the bits of two numbers and returns a new number number whose bits are set to 1 if the bits are equal to 1 in either input number
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedBits = someBits | moreBits

// Bitwise XOR Operator: compares the bits of two numbers and returns a new number whose bits are set to 1 where the input bits are different and are set to 0 where the input bit are the same
let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits

// Bitwise Left and Right Shift Operators
// Behavior
// - Existing bits are moved to the left or right by the requested number of places.
// - Any bits that are moved beyond the bounds of the integer’s storage are discarded.
// - Zeros are inserted in the spaces left behind after the original bits are moved to the left or right.

let shiftBits: UInt8 = 4   // 00000100 in binary
shiftBits << 1             // 00001000
shiftBits << 2             // 00010000
shiftBits << 5             // 10000000
shiftBits << 6             // 00000000
shiftBits >> 2             // 00000001

// bit shifting to encode and decode values within other data types
let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16    // redComponent is 0xCC, or 204
let greenComponent = (pink & 0x00FF00) >> 8   // greenComponent is 0x66, or 102
let blueComponent = pink & 0x0000FF           // blueComponent is 0x99, or 153

// Overflow Operators
// Value Overflow
var unsignedOverflow = UInt8.max // 255
unsignedOverflow = unsignedOverflow &+ 1 // 0

var unsignedOverflow2 = UInt8.min
unsignedOverflow2 = unsignedOverflow2 &- 1

// Operator
struct Vector2D {
    var x = 0.0, y = 0.0
}

prefix operator +++
infix operator +-: AdditionPrecedence
extension Vector2D {
    // Operator Methods
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
    // Prefix and Postfix Operators
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
    // Compound Assignment Operators
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
    // Equivalence Operators
    static func == (left: Vector2D, right: Vector2D) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
    // Custom Operators
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
    // Precedence for Custom Infix Operators
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}
let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector

let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
let alsoPositive = -negative

var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd

let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherTwoThree {
    print("These two vectors are equivalent.")
}

var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled

let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector
