import Foundation

// All Swift structs get a synthesized memberwise initializer by default



// If any of your properties have default values, then they’ll be incorporated into the initializer as default parameter values

struct Employee {
    var name: String
    var yearsActive = 0
}

let roslin = Employee(name: "Laura Roslin")
let adama = Employee(name: "William Adama", yearsActive: 45)


// If you create an initializer, Swift removes the default memberwise initializer.

struct User {
    var name: String
    var yearsActive = 0
    
    init() {
        self.name = "Anonymous"
        print("1- Creating an anonymous employee...") // -> this don't print nothing
    }
}

let example = Employee(name: "example") // With that in place, we could no longer rely on the memberwise initializer


// As soon as you add a custom initializer for your struct, the default memberwise initializer goes away.
// If you want it to stay, move your custom initializer to an extension.

extension Employee {
    init() {
        self.name = "Anonymous"
        print("2- Create an anonymous employee...")
    }
}

// creating a named employee now works
let ana = Employee(name: "Ana")

// as does creating an anonymous employee
let anonymous = Employee()
