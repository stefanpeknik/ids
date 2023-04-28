#!/bin/bash

# Create an array of file names
# files=(create_tables.sql trigger.sql insert_values.sql select.sql)
# files=(create_tables.sql trigger.sql insert_values.sql)
# files=(create_tables.sql trigger.sql)
files=(create_tables.sql trigger.sql insert_values.sql procedures.sql)

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
