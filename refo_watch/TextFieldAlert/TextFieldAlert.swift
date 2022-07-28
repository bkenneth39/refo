//
//  TextFieldAlert.swift
//  refo_watch
//
//  Created by Bryan Kenneth on 26/07/22.
//

import Foundation
import UIKit
import SwiftUI

struct TextFieldAlert {
    
  // MARK: Properties
  let title: String
  let message: String?
  @Binding var text: String?
  var isPresented: Binding<Bool>? = nil
    var finish: (Binding<String>) -> Void

    

  // MARK: Modifiers
  func dismissable(_ isPresented: Binding<Bool>) -> TextFieldAlert {
    TextFieldAlert(title: title, message: message, text: $text, isPresented: isPresented, finish: finish)
  }
}

extension TextFieldAlert: UIViewControllerRepresentable {

  typealias UIViewControllerType = TextFieldAlertViewController

  func makeUIViewController(context: UIViewControllerRepresentableContext<TextFieldAlert>) -> UIViewControllerType {
    TextFieldAlertViewController(title: title, message: message, text: $text, isPresented: isPresented, finish: finish)
  }

  func updateUIViewController(_ uiViewController: UIViewControllerType,
                              context: UIViewControllerRepresentableContext<TextFieldAlert>) {
    // no update needed
  }
}
