//
//  SimpleToastModifier.swift
//  
//
//  Created by Martin Lukacs on 09/07/2023.
//

import SwiftUI

public struct SimpleToastModifier: ViewModifier {
    @Binding var toast: SimpleToast?

    ///Tap to dismiss alert
    @State var tapToDismiss: Bool = true

    let offsetY: CGFloat

    ///Completion block returns `true` after dismiss
    var onTap: (() -> ())? = nil
    var completion: (() -> ())? = nil

    @State private var workItem: DispatchWorkItem?

    @ViewBuilder
    public func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                mainContainer
                    .animation(.spring(), value: toast)
                    .onTapGesture {
                        onTap?()
                        if tapToDismiss {
                            dismissAlert()
                        }
                    }
                    .onDisappear {
                        completion?()
                    }
            )
            .onChange(of: toast) { value in
              showToast()
            }
    }
}

private extension SimpleToastModifier {
    @ViewBuilder
    var mainContainer: some View{
        if let toast {
            switch toast.displayMode {
            case .center:
                VStack{
                    Spacer()
                    toast
                        .offset(y: offsetY)
                    Spacer()
                }
                .transition(AnyTransition.scale(scale: 0.8).combined(with: .opacity))
            case .top:
                VStack{
                    toast
                        .offset(y: offsetY)
                    Spacer()
                }
                .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
            case .bottom:
                VStack {
                    Spacer()
                    toast
                        .offset(y: offsetY)
                }
                .transition(toast.displayMode == .bottom(.slide) ? AnyTransition.slide : AnyTransition.move(edge: .bottom))
            }
        }
    }

    func showToast() {
        guard let toast, workItem == nil else {
            return
        }

        UIImpactFeedbackGenerator(style: .light)
            .impactOccurred()

        guard toast.type != .loading else {
            tapToDismiss = false
            return
        }

        if toast.duration > 0 {
            workItem?.cancel()

            let task = DispatchWorkItem {
                dismissAlert()
            }
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }

    func dismissAlert() {
        withAnimation {
            workItem?.cancel()
            workItem = nil
            toast = nil
        }
    }
}
