//
//  MainView.swift
//  Assignment
//
//  Created by 19336844 on 22.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

import SwiftUI

struct MainView: View {
  @ObservedObject private var viewModel: MainViewModel
  
  init(viewModel: MainViewModel) {
    self.viewModel = viewModel
  }
  
  var presentSheet: (() -> Void)?
  
  var body: some View {
      VStack {
        HStack {
          Text("Events")
            .font(.system(size: 30))
            .fontWeight(.bold)
          Spacer()
          Button {
            presentSheet?()
          } label: {
            Image(systemName: "plus")
          }
        }
        .padding()
        
        Picker("Select", selection: $viewModel.selectedStorage) {
                       Text("All").tag(0)
                       Text("Remote").tag(1)
                       Text("Local").tag(2)
                   }
                   .pickerStyle(.segmented)
                   .frame(height: 30)
                   .padding(.horizontal)
        
        List {
          ForEach(viewModel.filteredEvents) { item in
            VStack {
              HStack {
                Text(item.name)
                Spacer()
                if let duration = DateComponentsFormatter.timeIntervalFormatter.string(from: TimeInterval(item.duration)) {
                  Text(duration)
                }
              }
              HStack {
                Text(item.venue)
                Spacer()
                Text(item.inRemote ? "on server": "local")
                  .foregroundColor(item.inRemote ? Color.blue: Color.gray)
              }
            }
          }
        }
      }
  }
}
