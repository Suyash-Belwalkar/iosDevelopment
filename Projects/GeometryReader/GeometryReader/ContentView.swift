//
//  ContentView.swift
//  GeometryReader
//
//  Created by Suyash on 28/06/25.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        
                        let minY = proxy.frame(in: .global).minY
                        let opacity = max(0, min(1, (minY - 100) / 100))
                        let scale = max(0.5, min(1, (minY - 100) / 400))
                        let hue = min(1, max(0, (minY - 100) / 600))
                        let color = Color(hue: hue, saturation: 1.0, brightness: 1.0)
                        
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(color)
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(opacity)
                            .scaleEffect(scale)
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
