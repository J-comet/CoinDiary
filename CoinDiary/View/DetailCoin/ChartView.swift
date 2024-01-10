//
//  ChartView.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/10/24.
//

import SwiftUI

import Charts

struct ChartView: View {
    
    @State
    private var scrollPosition: Double = 0
    
    @Binding
    var chartCoins: [ChartCoin]
    
    @Binding
    var minVal: Double
    
    @Binding
    var maxVal: Double
    
    var body: some View {
        Chart {
            
            //            RuleMark(y: .value("시중가", 300000))
            //                .foregroundStyle(.mint)
            //                .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
            //                .annotation(alignment: .centerFirstTextBaseline) {
            //                    Text("시중가")
            //                        .font(.caption)
            //                        .foregroundStyle(.secondary)
            //                }
            
            ForEach(chartCoins, id:\.self) { item in
                LineMark(
                    x: .value("Date", item.date),
                    y: .value("Value", item.value)
                )
                .lineStyle(StrokeStyle(lineWidth: 3))
            }
            .foregroundStyle(.pink.gradient)
        }
        .chartYAxis {
            AxisMarks(
                preset: .extended,
                position: .leading,
                values: .automatic
            ) { value in
                AxisGridLine()
                AxisValueLabel() {
                    if let intValue = value.as(Int.self) {
                        Text("\(intValue)")
                            .font(.system(size: 8))
                    }
                }
            }
        }
        .chartXAxis {
            AxisMarks(
                preset: .extended,
                position: .bottom,
                values: .stride(by: .minute)
            ) { value in
                AxisGridLine()
//                    AxisValueLabel() {
//                        if let intValue = value.as(Int.self) {
//                            Text("\(intValue)분")
//                                .font(.system(size: 8))
//                        }
//                    }
                    AxisValueLabel(format: .dateTime.minute(.twoDigits))
                }
        }
        .chartScrollableAxes(.horizontal)
        .chartScrollPosition(x: $scrollPosition)
        .chartYScale(domain: minVal...maxVal)
//        .chartPlotStyle { plotStyle in
//            plotStyle
//                .background(Color(.lightGray).gradient.opacity(0.8))
//                .border(Color(.systemGray6).gradient, width: 1)
//        }
    }
}

#Preview {
    ChartView(chartCoins: .constant([]), minVal: .constant(0), maxVal: .constant(0))
}
