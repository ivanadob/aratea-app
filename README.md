# aratea-digital

[dsebaseapp](https://github.com/KONDE-AT/dsebaseapp) based Web Application to present things about Aratea

## install 

clone the application AND the [data repository](https://github.com/ivanadob/aratea-data); initialize git submodules in the app-repo; run ANT to build the app and deploy the `.xar` package in your eXist-db instance; so do something like

```shell
mkdir aratea-digital
cd aratea-digital
git clone https://github.com/ivanadob/aratea-app.git
git clone https://github.com/ivanadob/aratea-data.git
cd aratea-app
git submodule init
git submodule update
ant
```

## develop

edit, change code in the running application either through eXist-db's built in editor eXide or through oXygen's or Atom's eXist-db interfaces
to persist your changes (and to track them via git) you need to sync/export the code running in eXist-db with you local disk. This can be done by opening `sync.xql` in eXide and evaluating it. Make sure that the value of `target-dir` is accurate. 
Happy Hacking!