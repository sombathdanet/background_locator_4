#!/bin/bash

echo "=========================================="
echo "Publishing location_tracking to pub.dev"
echo "=========================================="
echo ""

# Step 1: Final validation
echo "Step 1: Running final validation..."
flutter pub publish --dry-run

echo ""
echo "=========================================="
echo "If validation passed, proceeding to publish..."
echo "=========================================="
echo ""

# Step 2: Publish
echo "Step 2: Publishing package..."
flutter pub publish

echo ""
echo "=========================================="
echo "Publication complete!"
echo "=========================================="
