// Assignee: Leo
//
//  Created by Leo Yoon on 5/21/24.
//
//
//@ 완료과제: 뷰짜봄, 캐릭터 애니메이션, SummaryView로 넘어가게 함
//@ 남은과제: 없음...? 디자인 수정 필요하면 의견 부탁드립니다.




import SwiftUI

struct OnboardingView: View {
    
    @State private var isActive: Bool = false
    @State private var fadeInOut = false
    @State private var opacity: Double = 0.0
    
    var body: some View {
        
        if isActive {
            SummaryView()
        } else {
            
            ZStack{
                Image("BG_OnboardingView")
                    .resizable()
                    .ignoresSafeArea()
                
                    Image("Img_OnboardingView")
                        .onAppear() {
                            withAnimation(Animation.easeIn(duration: 0.8)
                            ){
                                fadeInOut.toggle()
                            }
                        }.opacity(fadeInOut ? 1: 0)

            }.onAppear() {
                DispatchQueue.main.asyncAfter(deadline:.now() + 1.3){
                    isActive = true
                }
            }
        }
    }
}



#Preview {
    OnboardingView()
}
