import Foundation

// open enable entities to be used within any source file from their defining module, and also in a source file from another module that imports the defining module. Applies only to classes and class members. It allows code outside the module to subclass and override

// public enable entities to be used within any source file from their defining module, and also in a source file from another module that imports the defining module

// internal enables entities to be used in the module that defines them, but not outside of that module

// fileprivate restricts the use of an entity to its own defining source file

// private restricts the use of an entity to the enclosing declaration, and to extensions of that declaration that are in the same file

// the default access level is internal



//Custom Types
public class SomePublicClass {                  // explicitly public class
    
    public var somePublicProperty = 0            // explicitly public class member
    
    var someInternalProperty = 0                 // implicitly internal class member
    
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    
    private func somePrivateMethod() {}          // explicitly private class member
    
}

class SomeInternalClass {                       // implicitly internal class
    
    var someInternalProperty = 0                 // implicitly internal class member
    
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    
    private func somePrivateMethod() {}          // explicitly private class member
    
}

fileprivate class SomeFilePrivateClass {        // explicitly file-private class
    
    func someFilePrivateMethod() {}              // implicitly file-private class member
    
    private func somePrivateMethod() {}          // explicitly private class member
    
}

private class SomePrivateClass {                // explicitly private class
    
    func somePrivateMethod() {}                  // implicitly private class member
    
}

// func types
//private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    // function implementation goes here
//}


//subclass
public class A {
    fileprivate func someMethod() {}
}

internal class B: A {
    override internal func someMethod() {
        super.someMethod()
    }
}


// let and var, can’t be more public than its type. It’s not valid to write a public property with a private type
private var privateInstance = SomePrivateClass()


// getters and setters
public struct TrackedString {
    public private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    public init() {}
}

