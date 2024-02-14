//
//  ContentView.swift
//  calendar
//
//  Created by João Damazio on 07/02/24.
//

import SwiftUI
import CoreMotion

struct ContentView: View {

    let animationDuration: Double = 0.4
    let initialScale: CGFloat = 1
    let finalScale: CGFloat = 0.72
    let initialRotation: Double = 0
    let finalRotation: Double = -40
    let yOffsetMultiplier: CGFloat = 0.2

    @State private var phoneLiftedUp: Double = 0
    let motionManager = CMMotionManager()

    func startMotionDetection() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { motion, error in
                if let motion = motion {
                    let accelerationZ = motion.gravity.z

                    withAnimation(.linear(duration: self.animationDuration)) {
                        self.phoneLiftedUp = mapRange(inMin: 0.4, inMax: 0.8, outMin: 0, outMax: 1, valueToMap: -accelerationZ)
                    }
                }
            }
        }
    }

    func content(day: String, dayMonth: String) -> some View {
        VStack {
            HStack(alignment: .center) {
                Text(day)
                    .foregroundColor(.black)
                    .font(.title3.weight(.medium))
                Spacer()
                Text("January")
                    .foregroundColor(.gray)
                    .font(.title2.weight(.medium))
                Spacer()
                Text(dayMonth)
                    .foregroundColor(.black)
                    .font(.title.weight(.medium))
            }

            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(.vertical)
        .safeAreaPadding(.all)
        .background(Color.white)
        .cornerRadius(16)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }

    func dayContentView(day: String, dayMonth: String, yOffsetMultiplier: CGFloat, finalScale: CGFloat, finalRotation: Double) -> some View {
        content(day: day, dayMonth: dayMonth)
            .offset(y: animationFromTo(
                self.phoneLiftedUp,
                fromValue: 0,
                toValue: UIScreen.main.bounds.height * yOffsetMultiplier)
            )
            .scaleEffect(
                animationFromTo(
                    self.phoneLiftedUp, fromValue: initialScale, toValue: finalScale)
            )
            .rotation3DEffect(
                .degrees(animationFromTo(
                    self.phoneLiftedUp,
                    fromValue: initialRotation,
                    toValue: finalRotation)
                ),
                axis: (x: 1, y: 0, z: 0)
            )
    }

    var body: some View {
        ZStack {
            dayContentView(day: "Mon.", dayMonth: "15", yOffsetMultiplier: -0.06, finalScale: 0.72, finalRotation: -40)
            dayContentView(day: "Tue.", dayMonth: "16", yOffsetMultiplier: 0.14, finalScale: 0.81, finalRotation: -37)
            dayContentView(day: "Wed.", dayMonth: "17", yOffsetMultiplier: 0.34, finalScale: 0.90, finalRotation: -34)
            dayContentView(day: "Thu.", dayMonth: "18", yOffsetMultiplier: 0.54, finalScale: 0.99, finalRotation: -31)
            dayContentView(day: "Fri.", dayMonth: "19", yOffsetMultiplier: 0.74, finalScale: 1.08, finalRotation: -28)
        }
        .background(.black)
        .onAppear {
            startMotionDetection()
        }
        .onDisappear {
            motionManager.stopDeviceMotionUpdates()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
