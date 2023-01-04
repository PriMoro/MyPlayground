import Foundation

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    var apartment: Apartment?
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment {
    let unit: String
    init(unit: String) {
        self.unit = unit
        print("\(unit) is being initialized")
    }
    weak var tenant: Person?
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

var name_tony: Person?
var unit2B: Apartment?

name_tony = Person(name: "Tony Stark")
unit2B = Apartment(unit: "2B")

name_tony!.apartment = unit2B
unit2B!.tenant = name_tony

name_tony = nil

unit2B = nil
