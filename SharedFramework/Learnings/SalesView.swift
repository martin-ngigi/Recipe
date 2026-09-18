/*
* Created by Martin Wainaina on 17/09/2026
*
* Feel free to contribute.
*/

//
//  SalesDayLocationChart.swift
//  Recreates the "Day + Location" multi-series line chart with
//  tap-to-select weekday, a RuleMark + annotation popover card,
//  curved interpolation, and a computed summary line.
//
//  Requires iOS 17+ (Swift Charts + chartXSelection).
//

import SwiftUI
import Charts

// MARK: - Model

/// A single day's sales for one location.
struct RawSalesPoint: Identifiable {
    let id = UUID()
    let date: Date
    let location: String
    let sales: Double
}

/// A weekday-aggregated point — what actually gets plotted, since the
/// chart shows "average per weekday" rather than raw daily values.
struct WeekdayAverage: Identifiable {
    let id = UUID()
    let weekday: Int          // 1 = Sunday ... 7 = Saturday (Calendar convention)
    let weekdayDate: Date     // a representative date for that weekday, for x-axis plotting
    let location: String
    let averageSales: Double
}

// MARK: - Dummy Data

enum DummyData {

    static let locations = ["Cupertino", "San Francisco"]
    private static let locationColors: [String: Color] = [
        "Cupertino": .green,
        "San Francisco": .purple
    ]
    static func color(for location: String) -> Color {
        locationColors[location] ?? .gray
    }

    /// Generates ~30 days of raw daily sales per location with a bit of
    /// per-weekday bias so the weekday averages look distinct, similar
    /// to the reference screenshot (Sundays trending up for SF, etc.).
    static func rawPoints(daysBack: Int = 30) -> [RawSalesPoint] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        // Rough per-weekday baseline, index 0 = Sunday ... 6 = Saturday.
        let cupertinoBaseline: [Double]     = [70, 74, 92, 60, 96, 84, 66]
        let sanFranciscoBaseline: [Double]  = [137, 62, 55, 88, 78, 92, 101]

        var points: [RawSalesPoint] = []
        for offset in 0..<daysBack {
            guard let date = calendar.date(byAdding: .day, value: -offset, to: today) else { continue }
            let weekdayIndex = calendar.component(.weekday, from: date) - 1 // 0-based, Sun first

            for location in locations {
                let baseline = (location == "Cupertino" ? cupertinoBaseline : sanFranciscoBaseline)[weekdayIndex]
                let jitter = Double.random(in: -8...8)
                points.append(RawSalesPoint(date: date, location: location, sales: max(0, baseline + jitter)))
            }
        }
        return points
    }

    /// Averages raw points by weekday + location, and maps each weekday
    /// onto a date within the most recent Mon–Sun span so the x-axis
    /// reads naturally left to right.
    static func weekdayAverages(from raw: [RawSalesPoint]) -> [WeekdayAverage] {
        let calendar = Calendar.current

        // Anchor dates: the most recent Monday..Sunday, used purely as
        // x-axis positions for the averaged weekday buckets.
        let today = calendar.startOfDay(for: Date())
        let currentWeekday = calendar.component(.weekday, from: today) // 1 = Sun
        let daysSinceMonday = (currentWeekday + 5) % 7
        let monday = calendar.date(byAdding: .day, value: -daysSinceMonday, to: today)!
        let weekdayToDate: [Int: Date] = (0..<7).reduce(into: [:]) { result, i in
            let date = calendar.date(byAdding: .day, value: i, to: monday)!
            result[calendar.component(.weekday, from: date)] = date
        }

        var buckets: [String: [Double]] = [:] // key: "location-weekday"
        for point in raw {
            let weekday = calendar.component(.weekday, from: point.date)
            let key = "\(point.location)-\(weekday)"
            buckets[key, default: []].append(point.sales)
        }

        var result: [WeekdayAverage] = []
        for location in locations {
            for weekday in 1...7 {
                let key = "\(location)-\(weekday)"
                guard let values = buckets[key], !values.isEmpty else { continue }
                let average = values.reduce(0, +) / Double(values.count)
                result.append(WeekdayAverage(
                    weekday: weekday,
                    weekdayDate: weekdayToDate[weekday]!,
                    location: location,
                    averageSales: average
                ))
            }
        }
        return result.sorted { $0.weekdayDate < $1.weekdayDate }
    }
}

// MARK: - Chart View

struct SalesDayLocationChart: View {

    private let rawPoints = DummyData.rawPoints()
    private var weekdayAverages: [WeekdayAverage] {
        DummyData.weekdayAverages(from: rawPoints)
    }

    // Bound to chartXSelection; holds the tapped/dragged weekday date.
    @State private var rawSelectedDate: Date?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                    Picker("Range", selection: .constant(0)) {
                        Text("30 Days").tag(0)
                        Text("12 Months").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding(.top, 8)

                    chart
                        .frame(height: 280)
                        .padding(.top, 8)

                    if let summary = summaryText {
                        Text(summary)
                            .font(.subheadline)
                            .foregroundStyle(.primary)
                    }

                    Divider()
                        .padding(.top, 4)

                    Text("Options")
                        .font(.footnote)
                        .foregroundStyle(.secondary)

                    NavigationLink {
                        Text("Transactions")
                    } label: {
                        HStack {
                            Text("Show Transactions")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                                .font(.caption)
                        }
                        .foregroundStyle(.primary)
                    }
                    .padding(.vertical, 10)

                    Divider()
                }
                .padding(.horizontal)
            }
            .navigationTitle("Day + Location")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // MARK: Chart

    private var chart: some View {
        Chart {
            ForEach(DummyData.locations, id: \.self) { location in
                ForEach(weekdayAverages.filter { $0.location == location }) { element in
                    LineMark(
                        x: .value("Day", element.weekdayDate, unit: .day),
                        y: .value("Sales", element.averageSales)
                    )
                    .foregroundStyle(by: .value("Location", location))
                    .symbol(by: .value("Location", location))
                    .interpolationMethod(.catmullRom) // curved lines
                }
            }

            if let selectedDate = rawSelectedDate {
                RuleMark(
                    x: .value("Selected", selectedDate, unit: .day)
                )
                .foregroundStyle(Color.gray.opacity(0.3))
                .offset(yStart: -10)
                .zIndex(-1)
                .annotation(
                    position: .top,
                    spacing: 0,
                    overflowResolution: .init(x: .fit(to: .chart), y: .disabled)
                ) {
                    valueSelectionPopover
                }
            }
        }
        .chartForegroundStyleScale([
            "Cupertino": DummyData.color(for: "Cupertino"),
            "San Francisco": DummyData.color(for: "San Francisco")
        ])
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { _ in
                AxisGridLine()
                AxisValueLabel(format: .dateTime.weekday(.abbreviated))
            }
        }
        .chartLegend(.hidden)
        .chartXSelection(value: $rawSelectedDate)
       
    }

    // MARK: Selection popover

    /// The floating card shown above the RuleMark: "Average on <Weekday>"
    /// plus one entry per location, value + colored dot + name.
    @ViewBuilder
    private var valueSelectionPopover: some View {
        if let weekday = selectedWeekday {
            VStack(alignment: .leading, spacing: 8) {
                Text("Average on \(weekday.name)s")
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                HStack(alignment: .top, spacing: 20) {
                    ForEach(averagesForSelectedWeekday) { entry in
                        VStack(alignment: .leading, spacing: 2) {
                            Text("\(Int(entry.averageSales.rounded())) sales")
                                .font(.headline)
                                .foregroundStyle(DummyData.color(for: entry.location))

                            HStack(spacing: 4) {
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(DummyData.color(for: entry.location))
                                    .frame(width: 8, height: 8)
                                Text(entry.location)
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.secondarySystemBackground))
                    .shadow(color: .black.opacity(0.12), radius: 4, y: 2)
            )
        }
    }

    private var selectedWeekday: (number: Int, name: String)? {
        guard let rawSelectedDate else { return nil }
        let number = Calendar.current.component(.weekday, from: rawSelectedDate)
        let name = rawSelectedDate.formatted(.dateTime.weekday(.wide))
        return (number, name)
    }

    private var averagesForSelectedWeekday: [WeekdayAverage] {
        guard let weekday = selectedWeekday else { return [] }
        return weekdayAverages
            .filter { $0.weekday == weekday.number }
            .sorted { $0.location < $1.location }
    }

    // MARK: Summary

    /// Mirrors the reference UI's "On average, N sold on <weekday> in
    /// <location> in the past 30 days." caption. Defaults to the
    /// highest-selling location/weekday combo when nothing is selected.
    private var summaryText: String? {
        let entry: WeekdayAverage?
        if let weekday = selectedWeekday {
            entry = weekdayAverages
                .filter { $0.weekday == weekday.number }
                .max { $0.averageSales < $1.averageSales }
        } else {
            entry = weekdayAverages.max { $0.averageSales < $1.averageSales }
        }

        guard let entry else { return nil }
        let weekdayName = entry.weekdayDate.formatted(.dateTime.weekday(.wide))
        return "On average, \(Int(entry.averageSales.rounded())) sold on \(weekdayName)s in \(entry.location) in the past 30 days."
    }
}

// MARK: - Preview

#Preview {
    SalesDayLocationChart()
}
