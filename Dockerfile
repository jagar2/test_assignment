# syntax=docker/dockerfile:1
# otter grade -n demo -a ./dist/demo-autograder_2023_12_15T16_56_04_536836.zip -v ./submission
FROM ubuntu:latest

# Install Docker and Python
RUN apt-get update && \
    apt-get install -y docker.io python3 python3-pip

RUN pip install otter-grader
RUN pip install --upgrade python-on-whales

WORKDIR /app

# Copy the source code into the /app directory in the container.
COPY ./dist /app/dist
COPY ./install_docker.sh /app/install_docker.sh
RUN bash install_docker.sh

# Create a non-privileged user that the app will run under.
# See https://docs.docker.com/go/dockerfile-user-best-practices/
ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser

# # Switch to the non-privileged user to run the application.
# USER appuser

# # # Expose the port that the application listens on.
# # EXPOSE 5000

# # Temporarily list contents of /app to debug
# RUN ls

# # Finds the Autograder file in the dist directory.
RUN AUTOGRADER_FILE=$(find ./dist -type f -name "*autograde*.zip")

# # # Finds the Autograder file in the dist directory.
# # RUN NOTEBOOKS_FILE=$(find ./app/notebooks -type f -name "*.ipynb")

# CMD ["sh", "-c", "otter grade -n demo -a $AUTOGRADER_FILE -v ./submission -o ./submission"]

# # # Run the application.
# # CMD ["otter","grade","-n","demo","-a",$AUTOGRADER_FILE,"-v","app/submission", "-o", "results.csv"] 
