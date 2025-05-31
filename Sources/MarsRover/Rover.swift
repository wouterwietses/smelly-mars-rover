enum Heading: Character {
    case north = "N"
    case east = "E"
    case south = "S"
    case west = "W"
}

struct Coordinate {
    private let defaultXCoordinate = 0
    private let defaultYCoordinate = 0
    // swiftlint:disable identifier_name
    private var x: Int
    private var y: Int
    // swiftlint:enable identifier_name

    init(xCoordinate: String.SubSequence, yCoordinate: String.SubSequence) {
        x = Int(xCoordinate) ?? defaultXCoordinate
        y = Int(yCoordinate) ?? defaultYCoordinate
    }

    mutating func move(to heading: Heading) {
        switch heading {
        case .east:
            x += 1
        case .south:
            y -= 1
        case .west:
            x -= 1
        case .north:
            y += 1
        }
    }

    func position() -> String {
        "\(x) \(y)"
    }
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

    private var coordinate: Coordinate
    private var heading: Heading

    init(startingPosition: String) {
        let splitStartingPosition = startingPosition.split(separator: startingPositionSeparator)

        coordinate = Coordinate(
            xCoordinate: splitStartingPosition[xCoordinatePosition],
            yCoordinate: splitStartingPosition[yCoordinatePostion]
        )

        heading =
            Heading(
                rawValue: splitStartingPosition[headingPosition].first ?? Heading.north.rawValue
            ) ?? .north
    }

    func turnLeft() {
        heading = leftRotationMap[heading]!
    }

    func turnRight() {
        heading = rightRotationMap[heading]!
    }

    func move() {
        coordinate.move(to: heading)
    }

    func currentPosition() -> String {
        "\(coordinate.position()) \(heading.rawValue)"
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
