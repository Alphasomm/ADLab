from flask import Flask, render_template, request, send_file
import requests
from bs4 import BeautifulSoup
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
import io

app = Flask(__name__)

# Function to scrape and extract text
def scrape_website(url):
    response = requests.get(url)
    if response.status_code == 200:
        soup = BeautifulSoup(response.text, "html.parser")
        paragraphs = soup.find_all("p")
        text = "\n".join([p.get_text() for p in paragraphs])
        return text
    return "Failed to retrieve content."

# Function to generate PDF
def generate_pdf(text):
    buffer = io.BytesIO()
    pdf = canvas.Canvas(buffer, pagesize=letter)
    pdf.setFont("Helvetica", 12)
    
    y_position = 750  # Start from the top
    for line in text.split("\n"):
        if y_position < 50:  # New page if space runs out
            pdf.showPage()
            pdf.setFont("Helvetica", 12)
            y_position = 750
        pdf.drawString(50, y_position, line)
        y_position -= 20  # Line spacing

    pdf.save()
    buffer.seek(0)
    return buffer

@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        url = request.form.get("url")
        scraped_text = scrape_website(url)
        return render_template("index.html", text=scraped_text, url=url)
    return render_template("index.html")

@app.route("/download-pdf", methods=["POST"])
def download_pdf():
    text = request.form.get("text")
    pdf_buffer = generate_pdf(text)
    return send_file(pdf_buffer, as_attachment=True, download_name="scraped_data.pdf", mimetype="application/pdf")

if __name__ == "__main__":
    app.run(debug=True)
