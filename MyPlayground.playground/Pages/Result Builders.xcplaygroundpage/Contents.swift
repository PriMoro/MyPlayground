import Foundation

// result builders allow us to create a new value step by step by passing in a sequence of our choosing

@resultBuilder //-> tells Swift the following type should be treated as a result builder
struct SimpleStringBuilder {
    // Every result builder must provide at least one static method called buildBlock(),
    // which should take in some sort of data and transform it
    static func buildBlock(_ parts: String...) -> String {
        parts.joined(separator: "\n")
    }
}

// The end result is that our SimpleStringBuilder struct becomes a result builder,
// meaning that we can use @SimpleStringBuilder anywhere we need its string joining powers.

let joined = SimpleStringBuilder.buildBlock("hello", "world")
print(joined)

@SimpleStringBuilder func makeSentence() -> String {
    "first phrase"
    "second phrase"
    "third phrase"
}
print(makeSentence())

@resultBuilder
struct ComplexStringBuilder {
    static func buildBlock(_ parts: String...) -> String {
        parts.joined(separator: "\n")
    }
    
    // we could add if/else support
    static func buildEither(first component: String) -> String {
        return component
    }
    static func buildEither(second component: String) -> String {
        return component
    }
    
    // we could add support for loops
    static func buildArray(_ components: [String]) -> String {
        components.joined(separator: "\n")
    }
}

@ComplexStringBuilder func makeRandomSentence() -> String {
    "Why settle for a Duke"
    "when you can have"

    if Bool.random() {
        "a Prince?"
    } else {
        "a King?"
    }
}

print(makeRandomSentence())

@ComplexStringBuilder func countDown() -> String {
    for i in (0...10).reversed() {
        "\(i)…"
    }

    "Lift off!"
}

print(countDown())
