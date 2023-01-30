import Foundation

// Defining a Class Hierarchy for Type Casting
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
// library type is [MediaItem]
// If we iterate over the contents of library, the items we receive back are typed as MediaItem, and not as Movie or Song.


// Checking Type

var movieCount = 0
var songCount = 0

for item in library {
    
    // item is Movie checks whether the item is a Movie instance.
    if item is Movie {
        movieCount += 1
    }
    
    // item is Song checks whether the item is a Song instance.
    else if item is Song {
        songCount += 1
    }
}

print("Media library contains")
print(" - \(movieCount) movies")
print(" - \(songCount) songs")


// Downcasting

// Each item in the array might be a Movie, or it might be a Song.
// It’s appropriate to use the conditional form of the type cast operator (as?):
// - to check the downcast each time through the loop.
// - to access the director or artist property of a Movie or Song for use in the description.
for item in library {
    
    // Try to access item as a Movie.
    // If this is successful, set a new temporary constant called movie to
    // the value stored in the returned optional Movie.
    if let movie = item as? Movie {
        print("Movie: \(movie.name), director: \(movie.director)")
    }
    
    // Try to access item as a Song.
    // If this is successful, set a new temporary constant called song to
    // the value stored in the returned optional Song.
    else if let song = item as? Song {
        print("Song: \(song.name), artist: \(song.artist)")
    }
}
 

// Type Casting for Any and AnyObject

// To discover the specific type of a let or var that’s known only to be of type Any or AnyObject,
// we can use an is or as pattern in a switch statement’s cases.
var things: [Any] = []

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
            print("a positive double value of \(someDouble)")
        case is Double:
            print("some other double value that I don't want to print")
        case let someString as String:
            print("a string value of \"\(someString)\"")
        case let (x, y) as (Double, Double):
            print("an (x, y) point at \(x), \(y)")
        case let movie as Movie:
            print("a movie called \(movie.name), dir. \(movie.director)")
        case let stringConverter as (String) -> String:
            print(stringConverter("Michael"))
        default:
            print("something else")
    }
}


// The Any type represents values of any type, including optional types.
// Swift gives you a warning if you use an optional value where a value of type Any is expected.
// If you really do need to use an optional value as an Any value, you can use the as operator to explicitly cast the optional to Any.
let optionalNumber: Int? = 3
things.append(optionalNumber) // Warning
things.append(optionalNumber as Any) // No warning
