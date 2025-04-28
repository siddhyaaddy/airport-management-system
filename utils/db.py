# from sqlalchemy import create_engine
# import pandas as pd
# import streamlit as st  # 🔵 Import streamlit to use st.secrets

# # Get DATABASE_URL from Streamlit Secrets
# DATABASE_URL = st.secrets["DATABASE_URL"]

# # Create SQLAlchemy engine
# engine = create_engine(DATABASE_URL)

# def load_query(query_filename):
#     with open(f"SQL/{query_filename}", "r") as file:
#         return file.read()

# def run_query(query_filename):
#     query = load_query(query_filename)
#     with engine.connect() as conn:
#         return pd.read_sql_query(query, conn)

# --- utils/db.py ---
import psycopg2
import psycopg2.extras
import streamlit as st
import os

# Function to run a query from a file
def run_query_from_file(filename):
    sql_folder = "SQL"  # Folder where your SQL files are stored
    filepath = os.path.join(sql_folder, filename)
    with open(filepath, "r") as file:
        query = file.read()
    return run_query_direct(query)

# Function to run a direct query text
def run_query_direct(query):
    conn = psycopg2.connect(st.secrets["DB_URL"])
    cur = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    cur.execute(query)
    result = cur.fetchall()
    cur.close()
    conn.close()
    return result

# Function to load a query text from file for display
def load_query(filename):
    sql_folder = "SQL"
    filepath = os.path.join(sql_folder, filename)
    with open(filepath, "r") as file:
        query = file.read()
    return query


