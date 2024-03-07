Command to build docker file with name other than `Dockerfile` 
```dockerfile
docker build -f Dockerfile.dev .
```

Hot reloading (Docker Volumes)
-  This is used to update the changes in the code without rebuilding the image, it basically makes a reference to the code in the local machine and updates the changes in the container. It can be though of as port mapping between local and container file system that we have seen before.

  Doesn't work on windows
```dockerfile
docker run -p 3000:3000 -v /app/node_modules -v $(pwd):/app <image_id>
```

    docker run -p    3000:3000             -v /app/node_modules                        -v $(pwd):/app                      <image_id>
                    port maping     put a bookmark on the node_modules folder    map the pw in the /app folder
                                        don't map it up with anything
  Alternative
    docker-compose file

Hot reloading issue with app.test.js file
    There are two ways of doing it, 
> To use the existing volume that we have set up to resolve the previous hot reloading issue. Start the docker container and in another terminal type
```docker exec -it <id> npm run test```

>we will add tests service to docker-compose.yml
        


### Run Tests

```dockerfile
docker run <image_id> npm run test
```

### Run Tests in interactive mode
```dockerfile
docker run -it <image_id> npm run test
```

### Volume setup for tests

- After setting up the volumes we won't be able to run the tests in interactive mode, for that run second terminal and run ```docker attach <id>```
With ```docker attach``` we are attaching `stdin`, `stdout` and `stderr` of the primary process of the container. So, we want to attach to that process which is responsible for the output of the tests. With `docker attach <image_id>` we can't achive that.

- Tests command line interaction still doesn't work, for we are attaching to the primary process of the container.

- Alternative (Reuse existing container)

```dockerfile
docker exec -it <container_id> npm run test
```