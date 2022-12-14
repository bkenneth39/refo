//
//  TextAlert.swift
//  refo_watch
//
//  Created by Bryan Kenneth on 26/07/22.
//

import Foundation
import UIKit
import SwiftUI
import Combine


class TextFieldAlertViewController: UIViewController {
  @Environment(\.managedObjectContext) private var viewContext
  /// Presents a UIAlertController (alert style) with a UITextField and a `Done` button
  /// - Parameters:
  ///   - title: to be used as title of the UIAlertController
  ///   - message: to be used as optional message of the UIAlertController
  ///   - text: binding for the text typed into the UITextField
  ///   - isPresented: binding to be set to false when the alert is dismissed (`Done` button tapped)
    init(title: String, message: String?, text: Binding<String?>, isPresented: Binding<Bool>?, finish: @escaping (Binding<String>) -> Void) {
    self.alertTitle = title
    self.message = message
        self._text = text
    self.isPresented = isPresented
    self.finish = finish
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Dependencies
  private let alertTitle: String
  private let message: String?
    @Binding private var text: String?
  private var isPresented: Binding<Bool>?
    private var finish: (Binding<String>) -> Void?
  // MARK: - Private Properties
  private var subscription: AnyCancellable?

  // MARK: - Lifecycle
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    presentAlertController()
  }

  private func presentAlertController() {
    guard subscription == nil else { return } // present only once

    let vc = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)

    // add a textField and create a subscription to update the `text` binding
    vc.addTextField { [weak self] textField in
      guard let self = self else { return }
      self.subscription = NotificationCenter.default
        .publisher(for: UITextField.textDidChangeNotification, object: textField)
        .map { (($0.object as? UITextField)?.text)! }
        .assign(to: \.text, on: self)
    }

    // create a `Done` action that updates the `isPresented` binding when tapped
    // this is just for Demo only but we should really inject
    // an array of buttons (with their title, style and tap handler)
      let action = UIAlertAction(title: "Done", style: .default) { [weak self] _ in
          print(self!.$text)
//          let textToAdd =
          self?.finish(Binding(self!.$text) ?? .constant(""))
    }
    let action2 = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
        self?.isPresented?.wrappedValue = false
    }
    vc.addAction(action)
      vc.addAction(action2)
    present(vc, animated: true, completion: nil)
  }
}






