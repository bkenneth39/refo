//
//  SFSafariViewWrapper.swift
//  refo_watch
//
//  Created by Bryan Kenneth on 29/07/22.
//

import Foundation
import UIKit
import SwiftUI
import Combine
import SafariServices


struct SFSafariViewWrapper: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SFSafariViewWrapper>) {
        return
    }
}
