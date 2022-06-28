//
//  ContentView.swift
//  NextStep
//
//  Created by Nikita Kazakov on 30.05.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var toggleState = false
    @State private var alert = false
    @State private var name = ""
    @State private var password = ""
    @State private var sliderValue: Double = 5
    @State private var selectedZhopa = 0
    @State private var offsetTest = CGSize.zero
    @State private var animateTranslation = true
    private var zhopas = ["МИКРОЖОПА", "СРЕДНЕЖОПА", "МАКРОЖОПА"]
    var body: some View {
        VStack(alignment: .center) {
            Group {
                Toggle(isOn: $toggleState) {
                    Text("СОСТОЯНИЕ ЖОПЫ")
                }.padding()
                
                if toggleState {
                    Text("ПРИВЕТ ЖОПА")
                } else {
                    Text("ПОКА ЖОПА")
                }
                
                Button(action: {
                    self.alert.toggle()
                }) {
                    Text("СДЕЛАЙ ХОБА")
                }
                
                if alert {
                    Text("ХОБА")
                }
                
                TextField(text: $name) {
                    Text("ВВЕДИ ИМЯ")
                }
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("ВАШЕ ИМЯ: \(name == "" ? "НАПИШИ ЗАЕБАЛ" : name)")
                SecureField(text: $password) {
                    Text("РАЗБЛОКИРУЙ ЖОПУ")
                }.padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("КОД ОТ ЖОПЫ: \(password)").onTapGesture {
                    print("ЖОПА")
                }
                .animation(.spring(), value: animateTranslation)
                .offset(x: self.offsetTest.width, y: self.offsetTest.height)
                .gesture(DragGesture()
                    .onChanged { value in
                        self.animateTranslation = false
                        self.offsetTest = value.translation
                    }
                    .onEnded { value in
                        self.animateTranslation = true
                        self.offsetTest = CGSize.zero
                    }
                )
                Slider(value: $sliderValue, in: 0...10, step: 1)
                Text("ВОТ СТОЛЬКО ЖОП ХОЧУ: \(Int(sliderValue))")
            }
            Stepper("СКОЛЬКО ЖОП????????", value: $sliderValue, in: 0...10)
            Picker("ВЫБЕРИ ЖОПУ", selection: $selectedZhopa) {
                ForEach(0..<zhopas.count) { zhopa in
                    Text(self.zhopas[zhopa])
                }
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
