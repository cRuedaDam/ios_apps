import SwiftUI

struct EmpleadosView: View {
    @EnvironmentObject var empleados:EmpleadosModel
    
    var body: some View {
        NavigationView {
            List{
                ForEach(empleados.empleados){ empleado in
                    EmpleadoRow(empleado:empleado)
                }
            }
            .listStyle(InsetListStyle())
            .navigationTitle("Empleados")
            .navigationBarItems(trailing:
                Button (action: {
                },
                label: {
                Image(systemName: "plus")
                })
            )
        }
    }
}

struct EmpleadosView_Previews: PreviewProvider {
    static var previews: some View {
        EmpleadosView()
            .environmentObject(EmpleadosModel())
    }
}

struct EmpleadoRow: View {
    let empleado:Empleado
    @ObservedObject var imagenEmpleado = NetworkModel()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text("\(empleado.firstName) \(empleado.lastName)")
                    .font(.headline)
                Text("\(empleado.job)")
                    .font(.footnote)
                Text("\(empleado.email)")
                    .font(.caption)
            }
            Spacer()
            imagenEmpleado.avatar
                .resizable()
                .frame(width: 30, height: 30)
        }
        .onAppear{
            imagenEmpleado.getImage(url: empleado.avatar)
        }
    }
}
