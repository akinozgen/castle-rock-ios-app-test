//
//  CircleImage.swift
//  Testla
//
//  Created by Akın Özgen on 24.10.2020.
//

import SwiftUI

struct CircleImage: View {
    @State var contentMode = ContentMode.fit
    
    var body: some View {
        Image("castlerock")
            .resizable()
            .frame(width: 120, height: 120)
            .aspectRatio(contentMode: contentMode)
            .scaledToFit()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .shadow(radius: 10)
            .onTapGesture {
                withAnimation {
                    self.contentMode = ContentMode.fill
                }
            }
        
    }
    
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
