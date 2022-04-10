//
//  SeeText.swift
//  checklist3
//
//  Created by Abdullah Ridwan on 4/2/22.
//

import SwiftUI

struct SeeText: View {
    @Binding var text: String
    @Binding var fillCircle: Bool

    var body: some View {
        HStack{
            Circle()
                .strokeBorder(Color.black, lineWidth: 1)
                .background(fillCircle ? Circle().fill(Color.green) : Circle().fill(Color.white))
                .frame(width: 15, height: 15)
                .onTapGesture {
                    fillCircle.toggle()
                }
            TextField("", text: $text)
        }
    }
}

struct SeeText_Previews: PreviewProvider {
    static var previews: some View {
        SeeText(text: .constant("Some Item"), fillCircle: .constant(false))
    }
}
