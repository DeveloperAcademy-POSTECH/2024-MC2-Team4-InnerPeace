//
//  EmergencyLiveActivity.swift
//  EmergencyLiveActivity
//
//  Created by 신승아 on 5/15/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
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


struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct EmergencyWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        Image("WidgetIcon") // 추가한 이미지를 표시
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50) // 원하는 크기로 조정
    }
}

struct EmergencyWidget: Widget {
    let kind: String = "EmergencyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            EmergencyWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("숨숨집")
        .description("잠금 화면에서 빠르게 구조요청을 할 수 있습니다.")
    }
}

#Preview(as: .systemSmall) {
    EmergencyWidget()
} timeline: {
    SimpleEntry(date: .now)
}
