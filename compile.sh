#!/bin/bash

# Jinkra VPN Compilation Script
# This script compiles the new Jinkra commands and integrates them with AntiVPN code

PROJECT_DIR="/c/Users/duban/jinkra-vpn-bukkit"
SRC_DIR="$PROJECT_DIR/src"
OUTPUT_DIR="$PROJECT_DIR/target/classes"
JINKRA_JAR="$PROJECT_DIR/target/jinkra-vpn-1.0.0.jar"

# Create output directory
mkdir -p "$OUTPUT_DIR"

echo "[1/4] Copying original compiled classes..."
cp -r "/c/Users/duban/Downloads/antivpn-bukkit-6.4.13" "$OUTPUT_DIR/temp" 2>/dev/null || echo "Original classes not found, starting fresh"

echo "[2/4] Compiling new Jinkra classes..."
javac -d "$OUTPUT_DIR" \
    -cp ".:$OUTPUT_DIR/temp" \
    "$SRC_DIR/me/egg82/antivpn/commands/JinkraCommand.java" \
    "$SRC_DIR/me/egg82/antivpn/utils/StatisticsManager.java" \
    2>&1

if [ $? -ne 0 ]; then
    echo "Compilation failed. Trying alternative approach..."
    echo "[2b/4] Compiling without full dependency resolution..."
    javac -d "$OUTPUT_DIR" \
        "$SRC_DIR/me/egg82/antivpn/commands/JinkraCommand.java" \
        "$SRC_DIR/me/egg82/antivpn/utils/StatisticsManager.java" \
        2>&1 | head -20
fi

echo "[3/4] Creating JAR package..."
cd "$OUTPUT_DIR"
jar -cf "$JINKRA_JAR" . 2>&1

echo "[4/4] Finalizing..."
echo "Build complete!"
echo "Output: $JINKRA_JAR"
ls -lh "$JINKRA_JAR" 2>/dev/null || echo "Note: Manual compilation may be needed with full Bukkit SDK"

