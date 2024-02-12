## Prerequisites
- Docker
- Docker Compose
- mlx-lm

### Installation
install the mlx-lm package from PyPI:

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
./config_chat_ui.sh
```

## Usage
1. Launch mlx-lm api server
    ```python
    python -m mlx_lm.server --model mlx-community/Mixtral-8x7B-Instruct-v0.1-hf-4bit-mlx
    ```

2. Start UI frontend services, and open https://localhost/chat in your browser.
    ```shell
    docker-compose up --build
    ```