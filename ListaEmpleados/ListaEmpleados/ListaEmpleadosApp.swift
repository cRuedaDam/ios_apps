import SwiftUI

@main
struct ListaEmpleadosApp: App {
    @StateObject var empleados = EmpleadosModel()
    var body: some Scene {
        WindowGroup {
                EmpleadosView()
                    .environmentObject(empleados)
        }
    }
}
