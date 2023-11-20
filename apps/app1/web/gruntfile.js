module.exports = function (grunt) {
  grunt.registerTask("print-message", function () {
    console.log("Hello from Grunt!");
  });

  // Define the default task (can be run by typing 'grunt' in the terminal)
  grunt.registerTask("default", ["print-message"]);
};
