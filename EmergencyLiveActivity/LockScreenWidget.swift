//
//  LockScreenWidget.swift
//  SumSumZip
//
//  Created by 신승아 on 5/23/24.
//

import WidgetKit
import SwiftUI

struct EmergencyLockScreenProvider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        for hourOffset in 0..<5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct EmergencyLockScreenWidgetEntryView: View {
    
    @Environment(\.widgetFamily) var widgetFamily
    var entry: SimpleEntry

    var body: some View {
        
        switch widgetFamily {
        case .accessoryCircular:
            VStack {
                Image("WidgetIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
            .widgetBackground(Color.white)
            
        default:
            Text("숨숨집")
        }
        
        
        
    }
}

struct EmergencyLockScreenWidget: Widget {
    let kind: String = "EmergencyLockScreenWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: EmergencyLockScreenProvider()) { entry in
            EmergencyLockScreenWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Emergency Lock Screen Widget")
        .description("This widget displays an image on the lock screen.")
        .supportedFamilies([.accessoryRectangular, .accessoryCircular, .accessoryInline])
    }
}

