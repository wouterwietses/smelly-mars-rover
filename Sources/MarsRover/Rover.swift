class RoverState {
    var xCoordinate: Int = 0
    var yCoordinate: Int = 0
    var heading: Character = "N"
}

class Rover {
    private var roverState = RoverState()

    init(_ startingPosition: String = "") {
        let splitStartingPosition = startingPosition.split(separator: " ")
        if splitStartingPosition.count >= 3 {
            roverState.xCoordinate = Int(splitStartingPosition[0]) ?? 0
            roverState.yCoordinate = Int(splitStartingPosition[1]) ?? 0
            roverState.heading = splitStartingPosition[2].first ?? "N"
        }
    }

    func go(_ instructions: String) {
        for c in instructions {
            switch c {
            case "L":
                switch roverState.heading {
                case "E": roverState.heading = "N"
                case "N": roverState.heading = "W"
                case "W": roverState.heading = "S"
                case "S": roverState.heading = "E"
                default: break
                }
            case "R":
                switch roverState.heading {
                case "E": roverState.heading = "S"
                case "S": roverState.heading = "W"
                case "W": roverState.heading = "N"
                case "N": roverState.heading = "E"
                default: break
                }
            case "M":
                switch roverState.heading {
                case "E": roverState.xCoordinate += 1
                case "S": roverState.yCoordinate -= 1
                case "W": roverState.xCoordinate -= 1
                case "N": roverState.yCoordinate += 1
                default: break
                }
            default:
                break
            }
        }
    }

    func g(_ z: Character) {
        go(String(z))
    }

    func pos() -> String {
        "\(roverState.xCoordinate) \(roverState.yCoordinate) \(roverState.heading)"
    }
}
