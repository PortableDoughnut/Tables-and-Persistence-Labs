/*:
## App Exercise - Printable Workouts

 >These exercises reinforce Swift concepts in the context of a fitness tracking app.
 
 The `Workout` objects you have created so far in app exercises don't show a whole lot of useful information when printed to the console. They also aren't very easy to compare or sort. Throughout these exercises, you'll make the `Workout` class below adopt certain protocols that will solve these issues.
 */
import Foundation

class Workout: Codable {
    var distance: Double
    var time: Double
    var identifier: Int
    
    init(distance: Double, time: Double, identifier: Int) {
        self.distance = distance
        self.time = time
        self.identifier = identifier
    }

}

//:  Make the `Workout` class above conform to the `CustomStringConvertible` protocol so that printing an instance of `Workout` will provide useful information in the console. Create an instance of `Workout`, give it an identifier of 1, and print it to the console.
extension Workout: CustomStringConvertible {
	var description: String {
		"You have ran a workout with an identifier of \(identifier). It took you \(time) minutes and covered \(distance) miles."
	}
}

let workout = Workout(distance: 10, time: 10, identifier: 1)
print(workout)
//:  Make the `Workout` class above conform to the `Equatable` protocol. Two `Workout` objects should be considered equal if they have the same identifier. Create another instance of `Workout`, giving it an identifier of 2, and print a boolean expression that evaluates to whether or not it is equal to the first `Workout` instance you created.
extension Workout: Equatable {
	static func == (lhs: Workout, rhs: Workout) -> Bool {
		lhs.identifier == rhs.identifier
	}
}

let workoutTwo = Workout(distance: 20, time: 12, identifier: 2)
print(workoutTwo == workout)

/*:
 Make the `Workout` class above conform to the `Comparable` protocol so that you can easily sort multiple instances of `Workout`. `Workout` objects should be sorted based on their identifier. 
 
 Create three more `Workout` objects, giving them identifiers of 3, 4, and 5, respectively. Then create an array called `workouts` of type `[Workout]` and assign it an array literal with all five `Workout` objects you have created. Place these objects in the array out of order. Then create another array called `sortedWorkouts` of type `[Workout]` that is the `workouts` array sorted by identifier. 
 */
extension Workout: Comparable {
	static func < (lhs: Workout, rhs: Workout) -> Bool {
		lhs.identifier < rhs.identifier
	}
}

let workoutThree: Workout = Workout(distance: 30, time: 28, identifier: 3)
let workoutFour: Workout = Workout(distance: 40, time: 30, identifier: 4)
let workoutFive: Workout = Workout(distance: 50, time: 80, identifier: 5)

let workouts: [Workout] = [workoutThree, workoutFive, workoutFour, workoutTwo, workout]
let sortedWorkouts: [Workout] = workouts.sorted()

for workoutElement in sortedWorkouts {
	print(workoutElement)
}

//:  Make `Workout` adopt the `Codable` protocol so you can easily encode `Workout` objects as data that can be stored between app launches. Use a `JSONEncoder` to encode one of your `Workout` instances. Then use the encoded data to initialize a `String`, and print it to the console.
let jsonEncoder = JSONEncoder()
if let workoutData = try? jsonEncoder.encode(workoutFour), let workoutJsonString = String(data: workoutData, encoding: .utf8) {
	print(workoutJsonString)
}
/*:
[Previous](@previous)  |  page 2 of 5  |  [Next: Exercise - Create a Protocol](@next)
 */
