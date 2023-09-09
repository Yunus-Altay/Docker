FROM ubuntu
RUN apt-get update -y 
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN pip3 install flask 
COPY . /app
WORKDIR /app
CMD python3 ./app.py