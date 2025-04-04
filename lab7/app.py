from flask import Flask, request, jsonify, render_template
import mysql.connector
import google.generativeai as genai

app = Flask(__name__)

# Set your API key here
genai.configure(api_key="AIzaSyD0mQVa_0FbjkhQ7lJvd10TFzFwU-qbaA8")

# Configure MySQL Connection
db_config = {
    "host": "localhost",
    "user": "root",  
    "password": "somyashreesahoo2301", 
    "database": "students"  
}

# Function to Convert Natural Language to SQL
def convert_nl_to_sql(nl_query):
    model = genai.GenerativeModel("gemini-1.5-pro-latest")  
    response = model.generate_content(f"Convert this to SQL: {nl_query}")

    # Clean the SQL query (Remove markdown formatting)
    sql_query = response.text.strip().replace("```sql", "").replace("```", "").strip()
    # sql_query = sql_query.replace("studentsinfo", "students")  
    return sql_query

# Function to Execute SQL Query
def execute_sql_query(query):
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)  # Return results as dictionaries
    cursor.execute(query)
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return result

@app.route("/", methods=["GET", "POST"])
def process_query():
    if request.method == "POST":
        nl_query = request.form["nl_query"]
        sql_query = convert_nl_to_sql(nl_query)  # Convert NL to SQL
        
        # Debugging: Print generated SQL query
        print("Generated SQL Query:", sql_query)

        result = execute_sql_query(sql_query)  # Execute SQL query
        return render_template("index.html", nl_query=nl_query, sql_query=sql_query, result=result)
    
    return render_template("index.html", nl_query="", sql_query="", result=None)

if __name__ == "__main__":
    app.run(debug=True)
