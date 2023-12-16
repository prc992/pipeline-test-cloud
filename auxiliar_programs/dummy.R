# Open a file connection in write mode
file <- file("hello.txt", "w")

# Write the text to the file
writeLines("hello", file)

# Close the file connection
close(file)
