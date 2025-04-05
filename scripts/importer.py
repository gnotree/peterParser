import json
import re


def import_links(input_path: str, config_path: str):
    with open(input_path, 'r', encoding='utf-8') as f:
        content = f.read()

    urls = re.findall(r'https?://\S+', content)
    book_names = [f"Book{i+1}" for i in range(len(urls))]
    config = dict(zip(book_names, urls))

    with open(config_path, 'w', encoding='utf-8') as f:
        json.dump(config, f, indent=4)

    print(f"[✔] Imported {len(urls)} links into {config_path}")

