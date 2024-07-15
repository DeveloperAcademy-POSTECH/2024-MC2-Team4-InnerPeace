//
//  PatientInfo&ContactView.swift
//  SumSumZip
//
//  Created by 원주연 on 7/13/24.
//

import SwiftUI

struct PatientInfo_ContactView: View {
    
    //PatientInfo&Contact
    @Binding var hospitalInfo: String
    @Binding var medicineInfo: String
    @Binding var isShownPatientInfo_Contact: Bool
    @State private var pickedNumber: String = ""
    @State private var pickedNumber2: String = ""
    @State private var pickedNumber3: String = ""
    @State private var relation: String = ""
    @State private var relation2: String = ""
    @State private var relation3: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            TitleView()
            
            ContentView()
            
            Spacer()
            
            VStack {
                Spacer().frame(height: 130)
                List {
                    Section {
                        MyCell(relationship: relation, number: pickedNumber)
                        MyCell(relationship: relation2, number: pickedNumber2)
                        MyCell(relationship: relation3, number: pickedNumber3)
                    } header: {
                        Text("보호자 연락처")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundStyle(Color.white)
                    }
                    
                    Section {
                        MyCell(relationship: "119", number: "119")
                            .foregroundStyle(Color.red)
                    } header: {
                        Text("긴급 통화")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundStyle(Color.white)
                    }
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
                
                Button(action: {isShownPatientInfo_Contact = false}, label: {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundStyle(Color.secondary)
                        .background(Color.white).clipShape(Circle())
                })
                Spacer().frame(height: 40)
            }

            CustomXButton(action: {
                // 화면 전환 로직
                isShownPatientInfo_Contact = false
            })
            .padding(.bottom, 30)
        }
        // onAppear 내부 수정
        .onAppear {
            let contacts = ContactsManager.shared.fetchContacts()
            
            // 연락처 배열의 요소들을 안전하게 할당
            if contacts.indices.contains(0) {
                pickedNumber = contacts[0]
            }
            if contacts.indices.contains(1) {
                pickedNumber2 = contacts[1]
            }
            if contacts.indices.contains(2) {
                pickedNumber3 = contacts[2]
            }
            if contacts.indices.contains(3) {
                relation = contacts[3]
            }
            if contacts.indices.contains(4) {
                relation2 = contacts[4]
            }
            if contacts.indices.contains(5) {
                relation3 = contacts[5]
            }
        }

        .background(Color.black.opacity(0.82))
        .background(ClearBackground())
    }
    
    @ViewBuilder
    private func TitleView() -> some View {
        Text("환자 정보")
            .font(.title)
            .fontWeight(.bold)
            .padding(.top, 20)
            .foregroundColor(.white)
    }
    
    @ViewBuilder
    private func ContentView() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            InfoSection("자주 가는 병원", $hospitalInfo)
                .padding(.bottom, 49)
            InfoSection("복용 중인 약", $medicineInfo)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .shadow(radius: 5))
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func InfoSection(_ infoTitle: String, _ infoContent: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            
            SettingQuestionLabel(text: infoTitle)
            
            TextEditor(text: infoContent)
                .frame(height: 90)
                .padding(10)
                .background(AppColors.paleGreen.opacity(1))
                .cornerRadius(10)
                .scrollContentBackground(.hidden)
                .disabled(true)
        }
    }
}

struct MyCell: View { //ListRow 뷰 입니다
    let relationship: String
    let number: String
    
    var body: some View {
        Button(action: {
            let telephone = "tel://" + number
            guard let url = URL(string: telephone) else { return }
            UIApplication.shared.open(url)},
               label: {
            VStack(alignment: .leading) {
                Text(relationship)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                Text(number.prettyPhoneNumber())
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        })
    }
}

public struct ClearBackground: UIViewRepresentable {
    
    public func makeUIView(context: Context) -> UIView {
        
        let view = ClearBackgroundView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {
    }
}

class ClearBackgroundView: UIView {
    open override func layoutSubviews() {
        guard let parentView = superview?.superview else {
            return
        }
        parentView.backgroundColor = .clear
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


//#Preview {
//    PatientInfo_ContactView()
//}
