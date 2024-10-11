/*:
## Exercise - Adopt Protocols: CustomStringConvertible, Equatable, and Comparable
 
 Create a `Human` class with two properties: `name` of type `String`, and `age` of type `Int`. You'll need to create a memberwise initializer for the class. Initialize two `Human` instances.
 */
import Foundation

class Human: CustomStringConvertible, Equatable, Comparable, Codable {
	static func < (lhs: Human, rhs: Human) -> Bool {
		lhs.name < rhs.name
	}
	
	var description: String {
		"\(name) age \(age)"
	}
	
	static func == (lhs: Human, rhs: Human) -> Bool {
		lhs.name == rhs.name && lhs.age == rhs.age
	}
	
	var name: String
	var age: Int
	
	init(name: String, age: Int) {
		self.name = name
		self.age = age
	}
}

let dipper: Human = Human(name: "Dipper", age: 12)
let mabel: Human = Human(name: "Mabel", age: 12)
let wendy: Human = Human(name: "Wendy", age: 15)
let stanley: Human = Human(name: "Stanley", age: 62)
let stanford: Human = Human(name: "Stanford", age: 62)
let soos: Human = Human(name: "Soos", age: 22)
//:  Make the `Human` class adopt the `CustomStringConvertible` protocol. Print both of your previously initialized `Human` objects.
print(dipper)
print(mabel)
//:  Make the `Human` class adopt the `Equatable` protocol. Two instances of `Human` should be considered equal if their names and ages are identical to one another. Print the result of a boolean expression evaluating whether or not your two previously initialized `Human` objects are equal to eachother (using `==`). Then print the result of a boolean expression evaluating whether or not your two previously initialized `Human` objects are not equal to eachother (using `!=`).
print(dipper == mabel)
print(dipper != mabel)

//:  Make the `Human` class adopt the `Comparable` protocol. Sorting should be based on age. Create another three instances of a `Human`, then create an array called `people` of type `[Human]` with all of the `Human` objects that you have initialized. Create a new array called `sortedPeople` of type `[Human]` that is the `people` array sorted by age.
let gravityFalls: [Human] = [dipper, mabel, wendy, stanley, stanford, soos]

let sortedPeople: [Human] = gravityFalls.sorted()

print(sortedPeople)

//:  Make the `Human` class adopt the `Codable` protocol. Create a `JSONEncoder` and use it to encode as data one of the `Human` objects you have initialized. Then use that `Data` object to initialize a `String` representing the data that is stored, and print it to the console.
let jsonEncoder = JSONEncoder()

if let jsonData = try? jsonEncoder.encode(dipper), let jsonString = String(data: jsonData, encoding: .utf8) {
	print(jsonString)
}

/*:
page 1 of 5  |  [Next: App Exercise - Printable Workouts](@next)
 */
