import Testing

@testable import MarsRover

@Suite("Make sure that rover follows command")
struct RoverTests {
    @Test(
        "expect directions to be followed from staring postion",
        arguments: [
            (startingPosition: "1 2 N", instructions: " ", expectedOutput: "1 2 N"),
            (startingPosition: "1 2 N", instructions: "L", expectedOutput: "1 2 W"),
            (startingPosition: "1 2 W", instructions: "L", expectedOutput: "1 2 S"),
            (startingPosition: "1 2 S", instructions: "L", expectedOutput: "1 2 E"),
            (startingPosition: "1 2 E", instructions: "L", expectedOutput: "1 2 N"),
            (startingPosition: "1 2 N", instructions: "R", expectedOutput: "1 2 E"),
            (startingPosition: "1 2 E", instructions: "R", expectedOutput: "1 2 S"),
            (startingPosition: "1 2 S", instructions: "R", expectedOutput: "1 2 W"),
            (startingPosition: "1 2 W", instructions: "R", expectedOutput: "1 2 N"),
            (startingPosition: "1 2 N", instructions: "M", expectedOutput: "1 3 N"),
            (startingPosition: "1 2 E", instructions: "M", expectedOutput: "2 2 E"),
            (startingPosition: "1 2 S", instructions: "M", expectedOutput: "1 1 S"),
            (startingPosition: "1 2 W", instructions: "M", expectedOutput: "0 2 W"),
            (startingPosition: "1 2 N", instructions: "LMLMLMLMM", expectedOutput: "1 3 N"),
            (startingPosition: "3 3 E", instructions: "MMRMMRMRRM", expectedOutput: "5 1 E")
        ]
    )
    func testRoverMovements(startingPosition: String, instructions: String, expectedOutput: String) {
        let rover = Rover(startingPosition)
        rover.go(instructions)
        #expect(
            rover.pos() == expectedOutput,
            "Failed for starting position: \(startingPosition), instructions: \(instructions)"
        )
    }
}
