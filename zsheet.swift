import Foundation
import SwiftUI


private struct ZSheet<T: View>: ViewModifier {
    @Binding var isPresented: Bool
    @ViewBuilder let presentedView: () -> T
    
    init(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> T) {
        self._isPresented = isPresented
        self.presentedView = content
    }
    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                presentedView()
            }
        }
    }
}

private struct ZSheetItem<Item: Identifiable, T: View>: ViewModifier {
    @Binding var item: Item?
    @ViewBuilder let presentedView: () -> T
    
    init(item: Binding<Item?>, @ViewBuilder content: @escaping () -> T) {
        self._item = item
        self.presentedView = content
    }
    func body(content: Content) -> some View {
        ZStack {
            content
            if let item = item {
                presentedView()
            }
        }
    }
}


extension View {
    
    public func zSheet<Item, Content>(item: Binding<Item?>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping (Item) -> Content) -> some View where Item : Identifiable, Content : View {
        modifier(ZSheetItem(item: item, content: {
            if let value = item.wrappedValue {
                content(value)
                    .toolbar(.hidden, in: .tabBar)
                    .zIndex(100)
            }
        }))
    }

    func zSheet<Content>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View where Content: View {
        modifier(ZSheet(isPresented: isPresented, content: content))
    }
}
