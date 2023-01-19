//
//  LoadingOverlay.swift
//  PastaApp
//
//  Created by Kacper Rączy on 19/01/2023.
//

import SwiftUI

struct LoadingOverlay: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12.0)
                .foregroundColor(.accentColor)
                .opacity(0.5)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .tint(.white)
        }
        .frame(width: 80.0, height: 80.0)
    }
}
