const fs = require("fs");
const path = require("path");

const directoryPath = "."; // Replace with your directory path

fs.readdir(directoryPath, function (err, files) {
  if (err) {
    console.error("Error reading directory:", err);
    return;
  }

  const fileArray = [];

  files.forEach(function (file) {
    const filePath = path.join(directoryPath, file);
    const fileStats = fs.statSync(filePath);

    if (fileStats.isFile()) {
      fileArray.push(file);
    }
  });

  console.log("File array:", fileArray);
});
