module.exports = function(grunt) {
    grunt.loadNpmTasks("grunt-elm");
    grunt.loadNpmTasks("grunt-contrib-watch");

    grunt.initConfig({
      elm: {
        compile: {
          files: {
            'elm.js': ['src/Main.elm']
          }
        }
      },
      watch: {
        src: {
            files: ['index.html', 'src/**/*.elm'],
            tasks: ['default']
        }
      }

    });



    grunt.registerTask("default", ["elm"]);
    grunt.registerTask("dev", ["elm", "watch"]);
};
