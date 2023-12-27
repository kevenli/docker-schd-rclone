FROM python:3.8-alpine AS builder
RUN apk update && apk add build-base 
RUN python -m venv /venv
ENV PATH="/venv/bin:$PATH"
ADD requirements.txt .
RUN pip install -r requirements.txt
COPY package/rclone-v1.65.0-linux-amd64.zip .
RUN unzip rclone-v1.65.0-linux-amd64.zip
RUN cp rclone-v1.65.0-linux-amd64/rclone /usr/bin


FROM python:3.8-alpine
WORKDIR /app
COPY --from=builder /venv /venv
ENV PATH="/venv/bin:$PATH"
ENV XDG_CONFIG_HOME=/config
COPY --from=builder /usr/bin/rclone /usr/bin/rclone
