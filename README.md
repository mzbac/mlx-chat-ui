## Prerequisites
Before you begin, ensure you have the following tools installed:

- Docker
- Docker Compose

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
Note: This setup is configured for the mixtral-8x7b model. If you're using a different model, update the .env.local file in the chat-ui directory accordingly. For more details, see the[chat-ui environment template.](https://github.com/huggingface/chat-ui/blob/main/.env.template)

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
