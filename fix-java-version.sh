#!/bin/bash
echo "Checking pom.xml files for Java version..."

# Find all pom.xml files
pom_files=$(find /workspaces/SAP_CAP -name "pom.xml")

# Update Java version in all pom.xml files
for pom in $pom_files; do
  if grep -q '<jdk.version>21</jdk.version>' "$pom"; then
    echo "Updating Java version in $pom..."
    sed -i 's/<jdk.version>21<\/jdk.version>/<jdk.version>17<\/jdk.version>/g' "$pom"
    echo "✅ Updated $pom"
  else
    echo "✓ $pom already has correct Java version or no version specified"
  fi
done

echo "Java version check complete."
