import Foundation

enum AppConfiguration: CaseIterable {
    
    static var allCases: [AppConfiguration] {
        return [.exampleOne("https://swapi.dev/api/people/8"),
                .exampleTwo("https://swapi.dev/api/people/3"),
                .exampleThree("https://swapi.dev/api/people/5")]
    }
    
    case exampleOne(String)
    case exampleTwo(String)
    case exampleThree(String)
}
