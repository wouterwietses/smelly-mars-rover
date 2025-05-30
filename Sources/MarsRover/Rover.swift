class RoverState {
    var xCoordinate: Int = 0
    var yCoordinate: Int = 0
    var heading: Character = "N"
}

class Rover {
    private var rs = RoverState()

    init(_ p: String = "") {
        let s = p.split(separator: " ")
        if s.count >= 3 {
            rs.xCoordinate = Int(s[0]) ?? 0
            rs.yCoordinate = Int(s[1]) ?? 0
            rs.heading = s[2].first ?? "N"
        }
    }

    func go(_ cms: String) {
        for c in cms {
            switch c {
            case "L":
                switch rs.heading {
                case "E": rs.heading = "N"
                case "N": rs.heading = "W"
                case "W": rs.heading = "S"
                case "S": rs.heading = "E"
                default: break
                }
            case "R":
                switch rs.heading {
                case "E": rs.heading = "S"
                case "S": rs.heading = "W"
                case "W": rs.heading = "N"
                case "N": rs.heading = "E"
                default: break
                }
            case "M":
                switch rs.heading {
                case "E": rs.xCoordinate += 1
                case "S": rs.yCoordinate -= 1
                case "W": rs.xCoordinate -= 1
                case "N": rs.yCoordinate += 1
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
        "\(rs.xCoordinate) \(rs.yCoordinate) \(rs.heading)"
    }
}
