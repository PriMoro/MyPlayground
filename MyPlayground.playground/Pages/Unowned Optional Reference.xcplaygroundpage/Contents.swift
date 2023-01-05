import Foundation

class Department {
    var name: String
    var courses: [Course]
    init(name: String) {
        self.name = name
        self.courses = []
    }
    deinit {
        print("killed")
    }
}

class Course {
    var name: String
    unowned var department: Department
    unowned var nextCourse: Course?
    init(name: String, in department: Department) {
        self.name = name
        self.department = department
        self.nextCourse = nil
    }
}

var department: Department? = Department(name: "Horticulture")

let intro = Course(name: "Survey of Plants", in: department!)
let intermediate = Course(name: "Growing Common Herbs", in: department!)
let advanced = Course(name: "Caring for Tropical Plants", in: department!)

intro.nextCourse = intermediate
intermediate.nextCourse = advanced

department!.courses = [intro, intermediate, advanced]

department = nil
// What will be printed?
print(intermediate.department)
// print: Error
// La instancia department se crea de tipo Department?, por lo que puede llegar a ser nil.
// El problema es que la propiedad department de los courses no es del tipo opcional, es una unowned reference,
// por lo que swift no espera que la propiedad department de los courses pueda llegar a ser nil.
// Por otro lado, las unowned reference necesitan hacer referencia a clases que van a sobrevivir a largo plazo, en este sentido no puede
// existir un course sin department, pero si un department sin courses, porque Course tiene una unowned reference con Department,
// entonces cuando la instancia department se desasigna, no hay mas referencia fuerte a Department,
// por lo que se pierde la referencia con Course
