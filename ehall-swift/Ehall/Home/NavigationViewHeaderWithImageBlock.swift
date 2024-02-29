//
//  NavigationViewHeaderWithImageBlock.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/24.
//

import SwiftUI

struct NavigationViewHeaderWithImageBlock: View {
  @State var isAccountViewPresented = false
  let date: Date
  
  var body: some View {
    VStack {
      Text(date.toFullDateFormat())
        .font(.subheadline)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)
        .foregroundColor(.secondary)
      
      HStack {
        Text(date.toWeekDayFormat())
          .font(.title)
          .bold()
          .padding(.leading)
        
        Spacer()
        
        AccountButton(isAccountViewPresented: $isAccountViewPresented)
          .padding(.trailing)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding(.top, 32)
  }
}

extension Date {
  
  func toFullDateFormat() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMMM dd"
    return dateFormatter.string(from: self)
  }
  
  
  func toWeekDayFormat() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.doesRelativeDateFormatting = true
    return dateFormatter.string(from: self)
  }
  
}

struct NavigationViewHeaderWithImageBlock_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewHeaderWithImageBlock(date: Date())
            .environmentObject(ScoreViewModel())
    }
}
