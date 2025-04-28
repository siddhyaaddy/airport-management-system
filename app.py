# app.py
import streamlit as st
from utils.db import run_query, load_query
from dotenv import load_dotenv
import os

# Load environment variables
load_dotenv()

# App title
st.title("🛫 Airports Data Explorer (Supabase)")

# List of available queries
SQL = {
    "Classified Details of Large Airports": "classifed_details_of_large_airports.sql",
    "Combining Country Codes of Two Tables": "combing_country_codes_of_two_tables.sql",
    "Countries Having More Than 100 Airports": "countries_having_more_than_100_airports.sql",
    "Pairing Different Airports of Same Country": "pairing_different_airports_of_same_country.sql",
    "Joining Airports with Country Continent": "joins_airports_with_country_continent.sql"
}


# Dropdown menu
selected_query = st.selectbox("📄 Select a Query", list(SQL.keys()))

try:
    # Load and run the selected query
    df = run_query(SQL[selected_query])

    st.subheader("🧹 SQL Query Used")
    query_text = load_query(SQL[selected_query])
    st.code(query_text, language="sql")

    st.subheader("📊 Query Results")
    st.dataframe(df)

except Exception as e:
    st.error(f"❌ Failed to execute query: {e}")
