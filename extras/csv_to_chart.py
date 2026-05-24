#!/usr/bin/env python3
"""
Convert survey CSV to chart data JSON
Usage: python csv_to_chart_data.py input.csv > chart_data.json
"""

import csv
import json
import sys


def csv_to_chart_data(csv_path, skip_columns=3):
    """
    Convert CSV to chart data JSON
    
    Args:
        csv_path: Path to CSV file
        skip_columns: Number of columns to skip at start (default: 3)
    
    Returns:
        List of chart data dictionaries
    """
    with open(csv_path, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        data = list(reader)
    
    # Get column names (skip first columns: User ID, Name, Timestamp, etc.)
    columns = list(data[0].keys())[skip_columns:]
    
    chart_data = []
    
    for column in columns:
        counts = {}
        
        # Count occurrences
        for row in data:
            value = row.get(column, '').strip()
            if value:
                # Split by semicolon for multi-value answers , this was Crucial.
                # I had to process some results by hand
                items = [item.strip() for item in value.split(';') if item.strip()]
                for item in items:
                    counts[item] = counts.get(item, 0) + 1
        
        # Skip if no data
        if not counts:
            continue
        
        # Sort by count (descending)
        sorted_items = sorted(counts.items(), key=lambda x: x[1], reverse=True)
        labels = [item[0] for item in sorted_items]
        values = [item[1] for item in sorted_items]
        
        # Build chart data object
        chart_data.append({
            'question': column,
            'labels': labels,
            'values': values,
            'mostUsed': labels[0],
            'mostUsedCount': values[0]
        })
    
    return chart_data


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: python csv_to_chart_data.py <csv_file> [skip_columns]")
        print("Example: python csv_to_chart_data.py survey.csv 3")
        sys.exit(1)
    
    csv_file = sys.argv[1]
    skip_cols = int(sys.argv[2]) if len(sys.argv) > 2 else 3
    
    # Convert and output
    chart_data = csv_to_chart_data(csv_file, skip_cols)
    
    # Pretty print JSON (yesh!)
    print(json.dumps(chart_data, ensure_ascii=False, indent=2))
