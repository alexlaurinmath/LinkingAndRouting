import Foundation
import SwiftUI

struct Router {

  enum screens: String {
    case screen1

    func view() -> some View {
      switch self {
        case .screen1: return ContentView2()
      }
    }
  }
}
