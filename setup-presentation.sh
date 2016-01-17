#!/bin/bash

which node > /dev/null 2>&1
status=$?
if [ $status -ne 0 ]
then
    echo "Reveal.js requires Node.js and the npm package manager."
    echo "Please install Node.js if you would like to run the presentation."
    exit $status
fi

if [ ! -e "reveal.js" ]
then
    git clone https://github.com/hakimel/reveal.js/
fi

cd reveal.js
npm install -g grunt-cli
npm install
cp ../presentation.html index.html
cp -r ../presentation presentation
echo "Run 'grunt serve' to serve the Reveal.js presentation"
