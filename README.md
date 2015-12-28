##The new_project creator

Simple routine to create the scaffolds for a new Sinatra app.

####Instructions

- Clone the repository
  `git clone https://github.com/cocolote/new-project-creator.git`

- Add this to your .bashrc or .zshrc:
```
# New Project Creator path
export PATH=$HOME/my-projects/new-project-creator:$PATH
```
replace what is after $HOME with the directory where the application was cloned.

- To make it easy to execute, create a symbolic link like this:
```
**~>** ln -s $HOME/my-projects/new-project-creator/newp /usr/local/bin/newp
```

Run it like `newp` and it will create a new directory
new-project with all the dependencies in the directory where you are making the
call.

You can enter the name of your project like `newp my-project`
and it will create the directory with that name.

You can also enter the path where you want to create the new project like this
`newp your-project <~/your/path>`
