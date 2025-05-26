
import SwiftUI

struct ContentView: View {
    @State private var timer: Timer?
    @State private var timeElapsed: TimeInterval = 0
    @State private var isRunning = false
    @State private var showDot = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 40) {
                Text(timeString(from: timeElapsed))
                    .font(.system(size: 48, weight: .bold, design: .monospaced))
                    .padding()

                HStack(spacing: 40) {
                    Button(action: {
                        if isRunning {
                            stopTimer()
                        } else {
                            startTimer()
                        }
                    }) {
                        Text(isRunning ? "Stop" : "Start")
                            .frame(width: 100, height: 44)
                            .background(isRunning ? Color.red : Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Button(action: resetTimer) {
                        Text("Reset")
                            .frame(width: 100, height: 44)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()

            if showDot {
                Circle()
                    .fill(Color.white)
                    .frame(width: 2, height: 2)
                    .padding(4)
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }

    func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            timeElapsed += 0.01
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isRunning = false

        let ms = Int((timeElapsed * 100).truncatingRemainder(dividingBy: 100))
        showDot = ms % 2 == 0
    }

    func resetTimer() {
        stopTimer()
        timeElapsed = 0
        showDot = false
    }

    func timeString(from time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let milliseconds = Int((time * 100).truncatingRemainder(dividingBy: 100))
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
}

#Preview {
    ContentView()
}
