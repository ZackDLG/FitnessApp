import SwiftUI
import WebKit
import AVKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                // Full Body Workout Card (Clickable)
                NavigationLink(
                    destination: WorkoutListView(
                        workouts: workoutData.first { $0.day == "Full Body" }?.workouts ?? [],
                        title: "Full Body Workout"
                    )
                ) {
                    ZStack {
                        Image("fullbody")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .clipped()
                            .overlay(
                                Color.black.opacity(0.3)
                            )
                            .contrast(1.1)
                            .brightness(-0.05)
                            .shadow(color: .black.opacity(0.6), radius: 8, x: 0, y: 4)
                            .accessibilityLabel("Full Body Workout for Beginners")
                        
                        VStack(spacing: 10) {
                            Spacer()
                            Text("Full Body Workout")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                            
                            Text("For Beginners")
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                    .frame(width: 380, height: 300)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
                    .padding(.top, 20)
                }
                
                // Weekly Plan Title
                Text("Weekly Plan")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.top, 20)
                
                // Horizontal Scroll View for Other Days
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(workoutData.filter { $0.day != "Full Body" }, id: \.day) { workout in
                            NavigationLink(destination: WorkoutListView(workouts: workout.workouts, title: workout.day)) {
                                workoutCard(workout.image, day: workout.day, workout: workout.category)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 320)
                
                Spacer()
            }
            .navigationBarTitle("Home", displayMode: .inline)
        }
    }
    
    func workoutCard(_ imageName: String, day: String, workout: String) -> some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 300) // Original card size
                .clipped()
                .cornerRadius(20)
                .overlay(
                    Color.gray.opacity(0.5)
                )
                .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
            
            VStack(spacing: 10) {
                Spacer()
                Text(day)
                    .font(.system(size: 36))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(workout)
                    .font(.title2)
                    .fontWeight(.regular)
                    .foregroundColor(.white)
            }
            .padding()
        }
        .frame(width: 300, height: 300) // Original frame size
        .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
    }
}



struct WorkoutListView: View {
    var workouts: [Workout]
    var title: String

    var body: some View {
        List(workouts) { workout in
            NavigationLink(destination: ExerciseDetailView(workout: workout)) {
                HStack {
                    Image(workout.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Text(workout.name)
                        .font(.headline)
                        .padding(.leading, 10)
                }
            }
        }
        .navigationTitle(title)
    }
}



struct Workout: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let sets: Int
    let reps: Int
    let steps: [String]
    let videoURL: String // Add this property for the video URL
}



struct WorkoutDay: Identifiable {
    let id = UUID()
    let day: String
    let category: String
    let image: String
    let workouts: [Workout]
}

let workoutData: [WorkoutDay] = [
    WorkoutDay(day: "Monday", category: "Chest", image: "chest", workouts: [
        Workout(
            name: "Bench Press",
            imageName: "benchpress",
            sets: 3,
            reps: 10,
            steps: [
                "Lie flat on your back on a bench.",
                "Grip the barbell slightly wider than shoulder-width apart.",
                "Lower the barbell to your chest, keeping your elbows at a 45-degree angle.",
                "Press the barbell upward until your arms are fully extended.",
                "Repeat for the recommended number of reps."
            ],
            videoURL: "https://www.youtube.com/embed/gRVjAtPip0Y"
        ),
        Workout(
            name: "Push-Up",
            imageName: "pushups",
            sets: 3,
            reps: 12,
            steps: [
                "Start in a plank position with your hands directly under your shoulders.",
                "Lower your chest toward the floor, keeping your elbows close to your body.",
                "Push back up to the starting position.",
                "Repeat for the recommended number of reps."
            ],
            videoURL: "https://www.youtube.com/embed/IODxDxX7oi4"
        ),
        Workout(
            name: "Dumbbell Fly",
            imageName: "dumbbellfly",
            sets: 3,
            reps: 12,
            steps: [
                "Lie on a flat bench holding a dumbbell in each hand above your chest.",
                "Slowly lower the dumbbells in an arc until your arms are at chest level.",
                "Bring the dumbbells back to the starting position in the same arc motion.",
                "Repeat for the recommended number of reps."
            ],
            videoURL: "https://www.youtube.com/embed/eozdVDA78K0"
        )
    ]),
    WorkoutDay(day: "Tuesday", category: "Back", image: "back", workouts: [
        Workout(
            name: "Pull-Up",
            imageName: "pullup",
            sets: 3,
            reps: 8,
            steps: [
                "Grab the pull-up bar with an overhand grip, slightly wider than shoulder-width.",
                "Hang with your arms fully extended.",
                "Pull yourself up until your chin is above the bar.",
                "Lower yourself back down to the starting position.",
                "Repeat for the recommended number of reps."
            ],
            videoURL: "https://www.youtube.com/embed/eGo4IYlbE5g"
        ),
        Workout(
            name: "Deadlift",
            imageName: "deadlift",
            sets: 3,
            reps: 10,
            steps: [
                "Stand with your feet hip-width apart and the barbell in front of you.",
                "Hinge at your hips and bend your knees to grip the barbell.",
                "Engage your core and lift the barbell by straightening your hips and knees.",
                "Lower the barbell back to the ground in a controlled manner.",
                "Repeat for the recommended number of reps."
            ],
            videoURL: "https://www.youtube.com/embed/r4MzxtBKyNE"
        ),
        Workout(
            name: "Rowing",
            imageName: "rowing",
            sets: 3,
            reps: 12,
            steps: [
                "Sit on the rowing machine and secure your feet on the footrests.",
                "Grab the handle with both hands and extend your legs fully.",
                "Pull the handle toward your chest while leaning slightly backward.",
                "Extend your arms and return to the starting position.",
                "Repeat for the recommended number of reps."
            ],
            videoURL: "https://www.youtube.com/embed/UCXxvVItLoM"
        )
    ]),
    WorkoutDay(day: "Wednesday", category: "Arms", image: "arms", workouts: [
        Workout(
            name: "Bicep Curl",
            imageName: "bicepcurl",
            sets: 3,
            reps: 12,
            steps: [
                "Stand with your feet shoulder-width apart, holding a dumbbell in each hand.",
                "Keep your elbows close to your torso and palms facing forward.",
                "Curl the dumbbells up to shoulder level.",
                "Lower the dumbbells back to the starting position in a controlled manner.",
                "Repeat for the recommended number of reps."
            ],
            videoURL: "https://www.youtube.com/embed/in7PaeYlhrM"
        ),
        Workout(
            name: "Tricep Pushdown",
            imageName: "tricep",
            sets: 3,
            reps: 12,
            steps: [
                "Stand facing the cable machine with a rope or bar attachment.",
                "Grip the attachment with your palms facing downward.",
                "Push the attachment downward until your arms are fully extended.",
                "Slowly return to the starting position.",
                "Repeat for the recommended number of reps."
            ],
            videoURL: "https://www.youtube.com/embed/6Fzep104f0s"
        ),
        Workout(
            name: "Hammer Curl",
            imageName: "hammercurl",
            sets: 3,
            reps: 12,
            steps: [
                "Hold a dumbbell in each hand with your palms facing inward.",
                "Keep your elbows close to your torso.",
                "Curl the dumbbells up to shoulder level.",
                "Lower the dumbbells back to the starting position in a controlled manner.",
                "Repeat for the recommended number of reps."
            ],
            videoURL: "https://www.youtube.com/embed/zC3nLlEvin4"
        )
    ]),
    WorkoutDay(day: "Thursday", category: "Legs", image: "legs", workouts: [
        Workout(
            name: "Squat",
            imageName: "squat",
            sets: 3,
            reps: 12,
            steps: [
                "Stand with your feet shoulder-width apart.",
                "Lower your body by bending your knees and pushing your hips back.",
                "Keep your chest up and your knees aligned with your toes.",
                "Return to the starting position by pushing through your heels.",
                "Repeat for the recommended number of reps."
            ],
            videoURL: "https://www.youtube.com/embed/aclHkVaku9U"
        ),
        Workout(
            name: "Hamstring Curl",
            imageName: "hamstringcurl",
            sets: 3,
            reps: 12,
            steps: [
                "Adjust the machine so the pads rest just above your ankles.",
                "Lie face down on the machine and grip the handles for support.",
                "Curl your legs upward as far as possible while keeping your hips on the pad.",
                "Lower the weight back to the starting position in a controlled motion.",
                "Repeat for the recommended number of reps."
            ],
            videoURL: "https://www.youtube.com/embed/xdrPE8mB5AU"
        ),
        Workout(
            name: "Hip Thrust",
            imageName: "hipthrust",
            sets: 3,
            reps: 12,
            steps: [
                "Sit on the ground with your upper back resting on a bench and your feet flat on the floor.",
                "Place a barbell or weight across your hips.",
                "Drive through your heels to lift your hips upward until your torso is in line with your thighs.",
                "Squeeze your glutes at the top, then slowly lower your hips back to the ground.",
                "Repeat for the recommended number of reps."
            ],
            videoURL: "https://www.youtube.com/embed/gRVjAtPip0Y"
        )
    ]),
    WorkoutDay(day: "Friday", category: "Abs", image: "abs", workouts: [
        Workout(
            name: "Crunches",
            imageName: "crunch",
            sets: 3,
            reps: 15,
            steps: [
                "Lie on your back with your knees bent and feet flat on the floor.",
                "Place your hands behind your head without pulling on your neck.",
                "Lift your upper body toward your knees, engaging your core.",
                "Lower your upper body back to the starting position.",
                "Repeat for the recommended number of reps."
            ],
            videoURL: "https://www.youtube.com/embed/Xyd_fa5zoEU"
        ),
        Workout(
            name: "Plank",
            imageName: "plank",
            sets: 3,
            reps: 30,
            steps: [
                "Start in a push-up position with your elbows under your shoulders.",
                "Keep your body in a straight line from head to heels.",
                "Hold this position for the recommended time.",
                "Lower your body and rest before the next set."
            ],
            videoURL: "https://www.youtube.com/embed/Fcbw82ykBvY"
        ),
        Workout(
            name: "Russian Twist",
            imageName: "russiantwist",
            sets: 3,
            reps: 20,
            steps: [
                "Sit on the ground with your knees bent and feet slightly elevated.",
                "Hold a weight or medicine ball with both hands.",
                "Twist your torso to the right, then to the left.",
                "Repeat for the recommended number of reps."
            ],
            videoURL: "https://www.youtube.com/embed/9Vt2UQz1jRg"
        )
        
        
    ]),
    WorkoutDay(
        day: "Full Body",
        category: "Beginner Full Body",
        image: "fullbody",
        workouts: [
            Workout(
                name: "Jumping Jacks",
                imageName: "jumpingjacks",
                sets: 3,
                reps: 30,
                steps: [
                    "Stand upright with your legs together and arms by your side.",
                    "Jump up, spreading your legs shoulder-width apart and raising your arms overhead.",
                    "Return to the starting position and repeat."
                ],
                videoURL: "https://www.youtube.com/embed/lWMw6uppiFc"
            ),
            Workout(
                name: "High Knees",
                imageName: "highknees",
                sets: 3,
                reps: 30,
                steps: [
                    "Stand in place with your feet hip-width apart.",
                    "Lift one knee toward your chest while driving the opposite arm upward.",
                    "Switch legs quickly, as if running in place."
                ],
                videoURL: "https://www.youtube.com/embed/IdIlyOKozx4"
            ),
            Workout(
                name: "Mountain Climbers",
                imageName: "mountainclimbers",
                sets: 3,
                reps: 20,
                steps: [
                    "Start in a plank position with your arms straight and your hands under your shoulders.",
                    "Drive one knee toward your chest while keeping the other leg extended.",
                    "Quickly switch legs in a running motion."
                ],
                videoURL: "https://www.youtube.com/embed/nmwgirgXLYM"
            ),
            Workout(
                name: "Dynamic Stretching",
                imageName: "dynamicstretch",
                sets: 1,
                reps: 10,
                steps: [
                    "Perform arm circles, leg swings, and hip openers for 1-2 minutes.",
                    "Focus on smooth and controlled movements to loosen your joints."
                ],
                videoURL: "https://www.youtube.com/embed/AEgDzAN71PU"
            ),
            // Other existing full body exercises...
        ]
    )

]




struct ExerciseDetailView: View {
    let workout: Workout

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Video player for the workout
                if let url = URL(string: workout.videoURL) {
                    WebView(url: url)
                        .frame(height: 200)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                } else {
                    Text("Video unavailable")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding()
                }

                // Workout name
                Text(workout.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // Sets and reps
                Text("Details")
                    .font(.headline)
                HStack {
                    Text("Sets:")
                        .fontWeight(.semibold)
                    Text("\(workout.sets)")
                }
                HStack {
                    Text("Reps:")
                        .fontWeight(.semibold)
                    Text("\(workout.reps)")
                }

                // Step-by-step instructions
                Text("How to Perform")
                    .font(.headline)
                ForEach(workout.steps, id: \.self) { step in
                    HStack(alignment: .top) {
                        Text("•")
                        Text(step)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle(workout.name)
    }
}


struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = [] // Enable autoplay without user interaction
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // No updates required here since the URL doesn't change dynamically
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
