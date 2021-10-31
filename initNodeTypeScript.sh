#! /usr/bin/env bash
cecho(){
    RED="\033[0;31m"
    GREEN="\033[0;32m"
    YELLOW="\033[1;33m"
    NC="\033[0m"
    
    printf "${!1}${2} ${NC}\n"
}


echo "Node Initializer Starting Successfully";

echo -e "\e[33m ===========================STEP 1================================"

read -p "Where You want to initialize this project ?  [Leave it blank to start here] : " directoryinit

if ["$directoryinit" -eq ""]
then
    echo "I am going to initialize the project here!"
else
    if [ -d "$directoryinit" ]
    then
        echo -e "\e[31m Directory alrady exists!"
        
        read -p "do you want to rewrite it (the original will be deleted!)? [y/N] " rewriteIt
        if [[ "$rewriteIt" == "y" ]] || [[ "$rewriteIt" == "Y" ]]
        then
            rm -rf $directoryinit
            mkdir -p $directoryinit
        else
            echo -e "\e[31m I am exiting from the session!"
            exit 1
        fi
    else
        echo -e "\e[32m I am going to init project in ${directoryinit}"
        mkdir -p $directoryinit
    fi
    
fi


cd $directoryinit


echo -e "\e[33m ===========================STEP 2================================"

read -p "project name(without spaces and upper cases) : " projectname
read -p "Auther : " authername

cat << EOF > package.json
{
  "name": "${projectname}",
  "version": "0.0.1",
  "description": "",
  "main": "src/app.ts",
  "scripts": {
    "start": "node -r ts-node/register src/app.ts"
  },
  "keywords": [  ],
  "author": "${authername}",
  "license": "ISC",
  "dependencies": {
    "express": "^4.17.1",
    "moment": "^2.29.1",
    "ts-node": "^10.0.0",
    "typescript": "4.1.3"
  },
  "devDependencies": {
    "@types/express": "^4.17.13",
    "@types/node": "^14.14.7"

  }
}

EOF

mkdir src


cat << EOF > src/app.ts
import express from "express";
const app = express();


app.get( "/", ( req, res ) => {
    res.send( "Hello world!" );
} );

// start Express server
app.listen( 8080, () => {
    console.log( `server started at http://localhost:8080` );
} );

EOF

if command -v nvm > /dev/null
then
    read -p "nvm not exists do you want to install it? [Y/n]" projectname
    if [[ "$projectname" == "n" ]] || [[ "$projectname" == "N" ]]
    then
        exit 1
    else
        wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
        export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
        
    fi
    
fi


nvm install --lts
nvm use --lts

npm i


echo -e "\e[32m now your project is ready!"
echo -e "\e[32m type 'npm run start' to run your project on 8080 port"

exit;





