//
//  ContentView.swift
//  BerlinClock
//
//  Created by Yerkebulan Sharipov on 10.03.2022.
//

import SwiftUI

struct ContentView: View {
    @State var date = Date()
    @State var EmptyArray: [String] = []
    var body: some View {
        ZStack{
            Color(red: 242/255, green: 242/255, blue: 238/255)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing:10){
               ViewCalendar(date : $date)
                    .padding(20)
                if EmptyArray.count > 0{
                ZStack{
                    Rectangle()
                        .cornerRadius(16)
                        .frame(width: 358, height: 312)
                        .foregroundColor(.white)
                    VStack(spacing: 16){
                        Circle()
                            .fill(EmptyArray[0] == "Y" ? Color.yellow : Color.yellow.opacity(0.2))
                            .frame(width: 56, height: 56)
                            //.cornerRadius(4)
                        HStack(spacing: 10){
                            ForEach(1..<5) {i in
                                Rectangle()
                                    .fill(EmptyArray[i] == "R" ? Color.red : Color.red.opacity(0.2))
                                    .frame(width: 74, height: 32)
                                    .cornerRadius(4)
                                
                            }
                        }
                        HStack(spacing: 10){
                            ForEach(5..<9) {i in
                                Rectangle()
                                    .fill(EmptyArray[i] == "R" ? Color.red : Color.red.opacity(0.2))
                                    .frame(width: 74, height: 32)
                                    .cornerRadius(4)
                            }
                        }
                        HStack(spacing: 9.5){
                            ForEach(9..<20) {i in
                                if EmptyArray[i] == "R" {
                                    Rectangle().fill(Color.red)
                                   .frame(width: 21, height: 32)
                                   .cornerRadius(4)
                                   }
                                else if EmptyArray[i] == "Y"  {
                                    Rectangle().fill(Color.yellow)
                                   .frame(width: 21, height: 32)
                                   .cornerRadius(4)
                                }
                                
                               // не смог по другому закрасить квадраты в красный цвет в ряде из 11 ячеек :(
                                
                                else if i == 11 && EmptyArray[i] != "R"{
                                    Rectangle().fill(Color.red.opacity(0.2))
                                   .frame(width: 21, height: 32)
                                   .cornerRadius(4)
                                }
                                else if i == 14 &&
                                            EmptyArray[i] != "R"{
                                    Rectangle().fill(Color.red.opacity(0.2))
                                   .frame(width: 21, height: 32)
                                   .cornerRadius(4)
                                }
                                else if i == 17 &&
                                            EmptyArray[i] != "R"{
                                    Rectangle().fill(Color.red.opacity(0.2))
                                   .frame(width: 21, height: 32)
                                   .cornerRadius(4)
                                }
                                else{
                                    Rectangle().fill(Color.yellow.opacity(0.2))
                                   .frame(width: 21, height: 32)
                                   .cornerRadius(4)
                                }
                                
                                
                                   
                        }
                        }
                        HStack(spacing: 10){
                            ForEach(20..<24) {i in
                                Rectangle()
                                .fill(EmptyArray[i] == "R" ? Color.yellow : Color.yellow.opacity(0.2))
                                    .frame(width: 74, height: 32)
                                    .cornerRadius(4)
                            }
                        }
                    }
                    
                }
                }
                ZStack{
                    Rectangle()
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .frame(width: 358, height: 54)
              pickerDate(date:$date)
                    .padding()
                    
                    
            }
                Spacer()
            }
            
            .onAppear(perform: {
                       DisplayDate()
                   })
            
        }
    }

func DisplayDate (){
 Timer.scheduledTimer(withTimeInterval: 0.2,repeats: true, block: { _ in
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
     EmptyArray = BerlinClock.getResult(hour, minute, second).map{String($0)}
})
    
}
        
}

struct ViewCalendar : View{
    @Binding var date : Date
    var body: some View{
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        let sminute = String(format: "%02i", minute)
        let ssecond = String(format: "%02i", second)
        let shour = String(format: "%02i", hour)
        Text("Time is \(shour): \(sminute) : \(ssecond) ")
            .frame(height: 32)
            .foregroundColor(.black)
            .font(.system(size: 20, weight: .bold))
        
    }
}



struct pickerDate : View{
    @Binding var date : Date
    var body:some View{
        HStack{
            DatePicker("Insert Time", selection: $date, displayedComponents: .hourAndMinute)
                .foregroundColor(.black)
                .environment(\.locale, Locale(identifier: "ru-RU"))
        }
        .padding([.leading, .trailing])
    }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
