//
//  ContentView.swift
//  Drawing
//
//  Created by Hubert Wojtowicz on 07/07/2023.
//

import SwiftUI

struct Trapezoid: Shape {
    var insetAmount: Double

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))

        return path
    }
    var animatableData: Double {
        get { insetAmount }
        set {insetAmount = newValue }
    }
}

struct Checkboard: Shape {
    var rows: Int
    var columns: Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // how big each row/column needs to be
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)
        
        //loop for rows and oclumns, making alternating squares colored
        for row in 0 ..< rows {
            for column in 0 ..< columns {
                if (row + column).isMultiple(of: 2) {
                    // this square should be colored; add a ractangle here
                    let startX = columnSize * Double(column)
                    let StartY = rowSize * Double(row)
                    
                    let rect = CGRect(x: startX, y: StartY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        
        return path
    }
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))
        }
        
        set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
}

struct Arrow: Shape{
    var insetAmount: Double
    
    func path(in rect:CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX * insetAmount, y: rect.midY / 1.2  * insetAmount))
        path.addLine(to: CGPoint(x: rect.midX*1.4  * insetAmount, y: rect.midY / 1.2 * insetAmount))
        path.addLine(to: CGPoint(x: rect.midX*1.4 * insetAmount, y: rect.maxY * insetAmount))
        path.addLine(to: CGPoint(x: rect.midX*0.6  * insetAmount , y: rect.maxY * insetAmount))
        path.addLine(to: CGPoint(x: rect.midX*0.6  * insetAmount , y: rect.midY / 1.2 * insetAmount))
        path.addLine(to: CGPoint(x: rect.minX * insetAmount, y: rect.midY / 1.2 * insetAmount))
        
        
        
        return path
    }
}

struct ContentView: View {
    @State private var amount = 1.0
    @State private var insetAmount = 1.0
    
    @State private var rows = 4
    @State private var columns = 4
    
    @State private var tx = 0.0
    @State private var ty = 0.0
    @State private var bx = 1.0
    @State private var by = 1.0
    
    var body: some View {
//        Checkboard(rows: rows, columns: columns)
//            .onTapGesture {
//                withAnimation(.linear(duration: 3)) {
//                    rows = 8
//                    columns = 16
//                }
//            }
        
        VStack {
            VStack{
                Arrow(insetAmount: insetAmount)
                    .fill(
                        LinearGradient(colors: [.red, .blue], startPoint: UnitPoint(x: 1*tx, y: 1*ty), endPoint: UnitPoint(x: 1*bx, y: 1*by)))
                    .frame(width: 200 * amount, height: 400 * amount)
                    .drawingGroup()
            }
            .frame(minWidth: 500, minHeight: 400)
            
            Text("Special efect")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            Slider(value: $insetAmount, in: 0...1)
            
            Text("Size of arrow")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            Slider(value: $amount, in: 0...1)
            
            Text("Gradient modifiers")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            Slider(value: $tx, in: 0...1)
            Slider(value: $ty, in: 0...1)
            Slider(value: $bx, in: 0...1)
            Slider(value: $by, in: 0...1)
        }
        
//        VStack{
//            VStack {
//                ZStack {
//                    Circle()
//                        .fill(Color(red: 1, green: 0, blue: 0))
//                        .frame(width: 200 * amount)
//                        .offset(x: -50, y: -80)
//                        .blendMode(.screen)
//
//                    Circle()
//                        .fill(Color(red: 0, green: 1, blue: 0))
//                        .frame(width: 200 * amount)
//                        .offset(x: 50, y: -80)
//                        .blendMode(.screen)
//
//                    Circle()
//                        .fill(Color(red: 0, green: 0, blue: 1))
//                        .frame(width: 200 * amount)
//                        .blendMode(.screen)
//                }
//                .frame(width: 300, height: 300)
//
//                Slider(value: $amount)
//                    .padding()
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(.black)
//            .ignoresSafeArea()
//
//            Arrow(insetAmount: insetAmount)
//
//            VStack{
//                Image("Example")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 200, height:200)
//                    .saturation(amount)
//                    .blur(radius: (1-amount) * 20)
//
//                Slider(value: $amount)
//            }
//            Trapezoid(insetAmount: insetAmount)
//                .frame(width:200, height: 100)
//                .onTapGesture {
//                    withAnimation{
//                        insetAmount = Double.random(in: 10...90)
//                    }
//                }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
