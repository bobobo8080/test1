FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip3 install flask

WORKDIR /app

COPY app.py /app/app.py

EXPOSE 5002

CMD ["python3", "app.py"]