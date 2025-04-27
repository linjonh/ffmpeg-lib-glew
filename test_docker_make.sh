export PROJECT_BASE_DIR="$(cd "$(dirname "$0")/../" && pwd)" && echo "当前项目目录：$PROJECT_BASE_DIR"

#创建镜像 -t tag_name , ./tools/docker是DockerFile存放路径
docker build -t ffmpeg-maker ./tools/docker
#当未启动容器时，运行容器，并管理进入以ffmpeg-maker镜像的容器名为ffm的环境下，并挂载路径（-v "${PROJECT_BASE_DIR}:/mnt/"），执行终端界面（bash）
# Create and run a new container from an image
docker run -it -v "${PROJECT_BASE_DIR}:/mnt/" --name ffm ffmpeg-maker bash
#当退出后，如果docker容器名ffm没有启动时需要调用命令启动
docker start ffm
#停止容器
docker stop ffm
#删除容器
docker remove ffm
# 或
docker rm ffm
#当容器启动了之后 Execute a command in a running container
docker exec -it ffm bash
# List containers
docker ps
# List containers 包括停止的容器
docker ps -a
#List images
docker images
#登录或登出
docker login

docker logout

#Create a new image from a container's changes
docker commit
#Copy files/folders between a container and the local filesystem
docker cp
#  List port mappings or a specific mapping for the container
docker port
# Fetch the logs of a container
docker logs ffm > docker.log

docker run --rm \
    -v "${PROJECT_BASE_DIR}:/mnt/" \
    ffmpeg-maker ls /mnt 

docker run --rm \
    -v "${PROJECT_BASE_DIR}:/mnt/" \
    ffmpeg-maker \
    /mnt/ffmpeg-android-maker/scripts/export-host-variables.sh