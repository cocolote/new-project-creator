##The new_project creator

Simple routine to create the scaffolds for a new Sinatra app.

####Instructions

- Clone the repository
  `git clone https://github.com/cocolote/new-project-creator.git`

- Set the path where you installed the application
  `export PROJECT_CREATOR_PATH=<~/path/where/you/cloned/the/new-project-creator>`

- Create a symbolic link to the executable file(the command to execute the routine "newp").
  This will let you create a new project, anywhere in your computer.
  `ln -s <~/the/new-project-creator/path/newp> /usr/local/bin/newp


Run it like `newp` and it will create a new directory
new-project with all the dependencies in the directory where you are making the
call.

You can enter the name of your project like `newp my-project`
and it will create the directory with that name.

You can also enter the path where you want to create the new project like this
`newp your-project <~/your/path>`
