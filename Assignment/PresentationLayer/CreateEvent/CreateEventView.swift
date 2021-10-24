//
//  CreateEventView.swift
//  Assignment
//
//  Created by 19336844 on 22.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

import SwiftUI
import Combine

struct CreateEventView: View {
  
  // MARK: Public
  
  var cancelFlow: (() -> Void)?
  
  // MARK: Privates
  
  private enum Field: Int, CaseIterable {
         case name, venue, duration
  }
  
  private struct Constants {
    static let numbersLimit = 8
  }
  
  @FocusState private var focusedField: Field?

  @ObservedObject private var viewModel: CreateEventViewModel
  
  // MARK: Lifecycle
  
  /// Init with view model
  /// - Parameter viewModel: view model
  init(viewModel: CreateEventViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack {
      HStack {
        Button {
          cancelFlow?()
        } label: {
          Text("Cancel")
        }
        Spacer()
      }
      TextField("Enter event name...", text: $viewModel.nameInput)
        .focused($focusedField, equals: .name)
        .padding(.vertical)
      
      TextField("Enter event venue...", text: $viewModel.venueInput)
        .focused($focusedField, equals: .venue)
        .padding(.bottom)
      
      TextField("Enter duration in seconds...", text: $viewModel.durationInput)
        .focused($focusedField, equals: .duration)
        .keyboardType(.numberPad)
        .onReceive(Just(viewModel.durationInput)) { text in
          if text.count > Constants.numbersLimit {
            viewModel.durationInput = String(text.prefix(Constants.numbersLimit))
          }
        }
      
      viewModel.durationFormatted.map { text in
        HStack {
          Text(text)
            .foregroundColor(.gray)
          Spacer()
        }
      }
      
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
