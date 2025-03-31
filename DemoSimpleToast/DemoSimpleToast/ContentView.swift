//
//  ContentView.swift
//  DemoSimpleToast
//
//  Created by Martin Lukacs on 08/07/2023.
//

import SwiftUI
import SimpleToast

struct ContentView: View {
    var body: some View {
        TabView {
            ToastCreatorView()
                       .tabItem {
                           Label("Menu", systemImage: "list.dash")
                       }

                   Text("Test")
                       .tabItem {
                           Label("Order", systemImage: "square.and.pencil")
                       }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

import SwiftUI
import PhotosUI

struct ToastCreatorView: View {
    @State private var toastToDisplay: SimpleToast?

    // Image picker state
    @State private var selectedImage: Image?
    @State private var imageSelection: PhotosPickerItem?
    
    // Color states
    @State private var completeColor: Color = .green
    @State private var errorColor: Color = .red
    @State private var backgroundColor: Color = .blue
    @State private var titleColor: Color = .primary
    @State private var subtitleColor: Color = .secondary
    
    @State private var title: String? = "This is a title"
    @State private var subTitle: String? = "This is a subtitle"
    @State private var type: ToastType = .regular
    @State private var duration: TimeInterval = 2
    @State private var hapticFeedback = true
    
    // Shape selection
    @State private var selectedShapeIndex = 0
    let shapes: [any Shape] = [
        Capsule(),
        RoundedRectangle(cornerRadius: 12),
        RoundedRectangle(cornerRadius: 0),
        Circle()
    ]
    
    // Display mode
    @State private var displayMode: DisplayMode = .bottom(.pop)
    
    var body: some View {
        NavigationStack {
            Form {          
                // Content Section
                Section("Content") {
                    TextField("Title", text: Binding(
                        get: { title ?? "" },
                        set: { title = $0.isEmpty ? nil : $0 }
                    ))
                    
                    TextField("Subtitle", text: Binding(
                        get: { subTitle ?? "" },
                        set: { subTitle = $0.isEmpty ? nil : $0 }
                    ))
                }
                
                // Type Selection
                Section("Toast Type") {
                    Picker("Type", selection: $type) {
                        Text("Regular").tag(ToastType.regular)
                        Text("Complete").tag(ToastType.complete(completeColor))
                        Text("Error").tag(ToastType.error(errorColor))
                        Text("Image").tag(ToastType.image(selectedImage ?? Image(systemName: "photo")))
                        Text("Loading").tag(ToastType.loading)
                    }
                    .pickerStyle(.segmented)
                    
                    // Conditional controls based on type
                    if case .complete = type {
                        ColorPicker("Complete Color", selection: $completeColor)
                    }
                    
                    if case .error = type {
                        ColorPicker("Error Color", selection: $errorColor)
                    }
                    
                    if case .image = type {
                        PhotosPicker("Select Image", selection: $imageSelection, matching: .images)
                            .onChange(of: imageSelection) {
                                Task {
                                    if let data = try? await imageSelection?.loadTransferable(type: Data.self),
                                       let uiImage = UIImage(data: data) {
                                        selectedImage = Image(uiImage: uiImage)
                                    }
                                }
                            }
                    }
                }
                
                // Display Configuration
                Section("Display Settings") {
                    Picker("Position", selection: $displayMode) {
                        Text("Top").tag(DisplayMode.top)
                        Text("Center").tag(DisplayMode.center)
                        Text("Bottom (Slide)").tag(DisplayMode.bottom(.slide))
                        Text("Bottom (Pop)").tag(DisplayMode.bottom(.pop))
                    }
                    
                    Stepper("Duration: \(duration.formatted())s",
                            value: $duration,
                            in: 1...10, step: 0.5)
                    
                    Toggle("Haptic Feedback", isOn: $hapticFeedback)
                }
                
                // Style Configuration
                Section("Style Options") {
                    Picker("Shape", selection: $selectedShapeIndex) {
                        Text("Capsule").tag(0)
                        Text("Rounded").tag(1)
                        Text("Rectangle").tag(2)
                        Text("Circle").tag(3)
                    }
                    
                    ColorPicker("Background", selection: $backgroundColor)
               
                    
                    ColorPicker("Title Color", selection: $titleColor)
               
                    
                    ColorPicker("Subtitle Color", selection: $subtitleColor)
               
                }
            }
            .navigationTitle("Toast Creator")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Show Toast") {
                        toastToDisplay = SimpleToast(displayMode: displayMode, configuration: configuration, title: title, subTitle: subTitle)
                    }
                }
            }

        }
        .toast(toast: $toastToDisplay)

    }
    
    private var configuration: ToastConfiguration {
        let displayStyle = ToastDisplayStyle(shape: shapes[selectedShapeIndex],
                                                          backgroundColor: backgroundColor,
                                                          titleColor: titleColor,
                                                          subtitleColor: subtitleColor)
       return ToastConfiguration(type: type, duration: duration, hapticFeedback: hapticFeedback, style: displayStyle)
    }
}

// Preview
#Preview {
    ToastCreatorView()
}
