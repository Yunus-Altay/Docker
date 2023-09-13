cd ./image_comparison
docker pull alpine:3.14
touch Dockerfile # create a new alpine image
docker build -t "myalpine:1.0" .
docker images # be sure the new image has been created
export SHOW_LAYER='{{ range .RootFS.Layers }}{{ println . }}{{end}}'
export SHOW_SIZE='{{.Size}}'
docker inspect -f "$SHOW_SIZE" alpine
docker inspect -f "$SHOW_SIZE" myalpine:1.0 # see, the image size increased
docker inspect -f "$SHOW_LAYER" alpine
docker inspect -f "$SHOW_LAYER" myalpine:1.0 # another layer has been added atop the base image