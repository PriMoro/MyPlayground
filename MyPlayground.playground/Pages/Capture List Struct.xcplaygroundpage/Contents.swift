import Foundation

class HTMLElement {

    var name: String

    init(name: String) {
        self.name = name
    }
}

var paragraph = HTMLElement(name: "Enrique")

let closure1 = { [name = paragraph.name] in
    // What will be printed and why?
    print(name)
}

var localName = paragraph.name
let closure2 = { [localName] in
    // What will be printed and why?
    print(localName)
}

let closure3 = { [paragraph] in
    // What will be printed and why?
    print(paragraph.name)
}

paragraph.name = "Jose"

closure1()
closure2()
closure3()

// What will be printed and why?
print(paragraph.name)
