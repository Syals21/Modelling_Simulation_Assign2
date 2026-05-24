# 🏥 Dynamic Emergency Triage System

**A Real-Time Hospital Queue Optimization Simulation**

An interactive, data-driven simulation that models patient routing, waiting time dynamics, and clinical deterioration in emergency departments. This assignment demonstrates advanced discrete-event simulation techniques combined with machine learning-inspired decision algorithms.

## 🔗 Live Demo
**Play with the simulation here:** [syals21.github.io/Modelling_Simulation_Assign2](https://syals21.github.io/Modelling_Simulation_Assign2/)

---

## 📋 Overview

This project simulates a real-world emergency department with three distinct clinical units:
- **ICU** (Intensive Care Unit) - Critical patients, limited capacity
- **ER** (Emergency Room) - General emergency cases
- **Fast Track** - Non-critical, minor cases

The system intelligently **routes patients to appropriate units** based on:
- **Clinical Severity** (ESI triage levels)
- **Wait Times** (dynamically updated queue lengths)
- **Unit Capacity** (service rates per hour)

### Key Innovation: The Utility-SoftMax Model

Instead of simple triage rules, the system uses a **probabilistic routing algorithm**:

$$U_i = \beta_1 \cdot S - \beta_2 \cdot W$$

Where:
- $U_i$ = Utility score for unit $i$
- $S$ = Patient severity score
- $W$ = Estimated wait time
- $\beta_1$ = Unit-specific severity weight (captures clinical appropriateness)
- $\beta_2$ = Wait penalty coefficient (0.06)

Utilities are converted to probabilities using **SoftMax**, allowing the system to make nuanced routing decisions.

---

## 🧬 Core Features

### 1. **Real-Time Patient Routing**
- Register new patients with ESI triage levels (1=Critical to 5=Minor)
- Automatic intelligent queue assignment
- Dynamic wait time estimation

### 2. **Service Rate Control**
- Adjust ICU, ER, and Fast Track capacities (patients/hour)
- Observe how bottlenecks form and propagate

### 3. **Patient Deterioration Model**
- Patients who wait deteriorate according to: $S_{new} = S_{old} + \gamma \cdot W$
- Deterioration rate: $\gamma = 0.02$ severity points per minute
- System alerts when waiting degrades ESI level

### 4. **Time Simulation Engine**
- Advance time in 15-minute increments
- Watch discharge patterns based on service capacity
- Track patient flow through the system

### 5. **Live Analytics Dashboard**
- **Severity Trend Chart** - Real-time monitoring of average patient acuity
- **Live Queue Status** - Current wait times for each unit
- **Patient Log** - Complete audit trail of arrivals and discharges
- **Clinical Alerts** - Flag patients with deteriorating conditions

---

## 🎯 Educational Value

This simulation demonstrates:
- **Discrete Event Simulation (DES)** - Core modeling paradigm
- **Queueing Theory** - Service rates, utilization, wait times
- **Utility Theory & Decision Making** - Rational choice under constraints
- **Probabilistic Algorithms** - SoftMax for decision-making
- **System Dynamics** - Feedback loops between wait times and patient outcomes

---

## 💻 Technical Stack

- **Frontend**: HTML5 + Vanilla JavaScript
- **Visualization**: Chart.js for real-time trends
- **Styling**: Glassmorphism design with CSS backdrop filters
- **Backend**: Pure JavaScript simulation engine (client-side)
- **Modeling**: MATLAB/Octave for mathematical validation

---

## 📊 Example Scenario

1. **Add Patient P1** with ESI 2 (High Urgency, S=6.8)
   - System routes based on wait times and capacity
   
2. **Add Patient P2** with ESI 4 (Low Urgency, S=2.8)
   - Different routing logic due to lower severity
   
3. **Advance Time by 15 minutes**
   - Patients receive treatment based on unit capacity
   - Waiting patients deteriorate
   - Discharges appear in the log
   
4. **Monitor the Severity Chart**
   - Watch average acuity trends as the simulation progresses

---

## 🔬 Mathematical Foundation

### Deterioration Equation
$$S(t+\Delta t) = S(t) + \gamma \cdot \Delta t$$

Where $\gamma = 0.02$ (severity points per minute waiting)

### Unit Capacities
- ICU: 0.5 patients/hour (120 min per patient)
- ER: 5.0 patients/hour (12 min per patient)
- Fast Track: 12.0 patients/hour (5 min per patient)

### Severity Scoring (ESI Triage)
| Level | Severity Score | Severity |
|-------|--------|----------|
| ESI 1 | 8.8 | Critical |
| ESI 2 | 6.8 | High Urgency |
| ESI 3 | 4.8 | Moderate |
| ESI 4 | 2.8 | Low Urgency |
| ESI 5 | 0.8 | Minor |

---

## 🚀 Getting Started

1. **Open the [live demo](https://syals21.github.io/Modelling_Simulation_Assign2/)** in your browser
2. **Adjust unit capacities** using the control panel
3. **Register patients** one at a time with different ESI levels
4. **Advance time** and observe routing and deterioration
5. **Experiment** with different capacity scenarios

---

## 📁 Project Structure

```
├── index.html                          # Interactive simulation dashboard
├── Assign2ModellingOctave.m           # MATLAB/Octave mathematical model
└── README.md                           # This file
```

---

## 🎓 Assignment Context

This project is Assignment 2 in a **Modelling & Simulation** course, focusing on:
- Implementing discrete-event simulation logic
- Translating mathematical models into code
- Creating interactive tools to explore system behavior
- Validating simulation results against theoretical predictions

---

## 🔧 How to Modify & Extend

### Change Deterioration Rate
Edit in `index.html` (line ~207):
```javascript
const GAMMA = 0.02; // Severity points per minute
```

### Adjust Unit-Specific Weights
```javascript
const BETA1 = { ICU: 2.0, ER: 1.2, FT: 0.2 };
const BETA2 = 0.06;
```

### Add More Patient ESI Levels
Modify the patient registration dropdown to add custom severity values.

---

## 💡 Key Insights

- **Bottlenecks Cascade**: When one unit is full, high-acuity patients may overflow to less appropriate units
- **Waiting Kills**: Even brief waits significantly deteriorate patient severity
- **Capacity is King**: Service rate adjustments have the largest impact on system performance
- **Dynamic Routing Wins**: Probabilistic routing outperforms fixed triage rules

---

## 📝 License

Educational project - feel free to fork and extend for your own learning.

---

**Last Updated:** May 2026 | **Status:** Active Development