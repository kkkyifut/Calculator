import Foundation

extension FloatingPoint where Self: CVarArg {
    func fixedFraction(digits: Int) -> String {
        .init(format: "%.*f", digits, self)
    }
}

extension Formatter {
    static let number = NumberFormatter()
}

extension FloatingPoint {
    func fractionDigits(min: Int = 0, max: Int = 10, roundingMode: NumberFormatter.RoundingMode = .halfEven) -> String {
        Formatter.number.minimumFractionDigits = min
        Formatter.number.maximumFractionDigits = max
        Formatter.number.roundingMode = roundingMode
        Formatter.number.numberStyle = .decimal
        return Formatter.number.string(for: self) ?? ""
    }
}
