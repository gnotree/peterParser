import argparse
import os
import json
from scripts.importer import import_links
from scripts.html_cleaner import clean_html_from_file


def parse_all_books(config_path: str, output_dir: str):
    with open(config_path, 'r', encoding='utf-8') as f:
        config = json.load(f)

    os.makedirs(output_dir, exist_ok=True)

    for book, url in config.items():
        print(f"[+] Downloading: {book} from {url}")
        output_file = os.path.join(output_dir, f"{book}.txt")
        clean_html_from_file(url, output_file)

    print("[✔] All books processed.")


def main():
    parser = argparse.ArgumentParser(description='Peter Parser - HolyScraper Edition')
    parser.add_argument('--config', default='books.json', help='Path to book configuration JSON file')
    parser.add_argument('--output', default='books_txt', help='Output directory for .txt files')
    parser.add_argument('--import-links', help='Optional: import multiple links into config from .txt')
    args = parser.parse_args()

    if args.import_links:
        import_links(args.import_links, args.config)
    else:
        parse_all_books(args.config, args.output)


if __name__ == '__main__':
    main()
