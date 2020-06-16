
protocol ViewCode {
    func buildView()
    func setupConstraints()
    func setupAdditionalConfigs()
    func setupView()
}

extension ViewCode {
    func setupView() {
        buildView()
        setupConstraints()
        setupAdditionalConfigs()
    }
}
