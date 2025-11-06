#!/bin/bash

echo "🧪 Testing Override Feature"
echo "============================"
echo ""

cd example

echo "Step 1: Creating test_override feature..."
cleanarch test_override -b

echo ""
echo "Step 2: Trying to create it AGAIN (should show override prompt)..."
cleanarch test_override -b

echo ""
echo "✅ Test complete!"

