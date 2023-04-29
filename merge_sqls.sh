#!/bin/bash

# Create an array of file names

# 1
#

# 2
# files=(create_tables.sql)

# 3
# files=(create_tables.sql insert_values.sql selects.sql)

# 4
files=(create_tables.sql insert_values.sql triggers.sql procedures.sql index_with_explain_plan.sql grant_access.sql)

# Create an empty file
echo "" >xstipe02_xpekni01.sql

# Iterate over the array
for file in "${files[@]}"; do
  # Concatenate the contents of each file and append it to idk.sql
  echo "" >>xstipe02_xpekni01.sql
  echo "/* +--------+ $file +--------+ */" >>xstipe02_xpekni01.sql
  echo "" >>xstipe02_xpekni01.sql

  cat "$file" >>xstipe02_xpekni01.sql

  echo "" >>xstipe02_xpekni01.sql
  echo "/* ---------- $file ---------- */" >>xstipe02_xpekni01.sql
  echo "" >>xstipe02_xpekni01.sql
done
