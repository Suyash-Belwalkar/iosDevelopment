import SwiftUI

struct ContentView: View {
    @State private var windAnimation = false
    
    var body: some View {
        HStack {
            // Left side with player and goal
            ZStack {
                // Soccer goal
                GoalPost()
                    .frame(width: 60, height: 60)
                    .offset(x: 100)
                
                // Player with crown
                PlayerWithCrown(isAnimating: $windAnimation)
                    .frame(width: 100, height: 120)
                    .offset(x: -50)
                
                // Ball
                Circle()
                    .frame(width: 20, height: 20)
                    .offset(x: -20, y: 100)
            }
            .frame(width: 300)
            
            // Right side with menu buttons
            VStack(spacing: 20) {
                MenuButton(title: "PLAY")
                MenuButton(title: "SETTINGS")
                MenuButton(title: "HOW TO PLAY")
            }
            .padding(.leading, 50)
        }
        .frame(width: 600, height: 400)
        .background(Color.white)
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 2).repeatForever()) {
                windAnimation.toggle()
            }
        }
    }
}

struct PlayerWithCrown: View {
    @Binding var isAnimating: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            // Crown
            Path { path in
                path.move(to: CGPoint(x: 10, y: 20))
                path.addLine(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: 20, y: 10))
                path.addLine(to: CGPoint(x: 40, y: 0))
                path.addLine(to: CGPoint(x: 30, y: 20))
            }
            .fill(Color.black)
            .frame(width: 40, height: 20)
            
            // Stick figure
            StickFigure()
                .rotationEffect(.degrees(isAnimating ? 5 : -5))
        }
    }
}

struct StickFigure: View {
    var body: some View {
        Path { path in
            // Head
            path.addEllipse(in: CGRect(x: 15, y: 0, width: 20, height: 20))
            
            // Body
            path.move(to: CGPoint(x: 25, y: 20))
            path.addLine(to: CGPoint(x: 25, y: 50))
            
            // Arms
            path.move(to: CGPoint(x: 10, y: 35))
            path.addLine(to: CGPoint(x: 40, y: 35))
            
            // Legs
            path.move(to: CGPoint(x: 25, y: 50))
            path.addLine(to: CGPoint(x: 10, y: 70))
            path.move(to: CGPoint(x: 25, y: 50))
            path.addLine(to: CGPoint(x: 40, y: 70))
        }
        .stroke(Color.black, lineWidth: 2)
    }
}

struct GoalPost: View {
    var body: some View {
        Path { path in
            // Goal frame
            path.move(to: CGPoint(x: 0, y: 40))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 40, y: 0))
            path.addLine(to: CGPoint(x: 40, y: 40))
        }
        .stroke(Color.black, lineWidth: 2)
    }
}

struct MenuButton: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.black)
            .frame(width: 160, height: 40)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 2)
                    .background(Color.white)
            )
    }
}

#Preview {
    ContentView()
}

