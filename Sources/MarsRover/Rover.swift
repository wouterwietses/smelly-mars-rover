enum Heading: Character {
    case north = "N"
    case east = "E"
    case south = "S"
    case west = "W"
}

struct Coordinate {
    // swiftlint:disable identifier_name
    private var x: Int
    private var y: Int

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    // swiftlint:enable identifier_name

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

enum StartingPositionParser {
    private static let defaultXCoordinate = 0
    private static let defaultYCoordinate = 0

    private static let startingPositionSeparator: Character = " "
    private static let xCoordinatePosition = 0
    private static let yCoordinatePostion = 1
    private static let headingPosition = 2

    static func parse(startingPosition: String) -> (coordinate: Coordinate, heading: Heading) {
        let splitStartingPosition = startingPosition.split(separator: startingPositionSeparator)

        let coordinate = Coordinate(
            x: Int(splitStartingPosition[xCoordinatePosition]) ?? defaultXCoordinate,
            y: Int(splitStartingPosition[yCoordinatePostion]) ?? defaultYCoordinate
        )

        let heading =
            Heading(
                rawValue: splitStartingPosition[headingPosition].first ?? Heading.north.rawValue
            ) ?? .north

        return (coordinate, heading)
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

    private var coordinate: Coordinate
    private var heading: Heading

    init(startingPosition: String) {
        let parsedStartingPosition = StartingPositionParser.parse(
            startingPosition: startingPosition)

        coordinate = parsedStartingPosition.coordinate
        heading = parsedStartingPosition.heading
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
