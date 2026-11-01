
from pathlib import Path
import sqlite3
import pandas as pd

PROJECT_DIR = Path(__file__).resolve().parent
CSV_PATH = PROJECT_DIR / "data" / "Sample - Superstore.csv"
DB_PATH = PROJECT_DIR / "sales_ecommerce.db"

def main():
    # Load the dataset
    df = pd.read_csv(CSV_PATH)

    print("=" * 55)
    print("ECOMMERCE DATA QUALITY AUDIT")
    print("=" * 55)

    # 1. Dataset size
    print(f"\nRows: {len(df):,}")
    print(f"Columns: {len(df.columns)}")

    # 2. Column names and data types
    print("\n--- COLUMN TYPES ---")
    print(df.dtypes.to_string())

    # 3. Missing values
    print("\n--- MISSING VALUES ---")
    missing = df.isnull().sum()
    print(missing[missing > 0].to_string()
          if missing.any() else "No missing values found.")

    # 4. Duplicate rows and order IDs
    print("\n--- DUPLICATES ---")
    print("Duplicate rows:", df.duplicated().sum())

    if "Order_ID" in df.columns:
        print("Duplicate Order_ID values:",
              df["Order_ID"].duplicated().sum())

    # 5. Order dates
    if "Order_Date" in df.columns:
        dates = pd.to_datetime(df["Order_Date"], errors="coerce")
        print("\n--- ORDER DATE RANGE ---")
        print("Earliest:", dates.min())
        print("Latest:", dates.max())
        print("Invalid dates:", dates.isna().sum())

    # 6. Order status distribution
    if "Order_Status" in df.columns:
        print("\n--- ORDER STATUSES ---")
        print(df["Order_Status"].value_counts(dropna=False).to_string())

    # 7. Numeric summaries
    numeric_cols = [
        "Gross_Sales", "Discount_Amount",
        "Net_Sales", "Cost", "Profit",
        "Quantity", "Delivery_Days", "Customer_Rating"
    ]

    available = [c for c in numeric_cols if c in df.columns]

    print("\n--- NUMERIC SUMMARY ---")
    if available:
        print(df[available].describe().round(2).to_string())

    # 8. Check database record count
    print("\n--- SQLITE DATABASE CHECK ---")
    if DB_PATH.exists():
        with sqlite3.connect(DB_PATH) as conn:
            count = pd.read_sql_query(
                "SELECT COUNT(*) AS total FROM ecommerce_sales",
                conn
            ).iloc[0, 0]

        print("CSV rows:", len(df))
        print("Database rows:", count)
        print("Counts match:", len(df) == count)
    else:
        print("Database not found:", DB_PATH.name)

    print("\nAudit completed.")

if __name__ == "__main__":
    main()
