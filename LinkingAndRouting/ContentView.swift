//
//  ContentView.swift
//  LinkingAndRouting
//
//  Created by Alexandre Laurin on 7/13/20.
//  Copyright © 2020 Alexandre Laurin. All rights reserved.
//

import SwiftUI

struct ContentView: View {

  @ObservedObject
  var viewModel = ContentViewModel()

  var body: some View {
    VStack {
      Text("Hello, World!")
        .padding()
      Button(action: {
        self.viewModel.clickedRedButton()
      }) {
        Text("Navigate to second screen.")
        .padding()
      }.background(Color.red)
      .padding()
      TextField("link", text: $viewModel.textLink)
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
      Button(action: {
        self.viewModel.clickedGreenButton()
      }) {
        Text("Navigate to linked screen.")
          .padding()
      }.background(Color.green)
        .padding()
    }.sheet(isPresented: $viewModel.showLink) {
      self.viewModel.linkedView
    }
  }
}

class ContentViewModel: ObservableObject {

  @Published
  var linkedView: AnyView?

  @Published
  var showLink: Bool = false

  @Published
  var textLink: String = ""

  func clickedRedButton() {
    linkedView = AnyView(Router.screens.screen1.view())
    showLink = true
  }

  func clickedGreenButton() {
    guard let screen = Router.screens.init(rawValue: textLink) else {
      print("ERROR: unkown link")
      return
    }
    linkedView = AnyView(screen.view())
    showLink = true
  }
}

struct ContentView2: View {
    var body: some View {
      ZStack {
        Color.blue
        Text("I'm view 2")
          .foregroundColor(.white)
      }
    }
}

struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Missing:
// passing values
// dismissAll()
// Router.dismissAllAndShow(screen)
