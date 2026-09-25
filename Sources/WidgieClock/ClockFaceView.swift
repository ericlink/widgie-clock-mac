import SwiftUI

struct ClockFaceView: View {
    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 30.0)) { timeline in
            let angles = ClockMath.angles(for: timeline.date)

            ZStack {
                Circle().fill(Color(red: 0.067, green: 0.067, blue: 0.067))
                Circle().stroke(.white.opacity(0.2), lineWidth: 0.75)
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color(red: 0.969, green: 0.949, blue: 0.91),
                                Color(red: 0.851, green: 0.812, blue: 0.745)
                            ],
                            center: UnitPoint(x: 0.38, y: 0.32),
                            startRadius: 0,
                            endRadius: 118
                        )
                    )
                    .padding(6)

                ticks
                numerals
                hand(width: 7, length: 37, angle: angles.hour)
                hand(width: 4, length: 47, angle: angles.minute)
                hand(width: 1.5, length: 48, tail: 13, angle: angles.second)

                Circle().fill(.black).frame(width: 7, height: 7)
                Circle().fill(Color(white: 0.2)).frame(width: 3, height: 3)
            }
            .padding(0.5)
        }
        .frame(width: 130, height: 130)
    }

    private var ticks: some View {
        ZStack {
            ForEach(0..<60, id: \.self) { index in
                let isHour = index.isMultiple(of: 5)
                Capsule()
                    .fill(.black)
                    .frame(width: isHour ? 2 : 1, height: isHour ? 7 : 3)
                    .offset(y: -53)
                    .rotationEffect(.degrees(Double(index) * 6))
            }
        }
    }

    private var numerals: some View {
        ZStack {
            numeral("12", x: 0, y: -40)
            numeral("3", x: 42, y: 0)
            numeral("6", x: 0, y: 40)
            numeral("9", x: -42, y: 0)
        }
    }

    private func numeral(_ text: String, x: CGFloat, y: CGFloat) -> some View {
        Text(text)
            .font(.system(size: 14, weight: .bold, design: .default))
            .foregroundStyle(.black)
            .offset(x: x, y: y)
    }

    private func hand(width: CGFloat, length: CGFloat, tail: CGFloat = 0, angle: Double) -> some View {
        Capsule()
            .fill(.black)
            .frame(width: width, height: length + tail)
            .offset(y: (tail - length) / 2)
            .rotationEffect(.degrees(angle))
    }
}
