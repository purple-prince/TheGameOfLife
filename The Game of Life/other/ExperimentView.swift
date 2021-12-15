import SwiftUI

struct ExperimentView: View {
    
    @State private var showMessage = false

    var body: some View {
        ZStack {
            Color.yellow

            VStack {
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut) {
                        self.showMessage.toggle()
                    }
                }) {
                    Text("SHOW MESSAGE")
                }
            }

            if showMessage {
                Text("HELLO WORLD!")
                    .transition(.slide)
            }
        }
    }}

struct ExperimentView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentView()
    }
}
