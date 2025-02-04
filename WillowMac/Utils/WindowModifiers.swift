import SwiftUI

struct StandardWindowStyle: ViewModifier {
    static let defaultWidth: CGFloat = 1080
    static let defaultHeight: CGFloat = 720
    
    func body(content: Content) -> some View {
        content
            .frame(width: Self.defaultWidth, height: Self.defaultHeight)
            .background(WindowAccessor { window in
                window.styleMask.remove([.resizable, .fullScreen])
                window.isMovableByWindowBackground = true
                window.title = ""
                window.standardWindowButton(.zoomButton)?.isHidden = true
            })
    }
}

// Helper view to access NSWindow
struct WindowAccessor: NSViewRepresentable {
    let callback: (NSWindow) -> Void
    
    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            if let window = view.window {
                callback(window)
            }
        }
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {}
}

// Extension to make it easier to use
extension View {
    func standardWindowStyle() -> some View {
        modifier(StandardWindowStyle())
    }
} 