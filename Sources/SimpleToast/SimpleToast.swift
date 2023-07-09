import SwiftUI

public struct SimpleToast: View, Equatable {

    ///The display mode
    /// - `top`
    /// - `center`
    /// - `bottom`
    let displayMode: DisplayMode

    ///What the alert would show
    ///`complete`, `error`, `systemImage`, `image`, `loading`, `regular`
    var type: ToastType

    ///The title of the alert (`Optional(String)`)
    let title: String?

    ///The subtitle of the alert (`Optional(String)`)
    let subTitle: String?

    ///Duration time to display the alert
    let duration: TimeInterval

    ///Customize your alert appearance
     let style: ToastStyle?


    ///Full init
    public init(displayMode: DisplayMode = .center,
                type: ToastType,
                title: String? = nil,
                subTitle: String? = nil,
                duration: TimeInterval = 2,
                style: ToastStyle? = nil) {
        self.displayMode = displayMode
        self.type = type
        self.title = title
        self.subTitle = subTitle
        self.duration = duration
        self.style = style
    }

    ///Body init determine by `displayMode`
    public var body: some View {
        switch displayMode{
        case .center:
            centeredToastView
        case .top:
            topToastView
        case .bottom:
            bottomToastView
        }
    }
}

private extension SimpleToast {
    ///Alert View
    var centeredToastView: some View {
        VStack {
            switch type {
            case .complete(let color):
                Spacer()
                Image(systemName: "checkmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(color)
                    .frame(width: 50, height: 50, alignment: .center)
                Spacer()
            case .error(let color):
                Spacer()
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(color)
                    .frame(width: 50, height: 50, alignment: .center)
                Spacer()
            case .systemImage(let name, let color):
                Spacer()
                Image(systemName: name)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .foregroundColor(color)
                    .padding(.bottom)
                Spacer()
            case .image(let name, let color):
                Spacer()
                Image(name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .foregroundColor(color)
                    .padding(.bottom)
                Spacer()
            case .loading:
                ProgressView()
            case .regular:
                EmptyView()
            }

            VStack(spacing: type == .regular ? 8 : 2) {
                if let title {
                    Text(LocalizedStringKey(title))
                        .font(style?.titleFont ?? Font.body.bold())
                        .textColor(style?.titleColor ?? nil)
                }
                if let subTitle {
                    Text(LocalizedStringKey(subTitle))
                        .font(style?.subTitleFont ?? Font.footnote)
                        .opacity(0.7)
                        .textColor(style?.subtitleColor ?? nil)
                }
            }
        }
        .multilineTextAlignment(.center)
        .padding()
        .withFrame(type != .regular && type != .loading)
        .toastBackground(style?.backgroundColor ?? nil)
        .cornerRadius(10)
    }

    ///Top View
     var topToastView: some View {
        Group {
            HStack(spacing: 16){
                switch type {
                case .complete(let color):
                    Image(systemName: "checkmark")
                        .topDisplayModifier
                        .foregroundColor(color)
                case .error(let color):
                    Image(systemName: "xmark")
                        .topDisplayModifier
                        .foregroundColor(color)
                case .systemImage(let name, let color):
                    Image(systemName: name)
                        .topDisplayModifier
                        .foregroundColor(color)
                case .image(let name, let color):
                    Image(name)
                        .topDisplayModifier
                        .foregroundColor(color)
                case .loading:
                    ProgressView()
                case .regular:
                    EmptyView()
                }

                VStack(alignment: type == .regular ? .center : .leading, spacing: 2)  {
                    if let title {
                        Text(LocalizedStringKey(title))
                            .font(style?.titleFont ?? Font.body.bold())
                            .textColor(style?.titleColor ?? nil)
                    }
                    if let subTitle {
                        Text(LocalizedStringKey(subTitle))
                            .font(style?.subTitleFont ?? Font.footnote)
                            .opacity(0.7)
                            .textColor(style?.subtitleColor ?? nil)
                    }
                }
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, 24)
            .padding(.vertical, 8)
            .frame(minHeight: 50)
            .toastBackground(style?.backgroundColor ?? nil)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(style?.borderColor ?? Color.gray.opacity(0.2), lineWidth: 1))
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 6)
            .compositingGroup()
        }
        .padding(.top)
    }

    ///Bottom of the view
     var bottomToastView: some View {
        VStack {
            Spacer()

            //Banner view starts here
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    switch type {
                    case .complete(let color):
                        Image(systemName: "checkmark")
                            .foregroundColor(color)
                    case .error(let color):
                        Image(systemName: "xmark")
                            .foregroundColor(color)
                    case .systemImage(let name, let color):
                        Image(systemName: name)
                            .foregroundColor(color)
                    case .image(let name, let color):
                        Image(name)
                            .renderingMode(.template)
                            .foregroundColor(color)
                    case .loading:
                        ProgressView()
                    case .regular:
                        EmptyView()
                    }

                    Text(LocalizedStringKey(title ?? ""))
                        .font(style?.titleFont ?? Font.headline.bold())
                }

                if let subTitle {
                    Text(LocalizedStringKey(subTitle))
                        .font(style?.subTitleFont ?? Font.subheadline)
                }
            }
            .multilineTextAlignment(.leading)
            .textColor(style?.titleColor ?? nil)
            .padding()
            .frame(maxWidth: 400, alignment: .leading)
            .toastBackground(style?.backgroundColor ?? nil)
            .cornerRadius(10)
            .padding([.horizontal, .bottom])
        }
    }
}
