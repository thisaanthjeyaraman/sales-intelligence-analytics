
import pandas as pd
import sqlite3

# Load your CSV dataset
df = pd.read_csv("data/Sample - Superstore.csv")

# Create a SQLite database file
connection = sqlite3.connect("sales_database.db")

# Save the CSV data as a SQL table
df.to_sql("sales", connection, if_exists="replace", index=False)

# Confirm the data was imported
count = pd.read_sql_query(
    "SELECT COUNT(*) AS total_records FROM sales",
    connection
)

print("Dataset imported into SQLite successfully!")
print(count)

connection.close()
