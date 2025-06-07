# NYC Yellow Taxi Fare Prediction using R

## 🚕 Project Overview

This project presents a robust and accurate fare prediction system for NYC Yellow Taxi rides using advanced machine learning techniques implemented in **R**. We built a custom regression model enhanced with **Ridge regularization**, **Huber loss**, and **feature-specific penalties** to handle real-world noise and outliers effectively. The final model is deployed as a user-friendly **R Shiny web application** for real-time fare estimation.

---

## 📊 Problem Statement

With the exponential growth of ride-hailing platforms, precise fare estimation is essential for customer transparency and platform efficiency. However, standard regression techniques often fall short due to:

- Sensitivity to outliers
- Multicollinearity between features
- Lack of transparency in ensemble models

---

## 🧪 Dataset

- **Source:** New York City Taxi and Limousine Commission (TLC)
- **Format:** Parquet (12 months merged)
- **Key Features:**
  - `pickup_datetime`, `trip_distance`, `passenger_count`
  - Engineered fields: `trip_duration`, `hour_of_day`, `day_of_week`, `is_weekend`, `is_peak_hour`

---

## 🧼 Data Preprocessing

- Removed negative/zero values and outliers (e.g. fare > $600, distance > 80 miles)
- Imputed missing values
- Formatted datetime and categorical variables
- Engineered features for trip time categories, peak hour flags, and durations

---

## 🧠 Methodology

### 🔧 Custom Ridge Regression with Huber Loss

We implemented a **Ridge-regularized linear model** with the following enhancements:
- **Huber Loss Function** for robustness to outliers
- **Feature-specific Ridge Penalty**, inversely scaled by variance
- **Gradient Descent Optimization** with adaptive learning rate

**Objective Function:**
`L(β) = (1/n) * Huber(y - Xβ) + λ * ω * β²`


Where:
- `Huber(r)` = quadratic for small residuals, linear for large ones
- `λ` = regularization parameter
- `ω` = feature variance weight
- `β` = coefficients

---

## 💻 Tools & Technologies

- **Language:** R
- **Libraries:** `dplyr`, `caret`, `Metrics`, `arrow`, `shiny`
- **Model Storage:** `saveRDS()`
- **Deployment:** Shiny Web App

---

## 📈 Evaluation

- **Metrics Used:**
  - RMSE (Root Mean Square Error)
  - MAE (Mean Absolute Error)

### 🖼️ Visual Insights
- **Predicted vs Actual Plot** shows underfitting due to regularization
- **Residual Distribution** highlights right-skewed errors (model is conservative)
- **Feature Importance** ranks `is_weekend`, `is_peak_hour` as most significant

---

## 🌐 R Shiny Web App

A clean and interactive UI allows users to:
- Input trip attributes like distance, duration, time, and passenger count
- Predict fare instantly using the trained model
- Visualize prediction results live

---

## 🚀 Results

- Strong performance in noisy and real-world data scenarios
- The model generalizes well due to Huber robustness and Ridge regularization
- Practical deployment through a Shiny app for non-technical users

---

## 🧑‍💻 Contributors

- Samiksha Solanke - [samiksha.solanke23@vit.edu](mailto:samiksha.solanke23@vit.edu)
- Mangesh Tale, Rutika Shripati, Rupesh Sonawane, Swaraj Patil
- Guide: Prof. Ranjeetsingh Suryawanshi

---
