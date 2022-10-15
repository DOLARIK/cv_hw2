# Dependencies

1. [Docker](https://www.docker.com/)

# Development

1. How to build an image from dockerfile:
```bash
docker build -f Dockerfile.dev -t cv_hw_2.dev .
```

2. For running development container:
```bash
docker run --name cv_hw_2.dev -p 19888:8888 -v ${pwd}:/assignment_2/ -itd cv_hw_2.dev
```

Now, visit the url: [localhost:19888](http://localhost:19888) (password: `dev`)