import Foundation

//Generics
// Write code that works for multiple types and specify requirements for those types.

// The Problem That Generics Solve

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let aux = a
    a = b
    b = aux
    print("a is now \(a), and b is now \(b)")
}

var someInt = 10
var anotherInt = 15
swapTwoInts(&someInt, &anotherInt)

// If we want to swap two string values, two double values or another values, we have to write more functions.

// Generic Functions

// These functions can work with any type

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let aux = a
    a = b
    b = aux
    print("a is now \(a), and b is now \(b)")
}
// The generic version of the function uses a placeholder type name (T), it doesn’t say anything about what T must be,
// but it does say that both a and b must be of the same type T, whatever T represents.
// The actual type to use in place of T is determined each time the swapTwoValues(_:_:) function is called.
// <T> -> Swift doesn’t look for an actual type called T

swapTwoValues(&someInt, &anotherInt)
var str1 = "hola"
var str2 = "hello"
swapTwoValues(&str1, &str2)

// Type Parameters

// nongeneric version of a Stack -> it only can be used with Int values
struct IntStack {
    var items: [Int] = []
    
    mutating func push(_ item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
}
// generic version of a Stack -> it can manage any type of value
struct Stack<Element> {
    
    // original Stack<Element> implementation
    var items: [Element] = []
        mutating func push(_ item: Element) {
            items.append(item)
        }
        mutating func pop() -> Element {
            return items.removeLast()
        }
        // conformance to the Container protocol
        mutating func append(_ item: Element) {
            self.push(item)
        }
        var count: Int {
            return items.count
        }
        subscript(i: Int) -> Element {
            return items[i]
        }
}
var stackOfInts = Stack<Int>()
stackOfInts.push(1)
stackOfInts.push(2)
stackOfInts.push(3)
stackOfInts.push(4)
let last = stackOfInts.pop()

// Extending a generic type
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfInts.topItem {
    print("The top item is \(topItem)")
}

// Type constraint
func findInex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
//T: Equatable -> any type T that conforms to the Equatable protocol.
let doubleIndex = findInex(of: 9.3, in: [9.0, 9.1, 9.2, 9.3, 9.4, 9.5])
let stringIndex = findInex(of: "hola", in: ["hello", "world", "!"])

// Associated Types
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
struct IntStack2: Container {
    // original IntStack implementation
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // conformance to the Container protocol
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

// Adding Constraints to an Associated Type
protocol Container2 {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

// Using a Protocol in Its Associated Type’s Constraints
protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

extension Stack: SuffixableContainer {
    func suffix(_ size: Int) -> Stack<Element> {
        var result = Stack<Element>()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
    // Inferred that Suffix is Stack.
}

// Generic Where Clauses
func allItemsMatch<C1: Container, C2: Container>
        (_ someContainer: C1, _ anotherContainer: C2) -> Bool
        where C1.Item == C2.Item, C1.Item: Equatable {

    // Check that both containers contain the same number of items.
    if someContainer.count != anotherContainer.count {
        return false
    }

    // Check each pair of items to see if they're equivalent.
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }

    // All items match, so return true.
    return true
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")

//var arrayOfStrings = ["uno", "dos", "tres"]

var other = Stack<String>()
other.push("uno")
other.push("dos")
other.push("tres")
//other.push("cuatro")

if allItemsMatch(stackOfStrings, other) {
    print("All items match.")
} else {
    print("Not all items match")
}
 
// Extensions with a Generic Where Clause
extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}
if stackOfStrings.isTop("tres") {
    print("Top element is tres")
}
extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

// Generics Subscripts
extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
            where Indices.Iterator.Element == Int {
        var result: [Item] = []
        for index in indices {
            result.append(self[index])
        }
        return result
    }
}
