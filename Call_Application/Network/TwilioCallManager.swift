import TwilioVoice

class TwilioManager: NSObject, CallDelegate {
    func callDidFailToConnect(call: Call, error: Error) {
        print("sıkıntı mı var")
    }
    
    static let shared = TwilioManager()

    private var accessToken: String?
    private var call: Call?

    func configureTwilio(accessToken: String, deviceToken: Data?) {
        self.accessToken = accessToken
        
        let audioDevice = DefaultAudioDevice()
        TwilioVoiceSDK.audioDevice = audioDevice
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .voiceChat, options: [])
            try audioSession.setActive(true)
        } catch {
            print("Failed to configure AVAudioSession: \(error)")
        }
        
        TwilioVoiceSDK.register(accessToken: accessToken, deviceToken: deviceToken ?? Data()) { error in
            if let error = error {
                print("Failed to register Twilio Voice: \(error)")
            } else {
                print("Twilio Voice registered successfully")
            }
        }
    }


    func makeCall(to recipient: String) {
        guard let accessToken = self.accessToken else {
            print("Access token not set.")
            return
        }
        
        let uuid = UUID()
        let connectOptions = ConnectOptions(accessToken: accessToken) { builder in
            builder.params = ["To": recipient]
            builder.uuid = uuid
        }
        
        self.call = TwilioVoiceSDK.connect(options: connectOptions, delegate: self)
    }

    func disconnectCall() {
        self.call?.disconnect()
    }

    // MARK: - CallDelegate methods

    func callDidConnect(call: Call) {
        print("Call connected")
    }

    func callDidDisconnect(call: Call, error: Error?) {
        print("Call disconnected")
    }
}






 
