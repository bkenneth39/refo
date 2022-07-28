import Foundation
import SwiftUI
import UIKit

struct TextFieldWrapper<PresentingView: View>: View {

  @Binding var isPresented: Bool
  let presentingView: PresentingView
  let content: () -> TextFieldAlert

  var body: some View {
    ZStack {
      if (isPresented) { content().dismissable($isPresented) }
      presentingView
    }
  }
}

extension View {
  func textFieldAlert(isPresented: Binding<Bool>,
                      content: @escaping () -> TextFieldAlert) -> some View {
    TextFieldWrapper(isPresented: isPresented,
                     presentingView: self,
                     content: content)
  }
}
