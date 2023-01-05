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
    
    // en este caso, name se queda con el valor que tiene paragraph.name en este momento, que es: Enrique, entonces
    print(name) //-> print: Enrique
}

// en este momento, paragraph.name sigue teniendo el valor de Enrique,
// por lo que localName va a tener ese mismo valor
var localName = paragraph.name

let closure2 = { [localName] in
    // What will be printed and why?
    
    // hace un print del valor de localName, que es el valor que recibió de paragraph.name
    print(localName) //-> print Enrique
}

let closure3 = { [paragraph] in
    // What will be printed and why?
    
    // en este caso, se pasa la instancia de la clase HTMLElement, que es paragraph,
    // o sea que es un valor por referencia, por lo que va a ser print del ultimo valor
    // que se le haya asignado a paragraph.name antes de llamar al closure3()
    print(paragraph.name) //print: Jose
}

paragraph.name = "Jose"

closure1() // Enrique
closure2() // Enrique
closure3() // Jose

// What will be printed and why?
print(paragraph.name) // Jose
// su actual valor es Jose, ya que fue reasignado en la linea 41
