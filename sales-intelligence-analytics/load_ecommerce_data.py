
from pathlib import Path
import sqlite3
import pandas as pd

# Find the project folder automatically
PROJECT_DIR = Path(__file__).resolve().parent

# Input dataset and separate database
CSV_PATH = PROJECT_DIR / "data" / "Sample - Superstore.csv"
DB_PATH = PROJECT_DIR / "sales_ecommerce.db"

TABLE_NAME = "ecommerce_sales"

def main():
    # Check that the dataset exists
    if not CSV_PATH.exists():
        raise FileNotFoundError(
            f"Dataset not found: {CSV_PATH}\n"
            "Check that the CSV is inside the data folder."
        )

    # Load the new dataset
    df = pd.read_csv(CSV_PATH)

    print("Dataset loaded successfully!")
    print(f"Rows: {len(df):,}")
    print(f"Columns: {len(df.columns)}")
    print("\nColumn names:")
    print(df.columns.tolist())

    # Check important columns
    required_columns = [
        "Order_ID",
        "Order_Date",
        "Customer_ID",
        "Net_Sales",
        "Profit",
        "Order_Status",
    ]

    missing = [col for col in required_columns if col not in df.columns]

    if missing:
        raise ValueError(f"Missing required columns: {missing}")

    # Convert order dates into proper dates
    df["Order_Date"] = pd.to_datetime(
        df["Order_Date"], errors="raise"
    )

    # Create a separate SQLite database
    with sqlite3.connect(DB_PATH) as connection:
        df.to_sql(
            TABLE_NAME,
            connection,
            if_exists="replace",
            index=False
        )

        # Verify how many records were saved
        saved_rows = pd.read_sql_query(
            f"SELECT COUNT(*) AS total FROM {TABLE_NAME}",
            connection
        ).iloc[0]["total"]

    print("\nDatabase created successfully!")
    print(f"Database: {DB_PATH.name}")
    print(f"Table: {TABLE_NAME}")
    print(f"Records saved: {saved_rows:,}")

if __name__ == "__main__":
    main()
