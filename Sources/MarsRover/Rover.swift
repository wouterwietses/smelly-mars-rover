private let defaultXCoordinate = 0
private let defaultYCoordinate = 0

enum Heading: Character {
    case north = "N"
    case east = "E"
    case south = "S"
    case west = "W"
}

class RoverState {
    private let leftRotationMap: [Heading: Heading] = [
        .east: .north,
        .north: .west,
        .west: .south,
        .south: .east
    ]

    private let rightRotationMap: [Heading: Heading] = [
        .east: .south,
        .south: .west,
        .west: .north,
        .north: .east
    ]

    private let startingPositionSeparator: Character = " "
    private let xCoordinatePosition = 0
    private let yCoordinatePostion = 1
    private let headingPosition = 2

    private var xCoordinate: Int = defaultXCoordinate
    private var yCoordinate: Int = defaultYCoordinate
    private var heading: Heading = .north

    init(startingPosition: String) {
        let splitStartingPosition = startingPosition.split(separator: startingPositionSeparator)
        if splitStartingPosition.count >= 3 {
            xCoordinate =
                Int(splitStartingPosition[xCoordinatePosition]) ?? defaultXCoordinate
            yCoordinate =
                Int(splitStartingPosition[yCoordinatePostion]) ?? defaultYCoordinate
            heading =
                Heading(
                    rawValue: splitStartingPosition[headingPosition].first ?? Heading.north.rawValue
                ) ?? .north
        }
    }

    func turnLeft() {
        heading = leftRotationMap[heading]!
    }

    func turnRight() {
        heading = rightRotationMap[heading]!
    }

    func move() {
        switch heading {
        case .east: xCoordinate += 1
        case .south: yCoordinate -= 1
        case .west: xCoordinate -= 1
        case .north: yCoordinate += 1
        }
    }

    func currentPosition() -> String {
        "\(xCoordinate) \(yCoordinate) \(heading.rawValue)"
    }
}

class Rover {
    private let roverState: RoverState

    init(_ startingPosition: String = "") {
        roverState = RoverState(startingPosition: startingPosition)
    }

    func go(_ instructions: String) {
        instructions
            .compactMap { Command(rawValue: $0) }
            .forEach { [weak self] command in
                switch command {
                case .left:
                    self?.roverState.turnLeft()
                case .right:
                    self?.roverState.turnRight()
                case .move:
                    self?.roverState.move()
                }
            }
    }

    func pos() -> String {
        roverState.currentPosition()
    }
}

enum Command: Character {
    case left = "L"
    case right = "R"
    case move = "M"
}
