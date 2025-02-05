//
//  ContentView.swift
//  partFinder
//
//  Created by Gerardo Cervantes on 2/5/25.
//

/*
 Welcome to partFinder team
 
 
 */
import SwiftUI

struct Vehicle: Identifiable, Hashable {
    let id = UUID()
    var make: String
    var model: String
    var year: String
    var color: String
}

struct ContentView: View {
    @State private var vehicles: [Vehicle] = []
    @State private var selectedVehicle: Vehicle? = nil
    @State private var make: String = ""
    @State private var model: String = ""
    @State private var year: String = ""
    @State private var color: String = ""
    @State private var showPartsDropdown: Bool = false
    
    let relevantParts = ["Battery", "Oil Filter", "Brake Pads", "Spark Plugs", "Air Filter", "Tires", "FIXME: add more options?"]

    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 100) // ensures font begins under "dynamic island"
                
                // Title with centered dash & navigation to home
                VStack {
                    Button(action: {
                        selectedVehicle = nil // Reset selection to show vehicle list
                    }) {
                        Text("partFinder")
                            .font(.custom("SnellRoundhand-Bold", size: 45)) // font style: cursive
                            .foregroundColor(Color.blue.opacity(500)) // font color
                            .underline()
                    }
                }
                .padding(.bottom, 110)

                if let vehicle = selectedVehicle {
                    // Display selected vehicle info
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Selected Vehicle:")
                            .font(.title2)
                            .foregroundColor(.white)
                        
                        Text("Make: \(vehicle.make)")
                        Text("Model: \(vehicle.model)")
                        Text("Year: \(vehicle.year)")
                        Text("Color: \(vehicle.color)")
                    }
                    .foregroundColor(.blue)
                    .padding()

                    // Dropdown for relevant parts
                    VStack {
                        Button(action: {
                            showPartsDropdown.toggle()
                        }) {
                            Text("Show Relevant Parts")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.8))
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }

                        if showPartsDropdown {
                            VStack {
                                ForEach(relevantParts, id: \.self) { part in
                                    Text(part)
                                        .font(.body)
                                        .foregroundColor(.white)
                                        .padding(5)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.gray.opacity(0.3))
                                        .cornerRadius(5)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }

                    // Option to go back and select another vehicle
                    Button(action: {
                        selectedVehicle = nil
                    }) {
                        Text("Select Another Vehicle")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red.opacity(0.8))
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                } else {
                    if !vehicles.isEmpty {
                        // Show list of stored vehicles for selection
                        Text("Select a Vehicle or Add a New One:")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.bottom, 5)

                        ForEach(vehicles, id: \.self) { vehicle in
                            Button(action: {
                                selectedVehicle = vehicle
                            }) {
                                Text(vehicle.model)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue.opacity(0.8))
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                            }
                        }

                        Text("Or Add a New Vehicle:")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                    }

                    // Vehicle Info Inputs
                    VStack(spacing: 20) {
                        TextField("Make", text: $make)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)

                        TextField("Model", text: $model)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)

                        TextField("Year", text: $year)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)

                        TextField("Color", text: $color)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 10)

                    // Save Vehicle Button
                    Button(action: {
                        if !make.isEmpty && !model.isEmpty && !year.isEmpty && !color.isEmpty {
                            let newVehicle = Vehicle(make: make, model: model, year: year, color: color)
                            vehicles.append(newVehicle) // Save new vehicle
                            selectedVehicle = newVehicle // Select the newly added vehicle
                            make = ""
                            model = ""
                            year = ""
                            color = ""
                        }
                    }) {
                        Text("Save Vehicle")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.8))
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black) // Black background
            .ignoresSafeArea() // Extends background to full screen
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

