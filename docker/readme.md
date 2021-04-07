# Readme

This [docker-compose.yml](./docker-compose.yml) file extends the files in each of the sub-folders: Jenkins, SQLServer, Ubuntu. 

The containers created maintains the same configuration as each separate file, but adds a convenient way to spin up all containers at once, and adding them all to a shared network, allowing them to communicate. 

If everything is setup correctly according to the top level [readme.md](./../readme.md), everything should build, run and setup correctly, using:

```bash
$ docker-compose up -d
```
