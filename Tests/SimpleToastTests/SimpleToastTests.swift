import Testing
import SwiftUI
@testable import SimpleToast

struct SimpleToastTests {
    @Test func equalityIsIdentityBased() {
        let first = SimpleToast(id: "1", title: "A title")
        let sameId = SimpleToast(id: "1", title: "Another title")
        let other = SimpleToast(id: "2", title: "A title")

        #expect(first == sameId)
        #expect(first != other)
    }

    @Test func displayModeAlignment() {
        #expect(DisplayMode.top.alignment == .top)
        #expect(DisplayMode.center.alignment == .center)
        #expect(DisplayMode.bottom(.pop).alignment == .bottom)
    }

    @Test func toastTypeIdentifiers() {
        #expect(ToastType.complete(.green).id == "complete")
        #expect(ToastType.error(.red).id == "error")
        #expect(ToastType.image(Image(systemName: "photo")).id == "image")
        #expect(ToastType.loading.id == "loading")
        #expect(ToastType.regular.id == "regular")
    }

    @Test func equalToastTypesHashEqually() {
        #expect(ToastType.complete(.green).hashValue == ToastType.complete(.green).hashValue)
        #expect(ToastType.loading.hashValue == ToastType.loading.hashValue)
    }

    @Test func defaultConfiguration() {
        let configuration = ToastConfiguration.default

        #expect(configuration.type == .regular)
        #expect(configuration.duration == 2)
        #expect(configuration.hapticFeedback)
    }
}
