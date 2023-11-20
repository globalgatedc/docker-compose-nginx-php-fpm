const gulp = require("gulp");

// Define a task that prints a message
gulp.task("print-message", function () {
  console.log("Hello from Gulp!");
});

// Define a default task (can be run by typing 'gulp' in the terminal)
gulp.task("default", gulp.series("print-message"));
