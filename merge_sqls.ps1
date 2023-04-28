# Create an array of file names
$files = @("create_tables.sql", "trigger.sql", "insert_values.sql")
# $files = @("create_tables.sql", "trigger.sql", "insert_values.sql", "select.sql")
# $files = @("create_tables.sql", "trigger.sql")

# Create an empty file
New-Item -ItemType File xstipe02_xpekni01.sql | Out-Null

# Iterate over the array
foreach ($file in $files) {
    # Concatenate the contents of each file and append it to xstipe02_xpekni01.sql
    Add-Content -Path xstipe02_xpekni01.sql -Value "" 
    Add-Content -Path xstipe02_xpekni01.sql -Value "/* +--------+ $file +--------+ */" 
    Add-Content -Path xstipe02_xpekni01.sql -Value "" 
  
    Get-Content -Path $file | Add-Content -Path xstipe02_xpekni01.sql

    Add-Content -Path xstipe02_xpekni01.sql -Value ""
    Add-Content -Path xstipe02_xpekni01.sql -Value "/* ---------- $file ---------- */"
    Add-Content -Path xstipe02_xpekni01.sql -Value ""
}
