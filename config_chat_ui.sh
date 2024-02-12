#!/bin/bash

# Define paths
CHAT_UI_DIR="./chat-ui" 
ENV_FILE="$CHAT_UI_DIR/.env.local"
CONFIG_FILE="$CHAT_UI_DIR/svelte.config.js"
TEMP_FILE="$CHAT_UI_DIR/temp_config.js"

# Ensure the chat-ui directory exists
if [ ! -d "$CHAT_UI_DIR" ]; then
    echo "chat-ui directory does not exist: $CHAT_UI_DIR"
    exit 1
fi

# Modify the svelte.config.js file
awk '/base:/ {$0="			base: process.env.APP_BASE || \"/chat\","}1' "$CONFIG_FILE" > "$TEMP_FILE"

mv "$TEMP_FILE" "$CONFIG_FILE"

# Check if the sed command was successful
if [ $? -ne 0 ]; then
    echo "Failed to modify $CONFIG_FILE"
    exit 1
fi

echo "Modified svelte.config.js successfully."

# Create the .env.local file with the provided content
cat << EOF > "$ENV_FILE"
MONGODB_URL=mongodb://host.docker.internal:27017/
MODELS=\`[
  {
        "name": "mistralai/Mixtral-8x7B-Instruct-v0.1",
        "datasetName": "Mixtral-8x7B",
        "description": "A good alternative to ChatGPT",
        "websiteUrl": "https://mistral.ai/news/mixtral-of-experts/",
        "preprompt": "",
        "chatPromptTemplate" : "<s>{{#each messages}}{{#ifUser}}[INST] {{#if @first}}{{#if @root.preprompt}}{{@root.preprompt}}\n{{/if}}{{/if}}{{content}} [/INST]{{/ifUser}}{{#ifAssistant}}{{content}}</s>{{/ifAssistant}}{{/each}}",
        "parameters": {
        "temperature": 0.3,
        "top_p": 0.95,
        "repetition_penalty": 1.3,
        "top_k": 50,
        "truncate": 12000,
        "max_new_tokens": 4048,
        "stop": ["</s>"]
        },
        "promptExamples": [
        {
          "title": "Write an email from bullet list",
          "prompt": "As a restaurant owner, write a professional email to the supplier to get these products every week: \n\n- Wine (x10)\n- Eggs (x24)\n- Bread (x12)"
        }, {
          "title": "Code a snake game",
          "prompt": "Code a basic snake game in python, give explanations for each step."
        }, {
          "title": "Assist in a task",
          "prompt": "How do I make a delicious lemon cheesecake?"
        }
      ],
      "endpoints": [
        {
         "baseURL": "http://host.docker.internal:8080/v1",
         "type": "openai"
        }
      ]
    }
]\`
LLM_SUMMERIZATION=false
EOF

# Check if the .env.local file was created successfully
if [ $? -ne 0 ]; then
    echo "Failed to create $ENV_FILE"
    exit 1
fi

echo "Created .env.local file successfully."
