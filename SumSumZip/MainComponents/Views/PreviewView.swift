//
//  PreviewView.swift
//  SumSumZip
//
//  Created by 원주연 on 5/23/24.
//

import SwiftUI

struct PreviewView: View {
    
    @State var SOSmessage: String
    @State var breathTime: Int
    @State var medicineInfo = UserdefaultsManager.medicineInfo
    @State var hospitalInfo = UserdefaultsManager.hospitalInfo
    @State private var isShownPatientInfo: Bool = false
    @State private var isShownBreathing: Bool = false
    @State private var isShownContact: Bool = false
    @State private var isBreathing: Bool = false
    @State private var showingAlert: Bool = false
    @State private var progressValue: Double = 1.0
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.black, AppColors.lightGreen, AppColors.lightGreen]),
                               startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                VStack{
                    Spacer().frame(height: 10)
                    Text("도와주세요 버튼 클릭 시 보이는 화면입니다.")
                        .fontWeight(.bold)
                        .foregroundStyle(AppColors.systemGray)
                    Spacer().frame(height: 40)
                    Text("도움이 필요합니다")
                        .foregroundStyle(Color.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .padding(.bottom, 7)
                    Text(SOSmessage)
                        .foregroundStyle(Color.white)
                        .font(.title2)
                    Spacer().frame(height: 100)
                    
                    if isShownBreathing {
                        CircleView(isBreathing: $isBreathing)
                            .onAppear(perform: {
                                isBreathing.toggle()
                            })
                    } else {
                        CapsuleView(isShownBreathing: $isShownBreathing, breathTime: $breathTime, progressValue: $progressValue)
                    }
                    Spacer().frame(height: 100)
                    
                    
                    Text("만약 제가 의식이 없다면\n긴급연락과 119에 신고해주세요")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                    Spacer().frame(height: 60)
                }
            }
            //            .toolbar{
            //                ToolbarItem(placement: .topBarLeading) {
            //                    Text("미리보기 화면입니다.")
            //                        .fontWeight(.bold)
            //                        .foregroundStyle(AppColors.systemGray)
            //                }
            //            }
            .toolbar{
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("환자 정보") {
                        print("환자 정보")
                        isShownPatientInfo = true
                    }
                    .foregroundStyle(Color.gray)
                    .font(.title3)
                    .fontWeight(.bold)
                    
                    Button("긴급 연락") {
                        print("긴급 연락")
                        isShownContact = true
                    }
                    .foregroundStyle(Color.red)
                    .font(.title3)
                    .fontWeight(.bold)
                }
            }
            .fullScreenCover(isPresented: $isShownContact, content: {
                ContactView(isShownContact: $isShownContact)
            })
            .fullScreenCover(isPresented: $isShownPatientInfo, content: {
                PatientInfoView(hospitalInfo: $hospitalInfo, medicineInfo: $medicineInfo, isShownPatientInfo: $isShownPatientInfo)
            })
        }
        .onAppear{
            let BreathsavedTime = BreathTimeDataManager.shared.fetchTime()
            breathTime = BreathsavedTime != 0 ? BreathsavedTime : 30
            let message = MessageManager.shared.fetchMessage()
            SOSmessage = message != "" ? message : ""
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .blur(radius: isShownContact ? 5.0 : 0)
        .blur(radius: isShownPatientInfo ? 5.0 : 0)
    }
}



#Preview {
    PreviewView(SOSmessage: "", breathTime: 1)
}
