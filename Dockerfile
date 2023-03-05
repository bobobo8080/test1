# base image
FROM python:3.9-slim-buster

# set working directory
WORKDIR /app

# copy the requirements file
COPY requirements.txt .

# install dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# copy the app.py file to a new directory called "src"
COPY app.py src/

#Keygen & adding it to github via Token
RUN apt-get update && \
    apt-get install -y openssh-client && \
	ssh-keygen -t rsa -b 4096 -C "test@sqlabs.com" -f /root/.ssh/id_rsa -N "" && \
	apt-get update && \
    apt-get install -y curl && \
	curl -X POST -H "Authorization: token <yourtoken>" -H "Content-Type: application/json" -d '{"title":"My public key", "key":"'"$(cat ~/.ssh/id_rsa.pub)"'"}' https://api.github.com/user/keys


# install Git
RUN apt-get update && \
    apt-get install -y git

#Copy Local README.md file
COPY README.md /src/	
	
# initialize a Git repository inside the "src/" directory after copy of README.md
RUN     cd src/ && \
        git init && \
        git config --global user.name "David Schick Project" && \
        git config --global user.email "Project@sqlabs.com" && \
        git add README.md && \
		git commit -m "first commit" && \
		git branch -M main && \
		git remote add origin git@github.com:alufdavid/Project.git && \
		export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" && \
		git push -u origin main && \
		unset GIT_SSH_COMMAND


# expose port
EXPOSE 5000

# set environment variables
ENV FLASK_APP=src/app.py
ENV FLASK_RUN_HOST=0.0.0.0

# start the server
CMD ["flask", "run"]