# Docker + Laravel + Angular

**Comparto un Workflow para desarrollo con Laravel + Angular usando contenedores como es docker.**

Para poder iniciar el proyecto en linux ejecutar :
`sh ./start-project.sh`

Seleccionar la opción que te aparece en el menú

Ejecutara una serie de procesos para el desarrollo de los contenedores y descarga de paquetes necesarios para el desarrollo
de acuerdo a la opción seleccionada.

se se desea cambiar nombre de las carpetas y nombre de proyecto editar archivo start-project.sh
las variables:

`appName='notimarrisApp'` <br/>
`project='project'` <br/>
`folderfront='frontend'`<br/>
`folderback='backend'`<br/>

**Ejecución de Docker**

para correr los contenedores verifica que el archivo docker-compose.yml 
los volumnes hagan referencia a las carpetas que configurates en el archivo start-project.sh

Ejemplo : <br/>
`volumes:`  <br/>
`- ./[project]/[folderfront]/dist:/usr/share/nginx/html/frontend/`<br/>

Dónde: <br/>
[ project ]     = Es el nombre de la carpeta que contendra el backend y el frontend <br/>
[ folderfront ] = Es la carpeta que contendra el frontend


**Ejecución de docker**


Posicionarte en la carpeta donde se encuentra la raiz de todo el proyecto.

Para levantar los contenedores : <br/> 
`docker-compose up -d` <br/>
Para dar bajar los contenedores :  <br/>
`docker-compose down`

**Notas:**

Configurar el archivo .env de laravel para poder usar REDIS Y MYSQL quedando

`DB_HOST=127.0.0.1` por `DB_HOST=db` [ db ] es el nombre de servicio que tenemos configurado en docker-compose.yml.
<br/>
<br/>
`REDIS_HOST=127.0.0.1` por `REDIS_HOST=redis` [ redis ] es el nombre de servicio que tenemos configurado en docker-compose.yml.

y cambiar el CACHE_DRIVER, SESSION_DRIVER y  por : <br/>
`CACHE_DRIVER=redis` <br/>
`SESSION_DRIVER=redis` <br/>
`QUEUE_CONNECTION=redis`

En caso de fallar recuerda instalar predis/predis    <br/>
`composer require predis/predis`