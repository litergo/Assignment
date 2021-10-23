//
//  CreateEventView.swift
//  Assignment
//
//  Created by 19336844 on 22.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

import SwiftUI

struct CreateEventView: View {
  
  private enum Field: Int, CaseIterable {
         case name, venue, duration
  }
  
  @FocusState private var focusedField: Field?
  
  @ObservedObject var viewModel: CreateEventViewModel
  
  var body: some View {
    VStack {
      TextField.init("Enter event name...", text: $viewModel.nameInput)
        .focused($focusedField, equals: .name)
      
      TextField.init("Enter event venue...", text: $viewModel.venueInput)
        .focused($focusedField, equals: .venue)
      
      TextField.init("Enter event duration...", text: $viewModel.durationInput)
        .focused($focusedField, equals: .duration)
        .keyboardType(.numberPad)
      
      Toggle("Save on server", isOn: $viewModel.shouldSaveOnServer)
      
      Spacer()
      
      Button {
        if let model = viewModel.sportEventModel {
          viewModel.finishFlow?(model)
        }
      } label: {
        ZStack {
          RoundedRectangle(cornerRadius: 10)
            .stroke()
            .frame(height: 40)
          Text("Add")
        }
      }
      .disabled(!viewModel.isReadyToAdd)

    }
    .padding()
    .toolbar {
      ToolbarItem(placement: .keyboard) {
        HStack {
          Spacer()
          Button("Done") {
            focusedField = nil
          }
        }
      }
    }
  }
}

