# syntax=docker/dockerfile:1
# otter grade -n demo -a ./dist/demo-autograder_2023_12_15T16_56_04_536836.zip -v ./submission
FROM ubuntu:latest

WORKDIR /app

# Copy the source code into the /app directory in the container.
COPY ./dist /app/dist
COPY ./requirements.txt /app/requirements.txt
COPY ./grader.sh /app/grader.sh

# Install Docker and Python
RUN apt-get update && \
    apt-get install -y docker

# # Install Python 3.10
RUN apt-get install -y python3.10 python3.10-venv python3.10-dev python3-pip
RUN pip install -r ./requirements.txt

# Ensure the script is executable
RUN chmod +x ./grader.sh

# # Command to run the script
CMD ["./grader.sh"]

# # # Finds the Autograder file in the dist directory.
# # RUN NOTEBOOKS_FILE=$(find ./app/notebooks -type f -name "*.ipynb")

# CMD ["sh", "-c", "otter grade -n demo -a $AUTOGRADER_FILE -v ./submission -o ./submission"]

# # # Run the application.
# # CMD ["otter","grade","-n","demo","-a",$AUTOGRADER_FILE,"-v","app/submission", "-o", "results.csv"] 


# # syntax=docker/dockerfile:1
# # otter grade -n demo -a ./dist/demo-autograder_2023_12_15T16_56_04_536836.zip -v ./submission
# FROM ubuntu:latest

# WORKDIR /app

# # Copy the source code into the /app directory in the container.
# COPY ./dist /app/dist
# COPY ./install_docker.sh /app/install_docker.sh
# COPY ./docker_buildx.sh /app/./docker_buildx.sh
# # RUN bash install_docker.sh
# # RUN bash docker_buildx.sh

# # # Install Docker and Python
# # RUN apt-get update && \
# #     apt-get install -y docker

# # # Install necessary packages and add the deadsnakes PPA
# # RUN apt-get update && apt-get install -y \
# #     software-properties-common \
# #     && add-apt-repository ppa:deadsnakes/ppa


# # # Install Python 3.10
# # RUN apt-get install -y python3.10 python3.10-venv python3.10-dev

# # # Install pip for Python 3.10
# # RUN apt-get install -y python3-pip

# # # Optionally, make Python 3.10 the default Python version
# # RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1

# # # Clean up
# # RUN apt-get clean \
# #     && rm -rf /var/lib/apt/lists/*

# # RUN pip install otter-grader



# # # Create a non-privileged user that the app will run under.
# # # See https://docs.docker.com/go/dockerfile-user-best-practices/
# # ARG UID=10001
# # RUN adduser \
# #     --disabled-password \
# #     --gecos "" \
# #     --home "/nonexistent" \
# #     --shell "/sbin/nologin" \
# #     --no-create-home \
# #     --uid "${UID}" \
# #     appuser

# # # Switch to the non-privileged user to run the application.
# # USER appuser

# # # # Expose the port that the application listens on.
# # # EXPOSE 5000

# # # Temporarily list contents of /app to debug
# # RUN ls

# # # Finds the Autograder file in the dist directory.
# RUN AUTOGRADER_FILE=$(find ./dist -type f -name "*autograde*.zip")

# # # # Finds the Autograder file in the dist directory.
# # # RUN NOTEBOOKS_FILE=$(find ./app/notebooks -type f -name "*.ipynb")

# # CMD ["sh", "-c", "otter grade -n demo -a $AUTOGRADER_FILE -v ./submission -o ./submission"]

# # # # Run the application.
# # # CMD ["otter","grade","-n","demo","-a",$AUTOGRADER_FILE,"-v","app/submission", "-o", "results.csv"] 
