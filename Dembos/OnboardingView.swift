//
//  ContentView.swift
//  Dembos
//
//  Created by user231685 on 11/12/22.
//

import SwiftUI

struct OnBoardingConfig {
    let image: String
    let title: String
    let description: String
}

private let onBoardingConfig = [
    OnBoardingConfig(image: "onBoarding1", title: "Bienvenido", description: "Usted ha llegado a la mejor hamburgueseria!"),
    OnBoardingConfig(image: "onBoarding2", title: "Seleccion de productos", description: "Podra elegir entre uno o varios productos"),
    OnBoardingConfig(image: "onBoarding3", title: "Califiquenos", description: "Siempre es bueno dejar su feedback!")
]

struct OnboardingView: View {
    @ObservedObject var authenticationViewModel: AuthViewModel
    @State private var currentStep: Int = 0
    @State var navigated = false
    
    var body: some View {
        
        
        VStack {
            HStack{
                Spacer()
                Button {
                    self.currentStep = onBoardingConfig.count - 1
                } label: {
                    Text("Saltar")
                        .padding(16)
                        .foregroundColor(.gray)
                        
                }
                
            }
            
            TabView(selection: $currentStep){
                ForEach(0..<onBoardingConfig.count, id: \.self ) { it in
                VStack {
                    Image(onBoardingConfig[it].image)
                        .padding(.bottom, 10.0)
                    
                    Text(onBoardingConfig[it].title)
                        .font(.title)
                        .bold()
                        .padding(.bottom, 10.0)
                    
                    Text(onBoardingConfig[it].description)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                .tag(it)
            }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HStack {
                ForEach(0..<onBoardingConfig.count, id: \.self ) { it in
                    if it == currentStep {
                        Rectangle()
                            .frame(width: 20, height: 10)
                            .cornerRadius(10)
                            .foregroundColor(.purple)
                    } else {
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.bottom, 24)
            
          NavigationLink("", destination: AuthenticationLoginView(authenticationViewModel: authenticationViewModel), isActive: $navigated)
            
            
                    Button {
                        if self.currentStep < onBoardingConfig.count - 1 {
                            self.currentStep += 1
                        } else {
                           self.navigated.toggle()
                        }
                        
                    } label: {
                        Text(currentStep < onBoardingConfig.count - 1 ? "Siguiente" : "Empecemos!")
                            .padding(16)
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .cornerRadius(16)
                            .padding(.horizontal, 16)
                            .foregroundColor(.white)
                }
        }
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(authenticationViewModel: AuthViewModel())
    }
}
