//
//  ContentView.swift
//  BetterReast
//
//  Created by Suyash on 05/04/24.
//

import CoreML
import SwiftUI


struct ContentView: View {
    @State private var wakeUp = defaultDate
    @State private var sleepHours = 8.00
    @State private var coffeCups = 1
    
    @State private var recommendedSleepTime = ""
    
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    @State private var showAlert = false
    
    static var defaultDate : Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        
            NavigationStack{
                Form {
                    Section("Select wakeup time ☀️"){
                        VStack(alignment: .leading , spacing: 0){
                            Text("When do you want to wakeup")
                                .font(.title3)
                                .padding()
                                .bold()
                            DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                                .padding()
                        }
                        
                    }
                    Section("Select hours of sleep 💤"){
                        VStack(alignment: .leading , spacing: 0){
                            Text("How many hours of sleep")
                                .font(.title3)
                                .padding()
                                .bold()
                            Stepper("\(sleepHours.formatted()) Hours", value: $sleepHours ,in: 4...12 , step: 0.25)
                                .padding()
                                .bold()
                        }
                    }
                    Section("Select number of coffee cups ☕️"){
                        VStack(alignment: .leading , spacing: 0){
                            Text("Total coffee intake of today")
                                .font(.title3)
                                .bold()
                                .padding()
                            Picker("Coffee Cups",selection: $coffeCups){
                                ForEach(1..<21){
                                    Text("^[\($0) cups](inflect:true)")
                                }
                            }
                            .padding()
                            .bold()
                        }
                    }
                    Section("Recommended sleep"){
                        Text(recommendedSleepTime)
                            .font(.largeTitle)
                            .bold()
                    }
                }
                .navigationTitle("BetterRest👾")
                .alert(alertTitle , isPresented: $showAlert){
                    Button("OK!!"){ }
                }message: {
                    Text(alertMsg)
                }
                .onChange(of: wakeUp, calculateBedTime)
                .onChange(of: sleepHours, calculateBedTime)
                .onChange(of: coffeCups, calculateBedTime)
            }
    }
    func calculateBedTime(){
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour , .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0)  * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep:sleepHours, coffee: Double(coffeCups))
            let sleepTime = wakeUp - prediction.actualSleep
            
            recommendedSleepTime = "\(sleepTime.formatted(date: .omitted, time: .shortened))"
            
        }catch{
            alertTitle = "ERROR!!!"
            alertMsg = "There was a prediction Error"
            showAlert = true
        }
        
    }
}

#Preview {
    ContentView()
}
