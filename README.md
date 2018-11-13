#docker for livy

# Build docker image.
build --network=host -t livy-docker-0.5.0 .

# Run docker image. 
Spark is installed in /usr/lib/spark, mount it.
sudo docker run -p 8998:8998 -v /usr/lib/spark:/usr/lib/spark livy-docker-0.5.0
