import UIKit

class ViewController: UIViewController {
    
    private let notificationLabel = UILabel()
    private let soundLabel = UILabel()
    private let themeLabel = UILabel()
    private let languageLabel = UILabel()
    
    private let notificationSwitch = UISwitch()
    private let soundSwitch = UISwitch()
    
    private let themePickerView = UIPickerView()
    private let languagePickerView = UIPickerView()
    
    private let saveButton = UIButton(type: .system)
    private let resetButton = UIButton(type: .system)
    
    let themes = ["Light", "Dark", "System"]
    let languages = ["English", "Russian", "Spanish"]
    var selectedTheme = "Light"
    var selectedLanguage = "Russian"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabels()
        setupSwitches()
        setupPickers()
        setupButtons()
        setupStacks()
        loadSettings()
    }
}

// MARK: - setup labels

private extension ViewController {
    
    func setupLabels() {
        let labels: [(label: UILabel, text: String)] = [
            (notificationLabel, "Notifications"),
            (soundLabel, "Sound effects"),
            (themeLabel, "Theme"),
            (languageLabel, "Language")
        ]
        
        labels.forEach { label, text in
            label.text = text
            label.textAlignment = .left
            label.font = .systemFont(ofSize: 22, weight: .light)
        }
    }
}

// MARK: - setup switches

private extension ViewController {
    
    func setupSwitches() {
        
        notificationSwitch.isOn = true
        notificationSwitch.onTintColor = .systemBlue
        
        soundSwitch.isOn = true
        soundSwitch.onTintColor = .systemBlue
    }
}

// MARK: - setup pickers

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func setupPickers() {
        
        themePickerView.delegate = self
        themePickerView.dataSource = self
        
        languagePickerView.delegate = self
        languagePickerView.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == themePickerView {
            return themes.count
        } else if pickerView == languagePickerView {
            return languages.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == themePickerView {
            return themes[row]
        } else if pickerView == languagePickerView {
            return languages[row]
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == themePickerView {
            selectedTheme = themes[row]
            applyTheme(selectedTheme)
        } else if pickerView == languagePickerView {
            selectedLanguage = languages[row]
            applyLanguage(selectedLanguage)
        }
    }
    
    func applyTheme(_ theme: String) {
        switch theme {
        case "Light":
            overrideUserInterfaceStyle = .light
        case "Dark":
            overrideUserInterfaceStyle = .dark
        default:
            overrideUserInterfaceStyle = .unspecified
        }
    }
    
    func applyLanguage(_ language: String) {
        switch language {
        case "Russian":
            notificationLabel.text = "Уведомления"
            soundLabel.text = "Звуки"
            themeLabel.text = "Тема"
            languageLabel.text = "Язык"
            saveButton.setTitle("Сохранить", for: .normal)
            resetButton.setTitle("Сбросить", for: .normal)
        case "Spanish":
            notificationLabel.text = "Notificaciones"
            soundLabel.text = "Sonidos"
            themeLabel.text = "Tema"
            languageLabel.text = "Idioma"
            saveButton.setTitle("Guardar", for: .normal)
            resetButton.setTitle("Restablecer", for: .normal)
        default:
            notificationLabel.text = "Notifications"
            soundLabel.text = "Sound effects"
            themeLabel.text = "Theme"
            languageLabel.text = "Language"
            saveButton.setTitle("Save", for: .normal)
            resetButton.setTitle("Reset", for: .normal)
        }
    }
}

// MARK: - setup buttons

private extension ViewController {
    
    func setupButtons() {
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 10
        saveButton.addTarget(self, action: #selector(saveSettings), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        resetButton.setTitle("Reset", for: .normal)
        resetButton.backgroundColor = .systemRed
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.layer.cornerRadius = 10
        resetButton.addTarget(self, action: #selector(resetSettings), for: .touchUpInside)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

// MARK: - setup stacks

private extension ViewController {
    
    func setupStacks() {
        
        let notificationStack = UIStackView(arrangedSubviews: [notificationLabel, notificationSwitch])
        notificationStack.axis = .horizontal
        notificationStack.spacing = 10
        notificationStack.distribution = .fill
        notificationLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        notificationSwitch.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let soundStack = UIStackView(arrangedSubviews: [soundLabel, soundSwitch])
        soundStack.axis = .horizontal
        soundStack.spacing = 10
        soundStack.distribution = .fill
        soundLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        soundSwitch.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let themeStack = UIStackView(arrangedSubviews: [themeLabel, themePickerView])
        themeStack.axis = .vertical
        themeStack.spacing = 10
        
        let languageStack = UIStackView(arrangedSubviews: [languageLabel, languagePickerView])
        languageStack.axis = .vertical
        languageStack.spacing = 10
        
        let buttonStack = UIStackView(arrangedSubviews: [saveButton, resetButton])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 20
        buttonStack.distribution = .fillEqually
        
        let mainStack = UIStackView(arrangedSubviews: [
            notificationStack,
            soundStack,
            themeStack,
            languageStack,
            buttonStack
        ])
        mainStack.axis = .vertical
        mainStack.spacing = 30
        mainStack.alignment = .fill
        
        view.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

// MARK: - objc функции

private extension ViewController {
    
    @objc func saveSettings() {
        let notificationEnabled = notificationSwitch.isOn
        let soundsEnabled = soundSwitch.isOn
        
        let defaults = UserDefaults.standard
        defaults.set(notificationEnabled, forKey: "notificationsEnabled")
        defaults.set(soundsEnabled, forKey: "soundsEnabled")
        defaults.set(selectedTheme, forKey: "selectedTheme")
        defaults.set(selectedLanguage, forKey: "selectedLanguage")
        
        let alert = UIAlertController(
            title: "Saved",
            message: "Your settings successfully saved",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func resetSettings() {
        let alert = UIAlertController(
            title: "Are you sure?",
            message: "This will delete all your saved settings",
            preferredStyle: .alert
        )
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "notificationsEnabled")
            defaults.removeObject(forKey: "soundsEnabled")
            defaults.removeObject(forKey: "selectedTheme")
            defaults.removeObject(forKey: "selectedLanguage")
            defaults.removeObject(forKey: "hasLaunchedBefore")
            
            self.resetUI()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - load and reset settings

private extension ViewController {
    
    func loadSettings() {
        
        let defaults = UserDefaults.standard
        
        if !defaults.bool(forKey: "hasLaunchedBefore") {
            resetUI()
            defaults.set(true, forKey: "hasLaunchedBefore")
            return
        }
        
        let notificationsEnabled = defaults.bool(forKey: "notificationsEnabled")
        let soundsEnabled = defaults.bool(forKey: "soundsEnabled")
        selectedTheme = defaults.string(forKey: "selectedTheme") ?? "Light"
        selectedLanguage = defaults.string(forKey: "selectedLanguage") ?? "English"
        
        notificationSwitch.isOn = notificationsEnabled
        soundSwitch.isOn = soundsEnabled
        
        if let themeIndex = themes.firstIndex(of: selectedTheme) {
            themePickerView.selectRow(themeIndex, inComponent: 0, animated: false)
        }
        
        if let languageIndex = languages.firstIndex(of: selectedLanguage) {
            languagePickerView.selectRow(languageIndex, inComponent: 0, animated: false)
        }
        
        applyTheme(selectedTheme)
        applyLanguage(selectedLanguage)
    }
    
    func resetUI() {
        
        notificationSwitch.isOn = true
        soundSwitch.isOn = true
        
        selectedTheme = "Light"
        selectedLanguage = "English"
        
        themePickerView.selectRow(0, inComponent: 0, animated: true)
        languagePickerView.selectRow(0, inComponent: 0, animated: true)
        
        applyTheme(selectedTheme)
        applyLanguage(selectedLanguage)
    }
}

// MARK: - Preview

#Preview(traits: .portrait) {
    ViewController()
}
