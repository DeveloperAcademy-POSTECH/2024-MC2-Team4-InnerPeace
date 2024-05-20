//
//  ContactView.swift
//  SumSumZip
//
//  Created by 원주연 on 5/19/24.
//

import SwiftUI

struct MyCell: View { //ListRow 뷰 입니다
    let relationship: String
    let number: String
    var numberString: String = "01012345678"

    
    var body: some View {
        Button(action: {
            let telephone = "tel://" + numberString
            guard let url = URL(string: telephone) else { return }
            UIApplication.shared.open(url)},
               label: {
            VStack(alignment: .leading) {
                Text(relationship)
                    .font(.headline)
                Text(number.prettyPhoneNumber())
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
        })
//        VStack(alignment: .leading) {
//            Text(relationship)
//                .font(.headline)
//            Text(number)
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//        }
    }
    
}

struct ContactView: View {
    private var numberString: String = "01012345678"
    
    var body: some View {
        ZStack{
            Color.black
                .opacity(0.72)
                .ignoresSafeArea()
      
            VStack(alignment: .leading) {
                Spacer().frame(height: 100)
                Text("긴급 연락")
                    .foregroundStyle(Color.white)
                    .font(.title)
                    .fontWeight(.bold)

                Spacer().frame(height: 30)
                
                List{ //리스트 끝에 둥글게 하고싶은데 짤림
                    MyCell(relationship: "엄마", number: "010-1234-5678")
                    MyCell(relationship: "아빠", number: "010-1234-5678")
                    MyCell(relationship: "동생", number: "010-1234-5678")
                    MyCell(relationship: "동생", number: "010-1234-5678")
                }
                .listStyle(.plain)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                
                Spacer().frame(height: 110)

                HStack{
                    Spacer().frame(width: 150)
                    Button(action: {}, label: {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .foregroundStyle(Color.secondary)
                    })
                }
            }
            .padding()
        }
    }
}

extension String {
    func prettyPhoneNumber() -> String { //01012345678 -> 010-1234-5678
        let _str = self.replacingOccurrences(of: "-", with: "")
        let arr = Array(_str)
        
        if arr.count > 3 {
            let prefix = String(format: "%@%@%@", String(arr[0]), String(arr[1]), String(arr[2]))
            
            if prefix == "02" {
                if let regex = try? NSRegularExpression(pattern: "([0-9]{2})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) {
                    let modString = regex.stringByReplacingMatches(in: _str, options: [],
                                                                   range: NSRange(_str.startIndex..., in: _str),
                                                                   withTemplate: "$1-$2-$3")
                    return modString
                }
            } else if prefix == "15" || prefix == "16" || prefix == "18" {
                if let regex = try? NSRegularExpression(pattern: "([0-9]{4})([0-9]{4})", options: .caseInsensitive) {
                    let modString = regex.stringByReplacingMatches(in: _str, options: [],
                                                                   range: NSRange(_str.startIndex..., in: _str),
                                                                   withTemplate: "$1-$2")
                    return modString
                }
            } else if prefix.hasPrefix("05") {
                // Handle 050X numbers
                if let regex = try? NSRegularExpression(pattern: "([0-9]{3})([0-9]{4})([0-9]{4})", options: .caseInsensitive) {
                    let modString = regex.stringByReplacingMatches(in: _str, options: [],
                                                                   range: NSRange(_str.startIndex..., in: _str),
                                                                   withTemplate: "$1-$2-$3")
                    return modString
                }
            } else {
                if let regex = try? NSRegularExpression(pattern: "([0-9]{3})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) {
                    let modString = regex.stringByReplacingMatches(in: _str, options: [],
                                                                   range: NSRange(_str.startIndex..., in: _str),
                                                                   withTemplate: "$1-$2-$3")
                    return modString
                }
            }
        }
        return self
    }
}

#Preview {
    ContactView()
}
