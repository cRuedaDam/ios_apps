import Foundation
import Combine
import SwiftUI

struct Empleado: Codable, Identifiable {
    let id: Int
    let firstName, lastName, email: String
    let gender: Gender
    let address, job: String
    let avatar: URL

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email, gender, address
        case job = "Job"
        case avatar
    }
}

enum Gender: String, Codable {
    case agender = "Agender"
    case bigender = "Bigender"
    case female = "Female"
    case genderfluid = "Genderfluid"
    case genderqueer = "Genderqueer"
    case male = "Male"
    case nonBinary = "Non-binary"
    case polygender = "Polygender"
}

class EmpleadosModel:ObservableObject {
    @Published var empleados : [Empleado]
    
    init() {
        guard let url = Bundle.main.url(forResource: "EMPLEADOS", withExtension: "json") else{
            empleados = []
            return
        }
        do{
            let data = try Data (contentsOf: url)
            empleados = try JSONDecoder().decode([Empleado].self, from: data)
        }catch{
            print("Error en la carga \(error)")
            empleados = []
        }        
    }
}

class NetworkModel:ObservableObject {
    @Published var avatar = Image(systemName: "person.fill")
    var subscriber = Set<AnyCancellable>()
    
    func getImage(url:URL){
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .compactMap { UIImage(data: $0) }
            .map { Image(uiImage: $0) }
            .replaceEmpty(with: Image(systemName: "person.fill"))
            .replaceError(with: Image(systemName: "person.fill"))
            .assign(to: \.avatar, on: self)
            .store(in: &subscriber)
    }
}

