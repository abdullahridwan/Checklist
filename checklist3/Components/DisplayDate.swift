//
//  DisplayDate.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/14/22.
//

import SwiftUI

struct DisplayDate: View {
    @State var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 5.0)
                .opacity(0.2)
                .foregroundColor(Color.green)
                .frame(width: 25.0, height: 25.0)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.green.opacity(0.8))
                .rotationEffect(Angle(degrees: 270.0))
                .frame(width: 25.0, height: 25.0)


                
            
        }
    }
}

struct DisplayDate_Previews: PreviewProvider {
    static var previews: some View {
        DisplayDate(progress: 0.28)
    }
}
