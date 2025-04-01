//
//  CurrencyChartView.swift
//  cowrywise-currency-konvat
//
//  Created by Ayokunle Fatokimi on 31/03/2025.
//

import UIKit
import DGCharts

class CurrencyChartView: UIView {

    // MARK: Views
    private let chartView: LineChartView = {
        let chart = LineChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.noDataText = "No data available"
        chart.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
        chart.xAxis.labelTextColor = .white
        chart.xAxis.labelPosition = .bottom
        chart.leftAxis.labelTextColor = .white
        chart.rightAxis.labelTextColor = .white
        chart.isMultipleTouchEnabled = false
        chart.isUserInteractionEnabled = false
        chart.accessibilityIdentifier = "chartView"
        return chart
    }()

    let timeSegmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Past 30 days", "Past 90 days"])
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        
        // Set text color for normal and selected states
        control.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        control.setTitleTextAttributes([.foregroundColor: UIColor.blue], for: .selected)
        control.accessibilityIdentifier = "timeSegmentControl"
        return control
    }()

    private let rateLabel: UILabel = {
        let label = UILabel()
        label.text = "1 EUR = 1,300"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.8)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "rateLabel"
        return label
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupUI()
        setupConstraints()
        setupChartData()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
        setupUI()
        setupConstraints()
        setupChartData()
    }

    // MARK: - UI Setup
    private func setupUI() {
        addSubview(timeSegmentControl)
        addSubview(chartView)
        addSubview(rateLabel)
        
        timeSegmentControl.addTarget(self, action: #selector(setSegmentData(_:)), for: .primaryActionTriggered)
    }

    // MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            timeSegmentControl.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            timeSegmentControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            chartView.topAnchor.constraint(equalTo: timeSegmentControl.bottomAnchor, constant: 10),
            chartView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            chartView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            chartView.heightAnchor.constraint(equalToConstant: 350),
            
            rateLabel.centerXAnchor.constraint(equalTo: chartView.centerXAnchor),
            rateLabel.centerYAnchor.constraint(equalTo: chartView.centerYAnchor, constant: -100),
            rateLabel.widthAnchor.constraint(equalToConstant: 150),
            rateLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    // MARK: Chart Data
    private func setupChartData(
        dates: [Int] = [01, 07, 15, 23, 30],
        values: [Double] = [1200, 1300, 1250, 1350, 1300]
    ) {
        var entries: [ChartDataEntry] = []
        for i in 0..<dates.count {
            let entry = ChartDataEntry(x: Double(i), y: values[i])
            entries.append(entry)
        }

        let dataSet = LineChartDataSet(entries: entries, label: "")
        dataSet.colors = [.white]
        dataSet.circleColors = [.green]
        dataSet.circleRadius = 5
        dataSet.valueTextColor = .white
        dataSet.mode = .cubicBezier
        dataSet.drawFilledEnabled = true
        dataSet.fillColor = .white
        dataSet.fillAlpha = 0.35

        let data = LineChartData(dataSet: dataSet)
        chartView.data = data
    }
    
    @objc func setSegmentData(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case .zero:
            rateLabel.text = "1 EUR = 1,300"
            setupChartData()
        case 1:
            setupChartData(dates: [1, 7, 15, 23], values: [1150, 1000, 1200, 1200])
            rateLabel.text = "1 USD = 1,200"
        default:
            break
        }
    }
}
