import SwiftUI

struct FavoritePin: View {
    let action: () -> Void
    
    var body: some View {
        
        Button {
            action()
        } label: {
            Image(systemName: "paperclip")
                .font(.system(size: 30))
                .rotationEffect(.init(degrees: -45))
                .frame(width: 80, height: 80)
        }
        .buttonStyle(.borderless)
    }
}

struct FavoritePin_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePin { }
    }
}
