//
//  ContentView.swift
//  AppCounter
//
//  Created by claudio.f.raposo on 06/03/22.
//

import SwiftUI

class Counter: ObservableObject {
    
    @Published var days = 0;
    @Published var hours = 0;
    @Published var minutes = 0;
    @Published var seconds = 0;
    
    var selectedDate = Date()
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            timer in
            let calendar = Calendar.current
            
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
            
            let currentDate = calendar.date(from: components)
            
            let selectedComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.selectedDate)
            
            var eventDateComponents = DateComponents()
            eventDateComponents.year = selectedComponents.year
            eventDateComponents.month = selectedComponents.month
            eventDateComponents.day = selectedComponents.day
            eventDateComponents.hour = selectedComponents.hour
            eventDateComponents.minute = selectedComponents.minute
            eventDateComponents.second = selectedComponents.second
            
            let eventDate = calendar.date(from: eventDateComponents)
            
            let timeLeft = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate!, to: eventDate!)
            
            if(timeLeft.second! >= 0){
                self.days = timeLeft.day!
                self.hours = timeLeft.hour!
                self.minutes = timeLeft.minute!
                self.seconds = timeLeft.second!
            }
        }
    }
}

struct ContentView: View {
    
    @StateObject var counter =  Counter()
    
    var body: some View {
        VStack{
            DatePicker(selection: $counter.selectedDate, in: Date()..., displayedComponents: [
                .hourAndMinute, .date
            ]) {
                Text("Selecione e data: ")
            }
            HStack{
                Text("\(counter.days) dias")
                    .padding()
                    .background(Color.blue)
                Text("\(counter.hours) horas")
                Text("\(counter.minutes) min")
                Text("\(counter.seconds) seg")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
