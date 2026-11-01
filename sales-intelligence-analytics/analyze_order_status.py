
from pathlib import Path
import pandas as pd

PROJECT_DIR = Path(__file__).resolve().parent
CSV_PATH = PROJECT_DIR / "data" / "Sample - Superstore.csv"

def main():
    df = pd.read_csv(CSV_PATH)

    # Group business metrics by order status
    summary = (
        df.groupby("Order_Status")
        .agg(
            Order_Count=("Order_ID", "count"),
            Gross_Sales=("Gross_Sales", "sum"),
            Discounts=("Discount_Amount", "sum"),
            Net_Sales=("Net_Sales", "sum"),
            Cost=("Cost", "sum"),
            Profit=("Profit", "sum"),
            Average_Rating=("Customer_Rating", "mean"),
            Average_Delivery_Days=("Delivery_Days", "mean"),
        )
        .reset_index()
    )

    summary["Order_Percentage"] = (
        summary["Order_Count"] / len(df) * 100
    )

    summary["Profit_Margin_Percentage"] = (
        summary["Profit"] / summary["Net_Sales"] * 100
    )

    # Format for readable output
    numeric_columns = summary.select_dtypes(
        include="number"
    ).columns

    summary[numeric_columns] = summary[numeric_columns].round(2)

    print("\n=== ORDER STATUS ANALYSIS ===")
    print(summary.to_string(index=False))

    print("\n=== OVERALL DATASET TOTALS ===")
    print(f"Orders: {len(df):,}")
    print(f"Gross sales: {df['Gross_Sales'].sum():,.2f}")
    print(f"Discounts: {df['Discount_Amount'].sum():,.2f}")
    print(f"Net sales: {df['Net_Sales'].sum():,.2f}")
    print(f"Cost: {df['Cost'].sum():,.2f}")
    print(f"Profit: {df['Profit'].sum():,.2f}")

    # Save the analysis without modifying the source data
    output_dir = PROJECT_DIR / "outputs"
    output_dir.mkdir(exist_ok=True)

    output_path = output_dir / "order_status_analysis.csv"
    summary.to_csv(output_path, index=False)

    print(f"\nAnalysis saved to: {output_path}")

if __name__ == "__main__":
    main()
