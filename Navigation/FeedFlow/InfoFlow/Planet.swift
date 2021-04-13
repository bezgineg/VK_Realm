
import Foundation

struct Planet: Decodable {
    let orbitalPeriod: String
    let residents: [String]
    
    enum CodingKeys: String, CodingKey {
        case orbitalPeriod = "orbital_period"
        case residents = "residents"
    }
}

struct Resident: Decodable {
    let name: String
}

