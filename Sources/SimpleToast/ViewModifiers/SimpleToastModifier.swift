//
//  SimpleToastModifier.swift
//  
//
//  Created by Martin Lukacs on 09/07/2023.
//

import SwiftUI

public struct SimpleToastModifier: ViewModifier {
    @Binding private var toast: SimpleToast?

    private let tapToDismiss: Bool
    private let onTap: (() -> Void)?

    ///Completion block called after dismiss
    private let completion: (() -> Void)?

    init(toast: Binding<SimpleToast?>,
         tapToDismiss: Bool = true,
         onTap: (() -> Void)? = nil,
         completion: (() -> Void)? = nil) {
        self._toast = toast
        self.tapToDismiss = tapToDismiss
        self.onTap = onTap
        self.completion = completion
    }

    public func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: toast?.displayMode.alignment ?? .bottom) {
                mainContainer
                    .animation(.easeInOut, value: toast)
                    .onTapGesture {
                        onTap?()
                        if canTapToDismiss {
                            dismissToast()
                        }
                    }
                    .onDisappear {
                        completion?()
                    }
            }
            .sensoryFeedback(trigger: toast) { _, newToast in
                guard let newToast, newToast.configuration.hapticFeedback else {
                    return nil
                }
#if os(macOS)
                return .alignment
#else
                return .impact(weight: .light)
#endif
            }
            .task(id: toast) {
                await dismissAfterDuration()
            }
    }
}

private extension SimpleToastModifier {
    @ViewBuilder
    var mainContainer: some View {
        if let toast {
            toast.body
                .offset(y: toast.offsetY)
                .transition(toast.displayMode.transition)
        }
    }

    /// Loading toasts can only be dismissed programmatically or by their duration.
    var canTapToDismiss: Bool {
        tapToDismiss && toast?.configuration.type != .loading
    }

    func dismissAfterDuration() async {
        guard let toast, toast.configuration.duration > 0 else {
            return
        }

        try? await Task.sleep(for: .seconds(toast.configuration.duration))

        guard !Task.isCancelled else {
            return
        }
        dismissToast()
    }

    func dismissToast() {
        withAnimation {
            toast = nil
        }
    }
}
