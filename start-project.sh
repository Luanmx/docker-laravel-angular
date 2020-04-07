#!/bin/bash

#Nombre de tu aplicacion
appName='notimarrisApp'
#Path Padre de tu Proyecto
project='project'
folderfront='frontend'
folderback='backend'
#Path donde se almacenara los datos de la db
data='data'

CWD="$(pwd)"

#Creacion de subcarpetas para el frontend Angular - backend  PHP laravel
createSubFolders () {
  cd $project
  echo “Ingresando a $project”
  folders="$folderfront $folderback"
  for dir in $folders
  do
    if [ -d $dir ]
    then
      echo "La capeta $dir ya existe."
    else
      mkdir $dir
      if [ $? -eq 0 ]
      then
        echo "$dir se ha creado con éxito"
      else
        echo "Ups! Algo ha fallado al crear $dir"
      fi
    fi
  done
}

createPathFolder(){
  if [ -d $project ]
  then
    echo “La capeta $project ya existe.”
    createSubFolders
  else 
    mkdir $project
    echo “$project se ha creado con éxito”
    createSubFolders
  fi

  if [ -d $project ]
  then
    echo “La capeta $data ya existe.”
  else
    mkdir $data
    sudo chmod -R 775 $data
    echo “$data se ha creado con éxito”
  fi
}

createNewProject(){

  if [ ! "$(ls -A $CWD/$project/$folderfront)" ]
  then
      cd "$CWD/$project/$folderfront"
      "$(ng new $appName --directory .)"
      "$(ng build --output-path=dist/)"
  else
      echo "===================================================================================="
      echo "$folderfront ya tiene datos y no podemos sobre escribir"
      echo "===================================================================================="
  fi

  if [ ! "$(ls -A $CWD/$project/$folderback)" ]
  then
      cd "$CWD/$project/"
      "$(composer create-project laravel/laravel $folderback)"

      cd "$CWD/$project/$folderback"
      "$(composer require predis/predis)"
  else
      echo "===================================================================================="
      echo "$folderback ya tiene datos y no podemos sobre escribir"
      echo "===================================================================================="
  fi

}

getProjectGit(){
  echo "===================================================================================="
  echo "Ingresa la url de tus proyectos en git"
  echo ""
  echo "===================================================================================="
  echo
  read -p 'repositorio git para frontend: ' urlfrontend
  read -p 'repositorio git para backend: ' urlbackend

  cd "$CWD/$project/frontend" 
  "$(git clone $urlfrontend .)"
  "$(ng build --output-path=dist/)"

  cd "$CWD/$project/backend"
  "$(git clone $urlbackend .)"
  "$(composer require predis/predis)"
}

echo "===================================================================================="
echo "Asegurate de tener instalado"
echo "Git, nodejs, AngularCLI, Composer, Docker & Docker-compose"
echo "===================================================================================="
echo
echo "=============================== Opciones ==========================================="
echo "Teclea '-n' si el proyecto es nuevo "
echo "Teclea '-r' si el proyecto existe."

read -p "Ingresa opción " opcion

case $opcion in
  -n)
     createPathFolder
     createNewProject
     ;;
  -r)
    createPathFolder
    getProjectGit
    ;;

esac