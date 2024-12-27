
import SwiftUI

enum TypographyStyle {
    
    case headline
    case subheadline
    case title
    case title2
    case title3
    
    private var fontName: String {
        switch self {
        case .headline:
            return "Markazi Text"
            
        case .subheadline:
            return "Markazi Text"
            
        case .title:
            return "Karla"
            
        case .title2:
            return "Karla"
            
        case .title3:
            return "Karla"
            
        }
    }
    
    private var fontTextStyle: Font.TextStyle {
        switch self {
        case .headline:
            return .headline
            
        case .subheadline:
            return .subheadline
            
        case .title:
            return .title
            
            
        case .title2:
            return .title2
            
        case .title3:
            return .title3
        }
    }
    
    private var fontSize: CGFloat {
        switch self {
        case .headline:
            return 44
            
        case .subheadline:
            return 32
            
        case .title:
            return 24
            
        case .title2:
            return 20
            
        case .title3:
            return 16
            
        }
    }
    
    fileprivate func asFont() -> Font {
        Font.custom(fontName, size: fontSize, relativeTo: fontTextStyle)
    }
}

extension View {
    
    func typographyStyle(_ style: TypographyStyle) -> some View {
        font(style.asFont())
    }
}

extension Text {
    
    func typographyStyle(_ style: TypographyStyle) -> some View {
        font(style.asFont())
    }
}
