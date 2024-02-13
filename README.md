## Introduction
This repository demonstrates how to set up the huggingface chat-ui integration with mlx-lm server.

## Prerequisites
Before you begin, ensure you have the following tools installed:

- Docker
- Docker Compose
  
If you prefer using Colima for Docker, you can install it using Homebrew with the following commands:
```
brew install colima
colima start
```

### Installation
### mlx-lm Package

First, you need to install the `mlx-lm` package from PyPI. Run the following command:

```bash
pip install mlx-lm
```

## Generate Self-Signed SSL Certificate
```shell
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx/nginx-selfsigned.key -out nginx/nginx-selfsigned.crt
```

## Clone chat ui
```shell
git clone https://github.com/huggingface/chat-ui.git
cd ./chat-ui
git checkout e0c0b0e53fd3d9452c3adae82de39d15c9476a1b 
```

Run the configuration script to update svelte.config.js and crate a .env.local file
```shell
cd ..
./config_chat_ui.sh
```
Note: This setup is configured for the mixtral-8x7b model. If you're using a different model, update the .env.local file in the chat-ui directory accordingly. For more details, see the [chat-ui environment template.](https://github.com/huggingface/chat-ui/blob/main/.env.template)

## Usage

### Launch mlx-lm API Server

Start the mlx-lm API server with the following command:

```python
python -m mlx_lm.server --model mlx-community/Mixtral-8x7B-Instruct-v0.1-hf-4bit-mlx
```
### Start UI Frontend Services
To start the UI frontend services, use Docker Compose:
```shell
docker-compose up --build
```
After starting the services, open https://localhost/chat in your browser to interact with the application.

## Alternative Setup
If the standard docker-compose setup does not work for you, follow the setup instructions provided in the chat-ui repository's [README](https://github.com/huggingface/chat-ui?tab=readme-ov-file#setup). Make sure to change the .env.local file to point the API endpoint to your local mlx-lm server and adjust the MongoDB URL as necessary.
