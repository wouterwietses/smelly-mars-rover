private let headingNorth: Character = "N"
private let headingEast: Character = "E"
private let headingSouth: Character = "S"
private let headingWest: Character = "W"

private let defaultXCoordinate = 0
private let defaultYCoordinate = 0

class RoverState {
    private let startingPositionSeparator: Character = " "
    private let xCoordinatePosition = 0
    private let yCoordinatePostion = 1
    private let headingPosition = 2

    private var xCoordinate: Int = defaultXCoordinate
    private var yCoordinate: Int = defaultYCoordinate
    var heading: Character = headingNorth

    init(startingPosition: String) {
        let splitStartingPosition = startingPosition.split(separator: startingPositionSeparator)
        if splitStartingPosition.count >= 3 {
            xCoordinate =
                Int(splitStartingPosition[xCoordinatePosition]) ?? defaultXCoordinate
            yCoordinate =
                Int(splitStartingPosition[yCoordinatePostion]) ?? defaultYCoordinate
            heading = splitStartingPosition[headingPosition].first ?? headingNorth
        }
    }

    func move() {
        switch heading {
        case headingEast: xCoordinate += 1
        case headingSouth: yCoordinate -= 1
        case headingWest: xCoordinate -= 1
        case headingNorth: yCoordinate += 1
        default: break
        }
    }

    func currentPosition() -> String {
        "\(xCoordinate) \(yCoordinate) \(heading)"
    }
}

class Rover {
    private let turnLeftCommand: Character = "L"
    private let turnRightCommand: Character = "R"
    private let moveCommand: Character = "M"

    private let roverState: RoverState

    init(_ startingPosition: String = "") {
        roverState = RoverState(startingPosition: startingPosition)
    }

    func go(_ instructions: String) {
        for command in instructions {
            switch command {
            case turnLeftCommand:
                executeTurnLeftCommand()
            case turnRightCommand:
                executeTurnRightCommand()
            case moveCommand:
                roverState.move()
            default:
                break
            }
        }
    }

    private func executeTurnLeftCommand() {
        switch roverState.heading {
        case headingEast: roverState.heading = headingNorth
        case headingNorth: roverState.heading = headingWest
        case headingWest: roverState.heading = headingSouth
        case headingSouth: roverState.heading = headingEast
        default: break
        }
    }

    private func executeTurnRightCommand() {
        switch roverState.heading {
        case headingEast: roverState.heading = headingSouth
        case headingSouth: roverState.heading = headingWest
        case headingWest: roverState.heading = headingNorth
        case headingNorth: roverState.heading = headingEast
        default: break
        }
    }

    func pos() -> String {
        roverState.currentPosition()
    }
}
