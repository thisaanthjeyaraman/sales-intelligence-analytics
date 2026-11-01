Sales Intelligence & Revenue Growth Analytics

An end-to-end business analytics project that transforms sales data into actionable insights using Python, SQL, SQLite, and Power BI.

Overview

Businesses generate large amounts of sales data but may struggle to understand which products perform best, which regions are more profitable, how customer purchasing behavior changes over time, and how discounts affect profitability.

This project analyzes sales transactions to identify business performance patterns, segment customers, evaluate product and regional performance, study discount profitability, and build a time-series sales forecasting model.

The goal is to support data-driven business decisions and identify opportunities for revenue growth and improved profitability.

Business Objectives

- Analyze sales and recorded profit across product categories and regions.
- Identify top-performing and low-performing products.
- Examine monthly sales trends and changes in business performance.
- Evaluate the relationship between discounts and profitability.
- Segment customers based on recency, frequency, and monetary value (RFM).
- Forecast monthly sales and evaluate forecasting accuracy.
- Generate insights that can support business planning and profitability improvement.

Technology Stack

| Technology | Purpose |
|---|---|
| Python | Data analysis and forecasting |
| Pandas | Data cleaning, transformation, and aggregation |
| NumPy | Numerical operations |
| Matplotlib | Data visualization |
| Scikit-learn | Forecast evaluation metrics |
| Statsmodels | Time-series forecasting |
| SQL | Querying and analyzing sales data |
| SQLite | Local relational database |
| Power BI | Interactive business intelligence dashboard |
| Jupyter Notebook | Interactive analysis and presentation |
| Git and GitHub | Version control and project portfolio |

Dataset

The dataset used in this project was obtained from **Kaggle** and is stored locally in the `data/` directory.

- **Source:** Kaggle
- **Dataset file:** `Sample - Superstore.csv`
- **Dataset page:** Add the exact Kaggle dataset URL here.

The dataset contains sales transaction records covering order details, customer information, product categories, regional performance, discounts, costs, profits, order status, and delivery information.

Important Columns

| Column | Description |
|---|---|
| `Order_ID` | Order identifier |
| `Order_Date` | Date of the order |
| `Customer_ID` | Customer identifier |
| `Customer_Age` | Customer age |
| `Product_ID` | Product identifier |
| `Category` | Product category |
| `Region` | Sales region |
| `Sales_Channel` | Channel through which the order was placed |
| `Payment_Method` | Payment method |
| `Order_Status` | Order status, such as Delivered, Shipped, Returned, or Cancelled |
| `Quantity` | Quantity ordered |
| `Unit_Price` | Price per unit |
| `Discount_Percentage` | Discount applied |
| `Gross_Sales` | Sales amount before discounts |
| `Discount_Amount` | Discount amount |
| `Net_Sales` | Sales amount after discounts |
| `Cost` | Recorded product cost |
| `Profit` | Recorded profit |
| `Shipping_Cost` | Shipping cost |
| `Customer_Rating` | Customer rating |
| `Delivery_Days` | Delivery duration in days |

Data Preparation

The dataset is inspected and processed using Python and Pandas. Data quality checks include examining missing values, duplicate records, column data types, and date ranges. The validated data is then used for SQL analysis, customer segmentation, forecasting, and Power BI visualization.

Dataset Attribution

This project uses a dataset sourced from Kaggle for educational and analytical purposes. Refer to the original Kaggle dataset page for the dataset creator, license, and usage conditions.


Project Structure

sales-intelligence-analytics/
│
├── data/
│   └── Sample - Superstore.csv
│
├── notebooks/
│   ├── 01_data_overview.ipynb
│   ├── 02_sales_trends.ipynb
│   ├── 03_category_region_analysis.ipynb
│   ├── 04_discount_profitability.ipynb
│   ├── 05_product_analysis.ipynb
│   ├── 06_customer_segmentation.ipynb
│   └── 07_sales_forecasting.ipynb
│
├── sql/
│   └── SQL analysis queries
│
├── powerbi/
│   └── Sales_Intelligence_Dashboard_New.pbix
│
├── load_ecommerce_data.py
├── audit_ecommerce_data.py
├── analyze_order_status.py
├── sales_ecommerce.db
├── README.md
└── requirements.txt

Analytical Modules

1. Data Overview and Quality Checks

- Inspect dataset dimensions and column data types.
- Check missing values and duplicate records.
- Review numerical summaries and order status distributions.
- Examine the date range and basic dataset quality.

2. Sales Trend Analysis

- Aggregate net sales by month.
- Visualize changes in sales performance over time.
- Identify periods of relatively high and low sales activity.

3. Category and Regional Analysis

- Compare recorded profit across product categories.
- Analyze net sales by category.
- Evaluate regional differences in sales and recorded profit.
- Identify categories and regions that may require further investigation.

4. Discount and Profitability Analysis

- Group transactions into discount ranges.
- Compare sales and recorded profit across discount levels.
- Examine whether higher discount ranges are associated with lower profitability.

This analysis identifies associations and patterns; it does not establish that discounts alone cause changes in profit.

5. Product Performance Analysis

- Rank products by net sales, quantity, and recorded profit.
- Identify high-performing products.
- Highlight products with relatively low or negative recorded profit.
- Support further investigation into product pricing, costs, and discount strategies.

6. Customer Segmentation Using RFM

RFM analysis groups customers using three measures:

- Recency: How recently a customer placed an order.
- Frequency: How often a customer ordered.
- Monetary value: The monetary value associated with the customer's orders.

The project uses delivered orders for this analysis and assigns customers to segments such as:

- Best Customers
- Loyal / Active
- Recent Customers
- At Risk
- Needs Attention

These segments can help businesses develop targeted retention, engagement, and customer relationship strategies.

7. Sales Forecasting

- Aggregate delivered-order net sales into monthly time series.
- Build a seasonal Holt-Winters forecasting model.
- Evaluate forecast accuracy using MAE, RMSE, and MAPE.
- Compare the model against a seasonal-naive baseline.
- Generate forecasts for business planning and demand analysis.

Forecast accuracy should be evaluated against a holdout period and compared with a baseline before the model is used for decision-making. Forecast dates should be updated whenever a new forecasting period is required.

SQL and Database Analysis

The project uses SQLite to store sales data in a relational table named `ecommerce_sales`.

The database workflow includes:

1. Load the CSV dataset into SQLite.
2. Validate the loaded record count.
3. Query sales records using SQL.
4. Analyze orders, customers, products, and order statuses.
5. Compare database results with the source dataset.

Power BI Dashboard

The Power BI dashboard provides a visual overview of business performance.

Dashboard elements may include:

- KPI cards for delivered net sales, delivered orders, recorded profit, and profit margin.
- Monthly sales trend visualization.
- Category-level sales analysis.
- Regional profitability analysis.
- Product performance rankings.
- Filters for relevant dimensions such as date, region, category, and order status.

Dashboard measures must use consistent definitions. Delivered-only measures should be clearly distinguished from metrics calculated across all order statuses.

Installation and Setup

Prerequisites

- Python 3.10 or a compatible Python version.
- Visual Studio Code.
- Power BI Desktop for the dashboard.
- DB Browser for SQLite or another SQLite client (optional).

Step 1: Clone the Repository

```bash
git clone <https://github.com/thisaanthjeyaraman/sales-intelligence-analytics.git>
cd sales-intelligence-analytics
```

Step 2: Create a Virtual Environment

For Windows PowerShell:

powershell
py -m venv .venv
.\.venv\Scripts\Activate.ps1


Step 3: Install Dependencies

If `requirements.txt` is available:

powershell
python -m pip install -r requirements.txt


Otherwise, install the required packages:

powershell
python -m pip install pandas numpy matplotlib scikit-learn statsmodels jupyter ipykernel


Step 4: Verify the Dataset

Ensure the CSV file is located at:

text
data/Sample - Superstore.csv


Step 5: Run the Python Analysis

For example:

powershell
python notebooks/01_data_overview.py


Run the remaining analysis scripts in sequence:

powershell
python notebooks/02_sales_trends.py
python notebooks/03_category_region_analysis.py
python notebooks/04_discount_profitability.py
python notebooks/05_product_analysis.py
python notebooks/06_customer_segmentation.py
python notebooks/07_sales_forecasting.py

Run these commands from the project root.

Step 6: Load the Dataset into SQLite

Run:

powershell
python load_ecommerce_data.py


This script loads the CSV into `sales_ecommerce.db` and creates or replaces the `ecommerce_sales` table.

Step 7: Open the Power BI Dashboard

Open the relevant `.pbix` file from the `powerbi/` folder in Power BI Desktop.

Future Enhancements

- Add quarterly sales trend analysis.
- Build an interactive discount and pricing what-if simulator.
- Automate data refresh and report generation.
- Add dynamic business insights to the dashboard.
- Compare multiple forecasting methods and improve model validation.
- Deploy an interactive web dashboard if required.
- Add automated data quality checks and reproducible analysis workflows.


Conclusion

Sales Intelligence & Revenue Growth Analytics demonstrates an end-to-end analytics workflow, from CSV data inspection and SQL querying to customer segmentation, sales forecasting, and Power BI visualization.

The project showcases practical skills in Python, SQL, SQLite, data analysis, time-series forecasting, and business intelligence while illustrating how analytical findings can support more informed commercial decisions.

Author

Thisaanth Jeyaraman

Sales Analytics | Business Intelligence |