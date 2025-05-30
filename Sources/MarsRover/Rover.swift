private let headingNorth: Character = "N"
private let headingEast: Character = "E"
private let headingSouth: Character = "S"
private let headingWest: Character = "W"

private let defaultXCoordinate = 0
private let defaultYCoordinate = 0

class RoverState {
    var xCoordinate: Int = defaultXCoordinate
    var yCoordinate: Int = defaultYCoordinate
    var heading: Character = headingNorth
}

class Rover {
    private let startingPositionSeparator: Character = " "
    private let xCoordinatePosition = 0
    private let yCoordinatePostion = 1
    private let headingPosition = 2

    private let turnLeftCommand: Character = "L"
    private let turnRightCommand: Character = "R"
    private let moveCommand: Character = "M"

    private var roverState = RoverState()

    init(_ startingPosition: String = "") {
        let splitStartingPosition = startingPosition.split(separator: startingPositionSeparator)
        if splitStartingPosition.count >= 3 {
            roverState.xCoordinate =
                Int(splitStartingPosition[xCoordinatePosition]) ?? defaultXCoordinate
            roverState.yCoordinate =
                Int(splitStartingPosition[yCoordinatePostion]) ?? defaultYCoordinate
            roverState.heading = splitStartingPosition[headingPosition].first ?? headingNorth
        }
    }

    func go(_ instructions: String) {
        for command in instructions {
            switch command {
            case turnLeftCommand:
                switch roverState.heading {
                case headingEast: roverState.heading = headingNorth
                case headingNorth: roverState.heading = headingWest
                case headingWest: roverState.heading = headingSouth
                case headingSouth: roverState.heading = headingEast
                default: break
                }
            case turnRightCommand:
                switch roverState.heading {
                case headingEast: roverState.heading = headingSouth
                case headingSouth: roverState.heading = headingWest
                case headingWest: roverState.heading = headingNorth
                case headingNorth: roverState.heading = headingEast
                default: break
                }
            case moveCommand:
                switch roverState.heading {
                case headingEast: roverState.xCoordinate += 1
                case headingSouth: roverState.yCoordinate -= 1
                case headingWest: roverState.xCoordinate -= 1
                case headingNorth: roverState.yCoordinate += 1
                default: break
                }
            default:
                break
            }
        }
    }

    func pos() -> String {
        "\(roverState.xCoordinate) \(roverState.yCoordinate) \(roverState.heading)"
    }
}
