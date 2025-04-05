import requests
from bs4 import BeautifulSoup
import re


def clean_html_from_file(url: str, output_path: str):
    try:
        response = requests.get(url, timeout=10)
        response.raise_for_status()
        soup = BeautifulSoup(response.content, 'html.parser')

        for script in soup(['script', 'style']):
            script.decompose()

        text = soup.get_text(separator=' ')
        cleaned = re.sub(r'\s+', ' ', text).strip()

        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(cleaned)
        print(f"[✔] Cleaned and saved: {output_path}")

    except Exception as e:
        print(f"[✘] Failed to process {url}: {e}")

