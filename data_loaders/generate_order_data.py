import csv
import datetime
import json
import random
import uuid
import xml.etree.ElementTree as ET
from datetime import datetime, timedelta
from typing import Dict, Any, Generator


@data_loader
def generate_order_data(**kwargs) -> Generator[Dict[str, Any], None, None]:
    """
    Generates sample order data and yields it for dynamic export to CSV, JSON, and XML files.
    Uses Dynamic Blocks 2.0 with streaming capabilities.
    """
    current_time = datetime.now()
    systems = ['Ecommerce', 'POS', 'Mobile']
    
    # Define 5 fixed items and their prices
    items = {
        'ITEM1': 29.99,
        'ITEM2': 49.99, 
        'ITEM3': 99.99,
        'ITEM4': 149.99,
        'ITEM5': 199.99
    }
    
    order_num = 1000
    
    # Generate and yield orders for each system
    for system in systems:
        orders = []
        for i in range(50):
            timestamp = current_time + timedelta(minutes=random.randint(1,180))
            item_num = random.choice(list(items.keys()))
            
            order = {
                'system': system,
                'timestamp': timestamp.strftime('%Y-%m-%d %H:%M:%S'),
                'order_number': f'ORD{order_num}',
                'customer_number': f'CUST{random.randint(1,1000)}',
                'item_number': item_num,
                'price': items[item_num],
                'quantity': random.randint(1,10)
            }
            orders.append(order)
            order_num += 1
        
        # Sort orders by timestamp
        orders.sort(key=lambda x: x['timestamp'])
        
        # Prepare and yield data for each system
        if system == 'Ecommerce':
            yield {
                'file_name': 'ecommerce_orders.csv',
                'data': orders,
                'format': 'csv'
            }
        elif system == 'POS':
            yield {
                'file_name': 'pos_orders.json',
                'data': orders,
                'format': 'json'
            }
        else:  # Mobile
            yield {
                'file_name': 'mobile_orders.xml',
                'data': orders,
                'format': 'xml'
            }