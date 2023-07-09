//
//  ContentView.swift
//  DemoSimpleToast
//
//  Created by Martin Lukacs on 08/07/2023.
//

import SwiftUI
import SimpleToast

struct ContentView: View {
    @State private var toastToDisplay: SimpleToast?
    @State private var showToast = false

    var body: some View {
        VStack(spacing: 10) {


            Button("Show top Toast"){
                toastToDisplay = SimpleToast(displayMode: .top,
                                             type: .complete(.blue),
                                             title: "second toast this is a revylong tesxt againga aginga aigna ainag ainga ainag ainag ain againg a ",
                duration: 4)
                showToast.toggle()
            }
            .buttonStyle(.bordered)
            .padding()

            Button("Show centered Toast") {
                toastToDisplay = SimpleToast(displayMode: .center,
                                                               type: .regular,
               title: "First toast")
            }
            .buttonStyle(.bordered)
            .padding()

            Button("Show bottom Toast") {
                toastToDisplay = SimpleToast(displayMode: .bottom(.slide),
                                             type: .error(.red),
                                             title: "third toast"
                ,duration: 1)
            }
            .buttonStyle(.bordered)
            .padding()
        }
        .padding()
        .toast(toast: $toastToDisplay)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
